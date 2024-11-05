#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool
requirements:
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing: [$(inputs.bam)]
  NetworkAccess:
    networkAccess: true
  LoadListingRequirement:
    loadListing: deep_listing
hints:
  DockerRequirement:
    dockerPull: dukegcb/samtools:1.3
inputs:
  bam:
    type: File
    inputBinding:
      position: 1
    secondaryFiles:
    - .bai
    doc: Bam file (it should be indexed)
baseCommand: [samtools, idxstats]
stdout: $(inputs.bam.basename + ".idxstats")
outputs:
  idxstats_file:
    type: File
    doc: |
      Idxstats output file. TAB-delimited with each line consisting of reference
      sequence name, sequence length, # mapped reads and # unmapped reads
    outputBinding:
      glob: $(inputs.bam.basename + ".idxstats")
