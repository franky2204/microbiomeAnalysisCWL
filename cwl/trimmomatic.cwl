cwlVersion: v1.2
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}

hints:
  DockerRequirement:
    dockerPull: staphb/trimmomatic:0.39

baseCommand: ["java","-jar","/Trimmomatic-0.39/trimmomatic-0.39.jar","PE","-phred33"]


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


arguments: ["outputpaired1.fastq.gz","outputpaired2.fastq.gz","outputUNpaired1.fastq.gz",
            "outputUNpaired2.fastq.gz","-trimlog","log.txt","ILLUMINACLIP:/Trimmomatic-0.39/adapters/TruSeq3-PE-2.fa:2:30:10",
            "LEADING:3","TRAILING:3","SLIDINGWINDOW:4:20","MINLEN:36"]

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
      glob: "outputpaired1.fastq.gz"
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
