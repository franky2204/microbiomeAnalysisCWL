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
  knead_directory: Directory
  threads: int?

outputs:
  read_1:
    type: File[]
    outputSource: knead-data/read_1
  read_2:
    type: File[]
    outputSource: knead-data/read_2
  contaminant_1:
    type: File[]
    outputSource: knead-data/contaminant_1
  contaminant_2:
    type: File[]
    outputSource: knead-data/contaminant_2
  knead_log:
    type: File[]
    outputSource: knead-data/knead_log

steps:
  check-input:
    run: cwl/checkInput.cwl
    in:
      fastq_directory: fastq_directory
    out: [read_1, read_2]
  knead-data:
    run: cwl/kneadData.cwl
    in: 
      read_1: check-input/read_1
      read_2: check-input/read_2
      db_knead1: db_knead1
    out: [knead_log, contaminant_1, contaminant_2, read_1, read_2]