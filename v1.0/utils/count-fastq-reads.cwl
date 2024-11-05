#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool
doc: Counts reads in a fastq file
requirements:
  InlineJavascriptRequirement: {}
  NetworkAccess:
    networkAccess: true
  LoadListingRequirement:
    loadListing: deep_listing
hints:
  DockerRequirement:
    dockerPull: reddylab/workflow-utils:ggr
inputs:
  input_basename:
    type: string
  input_fastq_file:
    type: File
    inputBinding:
      position: 1
baseCommand: count-fastq-reads.sh
stdout: $(inputs.input_basename + '.read_count.txt')
outputs:
  output_read_count:
    type: File
    outputBinding:
      glob: $(inputs.input_basename + '.read_count.txt')
