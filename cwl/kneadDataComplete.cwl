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
  ResourceRequirement:
    coresMax: $(inputs.threads)
  DockerRequirement:
    dockerPull: fpant/kneaddata
baseCommand: ["bash", "/scripts/kneadDataComplete.sh"]


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
      glob: "*_out1.f*q.gz"
  out_read_2:
    type: File
    outputBinding:
      glob: "*_out2.f*q.gz"
  log:
    type: File
    outputBinding:
      glob: "*_kneaddata.log"

  
  
       


