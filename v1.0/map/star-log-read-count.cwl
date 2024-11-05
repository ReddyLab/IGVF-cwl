#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool
doc: Get number of processed reads from STAR log.
requirements:
  InlineJavascriptRequirement: {}
  ShellCommandRequirement: {}
  NetworkAccess:
    networkAccess: true
  LoadListingRequirement:
    loadListing: deep_listing
hints:
  DockerRequirement:
    dockerPull: reddylab/workflow-utils:ggr
inputs:
  star_log: {type: File, inputBinding: {}}
baseCommand: read-count-from-STAR-log.sh
stdout: $(inputs.star_log.path.replace(/^.*[\\\/]/, '') + '.read_count.mapped')
outputs:
  output:
    type: File
    outputBinding:
      glob: $(inputs.star_log.path.replace(/^.*[\\\/]/, '') + '.read_count.mapped')
