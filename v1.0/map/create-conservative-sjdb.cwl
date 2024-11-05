#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool
doc: |
  Merge the STAR 1-pass novel splice junction databases ('SJ.out.tab').
  Save only those splice junctions in autosomes and sex chromosomes.
  Filter out splice junctions that are non-canonical, supported by only 10 or fewer reads.
requirements:
  InlineJavascriptRequirement: {}
  ShellCommandRequirement: {}
  NetworkAccess:
    networkAccess: true
  LoadListingRequirement:
    loadListing: deep_listing
hints:
  DockerRequirement:
    dockerPull: dukegcb/star-utils
inputs:
  sjdb_out_filename:
    type: string
    inputBinding:
      position: 2
  sjdb_files:
    type: File[]
    inputBinding:
      position: 1
      itemSeparator: ','
baseCommand: create_SJ.out.tab.Pass1.conservative.sjdb.py
outputs:
  sjdb_out:
    type: File
    outputBinding:
      glob: $(inputs.sjdb_out_filename)
