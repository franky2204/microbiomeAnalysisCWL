#!usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  InlineJavascriptRequirement: {}
  ScatterFeatureRequirement: {}

inputs:
  bowtie_directory: Directory

outputs:
  read:
    type: File[] 
    outputSource: send-files/read

steps:
  check-files: 
    run: checkInput/findBowtie.cwl
    in:
      bowtie_directory: bowtie_directory
    out: [value]
  send-files:
    run: checkInput/sendBowtie.cwl
    scatter: bowtie_name
    in:
      bowtie_name: check-files/value
      bowtie_directory: bowtie_directory
    out: [read]
