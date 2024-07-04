cwlVersion: v1.2
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}
  DockerRequirement:
    dockerPull: fpant/metaphlan411

baseCommand: ["Rscript","/scripts/calculateDiversity.R"]

inputs:

  tsv_file:
    type: File
    inputBinding:
      position: 2
      prefix: "-f"

arguments:
  - position: 3
    valueFrom: -d
  - position: 4
    valueFrom: alpha
  - position: 5
    valueFrom: -m
  - position: 6
    valueFrom: simpson
  - position: 7
    valueFrom: -o
  - position: 8
    valueFrom: ./

outputs:
  simpson:
    type: File
    outputBinding:
      glob: "*simpson.tsv"
