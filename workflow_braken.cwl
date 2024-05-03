#!usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  InlineJavascriptRequirement: {}
  ScatterFeatureRequirement: {}
  MultipleInputFeatureRequirement: {}
  SubworkflowFeatureRequirement: {}

inputs:
  est_abundance: File
  report: File
  threshold: int?
  kmer_distrib: File
  classification_level: string
  alpha: string


outputs:
  alpha_div:
    type: File[]
    outputSource: braken/alpha_div
 

steps:
  Braken:
    run: cwl/braken.cwl
    scatter: [report]
    in:
      est_abundance: est_abundance
      report: report
      kmer_distrib: kmer_distrib
      classification_level: classification_level
      threshold: threshold
      alpha: alpha
    out: [alpha_div] 
 