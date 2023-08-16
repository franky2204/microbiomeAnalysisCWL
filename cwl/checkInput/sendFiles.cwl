#!/usr/bin/env cwl-runner
class: CommandLineTool
cwlVersion: "v1.2"

baseCommand: ["bash", "/sendFiles.sh"]

requirements:
  InlineJavascriptRequirement: {}
hints:
  DockerRequirement:
    dockerPull: scontaldo/checkinput

inputs: 
  fastq_name:
    type: string
    inputBinding:
      position: 1
  fastq_directory:
    type: Directory
    inputBinding:
      position: 2

outputs:
  read_1:
    type: File
    outputBinding:
      glob: "*_R1*.fastq.gz"   
  read_2:
    type: File
    outputBinding:
      glob: "*_R2*.fastq.gz"   
