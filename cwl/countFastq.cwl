class: CommandLineTool
cwlVersion: "v1.2"

doc:  |
  Count reads of fastq 

requirements:
  InlineJavascriptRequirement: {} 


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

outputs:
  count:
    type: File
    outputBinding:
      glob: "*_count_fastq.txt"
