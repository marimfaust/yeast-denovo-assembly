set terminal postscript color solid "Courier" 8
set output "/home/mariana/uni/exercise_02/blast/chrI-x-SRR6130428/chrI-x-SRR6130428_megablast.dnadiff.covg.ps.ps"
set size 3,1.5
set grid
unset key
set border 15
set tics scale 0
set xlabel "Scer_chrI"
set ylabel "%SIM"
set format "%.0f"
set xrange [1:230218]
set yrange [1:110]
set style line 1  lt 1 lw 4
set style line 2  lt 3 lw 4
set style line 3  lt 2 lw 4 pt 6 ps 0.5
plot \
 "/home/mariana/uni/exercise_02/blast/chrI-x-SRR6130428/chrI-x-SRR6130428_megablast.dnadiff.covg.ps.fplot" title "FWD" w l ls 1, \
 "/home/mariana/uni/exercise_02/blast/chrI-x-SRR6130428/chrI-x-SRR6130428_megablast.dnadiff.covg.ps.rplot" title "REV" w l ls 2
