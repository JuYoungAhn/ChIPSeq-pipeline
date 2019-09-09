## Chip-seq analysis pipeline 
Chromatin-immunoprecipitation (ChIP) followed by sequencing of the immuno-precipitated DNA is a powerful tool for the investigation of Protein:DNA interactions. ChIP studies have increased our knowledge of transcription factor biology, DNA methylation and histone modifications. In this page, I would like to describe general pipeline of chip-seq data processing and an example of downstream analysis: motif discovery. To make analysis simple, chip-seq and reference genome of *yeast Saccharomyces cerevisiae* were used.

#### This github repository describes following topics: 
1. Download public data with <a href="https://www.ncbi.nlm.nih.gov/sra/docs/toolkitsoft/"> SRAToolkit </a> 
1. Chip-seq data alignment to reference genome using <a href="http://bio-bwa.sourceforge.net/">BWA (Burrows-Wheeler Aligner)</a>
1. Peak calling with <a href="https://github.com/taoliu/MACS"> MACS2 (Model-based Analysis of ChIP-Seq) </a>  
1. Motif discovery with <a href="https://www.ncbi.nlm.nih.gov/pubmed/19193149"> rGADEM (R implementation of GADEM algorithm) </a>

![alt text](rGADEM.png "rGADEM")

1~3: pipeline.sh <br>
4: rGADEM.ipynb