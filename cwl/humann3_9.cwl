cwlVersion: v1.2
class: CommandLineTool

doc: |
  Use Humann3 to profile the functional potential of a microbial community from a biom file

requirements:
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement: 
    listing:
      - entry: $(inputs.biom_input)
        writable: True
      - entry: $(inputs.output_dir)
        writable: True

hints:
  ResourceRequirement:
    coresMax: $(inputs.threads)
  DockerRequirement:
    dockerPull: fpant/metaphlan 
baseCommand: ["bash", "/scripts/humann3.sh"]


inputs:
  biom_input:
    type: File
    inputBinding:
      position: 1
  output_dir:
    type: Directory?
    default: "./"
    inputBinding:
      position: 2
  threads:
    doc: "Maximum number of compute threads"
    type: int?
    default: 1
    inputBinding:
      position: 3
     
outputs:
  dir_humann:
    type: Directory
    outputBinding:
      glob: "*folder_aboundance*"

