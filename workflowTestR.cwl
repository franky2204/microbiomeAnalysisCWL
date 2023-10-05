#!usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  InlineJavascriptRequirement: {}
  ScatterFeatureRequirement: {}
  SubworkflowFeatureRequirement: {}

inputs:
  fastq_directory: Directory
  db_path: 
    type:
      - Directory
      - File
    secondaryFiles:
      - $("opts.k2d")
      - $("taxo.k2d")
  threads: int?
  index:
    type: File
    secondaryFiles:
      - .amb
      - .ann
      - .bwt
      - .fai
      - .pac
      - .sa

outputs:
  raw_results:
    type: File
    outputSource: datasetAnalysis/raw_results
  outputs_cwl:
    type: File[]
    outputSource: microbiomeCwlWorkflow/outputs_cwl
  prevalence_results:
    type: File
    outputSource: prevalenceAnalysis/prevalence_results
  decontaminationBrute-force_results:
    type: File
    outputSource: decontaminationBrute-force/decontaminationBrute-force_results
  decontaminationDNA_results:
    type: File
    outputSource: decontaminationDNA/decontaminationDNA_results
  decontaminationStringent_results:
    type: File
    outputSource: decontaminationStringent/decontaminationStringent_results

steps:
  datasetAnalysis:
    run: workflow.cwl
    in:
      fastq_directory: fastq_directory
    out: [raw_results]
  microbiomeCwlWorkflow:
    run: workflow.cwl
    in:
      fastq_directory: fastq_directory
      index: index
      threads: threads 
      db_path: db_path
    out: [outputs_cwl]
  prevalenceAnalysis:
    run: workflow.cwl
    in:
      data: microbiomeCwlWorkflow/outputs_cwl
    out: [prevalence_results]
  decontaminationBrute-force:
    run: workflow.cwl
    in:
       data: microbiomeCwlWorkflow/outputs_cwl
    out: [decontaminationBrute-force_results]
  decontaminationDNA:
    run: workflow.cwl
    in: 
      data: microbiomeCwlWorkflow/outputs_cwl
    out: [decontaminationDNA_results]
  decontaminationStringent:
    run: workflow.cwl
    in:
      data: microbiomeCwlWorkflow/outputs_cwl
    out: [decontaminationStringent_results]
