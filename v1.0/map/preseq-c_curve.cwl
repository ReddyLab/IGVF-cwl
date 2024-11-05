#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool
doc: |-
  Usage: c_curve [OPTIONS] <sorted-bed-file>

  Options:
    -o, -output   yield output file (default: stdout) 
    -s, -step     step size in extrapolations (default: 1e+06) 
    -v, -verbose  print more information 
    -P, -pe       input is paired end read file 
    -H, -hist     input is a text file containing the observed histogram 
    -V, -vals     input is a text file containing only the observed counts 
    -B, -bam      input is in BAM format 
    -l, -seg_len  maximum segment length when merging paired end bam reads 
                  (default: 5000) 

  Help options:
    -?, -help     print this help message 
        -about    print about message
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
  V:
    type: File?
    inputBinding:
      position: 1
      prefix: -V
    doc: |
      -vals     input is a text file containing only the observed counts 
  B:
    type: boolean
    default: true
    inputBinding:
      position: 1
      prefix: -B
    doc: |
      -bam      input is in BAM format 
  output_file_basename:
    type: string
  H:
    type: File?
    inputBinding:
      position: 1
      prefix: -H
    doc: |
      -hist     input is a text file containing the observed histogram 
  v:
    type: boolean
    default: false
    inputBinding:
      position: 1
      prefix: -v
    doc: |
      -verbose  print more information 
  input_sorted_file:
    type: File
    inputBinding:
      position: 2
    doc: Sorted bed or BAM file
  l:
    type: int?
    inputBinding:
      position: 1
      prefix: -l
    doc: |
      -seg_len  maximum segment length when merging paired end bam reads 
      (default: 5000)
      Help options:
      -?, -help     print this help message
      -about    print about message
  s:
    type: float?
    inputBinding:
      position: 1
      prefix: -s
    doc: |
      -step     step size in extrapolations (default: 1e+06) 
  pe:
    type: boolean?
    inputBinding:
      position: 1
      prefix: -P
    doc: |
      -pe       input is paired end read file 
baseCommand:
- preseq
- c_curve
stdout: $(inputs.output_file_basename + '.preseq_c_curve.txt')
outputs:
  output_file:
    type: File
    outputBinding:
      glob: $(inputs.output_file_basename + '.preseq_c_curve.txt')
