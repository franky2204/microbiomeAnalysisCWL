#!usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  InlineJavascriptRequirement: {}
  ScatterFeatureRequirement: {}

inputs:
  report_dir: Directory

outputs:
  report:
    type: File[] 
    outputSource: send-files/report

steps:
  check-files: 
    run: findMetaReport/findMetaReport.cwl
    in:
      report_dir: report_dir
    out: [value]
  send-files:
    run: findMetaReport/sendMetaReport.cwl
    scatter: report_array
    in:
      report: check-files/value
      report_directory: report_directory
    out: [report]
