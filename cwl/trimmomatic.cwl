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
    default: "outputpaired2.fastq.gz"
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
  leading:
    type: string?
    default: "LEADING:3"
    inputBinding: 
      position: 10
  trailing:
    type: string?
    default: "TRAILING:3"
    inputBinding: 
      position: 11
  minlen:
    type: string?
    default: "MINLEN:36"
    inputBinding: 
      position: 12
  

outputs:
  out_read_1:
    type: File
    outputBinding:
      glob: "outputpaired1.fastq.gz"
      outputEval: ${
        self[0].basename = inputs.read_1.basename;
        return self; }
  out_read_2:
    type: File
    outputBinding:
      glob: "outputpaired2.fastq.gz"
      outputEval: ${
        self[0].basename = inputs.read_2.basename;
        return self; }
  log:
    type: File
    outputBinding:
      glob: "log.txt"
      outputEval: ${
        self[0].basename = inputs.read_1.nameroot + ".txt";
        return self; }