#!usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  InlineJavascriptRequirement: {}
  MultipleInputFeatureRequirement: {}

inputs:
  read: File
  chocophlan_DB: Directory
  uniref_DB: Directory
  report: File
  threads: int?

outputs:
  gene_families: 
    type: File
    outputSource: humann3/gene_families
  path_coverage: 
    type: File
    outputSource: humann3/path_coverage
  path_abundance:
    type: File
    outputSource: humann3/path_abundance
  temp_dir: 
    type: Directory
    outputSource: humann3/temp_dir


steps:
  humann3:
    run: cwl/metaphlanFlow/humann3.cwl
    in:
      read_fused: read
      report: report
      chocophlan_DB: chocophlan_DB
      uniref_DB: uniref_DB
      threads: threads
    out: [gene_families, path_coverage, path_abundance, temp_dir]