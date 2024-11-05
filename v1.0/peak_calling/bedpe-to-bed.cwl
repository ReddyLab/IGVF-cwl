#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool
doc: Un-pack a BEDPE concatenating both mates so that they are treated independently
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
  bedpe:
    type: File
    inputBinding:
      position: 1
baseCommand: bedpe-to-bed.sh
stdout: $(inputs.bedpe.path.replace(/^.*[\\\/]/, '').replace(/\.[^/.]+$/, '').replace(/([_\.]?sorted)*$/,
  '.unpaired.bed'))
outputs:
  bed:
    type: File
    outputBinding:
      glob: $(inputs.bedpe.path.replace(/^.*[\\\/]/, '').replace(/\.[^/.]+$/, '').replace(/([_\.]?sorted)*$/,
        '.unpaired.bed'))
