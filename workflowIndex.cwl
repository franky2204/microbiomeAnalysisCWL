cwlVersion: v1.2
class: Workflow

requirements:
  InlineJavascriptRequirement: {}

inputs:
  raw_chm13:
    type: File
  output_db: string?
  method: string?

outputs:
  indexed_chm13:
    type: File[]
    outputSource: indexing/indexed_chm13

steps:
  indexing:
    run: indexCwl/indexing.cwl
    in:
      raw_chm13: raw_chm13
      output_db: output_db
      method: method
    out: [indexed_chm13]