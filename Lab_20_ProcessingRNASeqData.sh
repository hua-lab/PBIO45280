Fastqc name_of_your_file.fastq
#Run FastQC on the chosen sequence files to check the quality of raw sequence data

java -classpath /path/to/trimmomatic-0.32.jar PE -threads 16 -phred33 Input_file_R1.fastq Input_file_R2.fastq file_R1_trimmed.fastq file_R1_trimmed_unpaired.fastq file_R2_trimmed.fastq file_R2_trimmed_unpaired.fastq ILLUMINACLIP:TrueSeq.fa:2:30:10 LEADING:3 TRAILING:3 HEADCROP:10 SLIDINGWINDOW:4:20 MINLEN:30	

# Trim adapter and low quality sequences. Now, run FastQC again and see what has changed.  

# Part 3: Align cleaned reads to the references genome
# To use STAR quick mapping, will need to generate a STAR formatted genome.  This is required and is part of how STAR is able to run so quickly and accurately (this has been done):
STAR --runMode genomeGenerate --genomeDir TAIR_STARgenome/ --genomeFastaFiles TAIR10.fasta --runThreadN 2 --sjdbGTFfile TAIR10.gtf --genomeChrBinNbits 16

# Once this is complete we will align the reads (pair end here) to the genome:
STAR --genomeDir TAIR_STARgenome/ --readFilesIn  file_R1_trimmed.fastq.gz file_R2_trimmed.fastq.gz   --runThreadN 2 --sjdbGTFfile TAIR10.gtf --outFilterType BySJout --outFilterMultimapNmax 10 --alignSJDBoverhangMin 1 --outFilterMismatchNmax 999 --alignIntronMin 150 --alignIntronMax 20000

# Oct 25 18:28:30 ..... Started STAR run
# Oct 25 18:28:30 ..... Loading genome
# Oct 25 18:28:30 ..... Processing annotations GTF
# Oct 25 18:28:33 ..... Inserting junctions into the genome indices
# Oct 25 18:28:38 ..... Started mapping
# Oct 25 18:33:25 ..... Finished successfully

# This may take a little while…. When the alignment is complete, navigate into the new directory and identify the alignment file (a “.sam” or sequence alignment map file).  These files are HUGE, unwieldy, and are not particularly handy for our purposes.  
samtools view -Sb Aligned.out.sam> AlignmentwithReplicatename.bam
#  samtools converts a sam file into a more manageable binary sequence alignment map (bam) file

samtools sort -n AlignmentwithReplicatename.bam AlignmentwithReplicatename.bam
# [bam_sort_core] merging from 13 files...
# sort the alignments so that HTSeq can process the alignment correctly.  

htseq-count -f bam -m union -s no -q AlignmentwithReplicatename.bam TAIR10.gtf > ReplicatenameCounts.tab
