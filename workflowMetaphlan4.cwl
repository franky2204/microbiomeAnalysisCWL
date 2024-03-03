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


outputs:

  unmapped_R1:
    type: File[]
    outputSource: humanmapper/unmapped_R1
  unmapped_R2:
    type: File[]
    outputSource: humanmapper/unmapped_R2
  unmapped_chm_R1:
    type: File[]
    outputSource: humanMapper_chm13/unmapped_chm_R1
  unmapped_chm_R2:
    type: File[]
    outputSource: humanMapper_chm13/unmapped_chm_R2
  bowtie2:
    type: File[]
    outputSource: metaphlan4/bowtie2
  report:
    type: File[]
    outputSource: metaphlan4/report
  biom_output:
    type: File[]
    outputSource: metaphlan4/biom_output
  final_table:
    type: File
    outputSource: merge_bioms/final_table
  results:
    type: File
    outputSource: count_otu/results

steps:
  check-input:
    run: cwl/checkInput.cwl
    in:
      fastq_directory: fastq_directory
    out: [read_1, read_2]
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
  humanMapper_chm13:
    run: cwl/humanMapperChm13.cwl
    scatter: [read_1, read_2]
    scatterMethod: dotproduct
    in:
      read_1: humanmapper/unmapped_R1
      read_2: humanmapper/unmapped_R2
      index_chm13: index_chm13
      threads: threads
    out: [unmapped_chm_R1, unmapped_chm_R2]
  metaphlan4:
    run: cwl/metaphlan4.cwl
    scatter: [read_1, read_2]
    scatterMethod: dotproduct
    in:
      read_1: humanMapper_chm13/unmapped_chm_R1
      read_2: humanMapper_chm13/unmapped_chm_R2
      threads: threads
      meta_path: meta_path
    out: [bowtie2, report, biom_output] 
  merge_bioms:
    run: cwl/merge_bioms.cwl
    in: 
      biom_output: metaphlan4/biom_output
    out: [final_table]
  count_otu: 
    run: cwl/count_otu.cwl
    scatter: [read_1, read_2]
    scatterMethod: dotproduct
    in: 
      read_1: check-input/read_1
      read_2: check-input/read_2
      unmapped_R1: humanmapper/unmapped_R1
      unmapped_R2: humanmapper/unmapped_R2
      unmapped_chm_R1: humanMapper_chm13/unmapped_chm_R1
      unmapped_chm_R2: humanMapper_chm13/unmapped_chm_R2
    out: [results]
