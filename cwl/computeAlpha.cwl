#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}
hints:
  DockerRequirement:
    dockerPull: scontaldo/kraken2:v2.1.2 

baseCommand: ["python3", "/computeAlpha.py"]

inputs: 
  total_otu:
    doc: ""
    type: File
    inputBinding:
      position: 1

outputs:
  alpha_div:
    type: File
    outputBinding:
      glob: alphadiv.csv 
