cwlVersion: v1.0
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
          var partial_name = inputs.read_1.basename;
          var truncated_name = partial_name.split('_')[0];
          // Construct a glob pattern to match any file in the folder that contains the partial name
          return inputs.kraken_folder.path + '/*' + truncated_name + '*'+'.report';
        }

baseCommand: ["echo"]
