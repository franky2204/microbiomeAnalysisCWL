cwlVersion: v1.2
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}
  
  InitialWorkDirRequirement: 
    listing:
      - entry: $(inputs.read_1)
        writable: True
      - entry: $(inputs.read_2)
        writable: True

hints:
  DockerRequirement:
    dockerPull: staphb/trimmomatic:0.39

baseCommand: ["java", "-jar", "/Trimmomatic-0.39/trimmomatic-0.39.jar", "PE"]

inputs:
  read_1:
    type: File
    inputBinding:
      position: 1
  read_2: 
    type: File
    inputBinding:
      position: 2
  threads:
    doc: "Maximum number of compute threads"
    type: int?
    default: 1
    inputBinding:
      position: 3
      prefix: -threads
  output1: 
    type: string?
    default: "outputpaired1.fastq.gz"
    inputBinding:
      position: 4
  output2: 
    type: string?
    default: "outputpaired1.fastq.gz"
    inputBinding:
      position: 5
  unpaired1: 
    type: string?
    default: "outputUNpaired1.fastq.gz"
    inputBinding:
      position: 6
  unpaired2: 
    type: string?
    default: "outputUNpaired2.fastq.gz"
    inputBinding:
      position: 7
  logName:
    type: string?
    default: "log.txt"
    inputBinding:
      position: 8
      prefix: -trimlog
  illuminaclip:
    type: string?
    default: "ILLUMINACLIP:/Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10:2:True"
    inputBinding:
      position: 9
  remaningCommand:
    type: string?
    default: "LEADING:3 TRAILING:3 MINLEN:36"
    inputBinding: 
      position: 10
  

outputs:
  out_read_1:
    type: File
    outputBinding:
      glob: "outputpaired1.fastq.gz"
  out_read_2:
    type: File
    outputBinding:
      glob: "outputpaired2.fastq.gz"
  log:
    type: File
    outputBinding:
      glob: "log.txt"