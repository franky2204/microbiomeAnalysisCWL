#!usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  InlineJavascriptRequirement: {}
  ScatterFeatureRequirement: {}

inputs:
  output_meta_dir: Directory

outputs:
  meta_out:
    type: File[] 
    outputSource: send-files/meta_out

steps:
  check-files: 
    run: findMetaOut/findMetaOut.cwl
    in:
      output_meta_dir: output_meta_dir
    out: [value]
  send-files:
    run: findMetaOut/sendMetaOut.cwl
    scatter: meta_out_name
    in:
      meta_out_name: check-files/value
      output_meta_dir: output_meta_dir
    out: [meta_out]
