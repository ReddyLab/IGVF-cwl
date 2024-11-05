#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool
doc: |-
  Tool:    bedtools intersect (aka intersectBed)
  Version: v2.25.0
  Summary: Report overlaps between two feature files.

  Usage:   bedtools intersect [OPTIONS] -a <bed/gff/vcf/bam> -b <bed/gff/vcf/bam>

  	Note: -b may be followed with multiple databases and/or 
  	wildcard (*) character(s). 
  Options: 
  	-wa	Write the original entry in A for each overlap.

  	-wb	Write the original entry in B for each overlap.
  		- Useful for knowing _what_ A overlaps. Restricted by -f and -r.

  	-loj	Perform a "left outer join". That is, for each feature in A
  		report each overlap with B.  If no overlaps are found, 
  		report a NULL feature for B.

  	-wo	Write the original A and B entries plus the number of base
  		pairs of overlap between the two features.
  		- Overlaps restricted by -f and -r.
  		  Only A features with overlap are reported.

  	-wao	Write the original A and B entries plus the number of base
  		pairs of overlap between the two features.
  		- Overlapping features restricted by -f and -r.
  		  However, A features w/o overlap are also reported
  		  with a NULL B feature and overlap = 0.

  	-u	Write the original A entry _once_ if _any_ overlaps found in B.
  		- In other words, just report the fact >=1 hit was found.
  		- Overlaps restricted by -f and -r.

  	-c	For each entry in A, report the number of overlaps with B.
  		- Reports 0 for A entries that have no overlap with B.
  		- Overlaps restricted by -f and -r.

  	-v	Only report those entries in A that have _no overlaps_ with B.
  		- Similar to "grep -v" (an homage).

  	-ubam	Write uncompressed BAM output. Default writes compressed BAM.

  	-s	Require same strandedness.  That is, only report hits in B
  		that overlap A on the _same_ strand.
  		- By default, overlaps are reported without respect to strand.

  	-S	Require different strandedness.  That is, only report hits in B
  		that overlap A on the _opposite_ strand.
  		- By default, overlaps are reported without respect to strand.

  	-f	Minimum overlap required as a fraction of A.
  		- Default is 1E-9 (i.e., 1bp).
  		- FLOAT (e.g. 0.50)

  	-F	Minimum overlap required as a fraction of B.
  		- Default is 1E-9 (i.e., 1bp).
  		- FLOAT (e.g. 0.50)

  	-r	Require that the fraction overlap be reciprocal for A AND B.
  		- In other words, if -f is 0.90 and -r is used, this requires
  		  that B overlap 90 percent of A and A _also_ overlaps 90 percent of B.

  	-e	Require that the minimum fraction be satisfied for A OR B.
  		- In other words, if -e is used with -f 0.90 and -F 0.10 this requires
  		  that either 90 percent of A is covered OR 10 percent of  B is covered.
  		  Without -e, both fractions would have to be satisfied.

  	-split	Treat "split" BAM or BED12 entries as distinct BED intervals.

  	-g	Provide a genome file to enforce consistent chromosome sort order
  		across input files. Only applies when used with -sorted option.

  	-nonamecheck	For sorted data, don't throw an error if the file has different naming conventions
  			for the same chromosome. ex. "chr1" vs "chr01".

  	-sorted	Use the "chromsweep" algorithm for sorted (-k1,1 -k2,2n) input.

  	-names	When using multiple databases, provide an alias for each that
  		will appear instead of a fileId when also printing the DB record.

  	-filenames	When using multiple databases, show each complete filename
  			instead of a fileId when also printing the DB record.

  	-sortout	When using multiple databases, sort the output DB hits
  			for each record.

  	-bed	If using BAM input, write output as BED.

  	-header	Print the header from the A file prior to results.

  	-nobuf	Disable buffered output. Using this option will cause each line
  		of output to be printed as it is generated, rather than saved
  		in a buffer. This will make printing large output files 
  		noticeably slower, but can be useful in conjunction with
  		other software tools and scripts that need to process one
  		line of bedtools output at a time.

  	-iobuf	Specify amount of memory to use for input buffer.
  		Takes an integer argument. Optional suffixes K/M/G supported.
  		Note: currently has no effect with compressed files.

  Notes: 
  	(1) When a BAM file is used for the A file, the alignment is retained if overlaps exist,
  	and exlcuded if an overlap cannot be found.  If multiple overlaps exist, they are not
  	reported, as we are only testing for one or more overlaps.
requirements:
  InlineJavascriptRequirement: {}
  ShellCommandRequirement: {}
  NetworkAccess:
    networkAccess: true
  LoadListingRequirement:
    loadListing: deep_listing
hints:
  DockerRequirement:
    dockerPull: dukegcb/bedtools
