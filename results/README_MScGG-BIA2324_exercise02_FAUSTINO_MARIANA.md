---
### BEGIN-Of-YAML-Block ###
#
## ######################################################################################
##
##   README_MScGG-BIA2324_exercise02_SURNAME_NAME.md
##
##   A LaTeX-extended MarkDown template for MScGG-BIA practical exercise submissions.
##
## ######################################################################################
##
##                 CopyLeft 2023/24 (CC:BY-NC-SA) --- Josep F Abril
##
##   This file should be considered under the Creative Commons BY-NC-SA License
##   (Attribution-Noncommercial-ShareAlike). The material is provided "AS IS", 
##   mainly for teaching purposes, and is distributed in the hope that it will
##   be useful, but WITHOUT ANY WARRANTY; without even the implied warranty
##   of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
##
## ######################################################################################
#
# The current execise number
thyexercise: 02
#
# title-meta is title string without any LaTeX format
title-meta: MScGG-BIA Exercise 02
#
# title for the cover page, fully LaTeX formated to fit into a shortstack command
title: |
  \textsc{MScGG-BIA}
  \vskip 1.25ex \textsc{Practicals}
  \vskip 1.25ex \textsc{Report}
#subtitle:
#
# runtitle is the running header or footer
runtitle: |
  MScGG-BIA Exercise 02 Report
