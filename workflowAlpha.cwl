#!usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
    MultipleInputFeatureRequirement: {}
    SubworkflowFeatureRequirement: {}

inputs:
    tsv_file: File
outputs:
    simpson:
        type: File
        outputSource: calculate_alpha/simpson
    richness:
        type: File
        outputSource: calculate_alpha/richness
    shannon:   
        type: File
        outputSource: calculate_alpha/shannon
steps:
    calculate_alpha:
        run: cwl/calculateAlpha.cwl
        in:
            tsv_file: tsv_file
        out: [simpson, richness, shannon]