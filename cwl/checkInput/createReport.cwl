#!/usr/bin/env cwl-runner
class: CommandLineTool
cwlVersion: "v1.2"

baseCommand: ["bash", "touch report_count.txt"]
inputs: []
outputs:
  report_count:
    type: File
    outputBinding:
      glob: "report_count.txt"#da controllare   