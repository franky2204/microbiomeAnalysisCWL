cwlVersion: v1.2
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement: 
    listing:
      - entry: $(inputs.biom_input)
        writable: True

hints:
  ResourceRequirement:
    coresMax: $(inputs.threads)
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
    type: string?
    default: "./"
    inputBinding:
      position: 2
      prefix: --output
  threads:
    doc: "Maximum number of compute threads"
    type: int?
    default: 1
    inputBinding:
      position: 3
      prefix: --threads
  format:
    type: string?
    default: "genetable"
    inputBinding:
      position: 4
      prefix: --input-format
     
outputs:
  gene_families:
    type: File
    outputBinding:
      glob: "./*genefamilies.tsv"
  path_coverage:
    type: File
    outputBinding:
      glob: "./*pathcoverage.tsv"
  path_abundance:
    type: File
    outputBinding:
      glob: "./*pathabundance.tsv"
  temp_dir:
    type: Directory
    outputBinding:
      glob: "*humann_temp"


