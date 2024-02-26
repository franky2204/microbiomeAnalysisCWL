#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool

doc: |
  Create biom from bowtie2 output

requirements:
  InlineJavascriptRequirement: {}
hints:
  ResourceRequirement:
    coresMax: $(inputs.threads)
  DockerRequirement:
    dockerPull: fpant/metaphlan 

baseCommand: ["bash", "/bowtie2Biom.sh"]

inputs: 
  bowtie_files:
    doc: ""
    type: File
    inputBinding:
      position: 1  
  meta_path:
    type: Directory
    inputBinding:
      position: 2
  threads:
    doc: "Maximum number of compute threads"
    type: int?
    default: 1
    inputBinding:
      position: 3
  

outputs:
  biom_file:
    type: File
    outputBinding:
      glob: "*_output.biom"
