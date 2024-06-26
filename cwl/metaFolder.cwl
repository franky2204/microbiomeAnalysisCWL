#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool

doc: |
  Metaphlan4 mapping 

requirements:
  InlineJavascriptRequirement: {}
hints:
  ResourceRequirement:
    coresMax: $(inputs.threads)
  DockerRequirement:
    dockerPull: fpant/metaphlan411

baseCommand: ["bash", "/scripts/folder_meta.sh"]

inputs: 
  read_1:
    doc: ""
    type: File
    inputBinding:
      position: 1  
  read_2:
    doc: ""
    type: File
    inputBinding:
      position: 2 
  threads:
    doc: "Maximum number of compute threads"
    type: int?
    default: 1
    inputBinding:
      position: 3
  meta_path:
    type: Directory
    inputBinding:
      position: 4

outputs:
    meta_folder:
        type: Directory
        outputBinding:
            glob: "*_folder"