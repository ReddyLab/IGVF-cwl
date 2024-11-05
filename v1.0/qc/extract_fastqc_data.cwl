#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool
doc: Unzips a zipped fastqc report and returns the fastqc_data.txt file. Unzips the
  file to pipe and uses redirection
requirements:
  NetworkAccess:
    networkAccess: true
  LoadListingRequirement:
    loadListing: deep_listing
hints:
  DockerRequirement:
    dockerPull: dukegcb/fastqc   # Just so that unzip is installed
inputs:
  pipe:
    type: boolean
    default: true
    inputBinding:
      prefix: -p
      position: 1
  input_basename:
    type: string
  input_qc_report_file:
    type: File
    inputBinding:
      position: 2
  extract_pattern:
    type: string
    default: '*/fastqc_data.txt'
    inputBinding:
      position: 3
baseCommand: unzip
stdout: $(inputs.input_basename + '.fastqc_data.txt')
outputs:
  output_fastqc_data_file:
    type: File
    outputBinding:
      glob: $(inputs.input_basename + '.fastqc_data.txt')
