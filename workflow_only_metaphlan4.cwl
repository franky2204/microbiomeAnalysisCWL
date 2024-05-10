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
  threads: int?
  meta_path:
    type: Directory


outputs:
  bowtie2:
    type: File[]
    outputSource: metaphlan4/bowtie2
  report:
    type: File[]
    outputSource: metaphlan4/report
  biom_output:
    type: File[]
    outputSource: metaphlan4/biom_output
  final_table:
    type: File
    outputSource: merge_bioms/final_table
  sam_output:
    type: File[]
    outputSource: metaphlan4/sam_output


steps:
  check-input:
    run: cwl/checkInput.cwl
    in:
      fastq_directory: fastq_directory
    out: [read_1, read_2]
  metaphlan4:
    run: cwl/metaphlan4.cwl
    scatter: [read_1, read_2]
    scatterMethod: dotproduct
    in:
      read_1: check-input/read_1
      read_2: check-input/read_2
      threads: threads
      meta_path: meta_path
    out: [bowtie2, report, biom_output, sam_output] 
  merge_bioms:
    run: cwl/merge_bioms.cwl
    in: 
      biom_output: metaphlan4/biom_output
    out: [final_table]

