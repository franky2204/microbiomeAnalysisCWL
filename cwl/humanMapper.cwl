#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool

doc: |
  Filter human reads 

requirements:
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing: [ $(inputs.index)]
hints:
  ResourceRequirement:
    coresMax: $(inputs.threads)
  DockerRequirement:
    dockerPull: scontaldo/humanmapper 

baseCommand: ["bash", "/scripts/humanMapper.sh"]

inputs: 
  read_1:
    type: File
    inputBinding:
      position: 1
  read_2:
    type: File
    inputBinding:
      position: 2
  index:
    doc: "Index used as reference"
    type: File
    inputBinding: 
      position: 3 
    secondaryFiles:
      - .amb
      - .ann
      - .bwt
      - .fai
        opional: true
      - .pac
      - .sa
  threads:
    doc: "Maximum number of compute threads"
    type: int?
    default: 1
    inputBinding:
      position: 4


outputs:
  unmapped_R1:
    type: File
    outputBinding:
      glob: "*_unmapped_R1.fastq.gz"
  unmapped_R2:
    type: File
    outputBinding:
      glob: "*_unmapped_R2.fastq.gz"
  #single_pair:
  #  type: File
  #  outputBinding:
  #    glob: "*_single.fastq.gz"