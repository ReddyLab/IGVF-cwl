#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool
doc: |
  bedSort - Sort a .bed file by chrom,chromStart
  usage:
     bedSort in.bed out.bed
  in.bed and out.bed may be the same.
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
  bed_file:
    type: File
    inputBinding:
      position: 1
    doc: Bed or bedGraph file to be sorted
baseCommand: bedSort
arguments:
- valueFrom: $(inputs.bed_file.path.replace(/^.*[\\\/]/, '') + "_sorted")
  position: 2
outputs:
  bed_file_sorted:
    type: File
    outputBinding:
      glob: $(inputs.bed_file.path.replace(/^.*[\\\/]/, '') + "_sorted")
