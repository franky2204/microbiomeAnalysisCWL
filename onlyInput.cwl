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
  index:
    type: File
    secondaryFiles:
      - .amb
      - .ann
      - .bwt
      - .pac
      - .sa
  threads: int?

outputs:
  read_1:
    type: File[]
    outputSource: check-input/read_1
  read_2:
    type: File[]
    outputSource: check-input/read_2
  unmapped_R1:
    type: File[]
    outputSource: humanmapper/unmapped_R1
  unmapped_R2:
    type: File[]
    outputSource: humanmapper/unmapped_R2
#  count:
#    type: File[]
#    outputSource: count-start/count
  count2:
    type: File[]
    outputSource: count-genome1/count

steps:
  check-input:
    run: cwl/checkInput.cwl
    in:
      fastq_directory: fastq_directory
    out: [read_1, read_2]
  count-start:
    run: cwl/countUniteFastq.cwl
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
    run: cwl/countUniteFastq.cwl
    scatter: [read_1, read_2, file_count]
    scatterMethod: dotproduct
    in:
      read_1: humanmapper/unmapped_R1
      read_2: humanmapper/unmapped_R2
      file_count: count-start/count
    out: [count]
 
