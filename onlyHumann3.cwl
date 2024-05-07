#!usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  InlineJavascriptRequirement: {}
  ScatterFeatureRequirement: {}
  MultipleInputFeatureRequirement: {}
  SubworkflowFeatureRequirement: {}

inputs:
  biom_input: File
  output_dir: Directory
  threads: int?
outputs:
  dir_humann:
    type: Directory
    outputSource: humann3/dir_humann


steps:
  humann3:
    run: cwl/humann3_9.cwl
    in:
      biom_input: biom_input
      output_dir: output_dir
      threads: threads
    out: [dir_humann]

