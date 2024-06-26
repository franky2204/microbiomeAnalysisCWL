#!usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  InlineJavascriptRequirement: {}
  MultipleInputFeatureRequirement: {}
  SubworkflowFeatureRequirement: {}
  ScatterFeatureRequirement: {}

inputs:
  est_abundance: File
  report_folder: 
    type: Directory
  threshold: int?
  kmer_distrib: File
  classification_level: string
  alpha: string


outputs:
  alpha_div:
    type: File[]
    outputSource: Braken/alpha_div
  report_braken:
    type: File[]
    outputSource: Braken/report_braken


steps:
  find-report:
    run: cwl/checkReport.cwl
    in: 
      report_directory: report_folder
    out: [report]
  Braken:
    run: cwl/bracken.cwl
    scatter: [report]
    in:
      est_abundance: est_abundance
      report: find-report/report
      kmer_distrib: kmer_distrib
      classification_level: classification_level
      threshold: threshold
      alpha: alpha
    out: [alpha_div, report_braken] 
 