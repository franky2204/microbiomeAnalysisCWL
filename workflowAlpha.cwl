#!usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
    MultipleInputFeatureRequirement: {}
    SubworkflowFeatureRequirement: {}

inputs:
    output_meta_dir: Directory
outputs:
    tsv_file:
        type: File
        outputSource: fusion_to_tsv/tsv_file
    meta_out:
        type: File[]
        outputSource: find_meta_output/meta_out
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
    find_meta_output:
        run: cwl/find_meta_output.cwl
        in:
            output_meta_dir: output_meta_dir
        out: [meta_out]
    fusion_to_tsv:
        run: cwl/fusionToTsv.cwl
        in:
            meta_out: find_meta_output/meta_out
        out: [tsv_file]
    calculate_alpha:
        run: cwl/calculateAlpha.cwl
        in:
            tsv_file: fusion_to_tsv/tsv_file
        out: [simpson, richness, shannon]