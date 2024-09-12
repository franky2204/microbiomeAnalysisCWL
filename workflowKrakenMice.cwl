#!usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  InlineJavascriptRequirement: {}
  ScatterFeatureRequirement: {}
  MultipleInputFeatureRequirement: {}
  SubworkflowFeatureRequirement: {}

inputs:
  fastq_directory: Directory
  db_path: 
    type:
      - Directory
      - File
    secondaryFiles:
      - $("opts.k2d")
      - $("taxo.k2d")
  threads: int?
  mice_index:
    type: File
    secondaryFiles:
      - .amb
      - .ann
      - .bwt
      - .pac
      - .sa
  est_abundance: File
  threshold: int?
  kmer_distrib: File
  classification_level: string
  alpha: string
  mice_db : Directory

outputs:
  count_fatq:
    type: File[]
    outputSource: count-start/count
  count_fatq1:
    type: File[]
    outputSource: count-genome/count
  kraken2_output:
    type: File[]
    outputSource: kraken2/kraken2
  kraken2_report:
    type: File[]
    outputSource: kraken2/report
  kraken-biom_output:
    type: File
    outputSource: kraken-biom/biom
  get-otu_output:
    type: File[]
    outputSource: get-otu/otu_table
  braken_output:
    type: File[]
    outputSource: Bracken/report_braken
  count-total-otu_output:
    type: File
    outputSource: count-total-otu/total_otu
  compute-alpha_output:
    type: File
    outputSource: compute-alpha/alpha_div

steps:
  check-input:
    run: cwl/checkInput.cwl
    in:
      fastq_directory: fastq_directory
    out: [read_1, read_2]
  kneadData:
    run: cwl/kneadDataOnlyTrim.cwl
    scatter: [read_1, read_2]
    scatterMethod: dotproduct
    in:
      read_1: check-input/read_1
      read_2: check-input/read_2
      #db_path: mice_db
      threads: threads
    out: [out_read_1, out_read_2, log]
  rePairReads:
    run: cwl/rePairReads.cwl
    scatter: [read_1, read_2]
    scatterMethod: dotproduct
    in:
      read_1: kneadData/out_read_1
      read_2: kneadData/out_read_2
    out: [re_paired_R1, re_paired_R2]
  count-start:
    run: cwl/countFastq.cwl
    scatter: [read_1, read_2]
    scatterMethod: dotproduct
    in:
      read_1: rePairReads/re_paired_R1
      read_2: rePairReads/re_paired_R2
    out: [count]
  micemapper:
    run: cwl/humanMapper.cwl
    scatter: [read_1, read_2]
    scatterMethod: dotproduct
    in:
      read_1: kneadData/out_read_1
      read_2: kneadData/out_read_2
      index: mice_index
      threads: threads
    out: [unmapped_R1, unmapped_R2]
  count-genome:
    run: cwl/countFastq.cwl
    scatter: [read_1, read_2]
    scatterMethod: dotproduct
    in:
      read_1: micemapper/unmapped_R1
      read_2: micemapper/unmapped_R2
    out: [count]
  kraken2:
    run: cwl/kraken2.cwl
    scatter: [read_1, read_2]
    scatterMethod: dotproduct
    in:
      read_1: micemapper/unmapped_R1
      read_2: micemapper/unmapped_R2    
      db_path: db_path
      threads: threads
    out: [kraken2, report] 
  kraken-biom:
    run: cwl/kraken-biom.cwl
    in:
      kraken_report: kraken2/report
    out: [biom] 
  get-otu:
    run: cwl/getOTU.cwl
    scatter: kraken_report
    in:
      kraken_report: kraken2/report
    out: [otu_table]
  Bracken:
    run: cwl/bracken.cwl
    scatter: [report]
    in:
      est_abundance: est_abundance
      report: kraken2/report
      kmer_distrib: kmer_distrib
      classification_level: classification_level
      threshold: threshold
      alpha: alpha
    out: [alpha_div, report_braken] 
  count-total-otu:
    run: cwl/countTotalOTU.cwl
    in:
      otus: get-otu/otu_table
    out: [total_otu]
  compute-alpha:
    run: cwl/computeAlpha.cwl
    in:
      total_otu: count-total-otu/total_otu
    out: [alpha_div]