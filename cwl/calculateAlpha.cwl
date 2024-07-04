#!usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  InlineJavascriptRequirement: {}

inputs:
    tsv_file: File
outputs:
    simpson:
        type: File
        outputSource: calculate_simpson/simpson
    richness:
        type: File
        outputSource: calculate_richness/richness
    shannon:   
        type: File
        outputSource: calculate_shannon/shannon
steps:
    calculate_simpson:
        run: calculateAlpha/calculateSimpson.cwl
        in:
            tsv_file: tsv_file
        out: [simpson]
    calculate_richness:
        run: calculateAlpha/calculateRichness.cwl
        in:
            tsv_file: tsv_file
        out: [richness]
    calculate_shannon:
        run: calculateAlpha/calculateShannon.cwl
        in:
            tsv_file: tsv_file
        out: [shannon]