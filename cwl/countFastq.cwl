class: CommandLineTool
cwlVersion: "v1.2"

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
  read_2:
    type: File
    inputBinding:
      position: 2

outputs:
    single_pair:
    type: File
    outputBinding:
    glob: "*_count_fastq.txt"
