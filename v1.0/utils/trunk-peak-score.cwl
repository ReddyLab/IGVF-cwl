#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool
doc: Trunk scores in ENCODE bed6+4 files
requirements:
  NetworkAccess:
    networkAccess: true
  LoadListingRequirement:
    loadListing: deep_listing
hints:
  DockerRequirement:
    dockerPull: reddylab/workflow-utils:ggr
inputs:
  peaks:
    type: File
    inputBinding:
      position: 10000
  sep:
    type: string
    default: \t
    inputBinding:
      position: 2
      prefix: -F
baseCommand: awk
arguments:
- valueFrom: BEGIN{OFS=FS}$5>1000{$5=1000}{print}
  position: 3
stdout: $(inputs.peaks.path.replace(/^.*[\\\/]/, '').replace(/\.([^/.]+)$/, "\.trunked_scores\.$1"))
outputs:
  trunked_scores_peaks:
    type: File
    outputBinding:
      glob: $(inputs.peaks.path.replace(/^.*[\\\/]/, '').replace(/\.([^/.]+)$/, "\.trunked_scores\.$1"))
