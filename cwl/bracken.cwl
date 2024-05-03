cwlVersion: v1.2
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}

hints:
  DockerRequirement:
    dockerPull: scontaldo/kraken2:v2.1.2 

baseCommand: python3


inputs:
  est_abundance:
    type: File
    inputBinding:
      position: 1
  report: 
    type: File
    inputBinding:
      position: 2
      prefix: -i
  kmer_distrib:
    type: File
    inputBinding:
      position: 3
      prefix: -k
  classification_level:
    type: string?
    default: "S"
    inputBinding:
      position: 4
      prefix: -l
  threshold:
    type: int?
    default: 10
    inputBinding:
      position: 5
      prefix: -t 
  alpha:
    type: string
    inputBinding:
      position: 6
      prefix: -o
     
outputs:
  alpha_div:
    type: File
    outputBinding:
      glob: "*results.braken"
      outputEval: ${self[0].basename=inputs.report+alpha; return self;}

