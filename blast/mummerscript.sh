#!/bin/bash

SQSET=SRR6130428
WDR="/home/mariana/uni/exercise_02"

for SQ in chrI chrM; do
    #
    printf "# Running DNADIFF protocol: $SQSET x $SQ ...\n" >&2
    #
    dnadiff -p $WDR/blast/${SQ}-x-${SQSET}/${SQ}-x-${SQSET}_megablast.dnadiff \
            $WDR/seqs/chrs/${SQ}.fa \
            $WDR/blast/${SQ}-x-${SQSET}/${SQ}-x-${SQSET}_megablast.fa \
         2> $WDR/blast/${SQ}-x-${SQSET}/${SQ}-x-${SQSET}_megablast.dnadiff.log
    printf " DNAdiff...\n" >&2
    #
    mummerplot --breaklen --large --layout --fat --coverage --postscript \
               -t "Alignment Plot: ${SQ}-x-${SQSET}" \
               -p $WDR/blast/${SQ}-x-${SQSET}/${SQ}-x-${SQSET}_megablast.dnadiff \
                  $WDR/blast/${SQ}-x-${SQSET}/${SQ}-x-${SQSET}_megablast.dnadiff.1delta \
               2> $WDR/blast/${SQ}-x-${SQSET}/${SQ}-x-${SQSET}_megablast.dnadiff.alnplot.log
    convert-im6 -verbose \
    -density 300 \
   	-background white \
         $WDR/blast/${SQ}-x-${SQSET}/${SQ}-x-${SQSET}_megablast.dnadiff.ps \
         $WDR/blast/${SQ}-x-${SQSET}/${SQ}-x-${SQSET}_megablast.dnadiff.png
               # add this to convert PostScript image to PNG
    printf " ALNplot...\n" >&2
    mummerplot --breaklen --large --layout --fat --coverage --postscript \
               -t "Coverage Plot: ${SQ}-x-${SQSET}" \
               -p $WDR/blast/${SQ}-x-${SQSET}/${SQ}-x-${SQSET}_megablast.dnadiff.covg \
                  $WDR/blast/${SQ}-x-${SQSET}/${SQ}-x-${SQSET}_megablast.dnadiff.1delta \
               2> $WDR/blast/${SQ}-x-${SQSET}/${SQ}-x-${SQSET}_megablast.dnadiff.cvgplot.log
    convert-im6 -verbose \
   	-density 300 \
   	-background white \
        $WDR/blast/${SQ}-x-${SQSET}/${SQ}-x-${SQSET}_megablast.dnadiff.covg.ps \
        $WDR/blast/${SQ}-x-${SQSET}/${SQ}-x-${SQSET}_megablast.dnadiff.covg.png
              # add this to convert PostScript image to PNG
    printf " CVGplot...\n" >&2
    #
    ( grep "TotalBases"   $WDR/blast/${SQ}-x-${SQSET}/${SQ}-x-${SQSET}_megablast.dnadiff.report;
      grep "AlignedBases" $WDR/blast/${SQ}-x-${SQSET}/${SQ}-x-${SQSET}_megablast.dnadiff.report;
      grep "AvgIdentity"  $WDR/blast/${SQ}-x-${SQSET}/${SQ}-x-${SQSET}_megablast.dnadiff.report
      ) > $WDR/blast/${SQ}-x-${SQSET}/${SQ}-x-${SQSET}_megablast.dnadiff.shortsummary
    printf " DONE\n" >&2
    #
done

