cwlVersion: v1.2
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement: 
    listing:
      - entry: $(inputs.report)
        writable: True

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
      glob: "*.braken"
      outputEval: ${
          self[0].basename = inputs.report.nameroot + ".braken";
          return self; }
  report_braken: 
    type: File
    outputBinding:
      glob: "*bracken_species.report"
      outputEval: ${
          self[0].basename = inputs.report.nameroot + "_braken.report";
          return self; }
