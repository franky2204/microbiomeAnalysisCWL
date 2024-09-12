#!usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  InlineJavascriptRequirement: {}


inputs:
  read_1: File
  read_2: File
  

outputs:
 
  file_1:
    type: File
    outputSource: reRepairReads/re_paired_R1
  file_2:
    type: File
    outputSource: reRepairReads/re_paired_R2


steps:
  reRepairReads:
    run: cwl/rePairReads.cwl
    in:
      read_1: read_1
      read_2: read_2
    out: [re_paired_R1, re_paired_R2] 