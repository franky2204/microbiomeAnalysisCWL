#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool

doc: |
  Metaphlan4 mapping 

requirements:
  InlineJavascriptRequirement: {}
hints:
  ResourceRequirement:
    coresMax: $(inputs.threads)
  DockerRequirement:
    dockerPull: fpant/metaphlan 

baseCommand: ["bash", "/metaphlan4.sh"]

inputs: 
  read_1:
    doc: ""
    type: File
    inputBinding:
      position: 3  
  read_2:
    doc: ""
    type: File
    inputBinding:
      position: 4 
  db_path:
    type: 
      - Directory
      - File
    label: "Metaphlan 4 DB"
    doc: "(either a File refer to the hash.k2d file in the DB or a Directory to reference the entire directory)"
    inputBinding:
      position: 2
      valueFrom: |
        ${ return (self.class == "File") ? self.dirname : self.path }
    secondaryFiles:
      - $("opts.k2d")
      - $("taxo.k2d")
  threads:
    doc: "Maximum number of compute threads"
    type: int?
    default: 1
    inputBinding:
      position: 1

outputs:
  bowtie2:
    type: File
    outputBinding:
      glob: "*.fasta.gz.bowtie2out.txt" 
  report:
    type: File
    outputBinding:
      glob: "*.txt.gz"
