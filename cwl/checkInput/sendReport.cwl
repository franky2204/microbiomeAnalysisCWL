#!/usr/bin/env cwl-runner
class: CommandLineTool
cwlVersion: "v1.2"

baseCommand: ["bash", "/sendReport.sh"]

requirements:
  InlineJavascriptRequirement: {}
hints:
  DockerRequirement:
    dockerPull: scontaldo/checkinput

inputs: 
  report_name:
    type: string
    inputBinding:
      position: 1
  report_directory:
    type: Directory
    inputBinding:
      position: 2

outputs:
  read:
    type: File
    outputBinding:
      glob: "*.report"#da controllare   
