#!/usr/bin/env cwl-runner
cwlVersion: "v1.2"
class: CommandLineTool

baseCommand: ["bash", "-c", "touch report_count.txt"]

inputs: []

outputs:
  report_count:
    type: File
    outputBinding:
      glob: "report_count.txt"
