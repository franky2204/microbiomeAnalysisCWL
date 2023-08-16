#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool

doc: |
  Retrieve OTU from kraken2 report 

requirements:
  InlineJavascriptRequirement: {}
hints:
  DockerRequirement:
    dockerPull: scontaldo/kraken2:v2.1.2 

baseCommand: ["python3", "/getOTU.py"]

inputs: 
  kraken_report:
    doc: ""
    type: File
    inputBinding:
      position: 1

outputs:
  otu_table:
    type: File
    outputBinding:
      glob: $(inputs.kraken_report.nameroot)_S.tsv
