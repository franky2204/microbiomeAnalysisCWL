cwlVersion: v1.2
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}
  DockerRequirement:
    dockerPull: fpant/metaphlan411

baseCommand: ["Rscript","/scripts/calculate_diversity.R"]

inputs:

  tsv_file:
    type: File
    inputBinding:
      position: 1
      prefix: "-f"

arguments:
  - position: 2
    valueFrom: -d
  - position: 3
    valueFrom: alpha
  - position: 4
    valueFrom: -m
  - position: 5
    valueFrom: shannon
  - position: 6
    valueFrom: -o
  - position: 7
    valueFrom: ./

outputs:
  shannon:
    type: File
    outputBinding:
      glob: "*shannon.tsv"