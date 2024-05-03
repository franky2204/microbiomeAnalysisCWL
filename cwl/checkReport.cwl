#!usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  InlineJavascriptRequirement: {}
  ScatterFeatureRequirement: {}

inputs:
  report_directory: Directory

outputs:
  read:
    type: File[] 
    outputSource: send-files/output

steps:
  check-files: 
    run: checkInput/findReport.cwl
    in:
      report_directory: report_directory
    out: [value]
  send-files:
    run: checkInput/sendReport.cwl
    scatter: report_name
    in:
      report_name: check-files/value
      report_directory: report_directory
    out: [read]