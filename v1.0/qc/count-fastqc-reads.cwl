#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool
doc: Extracts read count from fastqc_data.txt
requirements:
  NetworkAccess:
    networkAccess: true
  LoadListingRequirement:
    loadListing: deep_listing
hints:
  DockerRequirement:
    dockerPull: reddylab/workflow-utils:ggr
inputs:
  input_fastqc_data:
    type: File
    inputBinding:
      position: 1
  input_basename:
    type: string
baseCommand: count-fastqc_data-reads.sh
stdout: $(inputs.input_basename + '.fastqc-read_count.txt')
outputs:
  output_fastqc_read_count:
    type: File
    outputBinding:
      glob: $(inputs.input_basename + '.fastqc-read_count.txt')
