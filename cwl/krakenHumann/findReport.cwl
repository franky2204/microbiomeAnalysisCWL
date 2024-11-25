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
    inputBinding:
      position: 1
  kraken_folder:
    type: Directory
    inputBinding:
      position: 2

outputs:
  report:
    type: File
    outputBinding:
      glob: "*.report"