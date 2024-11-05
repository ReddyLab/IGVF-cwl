#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool
doc: Get number of processed reads from Bowtie log.
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
  bowtie_log: {type: File, inputBinding: {}}
baseCommand: read-count-from-bowtie-log.sh
stdout: $(inputs.bowtie_log.path.replace(/^.*[\\\/]/, '') + '.read_count.mapped')
outputs:
  output:
    type: File
    outputBinding:
      glob: $(inputs.bowtie_log.path.replace(/^.*[\\\/]/, '') + '.read_count.mapped')
