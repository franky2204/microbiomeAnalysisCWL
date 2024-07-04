#!/usr/bin/env cwl-runner
class: CommandLineTool
cwlVersion: "v1.2"

requirements:
  InlineJavascriptRequirement: {}
hints:
  DockerRequirement:
    dockerPull: scontaldo/checkinput

baseCommand: ["bash", "/findMetaOut.sh"]
stdout: cwl.output.json

inputs: 
  output_meta_dir:
    type: Directory
    inputBinding:
      position: 1
outputs:
  value: string[]
