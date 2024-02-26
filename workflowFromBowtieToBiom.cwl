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
  reads:
    type: File[]
    outputSource: select_files/bowtie_files
  biom_file:
    type: File[]
    outputSource: biom_create/biom_file 

steps:
  select_files:
    run: cwl/selectBowtieFiles.cwl
    in: 
      bowtie_path: bowtie_path
    out: [bowtie_files]  
  biom_create:
    run: cwl/createBiom.cwl
    scatterMethod: dotproduct
    in:
      bowtie_files: select_files/bowtie_files
      meta_path: meta_path
      threads: threads
    out: [biom_file]