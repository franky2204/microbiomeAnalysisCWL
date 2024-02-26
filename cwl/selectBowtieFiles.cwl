#!/usr/bin/env cwl-runner
class: CommandLineTool
cwlVersion: "v1.2"

requirements:
  InlineJavascriptRequirement: {}
hints:
  DockerRequirement:
    dockerPull: scontaldo/checkinput

baseCommand: ["bash", "/findBowtie.sh"]
stdout: cwl.output.json

inputs: 
  bowtie_path:
    type: Directory
    inputBinding:
      position: 1
outputs:
  bowtie_files: string[]