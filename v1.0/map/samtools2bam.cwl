#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool
requirements:
  InlineJavascriptRequirement: {}
  NetworkAccess:
    networkAccess: true
  LoadListingRequirement:
    loadListing: deep_listing
hints:
  DockerRequirement:
    dockerPull: dukegcb/samtools:1.3
inputs:
  S:
#  - id: "#b"
#    type: boolean
#    description: "output BAM"
#    default: true
#    inputBinding:
#      position: 1
#      prefix: "-b"
    type: boolean
    default: true
    inputBinding:
      position: 1
      prefix: -S
    doc: Input format autodetected
  nthreads:
    type: int
    default: 1
    inputBinding:
      position: 1
      prefix: -@
    doc: Number of threads used
  input_file:
    type: File
    inputBinding:
      position: 2
    doc: File to be converted to BAM with samtools
baseCommand: [samtools, view, -b]
stdout: $(inputs.input_file.path.replace(/^.*[\\\/]/, '').replace(/\.[^/.]+$/, '')
  + '.bam')
outputs:
  bam_file:
    type: File
    outputBinding:
      glob: $(inputs.input_file.path.replace(/^.*[\\\/]/, '').replace(/\.[^/.]+$/,
        '') + '.bam')
    doc: Aligned file in BAM format
