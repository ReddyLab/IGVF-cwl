#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool
doc: Counts lines in a file and returns a suffixed file with that number
requirements:
  InlineJavascriptRequirement: {}
  NetworkAccess:
    networkAccess: true
  LoadListingRequirement:
    loadListing: deep_listing
inputs:
  output_suffix: {type: string, default: .count}
  input_file: {type: File}
stdin: $(inputs.input_file.path)
baseCommand:
- wc
- -l
stdout: $(inputs.input_file.path.replace(/^.*[\\\/]/, '') + inputs.output_suffix)
outputs:
  output_counts:
    type: File
    outputBinding:
      glob: $(inputs.input_file.path.replace(/^.*[\\\/]/, '') + inputs.output_suffix)
