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


hints:
  ResourceRequirement:
    coresMax: $(inputs.threads)
  DockerRequirement:
    dockerPull: fpant/metaphlan 
baseCommand: ["bash", "/scripts/humann3.sh"]


inputs:
  meta_path:
    type: Directory
    inputBinding:
      position: 1
  biom_input:
    type: File
    inputBinding:
      position: 2
  output_dir:
    type: string?
    default: "./"
    inputBinding:
      position: 3
  threads:
    doc: "Maximum number of compute threads"
    type: int?
    default: 1
    inputBinding:
      position: 4
  format:
    type: string?
    default: "biom"
    inputBinding:
      position: 5

     
    
outputs:
  #gene_families:
  #  type: File
  #  outputBinding:
  #    glob: "./*genefamilies.tsv"
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


