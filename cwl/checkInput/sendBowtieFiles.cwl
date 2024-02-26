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
  bowtie_names:
    type: string
    inputBinding:
      position: 1
  bowtie_path:
    type: Directory
    inputBinding:
      position: 2

outputs:
  bowtie_file:
    type: File
    outputBinding:
      glob: "*.bowtie2.bz2"#da controllare   