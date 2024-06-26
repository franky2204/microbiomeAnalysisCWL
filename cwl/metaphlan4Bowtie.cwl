#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool

doc: |
  Metaphlan4 mapping 

requirements:
  InlineJavascriptRequirement: {}
hints:
  ResourceRequirement:
    coresMax: $(inputs.threads)
  DockerRequirement:
    dockerPull: fpant/metaphlan 

baseCommand: ["bash", "/scripts/bowtie2Biom.sh"]

inputs: 
  read:
    doc: ""
    type: File
    inputBinding:
      position: 1  
  threads:
    doc: "Maximum number of compute threads"
    type: int?
    default: 1
    inputBinding:
      position: 2
  meta_path:
    type: Directory
    inputBinding:
      position: 3

outputs:
  report:
    type: File
    outputBinding:
      glob: "*.txt"
  biom_output:
    type: File
    outputBinding:
      glob: "*_output.biom"
