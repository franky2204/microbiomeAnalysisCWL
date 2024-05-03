#!/usr/bin/env cwl-runner
class: CommandLineTool
cwlVersion: "v1.2"

requirements:
  InlineJavascriptRequirement: {}
hints:
  DockerRequirement:
    dockerPull: scontaldo/checkinput

baseCommand: ["bash", "/findReport.sh"]
stdout: cwl.output.json

inputs: 
  report_directory:
    type: Directory
    inputBinding:
      position: 1
outputs:
  value: string[]
