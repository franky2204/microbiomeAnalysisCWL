#!/usr/bin/env cwl-runner
class: CommandLineTool
cwlVersion: "v1.2"

baseCommand: ["bash", "/sendMetaOut.sh"]

requirements:
  InlineJavascriptRequirement: {}
hints:
  DockerRequirement:
    dockerPull: scontaldo/checkinput

inputs: 
  meta_out_name:
    type: string
    inputBinding:
      position: 1
  output_meta_dir:
    type: Directory
    inputBinding:
      position: 2

outputs:
  meta_out:
    type: File
    outputBinding:
      glob: "*.txt"
