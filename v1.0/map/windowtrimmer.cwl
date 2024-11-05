#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool
doc: Filter out reads from a BED file that are too concentrated within a base-pair
  window.
requirements:
  InlineJavascriptRequirement: {}
  NetworkAccess:
    networkAccess: true
  LoadListingRequirement:
    loadListing: deep_listing
hints:
  DockerRequirement:
    dockerPull: dukegcb/windowtrimmer
inputs:
  cutoff:
    type: float?
    inputBinding:
      position: 1
      prefix: -c
    doc: |
      CUTOFF
              threshold for concentration at a single base
              within a window to cutoff
  window_size:
    type: int?
    inputBinding:
      position: 1
      prefix: -w
    doc: |
      WINDOWSIZE
              Window size threshold for trimming reads that have the same mapping start position.
  input_file:
    type: File
    inputBinding:
      position: 1
      prefix: -i
    doc: BED file containing the reads to be filter.
baseCommand: windowTrimmer.py
stdout: $(inputs.input_file.path.replace(/^.*[\\\/]/, '').replace(/\.[^/.]+$/, '')
  + '.filtered.bed')
outputs:
  filtered_file:
    type: File
    outputBinding:
      glob: $(inputs.input_file.path.replace(/^.*[\\\/]/, '').replace(/\.[^/.]+$/,
        '') + '.filtered.bed')
    doc: Filtered BED file
