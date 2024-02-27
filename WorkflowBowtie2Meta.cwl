#!usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  InlineJavascriptRequirement: {}
  ScatterFeatureRequirement: {}
  MultipleInputFeatureRequirement: {}
  SubworkflowFeatureRequirement: {}

inputs:
  threads: int?
  meta_path:
    type: Directory
  bowtie_directory:
    type: Directory

outputs:

  report:
    type: File[]
    outputSource: metaphlan4Bowtie/report
  biom_output:
    type: File[]
    outputSource: metaphlan4Bowtie/biom_output
  biom_output_comp:
    type: File[]
    outputSource: metaphlan4Bowtie/report
  final_table:
    type: File
    outputSource: merge_bioms/final_table

steps:
  check-input:
    run: cwl/checkBowtieInput.cwl
    in:
       bowtie_directory: bowtie_directory
    out: [read]
  metaphlan4Bowtie:
    run: cwl/metaphlan4Bowtie.cwl
    scatter: [read]
    in:
      read: check-input/read
      threads: threads
      meta_path: meta_path
    out: [report, biom_output, biom_output_comp] 
  merge_bioms:
    run: cwl/merge_bioms.cwl
    in: 
      biom_output: metaphlan4Bowtie/biom_output
    out: [final_table]
