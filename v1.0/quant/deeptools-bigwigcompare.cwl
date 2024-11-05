#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool
doc: |-
  usage: bigwigCompare [-h] [--version] [--binSize INT bp]
                       [--region CHR:START:END] [--numberOfProcessors INT]
                       [--verbose] --outFileName FILENAME
                       [--outFileFormat {bigwig,bedgraph}] --bigwig1 Bigwig file
                       --bigwig2 Bigwig file [--scaleFactors SCALEFACTORS]
                       [--pseudocount PSEUDOCOUNT]
                       [--ratio {log2,ratio,subtract,add,reciprocal_ratio}]
                       [--skipNonCoveredRegions]
  This tool compares two bigWig files based on the number of mapped reads. To compare the bigWig files, the genome is partitioned into bins of equal size, then the number of reads found in each BAM file are counted per bin and finally a summary value is reported. This value can be the ratio of the number of readsper bin, the log2 of the ratio, the sum or the difference. optional arguments:
    -h, --help            show this help message and exit
    --bigwig1 Bigwig file, -b1 Bigwig file
                          Bigwig file 1. Usually the file for the treatment.
                          (default: None)
    --bigwig2 Bigwig file, -b2 Bigwig file
                          Bigwig file 2. Usually the file for the control.
                          (default: None)
    --scaleFactors SCALEFACTORS
                          Set this parameter to multipy the bigwig values by a
                          constant. The format is scaleFactor1:scaleFactor2. For
                          example 0.7:1 to scale the first bigwig file by 0.7
                          while not scaling the second bigwig file (default:
                          None)
    --pseudocount PSEUDOCOUNT
                          small number to avoid x/0. Only useful when ratio =
                          log2 or ratio (default: 1)
    --ratio {log2,ratio,subtract,add,reciprocal_ratio}
                          The default is to compute the log2(ratio) between the
                          two samples. The reciprocal ratio returns the the
                          negative of the inverse of the ratio if the ratio is
                          less than 0. The resulting values are interpreted as
                          negative fold changes. Other possible operations are :
                          simple ratio, subtraction, sum (default: log2)
    --skipNonCoveredRegions, --skipNAs
                          This parameter determines if non-covered regions
                          (regions without a score) in the bigWig files should
                          be skipped. The default is to treat those regions as
                          having a value of zero. The decision to skip non-
                          covered regions depends on the interpretation of the
                          data. Non-covered regions in a bigWig file may
                          represent repetitive regions that should be skipped.
                          Alternatively, the interpretation of non-covered
                          regions as zeros may be wrong and this option should
                          be used (default: False)
  Optional arguments:
    --version             show program's version number and exit
    --binSize INT bp, -bs INT bp
                          Size of the bins, in bases, for the output of the
                          bigwig/bedgraph file. (default: 50)
    --region CHR:START:END, -r CHR:START:END
                          Region of the genome to limit the operation to - this
                          is useful when testing parameters to reduce the
                          computing time. The format is chr:start:end, for
                          example --region chr10 or --region
                          chr10:456700:891000. (default: None)
    --numberOfProcessors INT, -p INT
                          Number of processors to use. Type "max/2" to use half
                          the maximum number of processors or "max" to use all
                          available processors. (default: max/2)
    --verbose, -v         Set to see processing messages. (default: False)
  Output:
    --outFileName FILENAME, -o FILENAME
                          Output file name. (default: None)
    --outFileFormat {bigwig,bedgraph}, -of {bigwig,bedgraph}
                          Output file type. Either "bigwig" or "bedgraph".
                          (default: bigwig)
requirements:
  InlineJavascriptRequirement: {}
  NetworkAccess:
    networkAccess: true
  LoadListingRequirement:
    loadListing: deep_listing
hints:
  DockerRequirement:
    dockerPull: reddylab/deeptools:3.0.1
