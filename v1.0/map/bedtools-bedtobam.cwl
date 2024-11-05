#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool
doc: |-
  Tool:    bedtools bedtobam (aka bedToBam)
  Version: v2.25.0
  Summary: Converts feature records to BAM format.

  Usage:   bedtools bedtobam [OPTIONS] -i <bed/gff/vcf> -g <genome>

  Options: 
  	-mapq	Set the mappinq quality for the BAM records.
  		(INT) Default: 255

  	-bed12	The BED file is in BED12 format.  The BAM CIGAR
  		string will reflect BED "blocks".

  	-ubam	Write uncompressed BAM output. Default writes compressed BAM.

  Notes: 
  	(1)  BED files must be at least BED4 to create BAM (needs name field).
requirements:
  InlineJavascriptRequirement: {}
  NetworkAccess:
    networkAccess: true
  LoadListingRequirement:
    loadListing: deep_listing
hints:
  DockerRequirement:
    dockerPull: dukegcb/bedtools
inputs:
  i:
    type: File
    inputBinding:
      position: 3
      prefix: -i
    doc: Input <bed/gff/vcf> file to be converted to BAM format
  ubam:
    type: boolean?
    inputBinding:
      position: 1
      prefix: -ubam
    doc: |
      Write uncompressed BAM output. Default writes compressed BAM.
  mapq:
    type: int?
    inputBinding:
      position: 1
      prefix: -mapq
    doc: |
      Set the mappinq quality for the BAM records.
      (INT) Default: 255
  bed12:
    type: string?
    inputBinding:
      position: 1
      prefix: -bed12
    doc: |
      The BED file is in BED12 format.  The BAM CIGAR
      string will reflect BED "blocks".
  g:
    type: File
    inputBinding:
      position: 4
      prefix: -g
    doc: Genome chromosome sizes file
baseCommand:
- bedtools
- bedtobam
stdout: $(inputs.i.path.replace(/^.*[\\\/]/, '').replace(/\.[^/.]+$/, "") + '.bam')
outputs:
  bam_file:
    type: File
    outputBinding:
      glob: $(inputs.i.path.replace(/^.*[\\\/]/, '').replace(/\.[^/.]+$/, "") + '.bam')
