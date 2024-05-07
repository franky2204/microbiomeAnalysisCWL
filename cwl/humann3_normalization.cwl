cwlVersion: v1.2
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}

hints:
  DockerRequirement:
    dockerPull: fpant/metaphlan 
baseCommand: humann_renorm_table


inputs:
  gene_families:
    type: File
    inputBinding:
      position: 1
      prefix: --input  
  output_file_name:
    type: string?
    default: "output_normalized.tsv"
    inputBinding:
      position: 2
      prefix: --output
  normalize_units:
    doc: "units to normalize the table to"
    type: string?
    default: "relab"
    inputBinding:
      position: 3
      prefix: --units
     
outputs:
  normalized_families:
    type: File
    outputBinding:
      glob: "output_normalized.tsv"
      outputEval: ${
        self[0].basename = inputs.gene_families.nameroot + "_normalized.tsv";
        return self; }
