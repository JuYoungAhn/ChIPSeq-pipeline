## Chip-seq analysis pipeline 
Chromatin-immunoprecipitation (ChIP) followed by sequencing of the immuno-precipitated DNA is a powerful tool for the investigation of Protein:DNA interactions. ChIP studies have increased our knowledge of transcription factor biology, DNA methylation and histone modifications. In this page, I would like to describe general pipeline of chip-seq data processing and an example of downstream analysis: motif discovery. To make analysis simple, chip-seq dand reference genome of *yeast Saccharomyces cerevisiae* were used.

#### This github repository describes following topics: 
1. Download public data with SRAToolkit
1. Chip-seq data alignment to reference genome using BWA
1. Peak calling with MACS2 
1. Motif discovery with rGADEM 

1~3: pipeline.sh <br>
4: rGADEM.ipynb