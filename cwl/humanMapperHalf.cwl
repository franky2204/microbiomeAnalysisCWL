#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool

doc: |
  Filter uman reads using chm13

requirements:
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing: [ $(inputs.index)]
hints:
  ResourceRequirement:
    coresMax: $(inputs.threads)
  DockerRequirement:
    dockerPull: scontaldo/humanmapper

baseCommand: ["bash", "/scripts/humanMapperHalf.sh"]

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
      - .pac
      - .sa
  threads:
    doc: "Max number of threads in use"
    type: int?
    default: 1
    inputBinding:
      position: 4
      
outputs:
  unmapped_file:
    type: File
    outputBinding:
      glob: "*_unmapped.fastq.gz"
  single_pair:
    type: File
    outputBinding:
      glob: "*_single.fastq.gz"



