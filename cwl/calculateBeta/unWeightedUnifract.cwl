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
  three_tables:
    type: File
    inputBinding:
      position: 2
      prefix: "-t"

arguments:
  - position: 3
    valueFrom: -d
  - position: 4
    valueFrom: beta
  - position: 5
    valueFrom: -m
  - position: 6
    valueFrom: unweighted-unifrac
  - position: 7
    valueFrom: -o
  - position: 8
    valueFrom: ./

outputs:
  beta_unweighted_unifrac:
    type: File
    outputBinding:
      glob: "*unweighted-unifrac.tsv"