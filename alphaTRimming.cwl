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
  humanContaminant : Directory

outputs:
  out_read_1:
    type: File[]
    outputSource: kneadData/out_read_1
  out_read_2:
    type: File[]
    outputSource: kneadData/out_read_2
  log:
    type: File[]
    outputSource: kneadData/log


steps:
  check-input:
    run: cwl/checkInput.cwl
    in:
      fastq_directory: fastq_directory
    out: [read_1, read_2]
  kneadData:
    run: cwl/kneadDataComplete.cwl
    scatter: [read_1, read_2]
    scatterMethod: dotproduct
    in:
      read_1: check-input/read_1
      read_2: check-input/read_2
      db_path: human_contaminant
      threads: threads
    out: [out_read_1, out_read_2, log]