inputs:
  numberOfProcessors:
    type: int?
    inputBinding:
      position: 1
      prefix: --numberOfProcessors
    doc: |
      INT, -p INT
      Number of processors to use. Type "max/2" to use half
      the maximum number of processors or "max" to use all
      available processors. (default: max/2)
  operation:
    type: string?
    inputBinding:
      position: 1
      prefix: --operation
    doc: |
      The default is to output the log2ratio of the two
      samples. The reciprocal ratio returns the the negative
      of the inverse of the ratio if the ratio is less than
      0. The resulting values are interpreted as negative
      fold changes. *NOTE*: Only with --operation subtract
      can --normalizeUsing RPGC or --normalizeUsing RPKM be
      used. Instead of performing a computation using both
      files, the scaled signal can alternatively be output
      for the first or second file using the '--operation
      first' or '--operation second' (default: log2)
  bigwig1:
    type: File
    inputBinding:
      position: 1
      prefix: --bigwig1
    doc: |
      Bigwig file, -b1 Bigwig file
      Bigwig file 1. Usually the file for the treatment.
      (default: None)
  bigwig2:
    type: File
    inputBinding:
      position: 1
      prefix: --bigwig2
    doc: |
      Bigwig file, -b2 Bigwig file
      Bigwig file 2. Usually the file for the control.
      (default: None)
  outFileName:
    type: string?
    doc: |
      FILENAME, -o FILENAME
      Output file name. (default: None)
  region:
    type: string?
    inputBinding:
      position: 1
      prefix: --region
    doc: |
      CHR:START:END, -r CHR:START:END
      Region of the genome to limit the operation to - this
      is useful when testing parameters to reduce the
      computing time. The format is chr:start:end, for
      example --region chr10 or --region
      chr10:456700:891000. (default: None)
  binSize:
    type: int?
    inputBinding:
      position: 1
      prefix: --binSize
    doc: |
      INT bp, -bs INT bp
      Size of the bins, in bases, for the output of the
      bigwig/bedgraph file. (default: 50)
  version:
    type: boolean?
    inputBinding:
      position: 1
      prefix: --version
    doc: |2
                  show program's version number and exit
  pseudocount:
    type: int?
    inputBinding:
      position: 1
      prefix: --pseudocount
    doc: |
      PSEUDOCOUNT
      small number to avoid x/0. Only useful when ratio =
      log2 or ratio (default: 1)
  outFileFormat:
    type: string?
    inputBinding:
      position: 1
      prefix: --outFileFormat
    doc: |
      {bigwig,bedgraph}, -of {bigwig,bedgraph}
      Output file type. Either "bigwig" or "bedgraph".
      (default: bigwig)
  scaleFactors:
    type: float?
    inputBinding:
      position: 1
      prefix: --scaleFactors
    doc: |
      SCALEFACTORS
      Set this parameter to multipy the bigwig values by a
      constant. The format is scaleFactor1:scaleFactor2. For
      example 0.7:1 to scale the first bigwig file by 0.7
      while not scaling the second bigwig file (default:
      None)
  output_suffix:
    type: string?
    doc: |
      Suffix used to replace bigwig1 extension (please, include extension)
  verbose:
    type: boolean?
    inputBinding:
      position: 1
      prefix: --verbose
    doc: |
      --verbose
      Set to see processing messages. (default: False)
baseCommand: bigwigCompare
arguments:
- valueFrom: ${ if (inputs.outFileName) return inputs.outFileName; if (inputs.output_suffix)
    return inputs.bigwig1.path.replace(/^.*[\\\/]/, "").replace(/\.[^/.]+$/, "") +
    inputs.output_suffix; if (inputs.outFileFormat == "bedgraph") return inputs.bigwig1.path.replace(/^.*[\\\/]/,
    "").replace(/\.[^/.]+$/, "") + ".compared.bdg"; return inputs.bigwig1.path.replace(/^.*[\\\/]/,
    "").replace(/\.[^/.]+$/, "") + ".compared.bw"; }
  prefix: --outFileName
  position: 3
outputs:
  output:
    type: File
    outputBinding:
      glob: ${ if (inputs.outFileName) return inputs.outFileName; if (inputs.output_suffix)
        return inputs.bigwig1.path.replace(/^.*[\\\/]/, "").replace(/\.[^/.]+$/, "")
        + inputs.output_suffix; if (inputs.outFileFormat == "bedgraph") return inputs.bigwig1.path.replace(/^.*[\\\/]/,
        "").replace(/\.[^/.]+$/, "") + ".compared.bdg"; return inputs.bigwig1.path.replace(/^.*[\\\/]/,
        "").replace(/\.[^/.]+$/, "") + ".compared.bw"; }
