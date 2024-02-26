#!usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  InlineJavascriptRequirement: {}
  ScatterFeatureRequirement: {}
  MultipleInputFeatureRequirement: {}
  SubworkflowFeatureRequirement: {}

inputs:
  meta_path:
    type: Directory
  bowtie_path:
    type: Directory
  threads: int?

outputs:
  bowtie_file:
    type: File[]
    outputSource: select_files/bowtie_file
  biom_file:
    type: File[]
    outputSource: biom_create/biom_file 

steps:
  select_files:
    run: cwl/checkBowtie.cwl
    in: 
      bowtie_path: bowtie_path
    out: [bowtie_file]  
  biom_create:
    run: cwl/createBiom.cwl
    in:
      bowtie_files: select_files/bowtie_file
      meta_path: meta_path
      threads: threads
    out: [biom_file]