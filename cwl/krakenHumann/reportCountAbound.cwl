#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}
hints:
  DockerRequirement:
    dockerPull: scontaldo/Kraken2:latest

baseCommand: ["python3", "/trasformInMeta.py"]

inputs: 
  report:
    type: File
    inputBinding:
        position: 1

outputs:
    final_report:
        type: File
        outputBinding:
            glob: "*_output.tsv" 
