#!/usr/bin/env cwl-runner
class: CommandLineTool
cwlVersion: "v1.2"

requirements:
  InlineJavascriptRequirement: {}
hints:
  DockerRequirement:
    dockerPull: scontaldo/checkinput

baseCommand: ["bash", "/kaioken.sh"]
stdout: cwl.output.json

inputs: 
  fastq_directory:
    type: Directory
    inputBinding:
      position: 1
outputs:
  value: string[]
