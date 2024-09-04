cwlVersion: v1.2
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}
  ResourceRequirement:
    coresMax: $(inputs.threads)

hints:
  ResourceRequirement:
    coresMax: $(inputs.threads)
  DockerRequirement:
    dockerPull: fpant/kneaddata
baseCommand: ["bash", "/scripts/kneadData.sh"]


inputs:
  read_1:
    type: File
    inputBinding:
      position: 1
  read_2:
    type: File
    inputBinding:
      position: 2
  db_path:
    type: Directory
    inputBinding:
      position: 3
  threads:
    type: int?
    default: 1
    inputBinding:
      position: 4


     
outputs:
  out_read_1:
    type: File
    outputBinding:
      glob: "*R1_output.f*q"
  out_read_2:
    type: File
    outputBinding:
      glob: "*R2_output.f*q"
  log:
    type: File
    outputBinding:
      glob: "*_kneaddata.log"

  
  
       


