cwlVersion: v1.2
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}
hints:
  DockerRequirement:
    dockerPull: scontaldo/checkinput

baseCommand: ["bash", "/findReportUni.sh"]

inputs:
  read_1:
    type: File
  kraken_folder:
    type: Directory
    inputBinding:
      position: 1

outputs:
  report:
    type: File
    outputBinding:
      glob: "*.report"