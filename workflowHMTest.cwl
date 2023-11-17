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
  index:
    type: File
    secondaryFiles:
      - .amb
      - .ann
      - .bwt
      - .fai
      - .pac
      - .sa

outputs:
  unmapped_file:
    type: File[]
    outputSource: humanMapper/unmapped_file

steps:
  check-input:
    run: cwl/checkInput.cwl
    in:
      fastq_directory: fastq_directory
    out: [read_1, read_2]
  humanMapper:
    run: cwl/humanMapperHalf.cwl
    scatter: [read_1, read_2]
    scatterMethod: dotproduct
    in:
      read_1: check-input/read_1
      read_2: check-input/read_2
      index: index
      threads: threads
    out: [unmapped_file]