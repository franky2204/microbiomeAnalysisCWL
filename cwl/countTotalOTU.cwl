#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}
hints:
  DockerRequirement:
    dockerPull: scontaldo/kraken2:v2.1.2 

baseCommand: ["python3", "/countTotalOTU.py"]

inputs: 
  otus:
    doc: ""
    type: File[]
    inputBinding:
      position: 1

outputs:
  total_otu:
    type: File
    outputBinding:
      glob: otu_total.csv 
