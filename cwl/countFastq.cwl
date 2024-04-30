class: CommandLineTool
cwlVersion: "v1.2"

doc:  |
  Count reads of fastq 

requirements:
  InlineJavascriptRequirement: {} 
- class: InitialWorkDirRequirement
      listing: [ $(inputs.file) ]

hints:
  DockerRequirement:
    dockerPull: scontaldo/checkinput



baseCommand: ["bash", "/countFastq.sh"]
stdout: cwl.output.json

inputs:
  read_1:
    type: File
    inputBinding:
      position: 1 
  read_2:
    type: File
    inputBinding:
      position: 2 


outputs:
  count:
    type: File
    outputBinding:
      glob: "*_count_fastq.txt"
