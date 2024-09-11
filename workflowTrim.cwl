#!usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  InlineJavascriptRequirement: {}


inputs:
  read_1: File
  read_2: File
  threads: int?
  

outputs:
 
  file_1:
    type: File
    outputSource: trimmomatic/out_read_1
  file_2:
    type: File
    outputSource: trimmomatic/out_read_2
  logFile:
    type: File
    outputSource: trimmomatic/log
  

steps:
  trimmomatic:
    run: cwl/trimmomatic.cwl
    in:
      read_1: read_1
      read_2: read_2
      threads: threads
    out: [out_read_1, out_read_2, log] 
