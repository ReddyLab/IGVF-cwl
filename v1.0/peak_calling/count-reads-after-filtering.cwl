#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool
doc: Count number of dedup-ed reads used in peak calling
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
  peak_xls_file:
    type: File
    inputBinding:
      position: 1
baseCommand: count-filtered-reads-macs2.sh
stdout: $(inputs.peak_xls_file.path.replace(/^.*[\\\/]/, '').replace(/\_peaks\.xls$/,
  '_read_count.txt'))
outputs:
  read_count_file:
    type: File
    outputBinding:
      glob: $(inputs.peak_xls_file.path.replace(/^.*[\\\/]/, '').replace(/\_peaks\.xls$/,
        '_read_count.txt'))
