#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool
doc: 'Tool:   bedGraphToBigWig v 4 - Convert a bedGraph file to bigWig format.'
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
    default: .bw
  genome_sizes:
    type: File
    inputBinding:
      position: 2
    doc: |
      	genome_sizes is two column: <chromosome name> <size in bases>.
  bed_graph:
    type: File
    inputBinding:
      position: 1
    doc: |
      	bed_graph is a four column file in the format: <chrom> <start> <end> <value>
baseCommand: bedGraphToBigWig
arguments:
- valueFrom: $(inputs.bed_graph.path.replace(/^.*[\\\/]/, '').replace(/\.[^/.]+$/,
    "") + inputs.output_suffix)
  position: 3
outputs:
  output_bigwig:
    type: File
    outputBinding:
      glob: $(inputs.bed_graph.path.replace(/^.*[\\\/]/, '').replace(/\.[^/.]+$/,
        "") + inputs.output_suffix)
