## ######################################################################################
##
##   projectvars.sh
##
##   A BASH initialization file for MScGG-BIA practical exercise folders
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
# Base dir
export WDR=$PWD; 
export BIN=$WDR/bin;
export DOC=$WDR/docs;

#
# Formating chars
export TAB=$'\t';
export RET=$'\n';
export LC_ALL="en_US.UTF-8";


export PATH=$WDR/bin/sratoolkit.3.0.0-ubuntu64/bin:$PATH

export SPD=$WDR/soapdenovo/$SQSET

 export BUSCO_CONFIG_FILE=$WDR/bin/busco/config/"myconfig.ini"

#
# pandoc's vars
NM="FAUSTINO_MARIANA";                   
RB="README_MScGG-BIA2324_exercise02"; 
RD="${RB}_${NM}";
PDOCFLGS='markdown+pipe_tables+header_attributes';
PDOCFLGS=$PDOCFLGS'+raw_tex+latex_macros+tex_math_dollars';
PDOCFLGS=$PDOCFLGS'+citations+yaml_metadata_block';
PDOCTPL=$DOC/MScGG_BIA_template.tex;
export RD PDOCFLGS PDOCTPL;

function ltx2pdf () {
    RF=$1;
    pdflatex $RF.tex;
    bibtex $RF;
    pdflatex $RF.tex;
    pdflatex $RF.tex;
}

function runpandoc () {
  pandoc -f $PDOCFLGS               \
         --template=$PDOCTPL        \
         -t latex --natbib          \
         --number-sections          \
         --highlight-style pygments \
         -o $RD.tex $RD.md;
  ltx2pdf $RD;
}

#
# add your bash defs/aliases/functions below...
alias dir='/bin/ls -alFhrt --color=auto'

export REFDIR="S288C_reference_genome_R64-4-1_20230830"
export REFGEN="S288C_reference_sequence_R64-4-1_20230830"

export DT=$WDR/data;

export TMA=/usr/share/trimmomatic/

export PERL5LIB=$BIN;


