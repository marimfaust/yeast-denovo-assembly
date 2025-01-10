set terminal postscript color solid "Courier" 8
set output "/home/mariana/uni/exercise_02/blast/chrI-x-SRR3481383/chrI-x-SRR3481383_megablast.dnadiff.covg.ps"
set ytics ( \
 "*927" 1, \
 "*843" 473, \
 "*475" 742, \
 "*919" 948, \
 "119" 1385, \
 "*579" 1543, \
 "*321" 1757, \
 "*691" 1954, \
 "*799" 2180, \
 "*325" 2430, \
 "*657" 2627, \
 "*249" 2847, \
 "*933" 3040, \
 "279" 3542, \
 "129" 3737, \
 "965" 3907, \
 "*465" 4711, \
 "*761" 4916, \
 "351" 5158, \
 "*943" 5356, \
 "*133" 5903, \
 "981" 6079, \
 "59" 7440, \
 "*115" 7537, \
 "*975" 7689, \
 "*545" 8945, \
 "*563" 9156, \
 "557" 9369, \
 "*489" 9581, \
 "*611" 9788, \
 "897" 10004, \
 "181" 10318, \
 "*805" 10508, \
 "699" 10759, \
 "609" 10988, \
 "117" 11204, \
 "875" 11357, \
 "957" 11640, \
 "135" 12295, \
 "917" 12471, \
 "473" 12906, \
 "55" 13112, \
 "83" 13209, \
 "67" 13327, \
 "849" 13435, \
 "15" 13705, \
 "831" 13772, \
 "835" 14035, \
 "809" 14299, \
 "353" 14552, \
 "57" 14750, \
 "405" 14847, \
 "361" 15048, \
 "113" 15246, \
 "359" 15398, \
 "" 15650 \
)
set size 3,3
set grid
unset key
set border 10
set tics scale 0
set xlabel "Scer_chrI"
set ylabel "QRY"
set format "%.0f"
set xrange [1:230218]
set yrange [1:15650]
set style line 1  lt 1 lw 2 pt 6 ps 0.5
set style line 2  lt 3 lw 2 pt 6 ps 0.5
set style line 3  lt 2 lw 2 pt 6 ps 0.5
plot \
 "/home/mariana/uni/exercise_02/blast/chrI-x-SRR3481383/chrI-x-SRR3481383_megablast.dnadiff.covg.fplot" title "FWD" w lp ls 1, \
 "/home/mariana/uni/exercise_02/blast/chrI-x-SRR3481383/chrI-x-SRR3481383_megablast.dnadiff.covg.rplot" title "REV" w lp ls 2
