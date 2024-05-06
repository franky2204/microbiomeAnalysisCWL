#!usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  InlineJavascriptRequirement: {}
  ScatterFeatureRequirement: {}
  MultipleInputFeatureRequirement: {}
  SubworkflowFeatureRequirement: {}

inputs:
  biom_input: File
  output_dir: Directory
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

steps:
  humann3:
    run: cwl/humann3.cwl
    in:
      biom_input: biom_input
      output_dir: output_dir
    out: [gene_families,path_coverage ,path_abundance]

