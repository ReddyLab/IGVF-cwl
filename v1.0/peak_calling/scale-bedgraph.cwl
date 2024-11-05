#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool
doc: Scale BedGraph file by scaling factor computed using the number of uniq. mapped
  reads (library size)
requirements:
  NetworkAccess:
    networkAccess: true
  LoadListingRequirement:
    loadListing: deep_listing
hints:
  DockerRequirement:
    dockerPull: reddylab/workflow-utils:ggr
inputs:
  output_suffix:
    type: string
    default: .norm.bdg
  bedgraph_file:
    type: File
    inputBinding:
      position: 1
  read_count_file:
    type: File
    inputBinding:
      position: 2
baseCommand: scale-bedgraph-by-lib-uniq-reads.sh
stdout: $(inputs.bedgraph_file.path.replace(/^.*[\\\/]/, '').replace(/\.bdg$/, '')
  + inputs.output_suffix)
outputs:
  bedgraph_scaled:
    type: File
    outputBinding:
      glob: $(inputs.bedgraph_file.path.replace(/^.*[\\\/]/, '').replace(/\.bdg$/,
        '') + inputs.output_suffix)
