# 1. Chip-seq data download
mkdir ChIP_SRA
cd ChIP_SRA

# download SRA file
# prefetch command will be available after installing "SRA Toolkit" (https://www.ncbi.nlm.nih.gov/sra/docs/toolkitsoft/)
prefetch SRR1003623
prefetch SRR1003619
prefetch SRR1003615

# Contruction protocol can be found here: https://www.ncbi.nlm.nih.gov/sra/?term=SRR1003623
# copy sra files
cp ~/ncbi/public/sra/SRR10036* .

fastq-dump --split-files SRR1003615.sra
fastq-dump --split-files SRR1003619.sra
fastq-dump --split-files SRR1003623.sra

# comprss the files
for f in *fastq ; do gzip $f ; done

# make symbolic links
ln -s SRR1003615_1.fastq.gz input_1.fastq.gz
ln -s SRR1003615_2.fastq.gz input_2.fastq.gz
ln -s SRR1003623_1.fastq.gz swi6_1.fastq.gz
ln -s SRR1003623_2.fastq.gz swi6_2.fastq.gz
ln -s SRR1003619_1.fastq.gz mock_1.fastq.gz
ln -s SRR1003619_2.fastq.gz mock_2.fastq.gz

cd ..

# 2. Reference genome fast file download
# make a directory and change directory
mkdir ref
cd ref

# download a reference genome
wget http://hgdownload.soe.ucsc.edu/goldenPath/sacCer3/bigZips/chromFa.tar.gz

tar -xvzf chromFa.tar.gz

# merge fasta file 
cat chr*fa > yeast_sc3.fa

# index the reference genome
bwa index yeast_sc3.fa


# 3. Alignment 
cd ..

# make a directory and change directory
mkdir align

cd align

# map the fastq data onto the yeast genome
bwa mem ../ref/yeast_sc3.fa ../ChIP_SRA/input_1.fastq.gz ../ChIP_SRA/input_2.fastq.gz > input.sam
bwa mem ../ref/yeast_sc3.fa ../ChIP_SRA/swi6_1.fastq.gz ../ChIP_SRA/swi6_2.fastq.gz > swi6.sam
bwa mem ../ref/yeast_sc3.fa ../ChIP_SRA/mock_1.fastq.gz ../ChIP_SRA/mock_2.fastq.gz > mock.sam
    
# generate sorted bam files
samtools view -bS input.sam > input.bam
samtools view -bS swi6.sam > swi6.bam
samtools view -bS mock.sam > mock.bam

samtools sort -o input.sort.bam input.bam
samtools sort -o swi6.sort.bam swi6.bam
samtools sort -o mock.sort.bam mock.bam

samtools index input.sort.bam
samtools index swi6.sort.bam
samtools index mock.sort.bam

# 4. Peak calling with macs2 
# https://github.com/taoliu/MACS
cd ..

# make a directory and change directory
mkdir macs2
cd macs2

# call peaks with two different controls
# Difference of two controls can be found here: http://epigenie.com/wp-content/uploads/2013/02/Getting-Started-with-ChIP-Seq.pdf

# Peak calling with mock data
macs2 callpeak -t ../align/swi6.sort.bam -c ../align/mock.sort.bam -n swi6_mock_corrected -f BAM -g 1.3e+7 -B -q 0.01 --extsize=50 --nomodel

# Peak calling with input (control) data
macs2 callpeak -t ../align/swi6.sort.bam -c ../align/input.sort.bam -n swi6_input_corrected -f BAM -g 1.3e+7 -B -q 0.01 --extsize=50 --nomodel

