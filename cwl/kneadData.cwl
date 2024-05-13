cwlVersion: v1.2
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}

hints:
  DockerRequirement:
    dockerPull: fpant/metaphlan 
baseCommand: kneaddata


inputs:
  read_1:
    type: File
    inputBinding:
      position: 1
      prefix: -i1 
  read_2:
    type: File
    inputBinding:
      position: 2
      prefix: -i2
  db_knead1:
    type: Directory
    inputBinding:
      position: 3
      prefix: -db
  output_dir:
    type: string?
    default: "./"
    inputBinding:
      position: 4
      prefix: -o
     
outputs:
  knead_log:
    type: File
    outputBinding:
      glob: "*_kneaddata.log"
  contaminant_1:
    type: File
    outputBinding:
      glob: "*_kneaddata_demo_db_bowtie2_paired_contam_1.fastq"
  contaminant_2:
    type: File
    outputBinding:
      glob: "*_kneaddata_demo_db_bowtie2_paired_contam_2.fastq"
  read_1:
    type: File
    outputBinding:
      glob: "*_kneaddata_paired_1.fastq"
  read_2:
    type: File
    outputBinding:
      glob: "*_kneaddata_paired_2.fastq"
       


