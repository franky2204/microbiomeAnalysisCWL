#!usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  InlineJavascriptRequirement: {}
  MultipleInputFeatureRequirement: {}

inputs:
  read_1: File
  read_2: File
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
  fuse_reads:
    run: cwl/fuseReads.cwl
    scatterMethod: dotproduct
    in:
      read_1: read_1
      read_2: read_2
      threads: threads
    out: [read_fused]
  humann3:
    run: cwl/humann3.cwl
    in:
      read_fused: fuse_reads/read_fused
      report: report
      chocophlan_DB: chocophlan_DB
      uniref_DB: uniref_DB
      threads: threads
    out: [gene_families, path_coverage, path_abundance, temp_dir]
#  normailization:
#    run: cwl/humann3_normalization.cwl
#    in:
#      gene_families: humann3/gene_families
#    out: [normalized_families]

