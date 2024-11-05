#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool
doc: Get number of processed reads from Bowtie log.
requirements:
  InlineJavascriptRequirement: {}
  ShellCommandRequirement: {}
  NetworkAccess:
    networkAccess: true
  LoadListingRequirement:
    loadListing: deep_listing
hints:
  DockerRequirement:
    dockerPull: reddylab/workflow-utils:ggr
inputs:
  preseq_c_curve_outfile: {type: File, inputBinding: {}}
baseCommand: percent-uniq-reads-from-preseq.sh
stdout: $(inputs.preseq_c_curve_outfile.path.replace(/^.*[\\\/]/, '').replace(/\.[^/.]+$/,
  "") + '.percentage_unique_reads.txt')
outputs:
  output:
    type: File
    outputBinding:
      glob: $(inputs.preseq_c_curve_outfile.path.replace(/^.*[\\\/]/, '').replace(/\.[^/.]+$/,
        "") + '.percentage_unique_reads.txt')
