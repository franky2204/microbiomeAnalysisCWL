#!usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  InlineJavascriptRequirement: {}
  ScatterFeatureRequirement: {}
  MultipleInputFeatureRequirement: {}
  SubworkflowFeatureRequirement: {}

inputs:
  fastq_directory: Directory
  threads: int?
  meta_path:
    type: Directory
  mice_index:
    type: File
    secondaryFiles:
      - .amb
      - .ann
      - .bwt
      - .pac
      - .sa
  mice_db: Directory
  chocophlan_DB: Directory
  uniref_DB:  Directory


outputs:

  bowtie2:
    type: File[]
    outputSource: metaphlan4_flow/bowtie2
  report:
    type: File[]
    outputSource: metaphlan4_flow/report
  count_fatq:
    type: File[]
    outputSource: count-start/count
  count_fatq1:
    type: File[]
    outputSource: count-genome/count
  log:
    type: File[]
    outputSource: kneadData/log
  vsc_out: 
    type: File[]
    outputSource: metaphlan4_flow/vsc_out
  gene_families:  
    type: File[]
    outputSource: metaphlan4_flow/gene_families
  path_coverage:  
    type: File[]
    outputSource: metaphlan4_flow/path_coverage
  path_abundance:
    type: File[]
    outputSource: metaphlan4_flow/path_abundance
  temp_dir:
    type: Directory[]
    outputSource: metaphlan4_flow/temp_dir
  normalized_families:
    type: File[]
    outputSource: metaphlan4_flow/normalized_families


steps:
  check-input:
    run: cwl/checkInput.cwl
    in:
      fastq_directory: fastq_directory
    out: [read_1, read_2]
  count-start:
    run: cwl/countFastq.cwl
    scatter: [read_1, read_2]
    scatterMethod: dotproduct
    in:
      read_1: check-input/read_1
      read_2: check-input/read_2
    out: [count]
  micemapper:
    run: cwl/humanMapper.cwl
    scatter: [read_1, read_2]
    scatterMethod: dotproduct
    in:
      read_1: check-input/read_1
      read_2: check-input/read_2
      index: mice_index
      threads: threads
    out: [unmapped_R1, unmapped_R2]
  count-genome:
    run: cwl/countFastq.cwl
    scatter: [read_1, read_2]
    scatterMethod: dotproduct
    in:
      read_1: micemapper/unmapped_R1
      read_2: micemapper/unmapped_R2
    out: [count]
  kneadData:
    run: cwl/kneadData.cwl
    scatter: [read_1, read_2]
    scatterMethod: dotproduct
    in:
      read_1: micemapper/unmapped_R1
      read_2: micemapper/unmapped_R2
      db_path: mice_db
      threads: threads
    out: [out_read_1, out_read_2, log]
  metaphlan4_flow:
    run: cwl/metaphlan_flow.cwl
    scatter: [read_1, read_2]
    scatterMethod: dotproduct
    in:
      read_1: kneadData/out_read_1
      read_2: kneadData/out_read_2
      threads: threads
      meta_path: meta_path
      chocophlan_DB: chocophlan_DB
      uniref_DB: uniref_DB
    out: [bowtie2, report, vsc_out,gene_families, path_coverage, path_abundance, temp_dir, normalized_families]

