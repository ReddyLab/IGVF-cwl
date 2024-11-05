#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool
requirements:
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing: [$(inputs.input_file)]
  NetworkAccess:
    networkAccess: true
  LoadListingRequirement:
    loadListing: deep_listing
hints:
  DockerRequirement:
    dockerPull: dukegcb/samtools:1.3
inputs:
  input_file:
    type: File
    inputBinding:
      position: 1
    doc: Aligned file to be sorted with samtools
baseCommand: [samtools, index]
arguments:
- valueFrom: $(inputs.input_file.basename + '.bai')
  position: 2
outputs:
  indexed_file:
    doc: Indexed BAM file
    type: File
    outputBinding:
      glob: $(inputs.input_file.basename)
    secondaryFiles: .bai
