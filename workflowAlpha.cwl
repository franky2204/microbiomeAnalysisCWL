#!usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
    MultipleInputFeatureRequirement: {}
    SubworkflowFeatureRequirement: {}

inputs:
    report_dir: Directory
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
    find_report:
        run: cwl/findReport.cwl
        in:
            report_dir: report_dir
        out: [report]
    calculate_alpha:
        run: cwl/calculateAlpha.cwl
        in:
            report: find_report/report
        out: [simpson, richness, shannon]