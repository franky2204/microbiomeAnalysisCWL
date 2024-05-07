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
  output_dir: string?
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
  normalized_families:
    type: File
    outputSource: normailization/normalized_families


steps:
  humann3:
    run: cwl/humann3.cwl
    in:
      biom_input: biom_input
      threads: threads
    out: [gene_families, path_coverage, path_abundance, temp_dir]
  normailization:
    run: cwl/humann3_normalization.cwl
    in:
      gene_families: humann3/gene_families
    out: [normalized_families]

