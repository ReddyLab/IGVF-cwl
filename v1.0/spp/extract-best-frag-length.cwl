#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool
doc: Extracts best fragment length from SPP output text file
requirements:
  NetworkAccess:
    networkAccess: true
  LoadListingRequirement:
    loadListing: deep_listing
hints:
  DockerRequirement:
    dockerPull: reddylab/workflow-utils:ggr
inputs:
  input_spp_txt_file:
    type: File
    inputBinding:
      position: 1
baseCommand: extract-best-frag-length.sh
stdout: best_frag_length
outputs:
  output_best_frag_length:
    type: float
    outputBinding:
      glob: best_frag_length
      loadContents: true
      outputEval: $(Number(self[0].contents.replace('\n', '')))
