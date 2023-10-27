cwlVersion: v1.2
class: CommandLineTool

doc: |
  Indexing chm_13 

requirements:
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement: 
    listing:
      - entry: $(inputs.raw_chm13)
        writable: True

hints:
  DockerRequirement:
    dockerPull: chm13/index

baseCommand: ["bash", "/scripts/indexer.sh"]

inputs:
  raw_chm13:
    type: File
    inputBinding:
      position: 1
  method: 
    type: int?
    default: 0
    inputBinding:
      position: 2

outputs:
  indexed_chm13:
    type: File[]
    secondaryFiles:
      - .amb
      - .ann
      - .bwt
      - .fai
      - .pac
      - .sa
    outputBinding:
      glob: "chm13v2.0.*"