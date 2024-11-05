#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool
doc: |-
  Usage: lc_extrap [OPTIONS] <sorted-bed-file>

  Options:
    -o, -output      yield output file (default: stdout) 
    -e, -extrap      maximum extrapolation (default: 1e+10) 
    -s, -step        step size in extrapolations (default: 1e+06) 
    -n, -bootstraps  number of bootstraps (default: 100), 
    -c, -cval        level for confidence intervals (default: 0.95) 
    -x, -terms       maximum number of terms 
    -v, -verbose     print more information 
    -B, -bam         input is in BAM format 
    -l, -seg_len     maximum segment length when merging paired end bam reads 
                     (default: 5000) 
    -P, -pe          input is paired end read file 
    -V, -vals        input is a text file containing only the observed counts 
    -H, -hist        input is a text file containing the observed histogram 
    -Q, -quick       quick mode, estimate yield without bootstrapping for 
                     confidence intervals 
    -D, -defects     defects mode to extrapolate without testing for defects 

  Help options:
    -?, -help        print this help message 
        -about       print about message
requirements:
  InlineJavascriptRequirement: {}
  NetworkAccess:
    networkAccess: true
  LoadListingRequirement:
    loadListing: deep_listing
hints:
  DockerRequirement:
    dockerPull: reddylab/preseq:2.0
inputs:
  c:
    type: boolean?
    inputBinding:
      position: 1
      prefix: -c
    doc: |
      -cval        level for confidence intervals (default: 0.95) 
  B:
    type: boolean
    default: true
    inputBinding:
      position: 1
      prefix: -B
    doc: |
      -bam         input is in BAM format 
  e:
    type: boolean?
    inputBinding:
      position: 1
      prefix: -e
    doc: |
      -extrap      maximum extrapolation (default: 1e+10) 
  output_file_basename:
    type: string
  H:
    type: string?
    inputBinding:
      position: 1
      prefix: -H
    doc: |
      -hist        input is a text file containing the observed histogram 
  pe:
    type: boolean?
    inputBinding:
      position: 1
      prefix: -P
    doc: |
      -pe          input is paired end read file 
  input_sorted_file:
    type: File
    inputBinding:
      position: 2
    doc: Sorted bed or BAM file
  l:
    type: boolean?
    inputBinding:
      position: 1
      prefix: -l
    doc: |
      -seg_len     maximum segment length when merging paired end bam reads 
      (default: 5000)
  n:
    type: boolean?
    inputBinding:
      position: 1
      prefix: -n
    doc: |
      -bootstraps  number of bootstraps (default: 100), 
  Q:
    type: boolean?
    inputBinding:
      position: 1
      prefix: -Q
    doc: |
      -quick       quick mode, estimate yield without bootstrapping for 
      confidence intervals
  s:
    type: float?
    inputBinding:
      position: 1
      prefix: -s
    doc: |
      -step        step size in extrapolations (default: 1e+06) 
  v:
    type: boolean?
    inputBinding:
      position: 1
      prefix: -v
    doc: |
      -verbose     print more information 
  x:
    type: boolean?
    inputBinding:
      position: 1
      prefix: -x
    doc: |
      -terms       maximum number of terms 
  V:
    type: string?
    inputBinding:
      position: 1
      prefix: -V
    doc: |
      -vals        input is a text file containing only the observed counts 
  D:
    type: boolean
    default: false
    inputBinding:
      position: 1
      prefix: -D
    doc: |
      -defects     defects mode to extrapolate without testing for defects 
baseCommand:
- preseq
- lc_extrap
stdout: $(inputs.output_file_basename + '.preseq_lc_extrap.txt')
outputs:
  output_file:
    type: File
    outputBinding:
      glob: $(inputs.output_file_basename + '.preseq_lc_extrap.txt')
