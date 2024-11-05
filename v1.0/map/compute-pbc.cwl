#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool
doc: Compute PCR Bottleneck Coeficient from BedGraph file.
requirements:
  NetworkAccess:
    networkAccess: true
  LoadListingRequirement:
    loadListing: deep_listing
inputs:
  bedgraph_file:
    type: File
    inputBinding:
      position: 1
  output_filename:
    type: string
baseCommand:
- awk
- $4==1 {N1 += $3 - $2}; $4>=1 {Nd += $3 - $2} END {print N1/Nd}
stdout: $(inputs.output_filename + '.PBC.txt')
outputs:
  pbc:
    type: File
    outputBinding:
      glob: $(inputs.output_filename + '.PBC.txt')
