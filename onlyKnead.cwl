#!usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  InlineJavascriptRequirement: {}
  ScatterFeatureRequirement: {}
  MultipleInputFeatureRequirement: {}
  SubworkflowFeatureRequirement: {}

inputs:
  knead_directory: Directory
  threads: int?

outputs:
  read_1:
    type: File[]
    outputSource: check-input/read_1
  read_2:
    type: File[]
    outputSource: check-input/read_2


steps:
  check-input:
    run: cwl/checkInput.cwl
    in:
      fastq_directory: fastq_directory
    out: [read_1, read_2]