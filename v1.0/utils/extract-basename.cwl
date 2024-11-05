#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool
doc: Extracts the base name of a file
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
baseCommand: echo
outputs:
  output_basename:
    type: string
    outputBinding:
      outputEval: $(inputs.input_file.path.substr(inputs.input_file.path.lastIndexOf('/')
        + 1, inputs.input_file.path.lastIndexOf('.') - (inputs.input_file.path.lastIndexOf('/')
        + 1)))
