#!usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  InlineJavascriptRequirement: {}

inputs:
    tsv_file: File
    three_tables: File
outputs:
    beta_weighted_unifrac:
        type: File
        outputSource: beta_weighted_unifrac_step/beta_weighted_unifrac
    beta_unweighted_unifrac:
        type: File
        outputSource: beta_unweighted_unifrac_step/beta_unweighted_unifrac

steps:
    beta_weighted_unifrac_step:
        run: calculateBeta/weightedUnifrac.cwl
        in:
            tsv_file: tsv_file
            three_tables: three_tables
        out: [beta_weighted_unifrac]
    beta_unweighted_unifrac_step:
        run: calculateBeta/unWeightedUnifract.cwl
        in:
            tsv_file: tsv_file
            three_tables: three_tables
        out: [beta_unweighted_unifrac]
