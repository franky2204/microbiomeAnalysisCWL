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
    run: checkInput/selectBowtieFiles.cwl
    in:
      bowtie_path: bowtie_path
    out: [bowtie_files]
  send-files:
    run: checkInput/sendBowtieFiles.cwl
    in:
      bowtie_names: check-files/bowtie_files
      bowtie_path: bowtie_path
    out: [bowtie_file]