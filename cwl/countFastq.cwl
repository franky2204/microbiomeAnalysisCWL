class: CommandLineTool
cwlVersion: "v1.2"

requirements:
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement: 
    listing:
      - entry: $(inputs.read_1)
        writable: True
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
