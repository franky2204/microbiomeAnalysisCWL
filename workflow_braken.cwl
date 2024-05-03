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
    type: File
    outputSource: Braken/alpha_div
 

steps:
  find_report:
    run: cwl/checkReport.cwl
    in: 
      report_folder: report_folder
    out: [report]
  Braken:
    run: cwl/bracken.cwl
    scatter: [report]
    in:
      est_abundance: est_abundance
      report: find_report/report
      kmer_distrib: kmer_distrib
      classification_level: classification_level
      threshold: threshold
      alpha: alpha
    out: [alpha_div] 
 