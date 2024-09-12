cwlVersion: v1.2
class: CommandLineTool
baseCommand: ["repair.sh"]


inputs:
  read_1:
    type: File
    inputBinding:
      position: 1
      prefix: "in="
  read_2:
    type: string
    inputBinding:
      position: 2
      prefix: "in2="
  repair1:
    type: string?
    default: "repair1.fastq.gz"
    inputBinding:
      position: 3
      prefix: "out1="
  repair2:
    type: string?
    default: "repair2.fastq.gz"
    inputBinding:
      position: 4
      prefix: "out2="
  singletons:
    type: string?
    default: "singletons.fastq.gz"
    inputBinding:
      position: 5
      prefix: "outs="
  action:
    type: string?
    default: "repair"
    inputBinding:
      position: 6

outputs:
  re_paired_R1:
    type: File
    outputBinding:
      glob: $("repair1.fastq.gz")
  re_paired_R2:
    type: File
    outputBinding:
      glob: $("repair2.fastq.gz")

