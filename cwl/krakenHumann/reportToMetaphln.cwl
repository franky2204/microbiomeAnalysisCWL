#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}
hints:
  DockerRequirement:
    dockerPull: scontaldo/Kraken2:latest

baseCommand: ["python3", "/kreport2mpa.py"]

inputs: 
  report:
    type: File
    inputBinding:
        position: 1
        prefix: "-r"

arguments:
  - valueFrom: $(inputs.report.nameroot + "_mpa.tsv") 
    prefix: "-o"

outputs:
    mid_report:
        type: File
        outputBinding:
            glob: "*_mpa.tsv" 
