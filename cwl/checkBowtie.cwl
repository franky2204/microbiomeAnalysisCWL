#!usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  InlineJavascriptRequirement: {}
  ScatterFeatureRequirement: {}

inputs:
  bowtie_path: Directory

outputs:
  bowtie_file:
    type: File[] 
    outputSource: send-files/bowtie_file

steps:
  check-files: 
    run: checkInput/fidFiles.cwl
    in:
      bowtie_path: bowtie_path
    out: [bowtie_files]
  send-files:
    run: checkInput/sendBowtieFiles.cwl
    scatter: bowtie_files
    in:
      bowtie_files: check-files/bowtie_files
      bowtie_path: bowtie_path
    out: [bowtie_file]