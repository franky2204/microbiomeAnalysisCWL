
cwlVersion: v1.2
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}

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
      glob: |
        ${
          var partial_name = inputs.read_1.nameroot;
          return inputs.kraken_folder.basename + '/' + partial_name.split('_')[0] + '.report';
        }

baseCommand: ["echo"]
