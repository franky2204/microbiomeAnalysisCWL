cwlVersion: v1.2
class: CommandLineTool

inputs:
  read_1:
    type: File
  read_2:
    type: File
  repair1:
    type: string?
    default: "repair1.fastq.gz"
  repair2:
    type: string?
    default: "repair2.fastq.gz"
  singletons:
    type: string?
    default: "singletons.fastq.gz"
  action:
    type: string?
    default: "repair"

outputs:
  re_paired_R1:
    type: File
    outputBinding:
      glob: $("repair1.fastq.gz")
  re_paired_R2:
    type: File
    outputBinding:
      glob: $("repair2.fastq.gz")

baseCommand: ["repair.sh"]

arguments:
  - valueFrom: in=$(inputs.read_1)
  - valueFrom: in2=$(inputs.read_2)
  - valueFrom: out1=$(inputs.repair1)
  - valueFrom: out2=$(inputs.repair2)
  - valueFrom: outs=$(inputs.singletons)
  - valueFrom: $(inputs.action)