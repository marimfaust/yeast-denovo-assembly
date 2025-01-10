set terminal postscript color solid "Courier" 8
set output "/home/mariana/uni/exercise_02/blast/chrM-x-SRR3481383/chrM-x-SRR3481383_megablast.dnadiff.ps"
set ytics ( \
 "453" 1, \
 "*911" 204, \
 "509" 564, \
 "*939" 772, \
 "855" 1312, \
 "*537" 1585, \
 "829" 1795, \
 "*633" 2057, \
 "*839" 2275, \
 "*881" 2541, \
 "823" 2830, \
 "" 3100 \
)
set size 3,3
set grid
unset key
set border 10
set tics scale 0
set xlabel "Scer_chrM"
set ylabel "QRY"
set format "%.0f"
set xrange [1:85779]
set yrange [1:3100]
set style line 1  lt 1 lw 2 pt 6 ps 0.5
set style line 2  lt 3 lw 2 pt 6 ps 0.5
set style line 3  lt 2 lw 2 pt 6 ps 0.5
plot \
 "/home/mariana/uni/exercise_02/blast/chrM-x-SRR3481383/chrM-x-SRR3481383_megablast.dnadiff.fplot" title "FWD" w lp ls 1, \
 "/home/mariana/uni/exercise_02/blast/chrM-x-SRR3481383/chrM-x-SRR3481383_megablast.dnadiff.rplot" title "REV" w lp ls 2