#
# author-meta
author-meta: !!str 'Mariana FAUSTINO @ MScGG BIA Advanced Bionformatics'
#
# authors to appear on the title page
author:
- name: Mariana FAUSTINO
#
# authorshort defines a brief list of authors for headings
authorshort: Faustino, M
#
# template formating variables
papersize: a4paper
fontsize: 10pt
geometry: margin=1.5cm
toc: true
lof: true
lot: true
colorlinks: true
urlcolor: blue
citecolor: green
linkcolor: red
#
# LaTeX definitions
further-defs: 
-  \def\BIAVC{\href{https://campusvirtual.ub.edu/course/view.php?id=77505}{BIA Advanced Bioinformatics Virtual Campus at UB}}
-  \def\ScerS{\textit{Saccharomyces cerevisiae} (strain S288C)}
-  \def\scerS{\textit{S.~cerevisiae} (strain S288C)}
-  \def\Scer{\textit{Saccharomyces cerevisiae}}
-  \def\scer{\textit{S.~cerevisiae}}
-  \def\sra{\textsc{SRA}}
-  \def\Sra{\textsc{Short Reads Archive}}
-  \def\SRA{\href{https://www.ncbi.nlm.nih.gov/sra}{\sra}}
#
### End-Of-YAML-Block ###
---


# Introduction

Different high-throughput sequencing experiments have been performed
over genomic DNA samples of \Scer\ and paired-end raw reads were
provided. We were asked to assemble the reads obtained from at least
two of the suggested datasets. Those sequence sets may have
differences in sequencing methodology, but mainly they differ in
whole-genome coverage. We can evaluate if differences in coverage can
have an impact on the final assembled genome as we already have a
reference genome.


## Objectives

* To check qualities and other properties of sequencing reads.
* To run an assembly protocol: cleaning raw reads with `trimmomatic`
  and assembling the contigs to reconstruct a small genome using `SOAPdenovo`.
* To map the reads back to the assembly so we can visualize the
  coverage across the sequences and estimate the insert size.
* To compare our assembly against a reference genome, so we can assess
  the performance of the assembler and the protocol.
* To check completeness of our assembly with `BUSCO`.
* We introduce some \LaTeX\ examples for citing paper references as footnotes.


## Pre-requisites

The commands listed are compatible with a `Debian`-based linux
distribution (Linux 6.8.0-48-generic #48~22.04.1-Ubuntu).

* Perl (v5.32.0)
* Pandoc 2.9.2.1
* Latex pdfTeX 3.141592653-2.6-1.40.22
* EMACS or Geany
* EMBOSS:6.6.0.0
* NCBI SRA Toolkit
* fastqc 0.11.9+dfsg-5
* trimmomatic 0.39+dfsg-2
* samtools 1.13-4
* bamtools 2.5.1+dfsg-10build1
* picard-tools 2.26.10+dfsg-1
* gawk 1:5.1.0-1ubuntu0.1
* bwa 0.7.17-6
* bowtie2 2.4.4-1
* soapdenovo2 242+dfsg-2
* gnuplot 5.4 patchlevel 2
* BUSCO 5.2.2
* gunzip (gzip) 1.10
* Python 3.10.12
* R version 4.1.2 
* GNU Wget 1.21.2


To install `pandoc`:

```{.sh}
sudo apt-get install pandoc                    \
                     texlive-latex-recommended \
                     texlive-latex-extra       \
                     texlive-fonts-recommended \
                     texlive-fonts-extra
```

To install \LaTeX:

```{.sh}
sudo apt-get install texlive-full
```

Installing optional packages, such a text editor with
programming facilities and extensions, like `emacs` or `geany`:

```{.sh}
sudo apt-get install emacs geany vim
```

If experiencing \LaTeX or `pandoc` formatting errors,
then install the latest `pandoc` version. Following the
instructions from: https://pandoc.org/installing.html

```{.sh}
# On a Debian/Ubuntu/Mint box, visit
# pandoc's releases page, to get the latest version from repository:
#     https://github.com/jgm/pandoc/releases/latest
# Then, run those two commands:
wget https://github.com/jgm/pandoc/releases/download/3.1.11.1/pandoc-3.1.11.1-1-amd64.deb

sudo dpkg -i pandoc-3.1.11.1-1-amd64.deb

```

## Installing Bioinformatics software

Below are examples on how to install a software tool from
different repositories or systems (`emboss` must be installed).

```{.sh}
#################################
# emboss - European molecular biology open software suite

# on a debian/ubuntu/mint linux system (DEBs)
apt-cache search emboss     # to check if there is such a package
sudo apt-get install emboss # to install such a package

```

The instructions for the installion of the remaning toolkits are detailed below.

```{.sh}
#################################
# NCBI SRA Toolkit https://github.com/ncbi/sra-tools/wiki/01.-Downloading-SRA-Toolkit
wget https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/3.0.10/sratoolkit.3.0.10-ubuntu64.tar.gz \
     -O $WDR/bin/sratoolkit.3.0.10-ubuntu64.tar.gz
pushd $WDR/bin
tar -zxvf sratoolkit.3.0.10-ubuntu64.tar.gz
cd sratoolkit.3.0.10-ubuntu64
popd

export PATH=$WDR/bin/sratoolkit.3.0.0-ubuntu64/bin:$PATH
# NOTE: added to the projectvars.sh file

# seqtk - sampling, trimming, fastq2fasta, subsequence, reverse complement
sudo apt-get install seqtk

# jellyfish - count k-mers in DNA sequences
sudo apt-get install jellyfish

# fastqc - quality control for NGS sequence data
sudo apt-get install fastqc

# trimmomatic - flexible read trimming tool for Illumina NGS data
sudo apt-get install trimmomatic

# samtools - processing sequence alignments in SAM and BAM formats
# bamtools - toolkit for manipulating BAM (genome alignment) files
# picard-tools - Command line tools to manipulate SAM and BAM files
sudo apt-get install samtools bamtools picard-tools

# Downloading the latest version of picard
# see https://github.com/broadinstitute/picard/releases/latest
wget https://github.com/broadinstitute/picard/releases/download/2.27.5/picard.jar \
     -O $BIN/picard.jar

# bwa - Burrows-Wheeler Aligner
# bowtie2 - ultrafast memory-efficient short read aligner
sudo apt-get install bwa bowtie2

# soapdenovo2 - short-read assembly method to build de novo draft assembly
sudo apt-get install soapdenovo2

# igv - Integrative Genomics Viewer
sudo apt-get install igv

# ncbi-blast+ - next generation suite of BLAST sequence search tools
sudo apt-get install ncbi-blast+
#
# gnuplot-qt - a portable command-line driven interactive data and function plotting utility
#              It is required for mummerplot later on...
sudo apt-get install gnuplot-qt 
sudo ln -vfs /usr/bin/gnuplot-qt /usr/bin/gnuplot;
#
# graphicsmagick - collection of image processing tools (replacement for imagemagick)
sudo apt-get install graphicsmagick 
#
# mummer - Efficient sequence alignment of full genomes
sudo apt-get install mummer
#
# Potential errors and problem solving:
#   + just in case mummerplot returns error: Can't use 'defined(%hash)'
sudo sed -i 's/defined (%/(%/
            ' /usr/bin/mummerplot
#
#   + gnuplot fails because some instruction was implemented in later versions
sudo sed -i 's/^\(.*set mouse.*\)$/#\1/
            ' /usr/bin/mummerplot
#
#   + mummerplot cannot find gnuplot:
sudo sed -i 's/system (\"gnuplot --version\")/system (\"\/usr\/bin\/gnuplot --version\")/
            ' /usr/bin/mummerplot
sudo sed -i 's/my \$cmd = \"gnuplot\";/my \$cmd = \"\/usr\/bin\/gnuplot\";/
            ' /usr/bin/mummerplot
#
#   + just in case mummerplot returns error: Inappropriate ioctl for device
sudo ln -vfs /usr/bin/gnuplot-qt /etc/alternatives/gnuplot;
#
#
# BUSCO - estimating the completeness and redundancy of processed genomic data
#         based on universal single-copy orthologs.
#
# cd $BIN/
# git clone https://gitlab.com/ezlab/busco.git
# cd busco/
# sudo python3 setup.py install
# cd $WDR
# 
# Alternatively, download the source code and install it with the commands below:
#
# wget https://gitlab.com/ezlab/busco/-/archive/5.4.3/busco-5.4.3.tar.gz \
 #     -O busco-5.4.3.tar.gz
# tar -zxvf busco-5.4.3.tar.gz
# cd busco-5.4.3
# python3 setup.py install --user
# cd $WDR
# ln -vs ./busco-5.4.3/bin/busco $BIN/busco
```

## Datasets

The budding yeast
\href{https://www.ncbi.nlm.nih.gov/genome/?term=txid559292[Organism:noexp]}{\Scer}
is one of the major model organisms for understanding cellular and
molecular processes in eukaryotes. This single-celled organism is also
important in industry, where it is applied to make bread, beer, wine,
enzymes, and pharmaceuticals. The \scer\ genome has approximately
\qty{12}{\Mbp}, distributed in 16 chromosomes. Here, we are going to
work on raw reads from one of selected four different sequencing
experiments that have been already submitted to the \Sra\ (\SRA) and
we will compare the resulting assemblies against the reference
\scerS. Table \ref{tbl:srareadsets} summarizes the information about
those sets.

```{=latex}
\begin{table}[!ht]
\begin{center}
\begin{scriptsize}
\begin{tabular}{l|cllc}
%
Sequence set  &
SRA accession &
Sequencer     &
Run info      &
Run ID        \\\hline
%
Original WT strain &
\href{https://www.ncbi.nlm.nih.gov/sra/SRX3242873[accn]}{SRX3242873} &
Illumina HiSeq 4000 &
2.8M spots, 559.2M bases, 221.2Mb sra &
\href{https://trace.ncbi.nlm.nih.gov/Traces/sra/?run=SRR6130428}{SRR6130428} \\
%
S288c &
\href{https://www.ncbi.nlm.nih.gov/sra/SRX1746300[accn]}{SRX1746300} &
Illumina HiSeq 2000 &
5.3M spots, 1.1G bases, 733.6Mb sra &
\href{https://trace.ncbi.nlm.nih.gov/Traces/sra/?run=SRR3481383}{SRR3481383} \\
%
MiSeq PE-sequencing of SAMD00065885 &
\href{https://www.ncbi.nlm.nih.gov/sra/DRX070537[accn]}{DRX070537} &
Illumina MiSeq &
5.6M spots, 3.3G bases, 1.6Gb sra &
\href{https://trace.ncbi.nlm.nih.gov/Traces/sra/?run=DRR076693}{DRR076693} \\
%
S288c genomic DNA library &
\href{https://www.ncbi.nlm.nih.gov/sra/SRX4414623[accn]}{SRX4414623} &
Illumina HiSeq 2500 &
43.1M spots, 8.6G bases, 3.2Gb sra &
\href{https://trace.ncbi.nlm.nih.gov/Traces/sra/?run=SRR7548448}{SRR7548448} \\
%
\end{tabular}
\end{scriptsize}
\parbox{0.75\linewidth}{%
 \caption[Summary of raw reads datasets that we can use from \texttt{SRA} database.]{%
  \label{tbl:srareadsets}\textbf{Summary of raw reads datasets that we can use from \texttt{SRA} database}. Only the SRR6130428 and SRR3481383 sets were used for the exercise.
 }%caption
}%parbox
\end{center}
\end{table}
```

We will get first the reference genome\footnote{Engel et al. "The
Reference Genome Sequence of \textit{Saccharomyces cerevisiae}: Then
and Now". G3 (Bethesda), g3.113.008995v1, 2013
(\href{https://www.ncbi.nlm.nih.gov/pubmed/?term=24374639}{PMID:24374639}).},
\scerS (assembly `R64.4.1`). This genome version has 16 chromosome
sequences, including the mitochondrion genome, totaling
\qty{12157105}{\bp} (see Table \ref{tbl:yeastchrs}).


```{.sh}
mkdir -vp $WDR/seqs

URL="https://downloads.yeastgenome.org/sequence/S288C_reference/genome_releases"
wget $URL/S288C_reference_genome_Current_Release.tgz \
     -O $WDR/seqs/S288C_reference_genome_Current_Release.tgz

pushd $WDR/seqs/
tar -zxvf S288C_reference_genome_Current_Release.tgz
popd

#also on projectvars
export REFDIR="S288C_reference_genome_R64-4-1_20230830"
export REFGEN="S288C_reference_sequence_R64-4-1_20230830"

zcat $WDR/seqs/$REFDIR/$REFGEN.fsa.gz | \
  infoseq -only -length -noheading -sequence fasta::stdin  2> /dev/null | \
  gawk '{ s+=$1 } END{ printf "# Yeast genome size (v.R64.4.1): %dbp\n", s }' 
# Yeast genome size (v.R64.4.1): 12157105bp
```

```{.sh}
#Producing a LaTeX table with the chromosome sizes and GC content.

zcat $WDR/seqs/$REFDIR/$REFGEN.fsa.gz | \
  infoseq -noheading -sequence fasta::stdin  2> /dev/null | \
    gawk 'BEGIN {
            printf "%15s & %10s & %12s & %10s \\\\\n",
                   "Chromosome", "GenBank ID", "Length (bp)", "GC content";
          }
          $0 != /^[ \t]*$/ {
	        L=$0;
	        sub(/^.*\[(chromosome|location)=/,"",L);
	        sub(/\].*$/,"",L);
	        sub(/_/,"\\_",$3);
            printf "%15s & %10s & %12d & %8.2f\\%% \\\\\n",
                   L, $3, $6, $7;
          }' > $WDR/docs/chromosomes_info.tex;
```

```{=latex}
\begin{table}[!ht]
\begin{center}
\begin{tabular}{|r|c|r|r|}
\csname @@input\endcsname docs/chromosomes_info
\end{tabular}
\parbox{0.75\linewidth}{%
 \caption[Reference \Scer\ chromosome summary.]{%
  \label{tbl:yeastchrs}\textbf{Reference \Scer\ chromosome summary.} This table displays information about length and GC content for each of the chromosomes of the \scer\ reference genome.
 }%caption
}%parbox
\end{center}
\end{table}
```

The smaller dataset, SRR6130428 (221.2Mb \Sra\  file), was the chosen
dataset for further analysis due to hardware limitations.

```{.sh}
## The reads dataset: SRR6130428

# 221.2Mb downloads
mkdir -vp $WDR/seqs/SRR6130428
prefetch -v SRR6130428  -O $WDR/seqs
#
# The SRA file is stored as $WDR/seqs/SRR6130428/SRR6130428.sra,

fastq-dump -X 2 -Z $WDR/seqs/SRR6130428/SRR6130428.sra

# Read 2 spots for seqs/SRR6130428/SRR6130428.sra
# Written 2 spots for seqs/SRR6130428/SRR6130428.sra
# @SRR6130428.1 1 length=202
# NGACCTTGGCGTTGGTGTAGGTCACCACTCCGATTTTGAGCTAGAATATGAAATTCATCACTGGAATAAGTTTCATAAGGACAAAGATCCAGACGTTAAAGNATGGTAAAAATATATTTTAAGTGCTTTGATTACTTACTACATGCTAATTGACTACATACATAGTGTCTTGAATACTTTCTCAGTCTCAACTATTCATCTT
# +SRR6130428.1 1 length=202
# #AAFFJJJJJJJJJJJJJJJJJJJJJJJJJJJJFJJJJJJJJJJJJJJJJJJJJJJJJJFJJJJJFJJJJJJJJJJFFJJJJJJJJJJJJJJJJJJJJJJJ#AAA7FAFFJJJFJFF7FJJAJJ<FFJJFAJJJJJJJJFFJFJJ<JJFFJJF-FJFJJJAFJJJJFJJJJF7AJJ-77F7JJ<AFFF-F-J7-FJ-AFJFF
# @SRR6130428.2 2 length=202
# NTGCTACTCTCATGGTCTCAATACTGCCGCCGACATTCTGTCCCACATACTAAATCTCTTCCCGTCATTATCGCCCGCATCCGGTGCCGTAAATGCAAAACNGGACAATTTTTATTATATTGCATCTAATAGCAATAGGATAAGAAAGGTGAAAAAGCAAAAGCAATAGTGCATTGTGATGTGGAGAATAAGGTGCATACGA
# +SRR6130428.2 2 length=202
# #AAAAFFAFFJJJJJJJJJJJJJJJJJJFJJJFJJJJJJJFJJJJAJJJFJ<JJFA<FFAJJFFJJ<JFJJJJJJJFFJ7JJJJFJJJJJFFJAAFJFFJJ#AAFFFJAAFA-FAAFJFJJ-FF-77AJFFJJJJA<<A7-<-<<-<-77FFJJJJJJFJFAJJJ7---<77F--7-7A<FAJJA7A-7JJF--<-----7-

SQSET=SRR6130428
fastq-dump -I --split-files $WDR/seqs/${SQSET}/${SQSET}.sra \
           --gzip --outdir $WDR/seqs/${SQSET}/
#    Read 2768518 spots for seqs/SRR6130428/SRR6130428.sra
# Written 2768518 spots for seqs/SRR6130428/SRR6130428.sra
```

# The Assembly Protocol

## Exploratory data analysis of the raw reads

On this initial step,
\href{https://www.bioinformatics.babraham.ac.uk/projects/fastqc/}{\texttt{fastQC}}
was run over `fastq` files for the forward (R1) and reverse (R2) raw reads
sets. Then those two sets were compared from three of 
the resulting plots: the quality distribution per base position
(boxplots), the base content per position (lineplots), and the read
sequences GC content distribution (lineplot). The program generated
an `HTML` summary page, as well as a `zip` file containing
all the figures in a folder and some results in tabular format.

For all the code blocks following the variable 'SQSET' defined was 
particular to each dataset.

```{.sh}
SQSET=SRR6130428 	#either was exported at a time
SQSET=SRR3481383

mkdir -vp $WDR/seqs/${SQSET}/${SQSET}.QC

for READSET in 1 2;
  do {
    echo "# Running fastQC on $SQSET R${READSET}..." 1>&2;
    fastqc -t 8 --format fastq                                  \
           --contaminants $BIN/fastqc_conf/contaminant_list.txt \
           --adapters     $BIN/fastqc_conf/adapter_list.txt     \
           --limits       $BIN/fastqc_conf/limits.txt           \
           -o $WDR/seqs/${SQSET}/${SQSET}.QC                    \
           $WDR/seqs/${SQSET}/${SQSET}_${READSET}.fastq.gz      \
           2> $WDR/seqs/${SQSET}/${SQSET}.QC/fastQC_${SQSET}_${READSET}.log 1>&2;
  }; done
```
Calculating the sequence sizes in the SRR6130428 dataset FASTQ files (R1 and R2). 
```{.sh}
zcat seqs/SRR6130428/SRR6130428_2.fastq.gz | awk 'NR % 4 == 2 { seqlen += length($0) } NR % 4 == 0 { print seqlen; seqlen = 0 }' | uniq -c
2768518 101
zcat seqs/SRR6130428/SRR6130428_1.fastq.gz | awk 'NR % 4 == 2 { seqlen += length($0) } NR % 4 == 0 { print seqlen; seqlen = 0 }' | uniq -c
2768518 101
```
Each sequence is 101 nucleotides long for the SRR6130428 dataset.

\clearpage
```{=latex}
\begin{figure}[!ht]
\begin{center}
 \begin{tabular}{c@{}c}
  \includegraphics[width=0.435\linewidth]{{images/fastqc_SRR6130428_quality_R1}.png}     &
  \includegraphics[width=0.435\linewidth]{{images/fastqc_SRR6130428_quality_R2}.png}     \\[-0.75ex]
  \includegraphics[width=0.435\linewidth]{{images/fastqc_SRR6130428_basecontent_R1}.png} &
  \includegraphics[width=0.435\linewidth]{{images/fastqc_SRR6130428_basecontent_R2}.png} \\[-0.75ex]
  \includegraphics[width=0.435\linewidth]{{images/fastqc_SRR6130428_gccontent_R1}.png}   &
  \includegraphics[width=0.435\linewidth]{{images/fastqc_SRR6130428_gccontent_R2}.png}   \\[-0.75ex]
 \end{tabular}
 \parbox{0.8\linewidth}{%
  \caption[Raw reads basic sequence analyses for \texttt{SRR6130428}]{%
   \label{fig:fastqcsetA}\textbf{Raw reads basic sequence analyses for \texttt{SRR6130428}.} Left column shows results for the forward reads (R1), right column for the reverse reads (R2). On top panels we can observe phred scores distribution per base position, mid panels correspond to the base composition per position, while the bottom ones show the GC content distribution across reads.
  }%caption
 }%parbox
\end{center}
\end{figure}
```
\clearpage
```{=latex}
\begin{figure}[!ht]
\begin{center}
 \begin{tabular}{c@{}c}
  \includegraphics[width=0.435\linewidth]{{images/fastqc_SRR3481383_quality_R1}.png}     &
  \includegraphics[width=0.435\linewidth]{{images/fastqc_SRR3481383_quality_R2}.png}     \\[-0.75ex]
  \includegraphics[width=0.435\linewidth]{{images/fastqc_SRR3481383_basecontent_R1}.png} &
  \includegraphics[width=0.435\linewidth]{{images/fastqc_SRR3481383_basecontent_R2}.png} \\[-0.75ex]
  \includegraphics[width=0.435\linewidth]{{images/fastqc_SRR3481383_gccontent_R1}.png}   &
  \includegraphics[width=0.435\linewidth]{{images/fastqc_SRR3481383_gccontent_R2}.png}   \\[-0.75ex]
 \end{tabular}
 \parbox{0.8\linewidth}{%
  \caption[Raw reads basic sequence analyses for \texttt{SRR3481383}]{%
   \label{fig:fastqcsetA}\textbf{Raw reads basic sequence analyses for \texttt{SRR3481383}.} Left column shows results for the forward reads (R1), right column for the reverse reads (R2). On top panels we can observe phred scores distribution per base position, mid panels correspond to the base composition per position, while the bottom ones show the GC content distribution across reads.
  }%caption
 }%parbox
\end{center}
\end{figure}
```

## Cleaning and trimming reads with `trimmomatic`

A crucial step before starting the assembly is to remove any
contaminant sequences, like the sequencing adapters, and low quality
segments. For this purpose, `trimmomatic` was used to perform the 
main analysis, and the results were compared with those of `cutadapt`,
another raw reads cleaner.

```{.sh}
# 
##  We took the first 100000 sequences with the "head" command for the SRR3481383 dataset.
# 
 gunzip -c $WDR/seqs/${SQSET}/${SQSET}_1.fastq.gz | head -n 400000 | \
        gzip -c9 - > $WDR/seqs/${SQSET}/${SQSET}_1.subset100k.fastq.gz;
 gunzip -c $WDR/seqs/${SQSET}/${SQSET}_2.fastq.gz | head -n 400000 | \
        gzip -c9 - > $WDR/seqs/${SQSET}/${SQSET}_2.subset100k.fastq.gz;
        #The subset100k were renamed in the work through of this report
        #to SRR3481383_1.fastq.gz/SRR3481383_2.fastq.gz  for simplicity
# 
##  Alternatively, using the "seqtk" program (if installed), as follows:
#
# seqtk sample -s11 $WDR/seqs/${SQSET}/${SQSET}_1.fastq.gz 0.1 | \
#         gzip -c9 - > $WDR/seqs/${SQSET}/${SQSET}_1.subset10pct.fastq.gz;
# seqtk sample -s11 $WDR/seqs/${SQSET}/${SQSET}_2.fastq.gz 0.1 | \
#         gzip -c9 - > $WDR/seqs/${SQSET}/${SQSET}_2.subset10pct.fastq.gz;
#
##  The -s option specifies the seed value for the random number generator,
#   it needs to be the same value for file1 and file2 to keep the paired reads
#   on the sampled output. 0.1 argument sets the percent of seqs to sample (10%).
#

# to find where trimmomatic was installed in the system
find /usr -name trimmomatic.jar

# Taking the result of the previous command as the folder to set on TMC:
export TMC=/usr/share/java/trimmomatic.jar
# Set this variable to suit the system installation:
export TMA=/usr/share/trimmomatic/
#
# The trimmomatic parameters documentation is available at:
# http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/TrimmomaticManual_V0.32.pdf
#
export TRMPAR="LEADING:15 TRAILING:15 SLIDINGWINDOW:4:15 MINLEN:30 TOPHRED33";
export TRMPECLP="ILLUMINACLIP:$TMA/TruSeq2-PE.fa:2:30:10";

java -jar $TMC  PE                          \
     $WDR/seqs/${SQSET}/${SQSET}_1.fastq.gz \
     $WDR/seqs/${SQSET}/${SQSET}_2.fastq.gz \
     $WDR/seqs/${SQSET}/${SQSET}_1.trimmo_pe.fastq.gz \
     $WDR/seqs/${SQSET}/${SQSET}_1.trimmo_sg.fastq.gz \
     $WDR/seqs/${SQSET}/${SQSET}_2.trimmo_pe.fastq.gz \
     $WDR/seqs/${SQSET}/${SQSET}_2.trimmo_sg.fastq.gz \
     $TRMPECLP $TRMPAR                      \
  2> $WDR/seqs/${SQSET}/${SQSET}.trimmo.log 1>&2 ;

tail -n 2 $WDR/seqs/${SQSET}/${SQSET}.trimmo.log
#SQSET=SRR6130428 	
#  Input Read Pairs:         2768518
#            Both Surviving: 2536084 (91.60%)
#    Forward Only Surviving:  176365 ( 6.37%)
#    Reverse Only Surviving:    4082 ( 0.15%)
#                   Dropped:   51987 ( 1.88%)
# TrimmomaticPE: Completed successfully

tail -n 2 $WDR/seqs/${SQSET}/${SQSET}.trimmo.log
#SQSET=SRR3481383 
#  Input Read Pairs: 	     100000 
#	     Both Surviving: 81468 (81.47%)
#    Forward Only Surviving: 17918 (17.92%) 
#    Reverse Only Surviving:    343 (0.34%) 
#                   Dropped:    271 (0.27%)
# TrimmomaticPE: Completed successfully
```

```{.sh}
#Using cutadapt for trimming reads
#R1
cutadapt \
    --quality-cutoff 15,15 \
    --overlap 30 \
    --quality-base 33 \
   $WDR/seqs/${SQSET}/${SQSET}_1.fastq.gz \
    --output $WDR/seqs/${SQSET}/${SQSET}_1.cutadapt.fastq.gz
#R2 
cutadapt \
    --quality-cutoff 15,15 \
    --overlap 30 \
    --quality-base 33 \
   $WDR/seqs/${SQSET}/${SQSET}_2.fastq.gz \
    -o $WDR/seqs/${SQSET}/${SQSET}_2.cutadapt.fastq.gz
 
#SQSET=SRR6130428 cutadapt output for R1
=== Summary ===

Total reads processed:               5,346,334
Reads written (passing filters):     5,346,334 (100.0%)

Total basepairs processed:   539,979,734 bp
Quality-trimmed:              26,063,936 bp (4.8%)
Total written (filtered):    513,915,798 bp (95.2%)

#SQSET=SRR6130428 cutadapt output for R2 
=== Summary ===

Total reads processed:               2,768,518
Reads written (passing filters):     2,768,518 (100.0%)

Total basepairs processed:   279,620,318 bp
Quality-trimmed:               1,364,499 bp (0.5%)
Total written (filtered):    278,255,819 bp (99.5%)

#SQSET=SRR3481383 cutadapt output for R1
=== Summary ===

Total reads processed:                 100,000
Reads written (passing filters):       100,000 (100.0%)

Total basepairs processed:    10,100,000 bp
Quality-trimmed:                 171,591 bp (1.7%)
Total written (filtered):      9,928,409 bp (98.3%)

#SQSET=SRR3481383 cutadapt output for R2
=== Summary ===

Total reads processed:                 100,000
Reads written (passing filters):       100,000 (100.0%)

Total basepairs processed:    10,100,000 bp
Quality-trimmed:                 447,684 bp (4.4%)
Total written (filtered):      9,652,316 bp (95.6%)
```

Checking the new reads filtered by running `fastqc`
over the pair-end reads from `trimmomatic` and `cutadapt`.

```{.sh}
#SQSET=SRR6130428
#SQSET=SRR3481383
mkdir -vp $WDR/seqs/${SQSET}/${SQSET}.trimmo.QC
mkdir -vp $WDR/seqs/${SQSET}/${SQSET}.cutadapt.QC

#for trimmomatic pair-end reads
for READSET in 1 2;
  do {
    echo "# Running fastQC on trimmed PE reads $SQSET R${READSET}..." 1>&2;
    fastqc -t 8 --format fastq                                  \
           --contaminants $BIN/fastqc_conf/contaminant_list.txt \
           --adapters     $BIN/fastqc_conf/adapter_list.txt     \
           --limits       $BIN/fastqc_conf/limits.txt           \
           -o $WDR/seqs/${SQSET}/${SQSET}.trimmo.QC             \
	          $WDR/seqs/${SQSET}/${SQSET}_${READSET}.trimmo_pe.fastq.gz \
           2> $WDR/seqs/${SQSET}/${SQSET}.trimmo.QC/fastQC_${SQSET}_${READSET}.log 1>&2;
  }; done
  
#for cutadapt pair-end reads
for READSET in 1 2;
  do {
    echo "# Running fastQC on cutadapt PE reads $SQSET R${READSET}..." 1>&2;
    fastqc -t 8 --format fastq                                  \
           --contaminants $BIN/fastqc_conf/contaminant_list.txt \
           --adapters     $BIN/fastqc_conf/adapter_list.txt     \
           --limits       $BIN/fastqc_conf/limits.txt           \
           -o $WDR/seqs/${SQSET}/${SQSET}.cutadapt.QC             \
	          $WDR/seqs/${SQSET}/${SQSET}_${READSET}.cutadapt.fastq.gz \
           2> $WDR/seqs/${SQSET}/${SQSET}.cutadapt.QC/fastQC_${SQSET}_${READSET}.cutadapt.log 1>&2;
           }; done
```
\clearpage
```{=latex}
\begin{figure}[!ht]
\begin{center}
 \begin{tabular}{c@{}c}
  \includegraphics[width=0.435\linewidth]{{images/trimmo_SRR6130428_quality_R1}.png}     &
  \includegraphics[width=0.435\linewidth]{{images/trimmo_SRR6130428_quality_R2}.png}     \\[-0.75ex]
  \includegraphics[width=0.435\linewidth]{{images/trimmo_SRR6130428_basecontent_R1}.png} &
  \includegraphics[width=0.435\linewidth]{{images/trimmo_SRR6130428_basecontent_R2}.png} \\[-0.75ex]
  \includegraphics[width=0.435\linewidth]{{images/trimmo_SRR6130428_gccontent_R1}.png}   &
  \includegraphics[width=0.435\linewidth]{{images/trimmo_SRR6130428_gccontent_R2}.png}   \\[-0.75ex]
 \end{tabular}
 \parbox{0.8\linewidth}{%
  \caption[Cleaned reads basic sequence analyses for \texttt{SRR6130428}]{%
   \label{fig:fastqcsetA1}\textbf{Cleaned reads basic sequence analyses for \texttt{SRR6130428} using `trimmomatic`.} Left column shows results for the forward reads (R1), right column for the reverse reads (R2). On top panels we can observe phred scores distribution per base position, mid panels correspond to the base composition per position, while the bottom ones show the GC content distribution across reads.
  }%caption
 }%parbox
\end{center}
\end{figure}
```
\clearpage
```{=latex}
\begin{figure}[!ht]
\begin{center}
 \begin{tabular}{c@{}c}
  \includegraphics[width=0.435\linewidth]{{images/cutadapt_SRR6130428_quality_R1}.png}     &
  \includegraphics[width=0.435\linewidth]{{images/cutadapt_SRR6130428_quality_R2}.png}     \\[-0.75ex]
  \includegraphics[width=0.435\linewidth]{{images/cutadapt_SRR6130428_basecontent_R1}.png} &
  \includegraphics[width=0.435\linewidth]{{images/cutadapt_SRR6130428_basecontent_R2}.png} \\[-0.75ex]
  \includegraphics[width=0.435\linewidth]{{images/cutadapt_SRR6130428_gccontent_R1}.png}   &
  \includegraphics[width=0.435\linewidth]{{images/cutadapt_SRR6130428_gccontent_R2}.png}   \\[-0.75ex]
 \end{tabular}
 \parbox{0.8\linewidth}{%
  \caption[Cleaned reads basic sequence analyses for \texttt{SRR6130428}]{%
   \label{fig:fastqcsetA2}\textbf{Cleaned reads basic sequence analyses for \texttt{SRR6130428} using `cutadapt`.} Left column shows results for the forward reads (R1), right column for the reverse reads (R2). On top panels we can observe phred scores distribution per base position, mid panels correspond to the base composition per position, while the bottom ones show the GC content distribution across reads.
  }%caption
 }%parbox
\end{center}
\end{figure}
```
\clearpage
```{=latex}
\begin{figure}[!ht]
\begin{center}
 \begin{tabular}{c@{}c}
  \includegraphics[width=0.435\linewidth]{{images/trimmo_SRR3481383_quality_R1}.png}     &
  \includegraphics[width=0.435\linewidth]{{images/trimmo_SRR3481383_quality_R2}.png}     \\[-0.75ex]
  \includegraphics[width=0.435\linewidth]{{images/trimmo_SRR3481383_basecontent_R1}.png} &
  \includegraphics[width=0.435\linewidth]{{images/trimmo_SRR3481383_basecontent_R2}.png} \\[-0.75ex]
  \includegraphics[width=0.435\linewidth]{{images/trimmo_SRR3481383_gccontent_R1}.png}   &
  \includegraphics[width=0.435\linewidth]{{images/trimmo_SRR3481383_gccontent_R2}.png}   \\[-0.75ex]
 \end{tabular}
 \parbox{0.8\linewidth}{%
  \caption[Cleaned reads basic sequence analyses for \texttt{SRR3481383}]{%
   \label{fig:fastqcsetB1}\textbf{Cleaned reads basic sequence analyses for \texttt{SRR3481383} using `trimmomatic`.} Left column shows results for the forward reads (R1), right column for the reverse reads (R2). On top panels we can observe phred scores distribution per base position, mid panels correspond to the base composition per position, while the bottom ones show the GC content distribution across reads.
  }%caption
 }%parbox
\end{center}
\end{figure}
```
\clearpage
```{=latex}
\begin{figure}[!ht]
\begin{center}
 \begin{tabular}{c@{}c}
  \includegraphics[width=0.435\linewidth]{{images/cutadapt_SRR3481383_quality_R1}.png}     &
  \includegraphics[width=0.435\linewidth]{{images/cutadapt_SRR3481383_quality_R2}.png}     \\[-0.75ex]
  \includegraphics[width=0.435\linewidth]{{images/cutadapt_SRR3481383_basecontent_R1}.png} &
  \includegraphics[width=0.435\linewidth]{{images/cutadapt_SRR3481383_basecontent_R2}.png} \\[-0.75ex]
  \includegraphics[width=0.435\linewidth]{{images/cutadapt_SRR3481383_gccontent_R1}.png}   &
  \includegraphics[width=0.435\linewidth]{{images/cutadapt_SRR3481383_gccontent_R2}.png}   \\[-0.75ex]
 \end{tabular}
 \parbox{0.8\linewidth}{%
  \caption[Cleaned reads basic sequence analyses for \texttt{SRR3481383}]{%
   \label{fig:fastqcsetB2}\textbf{Cleaned reads basic sequence analyses for \texttt{SRR3481383} using `cutadapt`.} Left column shows results for the forward reads (R1), right column for the reverse reads (R2). On top panels we can observe phred scores distribution per base position, mid panels correspond to the base composition per position, while the bottom ones show the GC content distribution across reads.
  }%caption
 }%parbox
\end{center}
\end{figure}
```
\clearpage
We can now estimate the sequencing coverage, as we already have the
size of the reference genome, and the total amount of nucleotides
generated by the sequencing projects.

```{.sh}
#SQSET=SRR6130428
#SQSET=SRR3481383
# raw PE-reads
gunzip -c $WDR/seqs/${SQSET}/${SQSET}_[12].fastq.gz | \
  infoseq -sequence fastq::stdin -only -length -noheading | \
    gawk '{ s+=$1; n++ }
          END{ printf "# Total %d sequences and %d nucleotides\n", n, s }'
#SQSET=SRR6130428
# Total 5,537,036 sequences and 559,240,636 nucleotides
#
#SQSET=SRR3481383
# Total 10,692,668 sequences and 1,079,959,468 nucleotides

# cleaned PE-reads
gunzip -c $WDR/seqs/${SQSET}/${SQSET}_[12].trimmo_pe.fastq.gz | \
  infoseq -sequence fastq::stdin -only -length -noheading | \
    gawk '{ s+=$1; n++ }
          END{ printf "# Total %d sequences and %d nucleotides\n", n, s }'
#SQSET=SRR6130428
# Total 5,072,168 sequences and 499,530,830 nucleotides
#
#SQSET=SRR3481383
# Total 8,636,178 sequences and 839,065,950 nucleotides
```

For raw and cleaned reads of \texttt{SRR6130428} we can estimate a sequencing coverage of
$\num{559240636}/\num{12157105}=46.00$X and $\num{499530830}/\num{12157105}=41.09$X respectively.
For the complete set of raw and cleaned reads of \texttt{SRR3481383} we have estimated a sequencing coverage of $\num{1079959468}/\num{12157105}=88.83$X and $\num{839065950}/\num{12157105}=69.02$X respectively.


## Assembling reads with `SOAPdenovo`

`SOAPdenovo`\footnote{Luo et al. "SOAPdenovo2: an empirically improved
memory-efficient short-read de novo assembler". \textit{GigaScience},
1:18, 2012.} is easy to install and to configure. It has been reported
to perform like other more complex tools, generating in some tests
less chimeric contigs and missasemblies.

```{.r}
# SQSET=SRR6130428
# SQSET=SRR3481383
export SPD=$WDR/soapdenovo/$SQSET
mkdir -vp $SPD
  
export GENOMESIZE=12157105;  

# Generating the configuration file for SRR6130428
cat > $SPD/SRR6130428_soap.conf <<EOF
# Raw reads from SRA experiment SRR6130428
# Description: Original WT strain, Illumina HiSeq 4000 (2x100bp)
# Insert size was not described on the SRA project, using 450bp
# ---
# maximal read length
max_rd_len=100
#
[LIB]
# average insert size
avg_ins=450
# if sequence needs to be reversed (0 for short insert PE libs)
reverse_seq=0
# in which part(s) the reads are used (3 for both contig and scaffold assembly)
asm_flags=3
# use only first 100 bps of each read
rd_len_cutoff=100
# in which order the reads are used while scaffolding
rank=1
# cutoff of pair number for a reliable connection (at least 3 for short insert size)
pair_num_cutoff=3
# minimum aligned length to contigs for a reliable read location (at least 32 for short insert size)
map_len=32
# a pair of fastq file, read 1 file should always be followed by read 2 file
# using pair-end reads after filtering with trimmomatic
q1=$WDR/seqs/${SQSET}/${SQSET}_1.trimmo_pe.fastq.gz
q2=$WDR/seqs/${SQSET}/${SQSET}_2.trimmo_pe.fastq.gz
#
EOF

# Generating the configuration file for SRR3481383
cat > $SPD/SRR3481383_soap.conf <<EOF
# Raw reads from SRA experiment SRR3481383
# Description: Original WT strain, Illumina HiSeq 2000
# Insert size was not described on the SRA project, using 450bp
# ---
# maximal read length
max_rd_len=100
#
[LIB]
# average insert size
avg_ins=450
# if sequence needs to be reversed (0 for short insert PE libs)
reverse_seq=0
# in which part(s) the reads are used (3 for both contig and scaffold assembly)
asm_flags=3
# use only first 100 bps of each read
rd_len_cutoff=100
# in which order the reads are used while scaffolding
rank=1
# cutoff of pair number for a reliable connection (at least 3 for short insert size)
pair_num_cutoff=3
# minimum aligned length to contigs for a reliable read location (at least 32 for short insert size)
map_len=32
# a pair of fastq file, read 1 file should always be followed by read 2 file
# using pair-end reads after filtering with trimmomatic
q1=$WDR/seqs/${SQSET}/SRR3481383_1.subset100k.fastq.gz
q2=$WDR/seqs/${SQSET}/SRR3481383_2.subset100k.fastq.gz
#
EOF

# Building the k-mers graph
soapdenovo2-63mer pregraph -s $SPD/${SQSET}_soap.conf -K 63 -R -p 8 \
                           -o $SPD/${SQSET}_k63_graph               \
                           2> $SPD/${SQSET}_k63_pregraph.log 1>&2;
			    
# Contiging stage
soapdenovo2-63mer contig   -g $SPD/${SQSET}_k63_graph -R -p 8 \
                           2> $SPD/${SQSET}_k63_contig.log 1>&2;

# Mapping reads back over the contigs
soapdenovo2-63mer map      -s $SPD/${SQSET}_soap.conf -p 8 \
                           -g $SPD/${SQSET}_k63_graph      \
                           2> $SPD/${SQSET}_k63_map.log 1>&2;

# Scaffolding contigs if we have long range reads (i.e. a 2kbp mate-pairs run)
# in this case, as we only have a single pair-ends library, we will get a result
# that will be similar or the same as what we have obtained in the contiging stage
#
soapdenovo2-63mer scaff    -F -p 8 -N $GENOMESIZE            \
                           -g $SPD/${SQSET}_k63_graph_prefix \
                           2> $SPD/${SQSET}_k63_scaff.log 1>&2;

# just by looking at the $SPD/${SQSET}_k63_contig.log file,
# we can retrieve info about contigs assembly, such as N50
tail $SPD/${SQSET}_k63_contig.log

# SQSET=SRR6130428
# There are 3156 contig(s) longer than 100, sum up 11779878 bp, with average length 3732.
# The longest length is 69946 bp, contig N50 is 14294 bp, contig N90 is 3279 bp.
# 4867 contig(s) longer than 64 output.
#
# SQSET=SRR3481383
# There are 463 contig(s) longer than 100, sum up 127222 bp, with average length 274.
# The longest length is 7366 bp, contig N50 is 231 bp,contig N90 is 193 bp.
# 494 contig(s) longer than 64 output.
```

```{.sh}
# Computing some extra stats from the assemblies,

export PERL5LIB=$BIN;

chmod +x $WRD/bin/assemblathon_stats.pl
 zcat $WDR/seqs/$REFDIR/$REFGEN.fsa.gz | \
 $BIN/assemblathon_stats.pl \
            -csv -genome_size 12160000 \
            $WDR/soapdenovo/${SQSET}/${SQSET}_k63_graph.contig \
          > $WDR/stats/assembly_stats_${SQSET}_soapdenovo_k63_graph.contig.txt
```

The files `*.contig` and `*.scafSeq` were created for the fasta sequences assembled 
contigs and scaffolds, respectively.


__Open questions arise:__

* Is it possible to calculate the contig's lengths, and produce a plot distribution?
* What would happen if using a larger coverage reads set?
* Would knowing the real insert size improve the assembly?

In an attempt to answer these questions, the assembly was compared with
another assembly of the suggested raw-reads set.


## Estimating insert size with `picard`

Firstly, we checked whether the estimated insert size was an educated guess by
aligning the PE reads against the reference genome or the
assembly, and then taking the alignments in `bam` format to estimate
insert size with `picard` tool. This was only performed for the SRR6130428 dataset,
as we have previosuly trimmed the SRR3481383 dataset.

```{.sh}
# SQSET=SRR6130428;
# SQSET=SRR3481383
export BWT=$WDR/bowtie;

mkdir -vp $BWT/$SQSET;
mkdir $WDR/tmpsort	 

# by linking contigs file to one file with a fasta suffix,
# it facilitates using those sequences on IGV.
ln -vs ./${SQSET}_k63_graph.contig \
       $WDR/soapdenovo/${SQSET}/${SQSET}_k63_graph.contig.fa;

# preparing reference sequence databases for bowtie
FSAD=$WDR/seqs/$REFDIR;
bowtie2-build --large-index -o 2 \
              $FSAD/$REFGEN.fsa.gz \
              $BWT/scer_refgenome.bowtiedb \
           2> $BWT/scer_refgenome.bowtiedb.log 1>&2;
	
bowtie2-build --large-index -o 2 \
              $WDR/soapdenovo/${SQSET}/${SQSET}_k63_graph.contig \
              $BWT/${SQSET}/${SQSET}_k63_graph.contig.bowtiedb \
           2> $BWT/${SQSET}/${SQSET}_k63_graph.contig.bowtiedb.log 1>&2;

# mapping pe reads over reference sequences
TMP=$WDR/tmpsort;
PEfileR1=$WDR/seqs/${SQSET}/${SQSET}_1.trimmo_pe.fastq.gz;
PEfileR2=$WDR/seqs/${SQSET}/${SQSET}_2.trimmo_pe.fastq.gz;

BWTBF=$BWT/${SQSET}/${SQSET}-x-scer_refgen.bowtie;
TMPBF=$TMP/${SQSET}-x-scer_refgen.bowtie;

bowtie2 -q --threads 8 -k 5 -L 12                    \
        --local --sensitive-local --no-unal --met 60 \
        --met-file $BWTBF.metrics                    \
        -x         $BWT/scer_refgenome.bowtiedb      \
        -1         $PEfileR1  \
        -2         $PEfileR2  \
        -S         $TMPBF.sam \
        2>         $BWTBF.log 1>&2;
	
( samtools view -Sb -o ${TMPBF}.bam \
                       ${TMPBF}.sam;
  samtools sort ${TMPBF}.bam   \
             -o ${TMPBF}.sorted.bam;
  mv -v ${TMPBF}.sorted.bam ${BWTBF}.sorted.bam;
  rm -v ${TMPBF}.sam ${TMPBF}.bam
  ) 2> ${BWTBF}.bowtie2sortedbam.log 1>&2;

samtools index $BWTBF.sorted.bam;

java -jar $BIN/picard.jar CollectInsertSizeMetrics   \
          HISTOGRAM_FILE=$BWTBF.insertsize.hist.pdf  \
                   INPUT=$BWTBF.sorted.bam           \
                  OUTPUT=$BWTBF.insertsize_stats.txt \
           ASSUME_SORTED=true \
              DEVIATIONS=25   \
                      2> $BWTBF.insertsize_stats.log;


# checking the assembled contigs

BWTBF=$BWT/${SQSET}/${SQSET}-x-soapk63ctgs.bowtie;
TMPBF=$TMP/${SQSET}-x-soapk63ctgs.bowtie;

bowtie2 -q --threads 8 -k 5 -L 12                    \
        --local --sensitive-local --no-unal --met 60 \
        --met-file $BWTBF.metrics                    \
        -x         $BWT/scer_refgenome.bowtiedb      \
        -1         $PEfileR1  \
        -2         $PEfileR2  \
        -S         $TMPBF.sam \
        2>         $BWTBF.log 1>&2;
	
( samtools view -Sb -o $TMPBF.bam \
                       $TMPBF.sam;
  samtools sort $TMPBF.bam   \
             -o $TMPBF.sorted.bam;
  mv -v $TMPBF.sorted.bam $BWTBF.sorted.bam;
  rm -v $TMPBF.sam $TMPBF.bam
  ) 2> $BWTBF.bowtie2sortedbam.log 1>&2;

samtools index $BWTBF.sorted.bam;

java -jar $BIN/picard.jar CollectInsertSizeMetrics   \
          HISTOGRAM_FILE=$BWTBF.insertsize.hist.pdf  \
                   INPUT=$BWTBF.sorted.bam           \
                  OUTPUT=$BWTBF.insertsize_stats.txt \
           ASSUME_SORTED=true \
              DEVIATIONS=25   \
                      2> $BWTBF.insertsize_stats.log;
```
\clearpage
```{=latex}
\begin{figure}[!ht]
\begin{center}
 \begin{tabular}{c@{}c}
  \includegraphics[width=0.435\linewidth]{{bowtie/SRR6130428/SRR6130428-x-scer_refgen.bowtie.insertsize.hist}.png}     &
  \includegraphics[width=0.435\linewidth]{{bowtie/SRR6130428/SRR6130428-x-soapk63ctgs.bowtie.insertsize.hist}.png}     \\[-0.75ex]
  \includegraphics[width=0.435\linewidth]{{images/trimmo_SRR6130428_basecontent_R1}.png} &
  \includegraphics[width=0.435\linewidth]{{images/trimmo_SRR6130428_basecontent_R2}.png} \\[-0.75ex]
 \end{tabular}
 \parbox{0.8\linewidth}{%
  \caption[Cleaned reads basic sequence analyses for \texttt{SRR6130428}]{%
   \label{fig:picardassemblies}\textbf{Histogram outputs by \textit{picard} of the \texttt{SRR6130428} reads alignment over the reference genome and the \textit{soapdenovo} assemblies.} 
  }%caption
 }%parbox
\end{center}
\end{figure}
```


# Exploring the assemblies

## Filter out contigs mapping to reference chromosomes

On this section we are going to run `dnadiff` from the `MUMmer`
package\footnote{S. Kurtz, A. Phillippy, A.L. Delcher, M. Smoot,
M. Shumway, C. Antonescu, and S.L. Salzberg.\newline\hspace*{1cm}
"Versatile and open software for comparing large genomes."
\textit{Genome Biology}, 5:R12, 2004.} to compare assembled contigs
against the reference or between them. In order to speed up the
example, we will first use `NCBI-BLAST`\footnote{C. Camacho,
G. Coulouris, V. Avagyan, N. Ma, J. Papadopoulos, K. Bealer, and
T.L. Madden.\newline\hspace*{1cm} "BLAST+: architecture and
applications." \textit{BMC Bioinformatics}, 10:421, 2008.} to project
all the assembled contigs into the chosen reference chromosomes, 
and reduce all the downstream calculations. Thus, a database was
created for each assembly sequence sets which will be queried by the
reference selected chromosomes.

```{.sh}
SQSET=SRR6130428

mkdir -vp $WDR/blast/dbs

makeblastdb -in $WDR/soapdenovo/$SQSET/${SQSET}_k63_graph.contig.fa \
            -dbtype nucl \
	    -title "${SQSET}_SOAPdenovo_k63_contigs" \
	    -out $WDR/blast/dbs/${SQSET}_SOAPdenovo_k63_contigs \
	      2> $WDR/blast/dbs/${SQSET}_SOAPdenovo_k63_contigs.log 1>&2;
```

For practical reasons, we focused on a couple of reference genome's chromosomes, `chrI` and
`chrM` (mitochondrion genome). In order to obtain their sequences, they may
be downloaded from the genome repository or filtered out from the whole genome fasta
file as shown below:

```{.sh}
mkdir -vp $WDR/seqs/chrs;

for SQ in chrI:NC_001133 chrM:NC_001224;
  do {
    SQN=${SQ%%:*}; # get the chr from SQ string
    SQI=${SQ##*:}; # get the refseq id from SQ string
    echo "# Filtering $SQN [$SQI] from whole genome fasta file..." 1>&2;
    samtools faidx \
             $WDR/seqs/S288C_reference_genome_R64-4-1_20230830/S288C_reference_sequence_R64-4-1_20230830.fsa/S288C_reference_sequence_R64-4-1_20230823.fsa \
	     'ref|'$SQI'|' | \
      sed 's/^>.*$/>Scer_'$SQN'/;' > $WDR/seqs/chrs/$SQN.fa
  }; done
```

Subsequently, the reference sequences may be `BLAST`-ed against the newly created
database; using the `megablast` option to compare sequences
of the same species, since this `BLAST` program is optimal for 
the desired genomic searches.

```{.sh}
# here is defined a custom BLAST tabular output format
BLASTOUTFORMAT='6 qseqid qlen sseqid slen qstart qend sstart send length';
BLASTOUTFORMAT=$BLASTOUTFORMAT' score evalue bitscore pident nident ppos positive';
BLASTOUTFORMAT=$BLASTOUTFORMAT' mismatch gapopen gaps qframe sframe';
export BLASTOUTFORMAT;

#fixing permission/ownership issues with the blast/ directory
ls -l blast/
#	total 12
#	drwxr-xr-x 2 root root 4096 Mar 20 11:48 chrI-x-SRR6130428
#	drwxr-xr-x 2 root root 4096 Mar 20 11:48 chrM-x-SRR6130428
#	drwxr-xr-x 2 root root 4096 Mar 20 11:25 dbs

sudo chown -R mariana /home/mariana/uni/exercise_02/blast/
chmod u+rwx blast/
ls -l blast/
#	total 12
#	drwxr-xr-x 2 mariana root 4096 Mar 20 11:48 chrI-x-SRR6130428
#	drwxr-xr-x 2 mariana root 4096 Mar 20 11:48 chrM-x-SRR6130428
#	drwxr-xr-x 2 mariana root 4096 Mar 20 11:25 dbs

for SQ in chrI chrM;
  do {
    echo "# Running MEGABLAST: $SQSET x $SQ ..." 1>&2;
    mkdir -vp $WDR/blast/${SQ}-x-${SQSET};
    blastn -task megablast -num_threads 8                        \
           -db    $WDR/blast/dbs/${SQSET}_SOAPdenovo_k63_contigs \
           -outfmt "$BLASTOUTFORMAT"                             \
           -query $WDR/seqs/chrs/$SQ.fa                          \
           -out   $WDR/blast/${SQ}-x-${SQSET}/${SQ}-x-${SQSET}_megablast.out \
             2>   $WDR/blast/${SQ}-x-${SQSET}/${SQ}-x-${SQSET}_megablast.log;
  }; done
```

Once contigs have been matched, they are filtered from
the whole assembly fasta file.

```{.sh}
for SQ in chrI chrM;
  do {
    echo "# Running MEGABLAST: $SQSET x $SQ ..." 1>&2;
    OFBN="$WDR/blast/${SQ}-x-${SQSET}/${SQ}-x-${SQSET}_megablast";
    # this is a check to ensure we start with an empty contigs fasta file
    if [ -e "$WDR/blast/${SQ}-x-${SQSET}/${SQ}-x-${SQSET}_megablast.fa" ];
      then
        printf '' > "$WDR/blast/${SQ}-x-${SQSET}/${SQ}-x-${SQSET}_megablast.fa"; # rm can be also used here, but dangerous for novice
      fi;
    # get the contig IDs from third column and filter out sequences
    gawk '{ print $3 }' "$WDR/blast/${SQ}-x-${SQSET}/${SQ}-x-${SQSET}_megablast.out" | sed 's/^>//' | sort | uniq | \
      while read SQID;
        do {
           samtools faidx \
                    $WDR/soapdenovo/$SQSET/${SQSET}_k63_graph.contig.fa \
                    "$SQID";
        }; done >> "$WDR/blast/${SQ}-x-${SQSET}/${SQ}-x-${SQSET}_megablast.fa" \
                2> "$WDR/blast/${SQ}-x-${SQSET}/${SQ}-x-${SQSET}_megablast.fa.log";
  }; done
```

The filtered contigs are then subjected to a sequence comparison procedure based on `dnadiff`:

```{.sh}
SQSET=SRR6130428

for SQ in chrI chrM;
  do {
    printf "# Running DNADIFF protocol: $SQSET x $SQ ..." 1>&2;
    IFBN="$WDR/blast/${SQ}-x-${SQSET}/${SQ}-x-${SQSET}_megablast";
    OFBD="$WDR/blast/${SQ}-x-${SQSET}/${SQ}-x-${SQSET}_megablast.dnadiff";
    #
    dnadiff -p $WDR/blast/${SQ}-x-${SQSET}/${SQ}-x-${SQSET}_megablast.dnadiff              \
            $WDR/seqs/chrs/${SQ}.fa \
            $WDR/blast/${SQ}-x-${SQSET}/${SQ}-x-${SQSET}_megablast.fa      \
         2> $WDR/blast/${SQ}-x-${SQSET}/${SQ}-x-${SQSET}_megablast.dnadiff.log;
    printf " DNAdiff..." 1>&2;
    mummerplot --large --layout --fat --postscript \
               -t "Alignment Plot: ${SQ}-x-${SQSET}" \
               -p $WDR/blast/${SQ}-x-${SQSET}/${SQ}-x-${SQSET}_megablast.dnadiff          \
                  $WDR/blast/${SQ}-x-${SQSET}/${SQ}-x-${SQSET}_megablast.dnadiff.1delta    \
               2> $WDR/blast/${SQ}-x-${SQSET}/${SQ}-x-${SQSET}_megablast.dnadiff.alnplot.log;
    gm convert \
    	 $WDR/blast/${SQ}-x-${SQSET}/${SQ}-x-${SQSET}_megablast.dnadiff.ps \
    	 -background white
    	 $WDR/blast/${SQ}-x-${SQSET}/${SQ}-x-${SQSET}_megablast.dnadiff.png;
               # add this to convert PostScript image to PNG
    printf " ALNplot..." 1>&2;
    mummerplot --large --layout --fat --postscript \
               -t "Coverage Plot: ${SQ}-x-${SQSET}" \
               -p $WDR/blast/${SQ}-x-${SQSET}/${SQ}-x-${SQSET}_megablast.dnadiff.covg     \
                  $WDR/blast/${SQ}-x-${SQSET}/${SQ}-x-${SQSET}_megablast.dnadiff.1delta    \
               2> $WDR/blast/${SQ}-x-${SQSET}/${SQ}-x-${SQSET}_megablast.dnadiff.cvgplot.log;
    convert-im6 -verbose \
        -background white \
  -contrast-stretch 0x70% \
    -quality 600 \
    	$WDR/blast/${SQ}-x-${SQSET}/${SQ}-x-${SQSET}_megablast.dnadiff.covg.ps \
    	$WDR/blast/${SQ}-x-${SQSET}/${SQ}-x-${SQSET}_megablast.dnadiff.covg.png;
              # add this to convert PostScript image to PNG
    printf " CVGplot..." 1>&2;j
    ( grep "TotalBases"   $WDR/blast/${SQ}-x-${SQSET}/${SQ}-x-${SQSET}_megablast.dnadiff.report;
      grep "AlignedBases" $WDR/blast/${SQ}-x-${SQSET}/${SQ}-x-${SQSET}_megablast.dnadiff.report;
      grep "AvgIdentity"  $WDR/blast/${SQ}-x-${SQSET}/${SQ}-x-${SQSET}_megablast.dnadiff.report
      ) > $WDR/blast/${SQ}-x-${SQSET}/${SQ}-x-${SQSET}_megablast.dnadiff.shortsummary;
    printf " DONE\n" 1>&2;
  }; done
```

For chrI and chrM assemblies, the estimated aligned bases coverage is
$\num{297103}/\num{230218}=1.29$X and $\num{85749}/\num{85779}=0.99$X, respectively.


```{=latex}
\begin{figure}[!ht]
\begin{center}
 \begin{tabular}{cc}
  \bf chrI & \bf chrM \\
  \includegraphics[width=0.45\linewidth]{{blast/chrI-x-SRR6130428/chrI-x-SRR6130428_megablast.dnadiff}.pdf} &
  \includegraphics[width=0.45\linewidth]{{blast/chrM-x-SRR6130428/chrM-x-SRR6130428_megablast.dnadiff}.pdf} \\ 
  %% trim={<left> <lower> <right> <upper>}
  \includegraphics[width=0.45\linewidth]%
                  {{blast/chrI-x-SRR6130428/chrI-x-SRR6130428_megablast.dnadiff.covg}.pdf} &
  \includegraphics[width=0.45\linewidth]%
                  {{blast/chrM-x-SRR6130428/chrM-x-SRR6130428_megablast.dnadiff.covg}.pdf} \\ 
 \end{tabular}
 \parbox{0.75\linewidth}{%
  \caption[\texttt{dnadiff} comparison between two reference chromosomes and \texttt{SRR6130428} contigs]{%
   \label{fig:mummer}\textbf{\texttt{dnadiff} comparison between two reference chromosomes and \texttt{SRR6130428} contigs.} Top panels show the alignment plots of contigs from \texttt{SRR6130428} assembly mapped over two reference \Scer\ chromosomes, chrI and chrM on left and right panels respectively. Bottom panels show the chrI and chrM alignment coverage. Contigs aligning to chrM have better contiguity and higher coverage than the nuclear chromosomes (chrI), as the plot displays a more diagonal and longer line.
  }%caption
 }%parbox
\end{center}
\end{figure}
```

## Assessment of genome completeness with `BUSCO`

`BUSCO`\footnote{M. Manni, M.R. Berkeley, M. Seppey, F.A. Simão, and
E.M. Zdobnov.\newline\hspace*{1cm} "\texttt{BUSCO} Update: Novel and
Streamlined Workflows along with Broader and Deeper Phylogenetic
Coverage for Scoring of Eukaryotic, Prokaryotic, and Viral Genomes."
\textit{Molecular Biology and Evolution}, 38(10)4647-–4654, 2021.}
estimates the completeness and redundancy of processed genomic data
based on universal single-copy orthologs. First of all, we need to
check if there is a clade-specific parameters set that fits with our
organism, \Scer\ belong to the _Saccharomycetes_ class, within the
_Ascomycota_ phylum in the Fungi kingdom (see
\href{https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?mode=info&id=4932}{NCBI
Taxonomy browser species card}).

```{.sh}
busco --list-datasets
# 2022-10-24 19:06:49 INFO:	Downloading information on latest versions of BUSCO data...
# 2022-10-24 19:06:52 INFO:	Downloading file 'https://busco-data.ezlab.org/v5/data/information/lineages_list.2021-12-14.txt.tar.gz'
# 2022-10-24 19:06:53 INFO:	Decompressing file '/home/lopep/SANDBOX/BScCG2324/exercise_02/busco_downloads/information/lineages_list.2021-12-14.txt.tar.gz'
# 
# ################################################
# 
# Datasets available to be used with BUSCO v4 and v5:
# 
#  bacteria_odb10
#      - ...
#  archaea_odb10
#      - ...
#  eukaryota_odb10
#      - ...
#      - fungi_odb10
#          - ascomycota_odb10
#              - ...
#              - saccharomycetes_odb10
#              - ...
#          - ...
#      - ...
#  viruses (no root dataset)
#      - ...
# 
```

There is a class-specific set to evaluate the
completeness of the genome assembly `saccharomycetes_odb10`. 
However, it may be informative to use a more general parameters set,
 such as `fungi_odb10` or even `eukaryota_odb10` (or both), and compare the corresponding
results. This can be useful to extrapolate the assessment to other
species' genomes.

```{.sh}
mkdir -vp $WDR/busco/$SQSET

# fix PATH to point bin folders where you installed bbmap and busco programs
export BBMAP=$BIN/bbmap:$BIN/busco/bin:$BBMAP
export BUSCO=$BIN/bin/busco/bin:$BUSCO

export OUT=$WDR/busco/$SQSET/${SQSET}_k63_contigs:$OUT

# cd $WDR
busco -m genome \
      -i $WDR/soapdenovo/$SQSET/${SQSET}_k63_graph.contig.fa \
      -o $WDR/busco/$SQSET/${SQSET}_k63_contigs \
      -l saccharomycetes_odb10
      -f
## if you get an error "A run with the name xxx already exists"
## you should add command-line option "-f" to force overwriting those files
#    ---------------------------------------------------
#    |Results from dataset saccharomycetes_odb10       |
#    ---------------------------------------------------
#    |  C:98.8%[S:96.7%,D:2.1%],F:0.5%,M:0.7%,n:2137   |
#    |2111  Complete BUSCOs (C)                        |
#    |2067  Complete and single-copy BUSCOs (S)        |
#    |44    Complete and duplicated BUSCOs (D)         |
#    |11    Fragmented BUSCOs (F)                      |
#    |15    Missing BUSCOs (M)                         |
#    |2137  Total BUSCO groups searched                |
#    ---------------------------------------------------
# 2022-10-26 19:55:26 INFO: BUSCO analysis done. Total running time: 440 seconds
```

Note: The `generate_plot.py` script that is provided under the scripts
folder of the `busco` installation may be used for plotting the resulting completeness values.

```{.sh}
python3 $BIN/busco/scripts/generate_plot.py \
    -wd ./busco/$SQSET/${SQSET}_k63_contigs
```

```{=latex}
\begin{figure}[!ht]
\begin{center}
 \includegraphics[width=0.7\linewidth]{{$WDR/busco/SRR6130428/busco_figure}.png}
  \parbox{0.75\linewidth}{%
  \caption[\texttt{busco} assessment of genomic completedness.]{%
   \label{fig:buscoimage}\textbf{\texttt{busco}'s quantitative assessment of the genetic completeness of the {SRR6130428} contigs from \Scer\.} 
  }%caption
 }%parbox
\end{center}
\end{figure}
```

\clearpage
# Discussion

Due to hardware limitations, this report will solely discuss the complete analysis results of the Illumina HiSeq 4000 sequencing dataset SRR6130428 (SRX3242873 \Sra\, 221.2Mb) of the \scer\ genome. It will, however, also include some preliminary analysis of another dataset of the \scer\ genome, for comparison of data quality between the different Illumina technologies (SRR3481383). From this SRA file, the two extracted spots were split into a forward (R1) and reverse (R2) fastq files of the raw sequencing data. The quality control of the raw sequencing data was performed to filter out contaminant sequences, adapter sequences, and any other sequences that do not meet the default quality thresholds defined by `fastqc`. As seen in Figure\ref{fig:fastqcsetA}, the mean phred score distribution per base position is high for R1 and R2 and the contigs present with an uniform GC content distribution. 

The quality of the sequencing data was further improved by `trimmomatic` and `cutadapt` tools which removed the Illumina library adpater sequences and performed qualiy threshold filtration of the reads. Overall, `trimmomatic` and `cutadapt` removed 8.40% and 3.34% of the SRR6130428 total reads, and 18.53% and 3.06% of the SRR3481383 total reads. The filtered and trimmed dataset is represented in Figures \ref{fastqcsetA1}, \ref{fastqcsetA2} for the SRR6130428 dataset and \ref{fastqcsetB1} and \ref{fastqcsetB2} for the SRR3481383 dataset, representing 499,530,830 nucleotides at 41.09X coverage and 839,065,950 nucleotides at 69.02X coverage, respectively. 

After continging, mapping and scaffolding the reads, `SOAPdenovo` assessed the SRR3481383 assembly and reported an average contig length of 3732 nucleotides, and an N50 of 14294 base pairs. Considering the estimated genome size (12,157,105 bp) of \scer\ and its relative low level of complexity, the N50 statistic is reflecting that a substancial portion of the genome is represented in long contigs (14,294) and, thus, suggesting a contiguous assembly.

Chromosome 1's assembly sequence matched to 92.80% of that of the reference sequence, and the mitochondrion assembled genome matched to that of 77.78% of the reference sequence of \scer\. These results are reflected on the `mummerplot` output plots of Figure\ref{fig:mummer}, where the query and reference sequences are plotted based on similarity and identity at each nucleotide position. The alignment plots for chrI and chrM are indicative of a high degree of similarity between the assembled sequences and the reference genome of \scer\, with low number of tandem repeats, duplications or translocation events. Similarly, the coverage plots produced by `mummerplot` suggest that, for both chromosomal sequences, the query sequences were very similar to the references. As no deviation points from a diagonal line were observed, the assembly data has equivalent coverage of each nucleotide as that of the reference sequence. However, the chrM assembly stood out for its high coverage of aligned reads to the reference and alignment as it presented with the most proportional diagonal plot output for either measure. Ultimately, both chromosomal assemblies are seemingly complete and accurate in comparison with the reference.

To fully assess the completeness of the assemblies, the `BUSCO` tool was applied to both assembly datasets using the \scer\-specific parameters. This assay confirmed the hypothesis that the SRR3481383 dataset is a fairly complete and single dataset representative of the \scer\ genome. 

However, the SRR3481383 is only one of the datasets avalable on the \Sra\ depositorie. Using a larger dataset could potentially increase the sequence depth and contig length therefore producing a higher coverage, more contiguous genomic assembly better representative of the genome, inherently containing lower errors. 

\clearpage

# Appendices
\label{sec:appendices}


## Supplementary files
\label{sec:supplfiles}


### `conda` environment dependencies for the exercise

\loadfile{environment.yml}{environment.yml}{prg:environmentYML}


### Project specific scripts

```{=latex}
\loadfile{assemblathon\_stats.pl}{bin/assemblathon_stats.pl}{prg:assemblathonstatsPERL}
```


### Shell global vars and settings for this project

\loadfile{projectvars.sh}{projectvars.sh}{prg:projectvarsBASH}


## About this document

This document was be compiled into a PDF using `pandoc` (see
`projectvars.sh` from previous subsection) and some `LaTeX` packages
installed in this linux system. 
