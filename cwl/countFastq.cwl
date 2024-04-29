cwlVersion: v1.2
class: CommandLineTool
requirements:
  - class: ShellCommandRequirement
baseCommand: zcat 
inputs:
  read_1:
    type: File
    streamable: true
    shellQuote: False 
    inputBinding:
      position: 1
  pipe:
    type: string
    default: "|"
    shellQuote: False 
    inputbinding:
      positioning: 2
  wc:
    type: string
    shellQuote: False
    prefix: "wc"
    inputBinding:
      position: 3
  line: 
    type: string
    shellQuote: False
    prefix: "-l"
    inputBinding:
      position: 4
stdout: count_output.txt
outputs:
  grep_file:
    type: File
    streamable: true
    outputBinding:
      glob: count_output.txt
