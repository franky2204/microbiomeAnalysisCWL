cwlVersion: v1.2
class: Workflow

requirements:
  InlineJavascriptRequirement: {}
inputs:
  fastq_directory: Directory
  threads: int?
  kraken_folder:
    type: Directory
  chocophlan_DB:
    type: Directory
  uniref_DB:
    type: Directory
    
  

outputs:
    gene_families: 
        type: File
        outputSource: KHumann/gene_families
    path_coverage: 
        type: File
        outputSource: KHumann/path_coverage
    path_abundance: 
        type: File
        outputSource: KHumann/path_abundance
    temp_dir: 
        type: Directory
        outputSource: KHumann/temp_dir

steps:
  check-input:
    run: cwl/checkInput.cwl
    in:
      fastq_directory: fastq_directory
    out: [read_1, read_2]
  KHumann:
    run: cwl/KHumann.cwl
    scatter: [read_1, read_2]
    scatterMethod: dotproduct
    in:
      threads: threads
      read_1: check-input/read_1
      read_2: check-input/read_2
      kraken_folder: kraken_folder
      chocophlan_DB: chocophlan_DB
      uniref_DB: uniref_DB
    out: [gene_families,path_coverage,path_abundance,temp_dir]