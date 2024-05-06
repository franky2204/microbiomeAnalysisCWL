cwlVersion: v1.2
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement: 
    listing:
      - entry: $(inputs.biom_input)
        writable: True
      - entry: $(inputs.output_dir)

hints:
  DockerRequirement:
    dockerPull: fpant/metaphlan 
baseCommand: humann


inputs:
  biom_input:
    type: File
    inputBinding:
      position: 1
      prefix: --input
  output_dir:
    type: Directory?
    default: "./"
    inputBinding:
      position: 2
      prefix: --output
     
outputs:
  gene_families:
    type: File
    outputBinding:
      glob: "*genefamilies.tsv"
  path_coverage:
    type: File
    outputBinding:
      glob: "*pathcoverage.tsv"
  path_abundance:
    type: File
    outputBinding:
      glob: "*pathabundance.tsv"


