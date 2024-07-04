#!usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
    MultipleInputFeatureRequirement: {}
    SubworkflowFeatureRequirement: {}

inputs:
    output_meta_dir: Directory
    three_tables: File
outputs:
    tsv_file:
        type: File
        outputSource: fusion_to_tsv/tsv_file
    simpson:
        type: File
        outputSource: calculate_alpha/simpson
    richness:
        type: File
        outputSource: calculate_alpha/richness
    shannon:   
        type: File
        outputSource: calculate_alpha/shannon
    beta_weighted_unifrac:
        type: File
        outputSource: calculate_beta/beta_weighted_unifrac
    beta_unweighted_unifrac:
        type: File
        outputSource: calculate_beta/beta_unweighted_unifrac
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
    calculate_beta:
        run: cwl/calculateBeta.cwl
        in:
            tsv_file: fusion_to_tsv/tsv_file
            three_tables: three_tables
        out: [beta_weighted_unifrac, beta_unweighted_unifrac]