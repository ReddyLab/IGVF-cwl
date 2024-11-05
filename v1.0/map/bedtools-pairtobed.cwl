#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool
doc: |-
  Tool:    bedtools pairtobed (aka pairToBed)
  Version: v2.25.0
  Summary: Report overlaps between a BEDPE file and a BED/GFF/VCF file.

  Usage:   bedtools pairtobed [OPTIONS] -a <bedpe> -b <bed/gff/vcf>

  Options: 
  	-abam	The A input file is in BAM format.  Output will be BAM as well. Replaces -a.
  		- Requires BAM to be grouped or sorted by query.

  	-ubam	Write uncompressed BAM output. Default writes compressed BAM.

  		is to write output in BAM when using -abam.

  	-bedpe	When using BAM input (-abam), write output as BEDPE. The default
  		is to write output in BAM when using -abam.

  	-ed	Use BAM total edit distance (NM tag) for BEDPE score.
  		- Default for BEDPE is to use the minimum of
  		  of the two mapping qualities for the pair.
  		- When -ed is used the total edit distance
  		  from the two mates is reported as the score.

  	-f	Minimum overlap required as fraction of A (e.g. 0.05).
  		Default is 1E-9 (effectively 1bp).

  	-s	Require same strandedness when finding overlaps.
  		Default is to ignore stand.
  		Not applicable with -type inspan or -type outspan.

  	-S	Require different strandedness when finding overlaps.
  		Default is to ignore stand.
  		Not applicable with -type inspan or -type outspan.

  	-type 	Approach to reporting overlaps between BEDPE and BED.

  		either	Report overlaps if either end of A overlaps B.
  			- Default.
  		neither	Report A if neither end of A overlaps B.
  		both	Report overlaps if both ends of A overlap  B.
  		xor	Report overlaps if one and only one end of A overlaps B.
  		notboth	Report overlaps if neither end or one and only one 
  			end of A overlap B.  That is, xor + neither.

  		ispan	Report overlaps between [end1, start2] of A and B.
  			- Note: If chrom1 <> chrom2, entry is ignored.

  		ospan	Report overlaps between [start1, end2] of A and B.
  			- Note: If chrom1 <> chrom2, entry is ignored.

  		notispan	Report A if ispan of A doesn't overlap B.
  				- Note: If chrom1 <> chrom2, entry is ignored.

  		notospan	Report A if ospan of A doesn't overlap B.
  				- Note: If chrom1 <> chrom2, entry is ignored.

  Refer to the BEDTools manual for BEDPE format.
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
  aFile:
    type: File?
    inputBinding:
      position: 1
      prefix: -a
    doc: <bedpe>
  bFile:
    type: File
    inputBinding:
      position: 4
      prefix: -b
    doc: <bed/gff/vcf>
  abam:
    type: File?
    inputBinding:
      position: 1
      prefix: -abam
    doc: 'The A input file is in BAM format.  Output will be BAM as well. Replaces
      -a. - Requires BAM to be grouped or sorted by query. '
  ubam:
    type: boolean?
    inputBinding:
      position: 1
      prefix: -ubam
    doc: |
      Write uncompressed BAM output. Default writes compressed BAM.
  bedpe:
    type: boolean?
    inputBinding:
      position: 1
      prefix: -bedpe
    doc: |
      When using BAM input (-abam), write output as BEDPE. The default
      is to write output in BAM when using -abam.
  ed:
    type: boolean?
    inputBinding:
      position: 1
      prefix: -ed
    doc: |
      Use BAM total edit distance (NM tag) for BEDPE score.
      - Default for BEDPE is to use the minimum of
      of the two mapping qualities for the pair.
      - When -ed is used the total edit distance
      from the two mates is reported as the score.
  f:
    type: int?
    inputBinding:
      position: 1
      prefix: -f
    doc: |
      Minimum overlap required as fraction of A (e.g. 0.05).
      Default is 1E-9 (effectively 1bp).
  s:
    type: boolean?
    inputBinding:
      position: 1
      prefix: -s
    doc: |
      Require same strandedness when finding overlaps.
      Default is to ignore stand.
      Not applicable with -type inspan or -type outspan.
  S:
    type: boolean?
    inputBinding:
      position: 1
      prefix: -S
    doc: |
      Require different strandedness when finding overlaps.
      Default is to ignore stand.
      Not applicable with -type inspan or -type outspan.
  type:
    type: string?
    inputBinding:
      position: 1
      prefix: -type
    doc: |
      	Approach to reporting overlaps between BEDPE and BED.
      either	Report overlaps if either end of A overlaps B.
      - Default.
      neither	Report A if neither end of A overlaps B.
      both	Report overlaps if both ends of A overlap  B.
      xor	Report overlaps if one and only one end of A overlaps B.
      notboth	Report overlaps if neither end or one and only one
      end of A overlap B.  That is, xor + neither.
      ispan	Report overlaps between [end1, start2] of A and B.
      - Note: If chrom1 <> chrom2, entry is ignored.
      ospan	Report overlaps between [start1, end2] of A and B.
      - Note: If chrom1 <> chrom2, entry is ignored.
      notispan	Report A if ispan of A doesn't overlap B.
      - Note: If chrom1 <> chrom2, entry is ignored.
      notospan	Report A if ospan of A doesn't overlap B.
      - Note: If chrom1 <> chrom2, entry is ignored.
      Refer to the BEDTools manual for BEDPE format.
  outfile:
    type: string?
    doc: |
      Output filename return by this tool
baseCommand:
- bedtools
- pairtobed
stdout: |
  ${return inputs.outfile || inputs.abam.basename.replace(/\.[^/.]+$/, '') + (inputs.bedpe ? '.bedpe' : '.bam')}
outputs:
  filtered:
    type: File
    outputBinding:
      glob: |
        ${return inputs.outfile || inputs.abam.basename.replace(/\.[^/.]+$/, '') + (inputs.bedpe ? '.bedpe' : '.bam')}
