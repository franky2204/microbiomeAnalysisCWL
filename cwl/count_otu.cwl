#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool

doc: |
  Count mapped/unmappped part

requirements:
  InlineJavascriptRequirement: {}
hints:
  DockerRequirement:
    dockerPull: fpant/metaphlan

baseCommand: ["python3", "/script/count_fastq.py"]

inputs: 
  read_1: 
    type: File 
    inputBinding:
      position: 1
  read_2:
    type: File
    inputBinding:
      position: 2
  unmapped_R1: 
    type: File
    inputBinding:
      position: 3
  unmapped_R2: 
    type: File
    inputBinding:
      position: 4
  unmapped_chm_R1:
    type: File
    inputBinding:
      position: 5
  unmapped_chm_R2: 
    type: File
    inputBinding:
      position: 6
  

outputs:
  results:
    type: File
    outputBinding:
      glob: "*_count.txt"