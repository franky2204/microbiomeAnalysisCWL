#!/usr/bin/env cwl-runner
class: CommandLineTool
cwlVersion: "v1.2"

requirements:
  InlineJavascriptRequirement: {}
hints:
  DockerRequirement:
    dockerPull: fpantini/biom

baseCommand: ["bash", "/biomFusion.sh"]

inputs: 
  out_directory:
    type: Directory
    inputBinding:
      position: 1
outputs:
  final_table:    
    type: File
    outputBinding:
      glob: "final_table.biom"   
