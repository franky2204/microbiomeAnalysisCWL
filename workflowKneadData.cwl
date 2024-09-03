!usr/bin/env cwl-runner
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
    outputSource: kneadData/read_1
  file_2:
    type: File
    outputSource: kneadData/read_2
  read_output:
    type: File
    outputSource: kneadData/count

steps:
  kneadData:
    run: cwl/kneadData.cwl
    in:
      read_1: read_1
      read_2: read_2
      db_path: db_path
      threads: threads
    out: [read_1, read_2] 
