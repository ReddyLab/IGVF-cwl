#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool
doc: Cut columns from input file.
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
  input_file:
    type: File
    inputBinding:
      position: 1
  columns:
    type: string
    inputBinding:
      position: 2
      prefix: -f
  suffix:
    type: string
    default: .cut.txt
baseCommand: cut
stdout: $(inputs.input_file.nameroot + inputs.suffix)
outputs:
  output_file:
    type: File
    outputBinding:
      glob: $(inputs.input_file.nameroot + inputs.suffix)
