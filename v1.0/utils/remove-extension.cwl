#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool
doc: Extracts the base name of a file
requirements:
  NetworkAccess:
    networkAccess: true
  LoadListingRequirement:
    loadListing: deep_listing
hints:
  DockerRequirement:
    dockerPull: reddylab/workflow-utils:ggr
inputs:
  file_path:
    type: string
    inputBinding:
      position: 1
baseCommand: echo
outputs:
  output_path:
    type: string
    outputBinding:
      outputEval: $(inputs.file_path.replace(/\.[^/.]+$/, ""))
