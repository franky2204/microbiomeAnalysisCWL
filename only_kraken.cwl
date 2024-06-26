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
  

outputs:
 
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
  kraken2:
    run: cwl/kraken2.cwl
    scatter: [read_1, read_2]
    scatterMethod: dotproduct
    in:
      read_1: check-input/read_1
      read_2: check-input/read_2
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