#!usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  InlineJavascriptRequirement: {}

inputs:
    read_1: File
    read_2: File
    threads: int?
    kraken_folder: Directory
    chocophlan_DB: Directory    
    uniref_DB: Directory

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
    normalized_families:
        type: File
        outputSource: normalization/normalized_families
  
  
steps:
  fuse_reads:
    run: metaphlanFlow/fuseReads.cwl
    in:
      read_1: read_1
      read_2: read_2
      threads: threads
    out: [read_fused]
  find_report:
    run: krakenHumann/findReport.cwl
    in:
      read_1: read_1
      kraken_folder: kraken_folder
    out: [report]
  report_to_metaphlan:
    run: krakenHumann/reportToMetaphlan.cwl
    in:
      report: find_report/report
    out: [mid_report]
  report_count_abound:
    run: krakenHumann/reportCountAbound.cwl
    in:
      report: report_to_metaphlan/mid_report
    out: [final_report]
  humann3:
    run: metaphlanFlow/humann3.cwl
    in:
      read_fused: fuse_reads/read_fused
      report: report_count_abound/final_report
      chocophlan_DB: chocophlan_DB
      uniref_DB: uniref_DB
      threads: threads
    out: [gene_families, path_coverage, path_abundance, temp_dir]
  normalization:
    run: metaphlanFlow/humann3_normalization.cwl
    in:
      gene_families: humann3/gene_families
    out: [normalized_families]
