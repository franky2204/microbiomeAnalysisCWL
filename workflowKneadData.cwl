#!usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  InlineJavascriptRequirement: {}


inputs:
  read_1: File
  read_2: File
  db_path: Directory
  threads: int?
  

outputs:
 
  file_1:
    type: File
    outputSource: kneadData/out_read_1
  file_2:
    type: File
    outputSource: kneadData/out_read_2
  logFile:
    type: File
    outputSource: kneadData/log

steps:
  kneadData:
    run: cwl/kneadDataComplete.cwl
    in:
      read_1: read_1
      read_2: read_2
      db_path: db_path
      threads: threads
    out: [out_read_1, out_read_2, log] 
