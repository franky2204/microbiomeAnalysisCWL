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
  db_path: 
    type:
      - Directory
      - File
    secondaryFiles:
      - $("opts.k2d")
      - $("taxo.k2d")
  threads: int?
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
