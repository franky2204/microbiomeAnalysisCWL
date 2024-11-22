#!usr/bin/env cwl-runner
cwlVersion: v1.2 
class: Workflow

requirements:
  InlineJavascriptRequirement: {}

inputs:
  read_1: File  
  kraken_folder: Directory

outputs:
  report:
    type: File
    outputSource: find_report/report
  mid_report:
    type: File
    outputSource: report_to_metaphlan/mid_report
  final_report:
    type: File
    outputSource: report_count_abound/final_report

steps:
  find_report:
    run: cwl/krakenHumann/findReport.cwl
    in:
      read_1: read_1
      kraken_folder: kraken_folder
    out: [report]
  report_to_metaphlan:
    run: cwl/krakenHumann/reportToMetaphln.cwl
    in:
      report: find_report/report
    out: [mid_report]
  report_count_abound:
    run: cwl/krakenHumann/reportCountAbound.cwl
    in:
      report: report_to_metaphlan/mid_report
    out: [final_report]
