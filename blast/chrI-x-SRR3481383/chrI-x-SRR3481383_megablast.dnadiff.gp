set terminal postscript color solid "Courier" 8
set output "/home/mariana/uni/exercise_02/blast/chrI-x-SRR3481383/chrI-x-SRR3481383_megablast.dnadiff.ps"
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
 "15" 10988, \
 "83" 11055, \
 "113" 11173, \
 "831" 11325, \
 "405" 11588, \
 "135" 11789, \
 "55" 11965, \
 "473" 12062, \
 "917" 12268, \
 "609" 12703, \
 "361" 12919, \
 "835" 13117, \
 "67" 13381, \
 "57" 13489, \
 "353" 13586, \
 "849" 13784, \
 "809" 14054, \
 "359" 14307, \
 "117" 14505, \
 "875" 14658, \
 "957" 14941, \
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
 "/home/mariana/uni/exercise_02/blast/chrI-x-SRR3481383/chrI-x-SRR3481383_megablast.dnadiff.fplot" title "FWD" w lp ls 1, \
 "/home/mariana/uni/exercise_02/blast/chrI-x-SRR3481383/chrI-x-SRR3481383_megablast.dnadiff.rplot" title "REV" w lp ls 2
