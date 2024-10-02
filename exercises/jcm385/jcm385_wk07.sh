# Practice minimap

# New project
mkdir ~/projects/wk07
cd ~/projects/wk07

# Get refs and reads
cp -r ~/share/OMICS/wk07/refs .
ln -s ~/share/OMICS/wk07/reads .

# Index reference
samtools faidx refs/K03455.fasta
minimap2 -d K03455.mmi refs/K03455.fasta

# Examine reads
seqkit stats reads/*.fq.gz

# Map 'em
reads=reads/T78276-MFG.small.fq.gz

prefix=$(basename $reads .fq.gz)
minimap2 -ax map-ont K03455.mmi $reads \
| samtools view -b \
| samtools sort \
> $prefix.K03455.bam

# Map 'em
reads=reads/T78276-SPL.small.fq.gz

prefix=$(basename $reads .fq.gz)
minimap2 -ax map-ont K03455.mmi $reads \
| samtools view -b \
| samtools sort \
> $prefix.K03455.bam

# Index bams
samtools index -M *.bam

