#!/usr/bin/env cwl-runner
class: CommandLineTool
cwlVersion: "v1.2"

baseCommand: ["bash", "/sendBowtie.sh"]

requirements:
  InlineJavascriptRequirement: {}
hints:
  DockerRequirement:
    dockerPull: scontaldo/checkinput

inputs: 
  bowtie_name:
    type: string
    inputBinding:
      position: 1
  bowtie_directory:
    type: Directory
    inputBinding:
      position: 2

outputs:
  read:
    type: File
    outputBinding:
      glob: "*.bowtie2.bz2"#da controllare   
