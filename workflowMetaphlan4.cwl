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
  index_chm13:
    type: File
    secondaryFiles:
      - .amb
      - .ann
      - .bwt
      - .pac
      - .sa

outputs:

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

steps:
  check-input:
    run: cwl/checkInput.cwl
    in:
      fastq_directory: fastq_directory
    out: [read_1, read_2]
  humanMapper_chm13:
    run: cwl/humanMapperChm13.cwl
    scatter: [read_1, read_2]
    scatterMethod: dotproduct
    in:
      read_1: check-input/read_1
      read_2: check-input/read_2
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
    out: [bowtie2, report] 
