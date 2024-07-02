cwlVersion: v1.2
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}

hints:
  DockerRequirement:
    dockerPull: biobakery/humann 
baseCommand: ["humann_renorm_table"]


inputs:
  gene_families:
    type: File
    inputBinding:
      position: 1
      prefix: --input  
  normalize_units:
    doc: "units to normalize the table to"
    type: string?
    default: "relab"
    inputBinding:
      position: 2
      prefix: --units
arguments: ["--output","output_normalized.tsv"]
outputs:
  normalized_families:
    type: File
    outputBinding:
      glob: "output_normalized.tsv"
      outputEval: ${
        self[0].basename = inputs.gene_families.nameroot + "_normalized.tsv";
        return self; }
