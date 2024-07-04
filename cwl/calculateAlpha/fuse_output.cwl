cwlVersion: v1.2
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}
  DockerRequirement:
    dockerPull: fpant/metaphlan411

baseCommand: ["python3","/scripts/merge_metaphlan_tables.py"]

inputs:

  report:
    type: File[]
    inputBinding:
      position: 1
      itemSeparator: " " 


outputs:
  tsv_file:
    type: File
    outputBinding:
      glob: tsv_file.tsv

stdout: tsv_file.tsv