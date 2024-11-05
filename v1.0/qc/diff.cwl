#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool
doc: Compares 2 files
requirements:
  NetworkAccess:
    networkAccess: true
  LoadListingRequirement:
    loadListing: deep_listing
hints:
  DockerRequirement:
    dockerPull: reddylab/workflow-utils:ggr
inputs:
  file2:
    type: File
    inputBinding:
      position: 2
  file1:
    type: File
    inputBinding:
      position: 1
  brief:
    type: boolean
    default: true
    inputBinding:
      prefix: --brief
      position: 3
baseCommand: diff
stdout: stdout.txt
outputs:
  result:
    type: File
    outputBinding:
      glob: stdout.txt
