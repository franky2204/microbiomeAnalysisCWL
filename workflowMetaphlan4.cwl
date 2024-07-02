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
  index:
    type: File
    secondaryFiles:
      - .amb
      - .ann
      - .bwt
      - .fai
      - .pac
      - .sa
  index_chm13:
    type: File
    secondaryFiles:
      - .amb
      - .ann
      - .bwt
      - .pac
      - .sa
  chocophlan_DB: Directory
  uniref_DB:  Directory


outputs:

  unmapped_R1:
    type: File[]
    outputSource: humanmapper/unmapped_R1
  unmapped_R2:
    type: File[]
    outputSource: humanmapper/unmapped_R2
  unmapped_chm_R1:
    type: File[]
    outputSource: humanMapper_chm13/unmapped_R1
  unmapped_chm_R2:
    type: File[]
    outputSource: humanMapper_chm13/unmapped_R2
  bowtie2:
    type: File[]
    outputSource: metaphlan4_flow/bowtie2
  report:
    type: File[]
    outputSource: metaphlan4_flow/report
  count_fatq:
    type: File[]
    outputSource: count-start/count
  count_fatq_g1:
    type: File[]
    outputSource: count-genome1/count
  count_fatq_g2:
    type: File[]
    outputSource: count-genome2/count
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
  humanmapper:
    run: cwl/humanMapper.cwl
    scatter: [read_1, read_2]
    scatterMethod: dotproduct
    in:
      read_1: check-input/read_1
      read_2: check-input/read_2
      index: index
      threads: threads
    out: [unmapped_R1, unmapped_R2]
  count-genome1:
    run: cwl/countFastq.cwl
    scatter: [read_1, read_2]
    scatterMethod: dotproduct
    in:
      read_1: humanmapper/unmapped_R1
      read_2: humanmapper/unmapped_R2
    out: [count]
  humanMapper_chm13:
    run: cwl/humanMapper.cwl
    scatter: [read_1, read_2]
    scatterMethod: dotproduct
    in:
      read_1: humanmapper/unmapped_R1
      read_2: humanmapper/unmapped_R2
      index: index_chm13
      threads: threads
    out: [unmapped_R1, unmapped_R2]
  count-genome2:
    run: cwl/countFastq.cwl
    scatter: [read_1, read_2]
    scatterMethod: dotproduct
    in:
      read_1: humanMapper_chm13/unmapped_R1
      read_2: humanMapper_chm13/unmapped_R2
    out: [count]
  metaphlan4_flow:
    run: cwl/metaphlan_flow.cwl
    scatter: [read_1, read_2]
    scatterMethod: dotproduct
    in:
      read_1: humanMapper_chm13/unmapped_R1
      read_2: humanMapper_chm13/unmapped_R2
      threads: threads
      meta_path: meta_path
      chocophlan_DB: chocophlan_DB
      uniref_DB: uniref_DB
    out: [bowtie2, report, vsc_out,gene_families, path_coverage, path_abundance, temp_dir, normalized_families]