inputs:
  header:
    type: boolean?
    inputBinding:
      position: 1
      prefix: -header
    doc: |
      Print the header from the A file prior to results.
  names:
    type: boolean?
    inputBinding:
      position: 1
      prefix: -names
    doc: |
      When using multiple databases, provide an alias for each that
      will appear instead of a fileId when also printing the DB record.
  nonamecheck:
    type: boolean?
    inputBinding:
      position: 1
      prefix: -nonamecheck
    doc: |
      For sorted data, don't throw an error if the file has different naming conventions
      for the same chromosome. ex. "chr1" vs "chr01".
  wao:
    type: boolean?
    inputBinding:
      position: 1
      prefix: -wao
    doc: |
      Write the original A and B entries plus the number of base
      pairs of overlap between the two features.
      - Overlapping features restricted by -f and -r.
      However, A features w/o overlap are also reported
      with a NULL B feature and overlap = 0.
  loj:
    type: boolean?
    inputBinding:
      position: 1
      prefix: -loj
    doc: |
      Perform a "left outer join". That is, for each feature in A
      report each overlap with B.  If no overlaps are found,
      report a NULL feature for B.
  split:
    type: boolean?
    inputBinding:
      position: 1
      prefix: -split
    doc: |
      Treat "split" BAM or BED12 entries as distinct BED intervals.
  sortout:
    type: boolean?
    inputBinding:
      position: 1
      prefix: -sortout
    doc: |
      When using multiple databases, sort the output DB hits
      for each record.
  wb:
    type: boolean?
    inputBinding:
      position: 1
      prefix: -wb
    doc: |
      Write the original entry in B for each overlap.
      - Useful for knowing _what_ A overlaps. Restricted by -f and -r.
  wa:
    type: boolean?
    inputBinding:
      position: 1
      prefix: -wa
    doc: |
      Write the original entry in A for each overlap.
  F:
    type: float?
    inputBinding:
      position: 1
      prefix: -F
    doc: |
      Minimum overlap required as a fraction of B.
      - Default is 1E-9 (i.e., 1bp).
      - FLOAT (e.g. 0.50)
  wo:
    type: boolean?
    inputBinding:
      position: 1
      prefix: -wo
    doc: |
      Write the original A and B entries plus the number of base
      pairs of overlap between the two features.
      - Overlaps restricted by -f and -r.
      Only A features with overlap are reported.
  output_basename_file:
    type: string
  filenames:
    type: boolean?
    inputBinding:
      position: 1
      prefix: -filenames
    doc: |
      When using multiple databases, show each complete filename
      instead of a fileId when also printing the DB record.
  S:
    type: boolean?
    inputBinding:
      position: 1
      prefix: -S
    doc: |
      Require different strandedness.  That is, only report hits in B
      that overlap A on the _opposite_ strand.
      - By default, overlaps are reported without respect to strand.
  sorted:
    type: boolean?
    inputBinding:
      position: 1
      prefix: -sorted
    doc: |
      Use the "chromsweep" algorithm for sorted (-k1,1 -k2,2n) input.
  a:
    type: File
    inputBinding:
      position: 1
      prefix: -a
    doc: Input <bed/gff/vcf/bam> file
  c:
    type: boolean?
    inputBinding:
      position: 1
      prefix: -c
    doc: |
      For each entry in A, report the number of overlaps with B.
      - Reports 0 for A entries that have no overlap with B.
      - Overlaps restricted by -f and -r.
  b:
    type: File
    inputBinding:
      position: 4
      prefix: -b
    doc: <bed/gff/vcf/bam>
  e:
    type: boolean?
    inputBinding:
      position: 1
      prefix: -e
    doc: |
      Require that the minimum fraction be satisfied for A OR B.
      - In other words, if -e is used with -f 0.90 and -F 0.10 this requires
      that either 90 percent of A is covered OR 10 percent of  B is covered.
      Without -e, both fractions would have to be satisfied.
  g:
    type: boolean?
    inputBinding:
      position: 1
      prefix: -g
    doc: |
      Provide a genome file to enforce consistent chromosome sort order
      across input files. Only applies when used with -sorted option.
  f:
    type: float?
    inputBinding:
      position: 1
      prefix: -f
    doc: |
      Minimum overlap required as a fraction of A.
      - Default is 1E-9 (i.e., 1bp).
      - FLOAT (e.g. 0.50)
  ubam:
    type: boolean?
    inputBinding:
      position: 1
      prefix: -ubam
    doc: |
      Write uncompressed BAM output. Default writes compressed BAM.
  bed:
    type: boolean?
    inputBinding:
      position: 1
      prefix: -bed
    doc: |
      If using BAM input, write output as BED.
  s:
    type: boolean?
    inputBinding:
      position: 1
      prefix: -s
    doc: |
      Require same strandedness.  That is, only report hits in B
      that overlap A on the _same_ strand.
      - By default, overlaps are reported without respect to strand.
  r:
    type: boolean?
    inputBinding:
      position: 1
      prefix: -r
    doc: |
      Require that the fraction overlap be reciprocal for A AND B.
      - In other words, if -f is 0.90 and -r is used, this requires
      that B overlap 90 percent of A and A _also_ overlaps 90 percent of B.
  u:
    type: boolean?
    inputBinding:
      position: 1
      prefix: -u
    doc: |
      Write the original A entry _once_ if _any_ overlaps found in B.
      - In other words, just report the fact >=1 hit was found.
      - Overlaps restricted by -f and -r.
  v:
    type: boolean?
    inputBinding:
      position: 1
      prefix: -v
    doc: |
      Only report those entries in A that have _no overlaps_ with B.
      - Similar to "grep -v" (an homage).
  iobuf:
    type: int?
    inputBinding:
      position: 1
      prefix: -iobuf
    doc: |
      Specify amount of memory to use for input buffer.
      Takes an integer argument. Optional suffixes K/M/G supported.
      Note: currently has no effect with compressed files.
  nobuf:
    type: boolean?
    inputBinding:
      position: 1
      prefix: -nobuf
    doc: |
      Disable buffered output. Using this option will cause each line
      of output to be printed as it is generated, rather than saved
      in a buffer. This will make printing large output files
      noticeably slower, but can be useful in conjunction with
      other software tools and scripts that need to process one
      line of bedtools output at a time.
baseCommand:
- bedtools
- intersect
stdout: $(inputs.output_basename_file + '.masked.bam')
outputs:
  file_wo_blacklist_regions:
    type: File
    outputBinding:
      glob: $(inputs.output_basename_file + '.masked.bam')
