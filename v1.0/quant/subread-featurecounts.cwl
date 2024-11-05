#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool
doc: featureCounts is a highly efficient general-purpose read summarization program
  that counts mapped reads for genomic features such as genes, exons, promoter, gene
  bodies, genomic bins and chromosomal locations. It can be used to count both RNA-seq
  and genomic DNA-seq reads.
requirements:
  InlineJavascriptRequirement: {}
  NetworkAccess:
    networkAccess: true
  LoadListingRequirement:
    loadListing: deep_listing
hints:
  DockerRequirement:
    dockerPull: reddylab/subread:1.4.6-p4
inputs:
  primary:
    type: boolean?
    inputBinding:
      position: 1
      prefix: --primary
    doc: |
      	If specified, only primary alignments will be counted. Primary
      and secondary alignments are identified using bit 0x100 in the
      Flag field of SAM/BAM files. All primary alignments in a dataset
      will be counted no matter they are from multi-mapping reads or
      not ('-M' is ignored).
  output_filename:
    type: string
    inputBinding:
      position: 3
      prefix: -o
    doc: |
      -o <input>
      Give the name of the output file. The output file contains
      the number of reads assigned to each meta-feature (or each
      feature if -f is specified). A meta-feature is the aggregation
      of features, grouped by using gene identifiers. Please refer
      to the users guide for more details.
  read2pos:
    type: int?
    inputBinding:
      position: 1
      prefix: --read2pos
    doc: |
      <5:3>            The read is reduced to its 5' most base or 3'
      most base. Read summarization is then performed based on the
      single base which the read is reduced to.
  B:
    type: boolean?
    inputBinding:
      position: 1
      prefix: -B
    doc: |2
             	If specified, only fragments that have both ends 
      successfully aligned will be considered for summarization.
      This option is only applicable for paired-end reads.
  ignoreDup:
    type: boolean?
    inputBinding:
      position: 1
      prefix: --ignoreDup
    doc: |
      	If specified, reads that were marked as
      duplicates will be ignored. Bit Ox400 in FLAG field of SAM/BAM
      file is used for identifying duplicate reads. In paired end
      data, the entire read pair will be ignored if at least one end
      is found to be a duplicate read.
  fraction:
    type: boolean?
    inputBinding:
      position: 1
      prefix: --fraction
    doc: |
      If specified, a fractional count 1/n will be generated for each
      multi-mapping read, where n is the number of alignments (indica-
      ted by 'NH' tag) reported for the read. This option must be used
      together with the '-M' option.
  A:
    type: File?
    inputBinding:
      position: 1
      prefix: -A
    doc: |
      <input>	Specify the name of a file including aliases of chromosome
      names. The file should be a comma delimited text file that
      includes two columns. The first column gives the chromosome
      names used in the annotation and the second column gives the
      chromosome names used by reads. This file should not contain
      header lines. Names included in this file are case sensitive.
  C:
    type: boolean?
    inputBinding:
      position: 1
      prefix: -C
    doc: |2
             	If specified, the chimeric fragments (those fragments that 
      have their two ends aligned to different chromosomes) will
      NOT be included for summarization. This option is only
      applicable for paired-end read data.
  countSplitAlignmentsOnly:
    type: boolean?
    inputBinding:
      position: 1
      prefix: --countSplitAlignmentsOnly
    doc: |
      	If specified, only split alignments (CIGAR
      strings containing letter `N') will be counted. All the other
      alignments will be ignored. An example of split alignments is
      the exon-spanning reads in RNA-seq data.
      Optional paired-end parameters:
  D:
    type: int?
    inputBinding:
      position: 1
      prefix: -D
    doc: |
      <int>  	Maximum fragment/template length, 600 by default.
  F:
    type: string?
    inputBinding:
      position: 1
      prefix: -F
    doc: |
      <input>	Specify the format of the annotation file. Acceptable formats
      include `GTF' and `SAF'. `GTF' by default. Please refer to the
      users guide for SAF annotation format.
  v:
    type: boolean?
    inputBinding:
      position: 1
      prefix: -v
    doc: |2
             	Output version of the program.
  M:
    type: boolean?
    inputBinding:
      position: 1
      prefix: -M
    doc: |2
             	If specified, multi-mapping reads/fragments will be counted (ie.
      a multi-mapping read will be counted up to N times if it has N
      reported mapping locations). The program uses the `NH' tag to
      find multi-mapping reads.
  O:
    type: boolean?
    inputBinding:
      position: 1
      prefix: -O
    doc: |2
             	If specified, reads (or fragments if -p is specified) will
      be allowed to be assigned to more than one matched meta-
      feature (or feature if -f is specified).
  Q:
    type: int?
    inputBinding:
      position: 1
      prefix: -Q
    doc: |
      <int>  	The minimum mapping quality score a read must satisfy in order
      to be counted. For paired-end reads, at least one end should
      satisfy this criteria. 0 by default.
  P:
    type: boolean?
    inputBinding:
      position: 1
      prefix: -P
    doc: |2
             	If specified, paired-end distance will be checked when assigning
      fragments to meta-features or features. This option is only
      applicable when -p is specified. The distance thresholds should
      be specified using -d and -D options.
  readExtension5:
    type: int?
    inputBinding:
      position: 1
      prefix: --readExtension5
    doc: |
      <int>      Reads are extended upstream by <int> bases from
      their 5' end.
  readExtension3:
    type: int?
    inputBinding:
      position: 1
      prefix: --readExtension3
    doc: |
      <int>      Reads are extended upstream by <int> bases from
      their 3' end.
  T:
    type: int?
    inputBinding:
      position: 1
      prefix: -T
    doc: |
      <int>  	Number of the threads. 1 by default.
  minReadOverlap:
## >>> Currently not supported <<<
#  - id: R
#    type:
#      - 'null'
#      - boolean
#    description: "       \tOutput read counting result for each read/fragment. For each\ninput read file, read counting results for reads/fragments will\nbe saved to a tab-delimited file that contains four columns\nincluding read name, status(assigned or the reason if not\nassigned), name of target feature/meta-feature and number of\nhits if the read/fragment is counted multiple times. Name of\nthe file is the same as name of the input read file except a\nsuffix `.featureCounts' is added.\n"
#    inputBinding:
#      position: 1
#      prefix: '-R'
## >>> Currently not supported <<<
    type: int?
    inputBinding:
      position: 1
      prefix: --minReadOverlap
    doc: |
      <int>      Specify the minimum number of overlapped bases
      required to assign a read to a feature. 1 by default. Negative
      values are permitted, indicating a gap being allowed between a
      read and a feature.
  input_files:
    type: File[]
    inputBinding:
      position: 4
    doc: |
      <input_files>
      Give the names of input read files that include the read
      mapping results. Format of input files is automatically
      determined (SAM or BAM). Paired-end reads will be
      automatically re-ordered if it is found that reads from the
      same pair are not adjacent to each other. Multiple files can
      be provided at the same time.
  d:
    type: int?
    inputBinding:
      position: 1
      prefix: -d
    doc: |
      <int>  	Minimum fragment/template length, 50 by default.
  g:
    type: string?
    inputBinding:
      position: 1
      prefix: -g
    doc: |
      <input>	Specify the attribute type used to group features (eg. exons)
      into meta-features (eg. genes), when GTF annotation is provided.
      `gene_id' by default. This attribute type is usually the gene
      identifier. This argument is useful for the meta-feature level
      summarization.
  f:
    type: boolean?
    inputBinding:
      position: 1
      prefix: -f
    doc: |2
             	If specified, read summarization will be performed at the 
      feature level (eg. exon level). Otherwise, it is performed at
      meta-feature level (eg. gene level).
  p:
    type: boolean?
    inputBinding:
      position: 1
      prefix: -p
    doc: |2
             	If specified, fragments (or templates) will be counted instead
      of reads. This option is only applicable for paired-end reads.
      The two reads from the same fragment must be adjacent to each
      other in the provided SAM/BAM file.
  s:
    type: int?
    inputBinding:
      position: 1
      prefix: -s
    doc: |
      <int>  	Indicate if strand-specific read counting should be performed.
      It has three possible values:  0 (unstranded), 1 (stranded) and
      2 (reversely stranded). 0 by default.
  donotsort:
    type: boolean?
    inputBinding:
      position: 1
      prefix: --donotsort
    doc: |2
        If specified, paired end reads will not be reordered even if
      reads from the same pair were found not to be next to each other
      in the input.
  t:
    type: string?
    inputBinding:
      position: 1
      prefix: -t
    doc: |
      <input>	Specify the feature type. Only rows which have the matched
      matched feature type in the provided GTF annotation file
      will be included for read counting. `exon' by default.
  annotation_file:
    type: File
    inputBinding:
      position: 2
      prefix: -a
    doc: |
      -a <input>
      Give the name of the annotation file. The program assumes
      that the provided annotation file is in GTF format. Use -F
      option to specify other annotation formats.
baseCommand:
- featureCounts
outputs:
  output_files:
    type: File
    outputBinding:
      glob: $(inputs.output_filename)
