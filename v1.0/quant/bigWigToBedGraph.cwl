#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool
doc: |
  bigWigToBedGraph - Convert from bigWig to bedGraph format.
  usage:
     bigWigToBedGraph in.bigWig out.bedGraph
  options:
     -chrom=chr1 - if set restrict output to given chromosome
     -start=N - if set, restrict output to only that over start
     -end=N - if set, restict output to only that under end
     -udcDir=/dir/to/cache - place to put cache for remote bigBed/bigWigs
requirements:
  InlineJavascriptRequirement: {}
  NetworkAccess:
    networkAccess: true
  LoadListingRequirement:
    loadListing: deep_listing
hints:
  DockerRequirement:
    dockerPull: reddylab/ucsc-kentutils:1.0
inputs:
  output_suffix:
    type: string
    default: .bdg
  bigwig_file:
    type: File
    inputBinding:
      position: 1
    doc: Bed file to be clipped
baseCommand: bigWigToBedGraph
arguments:
- valueFrom: $(inputs.bigwig_file.path.replace(/^.*[\\\/]/, '').replace(/\.[^/.]+$/,
    "") + inputs.output_suffix)
  position: 2
outputs:
  output_bedgraph:
    type: File
    outputBinding:
      glob: $(inputs.bigwig_file.path.replace(/^.*[\\\/]/, '').replace(/\.[^/.]+$/,
        "") + inputs.output_suffix)
