#!/usr/bin/env cwl-runner
class: CommandLineTool
cwlVersion: "v1.2"

requirements:
  InlineJavascriptRequirement: {}
hints:
  DockerRequirement:
    dockerPull: fpant/metaphlan 

baseCommand: ["bash", "/biomFusion.py"]

inputs: 
  biom_output:
    type: File[]
    inputBinding:
      position: 1
outputs:
  final_table:    
    type: File
    outputBinding:
      glob: "final_table.biom"   
