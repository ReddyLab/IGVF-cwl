#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool
doc: |-
  Description: filters BAM file(s).


  Usage: bamtools filter [-in <filename> -in <filename> ... | -list <filelist>] [-out <filename> | [-forceCompression]] [-region <REGION>] [ [-script <filename] | [filterOptions] ]


  Input & Output:

    -in <BAM filename>                the input BAM file(s) [stdin]

    -list <filename>                  the input BAM file list, one

                                      line per file

    -out <BAM filename>               the output BAM file [stdout]

    -region <REGION>                  only read data from this

                                      genomic region (see documentation for more

                                      details)

    -script <filename>                the filter script file (see

                                      documentation for more details)

    -forceCompression                 if results are sent to stdout

                                      (like when piping to another tool),

                                      default behavior is to leave output

                                      uncompressed. Use this flag to override

                                      and force compression



  General Filters:

    -alignmentFlag <int>              keep reads with this *exact*

                                      alignment flag (for more detailed queries,

                                      see below)

    -insertSize <int>                 keep reads with insert size

                                      that matches pattern

    -mapQuality <[0-255]>             keep reads with map quality

                                      that matches pattern

    -name <string>                    keep reads with name that

                                      matches pattern

    -queryBases <string>              keep reads with motif that

                                      matches pattern

    -tag <TAG:VALUE>                  keep reads with this

                                      key=>value pair



  Alignment Flag Filters:

    -isDuplicate <true/false>         keep only alignments that are

                                      marked as duplicate? [true]

    -isFailedQC <true/false>          keep only alignments that

                                      failed QC? [true]

    -isFirstMate <true/false>         keep only alignments marked as

                                      first mate? [true]

    -isMapped <true/false>            keep only alignments that were

                                      mapped? [true]

    -isMateMapped <true/false>        keep only alignments with

                                      mates that mapped [true]

    -isMateReverseStrand <true/false> keep only alignments with mate

                                      on reverese strand? [true]

    -isPaired <true/false>            keep only alignments that were

                                      sequenced as paired? [true]

    -isPrimaryAlignment <true/false>  keep only alignments marked as

                                      primary? [true]

    -isProperPair <true/false>        keep only alignments that

                                      passed PE resolution? [true]

    -isReverseStrand <true/false>     keep only alignments on

                                      reverse strand? [true]

    -isSecondMate <true/false>        keep only alignments marked as

                                      second mate? [true]

    -isSingleton <true/false>         keep only singletons [true]



  Help:

    --help, -h                        shows this help text
requirements:
  InlineJavascriptRequirement: {}
  ShellCommandRequirement: {}
  NetworkAccess:
    networkAccess: true
  LoadListingRequirement:
    loadListing: deep_listing
hints:
  DockerRequirement:
    dockerPull: reddylab/bamtools:2.2.3
inputs:
  isMapped:
    type: string?
    inputBinding:
      position: 1
      prefix: -isMapped
    doc: |
      <true/false>            keep only alignments that were
      mapped? [true]
  mapQuality:
    type: string?
    inputBinding:
      position: 1
      prefix: -mapQuality
    doc: |
      <[0-255]>
      keep reads with map quality that matches pattern (e.g. '>50')
  isPaired:
    type: string?
    inputBinding:
      position: 1
      prefix: -isPaired
    doc: |
      <true/false>            keep only alignments that were
      sequenced as paired? [true]
  isFailedQC:
    type: string?
    inputBinding:
      position: 1
      prefix: -isFailedQC
    doc: |
      <true/false>          keep only alignments that
      failed QC? [true]
  isReverseStrand:
    type: string?
    inputBinding:
      position: 1
      prefix: -isReverseStrand
    doc: |
      <true/false>     keep only alignments on
      reverse strand? [true]
  tag:
    type: string?
    inputBinding:
      position: 1
      prefix: -tag
    doc: |
      <TAG:VALUE>
      keep reads with this key=>value pair
  in:
    type: File[]
    inputBinding:
      position: 1
      prefix: -in
    doc: |
      <BAM filename>
      the input BAM file(s) [stdin if omitted]
  isProperPair:
    type: string?
    inputBinding:
      position: 1
      prefix: -isProperPair
    doc: |
      <true/false>        keep only alignments that
      passed PE resolution? [true]
  out:
    type: string?
    inputBinding:
      position: 1
      prefix: -out
    doc: |
      <BAM filename>
      the output BAM filename [stdout ]
  forceCompression:
    type: boolean?
    inputBinding:
      position: 1
      prefix: -forceCompression
    doc: |
      if results are sent to stdout\n(like when piping to another tool),
      default behavior is to leave output
      uncompressed. Use this flag to override
      and force compression.
  script:
    type: File?
    inputBinding:
      position: 1
      prefix: -script
    doc: |
      <filename>
      the filter script file (see documentation for more details)
  isPrimaryAlignment:
    type: string?
    inputBinding:
      position: 1
      prefix: -isPrimaryAlignment
    doc: |
      <true/false>  keep only alignments marked as
      primary? [true]
  alignmentFlag:
    type: int?
    inputBinding:
      position: 1
      prefix: -alignmentFlag
    doc: |
      <int>
      keep reads with this *exact*
      alignment flag (for more detailed queries, see below)
  isDuplicate:
    type: string?
    inputBinding:
      position: 1
      prefix: -isDuplicate
    doc: |
      <true/false>
      keep only alignments that are marked as duplicate? [true]
  isFirstMate:
    type: string?
    inputBinding:
      position: 1
      prefix: -isFirstMate
    doc: |
      <true/false>         keep only alignments marked as
      first mate? [true]
  isSecondMate:
    type: string?
    inputBinding:
      position: 1
      prefix: -isSecondMate
    doc: |
      <true/false>        keep only alignments marked as
      second mate? [true]
  name:
    type: string?
    inputBinding:
      position: 1
      prefix: -name
    doc: |
      <string>
      keep reads with name that matches pattern
  region:
    type: string?
    inputBinding:
      position: 1
      prefix: -region
    doc: |
      <REGION>
      only read data from this
      genomic region (see documentation for more
      details)
  isMateMapped:
    type: string?
    inputBinding:
      position: 1
      prefix: -isMateMapped
    doc: |
      <true/false>        keep only alignments with
      mates that mapped [true]
  insertSize:
    type: int?
    inputBinding:
      position: 1
      prefix: -insertSize
    doc: |
      <int>
      keep reads with insert size that matches pattern
  queryBases:
    type: string?
    inputBinding:
      position: 1
      prefix: -queryBases
    doc: |
      <string>
      keep reads with motif that matches pattern
  isMateReverseStrand:
    type: string?
    inputBinding:
      position: 1
      prefix: -isMateReverseStrand
    doc: |
      <true/false> keep only alignments with mate
      on reverese strand? [true]
  isSingleton:
    type: string?
    inputBinding:
      position: 1
      prefix: -isSingleton
    doc: |
      <true/false>         keep only singletons [true]
      Help:
      --help, -h                        shows this help text
baseCommand:
- bamtools
- filter
outputs:
  output_file:
    type: File
    outputBinding:
      glob: $(inputs.out)
