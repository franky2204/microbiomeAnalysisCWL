cwlVersion: v1.2
class: CommandLineTool

doc: |
  Filter uman reads using chm13

requirements:
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing: [ $(inputs.indexed_chm13)]
hints:
  ResourceRequirement:
    coresMax: $(inputs.threads)
  DockerRequirement:
    dockerPull: filtering/chm13

baseCommand: ["bash", "/script/hMSecondStep.sh"]

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
  indexed_chm13:
    doc: "indexed chm13 used as reference"
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
  unmapped_R1_chm13:
    type: File
    outputBinding:
      glob: "*_unmapped_R1_chm13.fastq.gz"
  unmapped_R2_chm13:
    type: File
    outputBinding:
      glob: "*_unmapped_R2_chm13.fastq.gz"



