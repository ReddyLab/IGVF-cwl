# Programs
trimmomatic_jar = "/opt/apps/rhel7/Trimmomatic-0.39/trimmomatic-0.39.jar"
picard_jar = "/opt/apps/rhel7/picard/2.18.2/picard.jar"
fgbio_jar = "/opt/apps/rhel7/fgbio-1.0.0/fgbio.jar"

# Auxiliary reference files (species agnostic)
as_narrowPeak = '/hpc/group/gersbachlab/Reference_Data/ENCODE/kent/src/hg/lib/encode/narrowPeak.as'
as_broadPeak = '/hpc/group/gersbachlab/Reference_Data/ENCODE/kent/src/hg/lib/encode/broadPeak.as'
bamtools_forward_filter = '/hpc/group/gersbachlab/Reference_Data/projects/GGR/auxiliary/quantification/forward_filter.duke_sequencing_core.txt'
bamtools_reverse_filter = '/hpc/group/gersbachlab/Reference_Data/projects/GGR/auxiliary/quantification/reverse_filter.duke_sequencing_core.txt'

# Defaults
GENOME = 'hg38'
MEM = 24000
CPUS = 16
READ_LENGTH = 50

class ReferenceDataset(object):
    def __init__(self, genome=GENOME, read_length=READ_LENGTH, with_ercc=False, umis=False):
        if umis:
            self.default_adapters = "/hpc/group/gersbachlab/Reference_Data/Adapters/trimmomatic_UMI.fa"
        else:
            self.default_adapters = "/hpc/group/gersbachlab/Reference_Data/Adapters/default_adapters.fasta"
        self.read_length = read_length
        _genome = genome.lower()
        if _genome == 'hg38' or _genome == 'grch38':
            self.bowtie_genome_ref_first_index = "/hpc/group/gersbachlab/Reference_Data/IGVF/GRCh38/bowtie_GRCh38%s/IGVFFI0653VCGH_GRCh38.1.ebwt"  % (".with_ercc92" if with_ercc else "")
            self.bowtie2_genome_ref_first_index = "/hpc/group/gersbachlab/Reference_Data/IGVF/GRCh38/bowtie2_GRCh38%s/IGVFFI0653VCGH_GRCh38.1.bt2"  % (".with_ercc92" if with_ercc else "")
            self.star_genome_dir = "/hpc/group/gersbachlab/Reference_Data/IGVF/GRCh38/STAR_genome_sjdbOverhang_%d_novelSJDB%s" % (self.read_length-1, ".with_ercc92" if with_ercc else "")
            self.encode_blacklist_bedfile = "/hpc/group/gersbachlab/Reference_Data/IGVF/GRCh38/hg38.blacklist.v3.bed"
            self.genome_effective_size = "hs"
            self.annotation_file = "/hpc/group/gersbachlab/Reference_Data/IGVF/GRCh38/Gencode/v43/IGVFFI7217ZMJZ%s.gtf" % (".with_ercc92" if with_ercc else "")
            self.rsem_dir = "/hpc/group/gersbachlab/Reference_Data/IGVF/GRCh38/RSEM_genome%s"% (".with_ercc92" if with_ercc else "")
            self.genome_sizes_file = "/hpc/group/gersbachlab/Reference_Data/IGVF/GRCh38/GCA_000001405.15_GRCh38_no_alt_analysis_set%s.sizes" % (".with_ercc92" if with_ercc else "")
            self.genome_fasta_files = ["/hpc/group/gersbachlab/Reference_Data/IGVF/GRCh38/fasta/IGVFFI0653VCGH%s.fasta" % (".with_ercc92" if with_ercc else "")]
            self.regions_bed_file = "/hpc/group/gersbachlab/Reference_Data/IGVF/GRCh38/GCA_000001405.15_GRCh38_no_alt_analysis_set%s.bed" % (".with_ercc92" if with_ercc else "")
        elif _genome == 'hg19' or _genome == 'grch37':
            self.bowtie_genome_ref_first_index = "/hpc/group/gersbachlab/Reference_Data/Genomes/hg19/hg19.1.ebwt"
            self.bowtie2_genome_ref_first_index = "/hpc/group/gersbachlab/Reference_Data/Bowtie2/hg19/hg19.1.bt2"
            self.star_genome_dir = "/hpc/group/gersbachlab/Reference_Data/Genomes/hg19/STAR_genome_sjdbOverhang_%d" % self.read_length
            self.genome_sizes_file = "/hpc/group/gersbachlab/Reference_Data/Genomes/hg19/hg19.chrom.sizes"
            self.encode_blacklist_bedfile = "/hpc/group/gersbachlab/Reference_Data/ENCODE/wgEncodeDacMapabilityConsensusExcludable.hg19.merged.bed"
            self.genome_effective_size = "hs"
            self.annotation_file = "/hpc/group/gersbachlab/Reference_Data/Gencode/v19/gencode.v19.annotation.gtf"
            self.rsem_dir = "/hpc/group/gersbachlab/Reference_Data/Genomes/hg19/RSEM_genome"
            self.genome_fasta_files = ["/hpc/group/gersbachlab/Reference_Data/Genomes/hg19/hg19.fa"]
            self.regions_bed_file = "/hpc/group/gersbachlab/Reference_Data/Genomes/hg19/hg19.chrom.bed"
        elif _genome == 'mm10' or _genome == 'grcm38':
            self.bowtie_genome_ref_first_index = "/hpc/group/gersbachlab/Reference_Data/Genomes/mm10/bowtie/GRCm38.1.ebwt"
            self.bowtie2_genome_ref_first_index = "/hpc/group/gersbachlab/Reference_Data/Genomes/mm10/bowtie2/GRCm38.1.bt2"
            self.star_genome_dir = "/hpc/group/gersbachlab/Reference_Data/Genomes/mm10/STAR_genome_sjdbOverhang_%d_novelSJDB" % (self.read_length-1)
            self.encode_blacklist_bedfile = "/hpc/group/gersbachlab/Reference_Data/ENCODE/mm10.blacklist.merged.bed"
            self.genome_effective_size = "mm"
            self.annotation_file = "/hpc/group/gersbachlab/Reference_Data/Gencode/vM13/gencode.vM13.annotation%s.gtf" % (".with_ercc92" if with_ercc else "")
            self.rsem_dir = "/hpc/group/gersbachlab/Reference_Data/Genomes/mm10/RSEM/RSEM_genome%s" % (".with_ercc92" if with_ercc else "")
            self.genome_sizes_file = "/hpc/group/gersbachlab/Reference_Data/Genomes/GRCm38/GRCm38%s.sizes" % (".with_ercc92" if with_ercc else "")
            self.genome_fasta_files = ["/hpc/group/gersbachlab/Reference_Data/Genomes/mm10/GRCm38.primary_assembly.genome%s.fa" % (".with_ercc92" if with_ercc else "")]
            self.regions_bed_file = "/hpc/group/gersbachlab/Reference_Data/Genomes/GRCm38/GRCm38%s.bed" % (".with_ercc92" if with_ercc else "")
        elif _genome == 'mm9' or _genome == 'grcm37' or _genome == 'ncbi37':
            self.bowtie_genome_ref_first_index = "/hpc/group/gersbachlab/Reference_Data/Genomes/mm9/bowtie/mm9.1.ebwt"
            self.bowtie2_genome_ref_first_index = "/hpc/group/gersbachlab/Reference_Data/Genomes/mm9/bowtie2/mm9.1.bt2"
            self.star_genome_dir = "/hpc/group/gersbachlab/Reference_Data/Genomes/mm9/STAR_genome_sjdbOverhang_%d_novelSJDB" % self.read_length
            self.genome_sizes_file = "/hpc/group/gersbachlab/Reference_Data/Genomes/mm9/mm9.chrom.sizes"
            self.encode_blacklist_bedfile = "/hpc/group/gersbachlab/Reference_Data/ENCODE/mm9.blacklist.bed"
            self.genome_effective_size = "mm"
            self.annotation_file = "/hpc/group/gersbachlab/Reference_Data/Gencode/vM1/gencode.vM1.annotation.gtf"
            self.rsem_dir = "/hpc/group/gersbachlab/Reference_Data/Genomes/mm9/RSEM/RSEM_genome"
            self.genome_fasta_files = ["/hpc/group/gersbachlab/Reference_Data/Genomes/mm9/mm9.fa"]
            self.regions_bed_file = "/hpc/group/gersbachlab/Reference_Data/Genomes/mm9/mm9.chrom.bed"
        elif _genome == 'mm39' or _genome == 'grcm39':
            self.bowtie_genome_ref_first_index = "/hpc/group/gersbachlab/Reference_Data/IGVF/GRCm39/bowtie_GRCm39/IGVFFI928QLXO_GRCm39.1.ebwt"
            self.bowtie2_genome_ref_first_index = "/hpc/group/gersbachlab/Reference_Data/IGVF/GRCm39/bowtie2_GRCm39/IGVFFI928QLXO_GRCm39.1.bt2"
            self.star_genome_dir = "/hpc/group/gersbachlab/Reference_Data/IGVF/GRCm39/STAR_GRCm39_genome"
            self.genome_sizes_file = "/hpc/group/gersbachlab/Reference_Data/IGVF/GRCm39/mm39.chrom.sizes"
            self.encode_blacklist_bedfile = "/hpc/group/gersbachlab/Reference_Data/IGVF/GRCm39/exclusion_lists/mm39.excluderanges.bed"
            self.genome_effective_size = "mm"
            self.annotation_file = "/hpc/group/gersbachlab/Reference_Data/IGVF/GRCm39/Gencode/vM32/IGVFFI9744VSJF.gtf"
            self.rsem_dir = "/hpc/group/gersbachlab/Reference_Data/IGVF/GRCm39/RSEM_genome"
            self.genome_fasta_files = ["/hpc/group/gersbachlab/Reference_Data/IGVF/GRCm39/fasta/IGVFFI9282QLXO.fasta"]
            self.regions_bed_file = "/hpc/group/gersbachlab/Reference_Data/IGVF/GRCm39/mm39.chrom.bed"
        elif _genome == 'danrer10' or _genome == 'grcz10':
            self.bowtie_genome_ref_first_index = "/hpc/group/gersbachlab/Reference_Data/Genomes/danRer10/bowtie/danRer10.1.ebwt"
            self.star_genome_dir = "/hpc/group/gersbachlab/Reference_Data/Genomes/danRer10/STAR_genome_sjdbOverhang_%d_novelSJDB" % self.read_length
            self.genome_sizes_file = "/hpc/group/gersbachlab/Reference_Data/Genomes/danRer10/danRer10.chrom.sizes"
            self.encode_blacklist_bedfile = None
            self.genome_effective_size = "1.04e9"
            self.annotation_file = "/hpc/group/gersbachlab/Reference_Data/Genomes/danRer10/Danio_rerio.GRCz10.88.chrom_cleaned.gtf"
            self.rsem_dir = "/hpc/group/gersbachlab/Reference_Data/Genomes/danRer10/RSEM/RSEM_genome"
            self.genome_fasta_files = ["/hpc/group/gersbachlab/Reference_Data/Genomes/danRer10/danRer10.fa"]
        else:
            raise Exception("Genome %s not recognized" % genome)
