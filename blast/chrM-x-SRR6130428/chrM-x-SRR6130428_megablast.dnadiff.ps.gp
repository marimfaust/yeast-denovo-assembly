set terminal postscript color solid "Courier" 8
set output "/home/mariana/uni/exercise_02/blast/chrM-x-SRR6130428/chrM-x-SRR6130428_megablast.dnadiff.ps.ps"
set ytics ( \
 "7978" 1, \
 "*6336" 3453, \
 "8560" 3755, \
 "*6600" 10232, \
 "6876" 10602, \
 "*7352" 11118, \
 "9364" 12396, \
 "*7694" 29858, \
 "*7100" 32142, \
 "6988" 32953, \
 "*7708" 33616, \
 "8344" 35921, \
 "*5942" 41028, \
 "*8048" 41257, \
 "6234" 44943, \
 "*7306" 45222, \
 "8164" 46379, \
 "*6636" 50573, \
 "*8510" 50959, \
 "8496" 57088, \
 "8524" 63160, \
 "*6806" 69403, \
 "*8842" 69872, \
 "7590" 78856, \
 "6752" 80778, \
 "*7564" 81222, \
 "7730" 83074, \
 "7414" 85475, \
 "9638" 86917, \
 "1879" 117455, \
 "3041" 117526, \
 "2549" 117614, \
 "6644" 117693, \
 "2375" 118085, \
 "727" 118161, \
 "2265" 118225, \
 "2715" 118300, \
 "187" 118381, \
 "3561" 118444, \
 "2567" 118547, \
 "6622" 118626, \
 "1401" 119008, \
 "2347" 119075, \
 "6370" 119151, \
 "5642" 119458, \
 "" 119699 \
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
set yrange [1:119699]
set style line 1  lt 1 lw 2 pt 6 ps 0.5
set style line 2  lt 3 lw 2 pt 6 ps 0.5
set style line 3  lt 2 lw 2 pt 6 ps 0.5
plot \
 "/home/mariana/uni/exercise_02/blast/chrM-x-SRR6130428/chrM-x-SRR6130428_megablast.dnadiff.ps.fplot" title "FWD" w lp ls 1, \
 "/home/mariana/uni/exercise_02/blast/chrM-x-SRR6130428/chrM-x-SRR6130428_megablast.dnadiff.ps.rplot" title "REV" w lp ls 2
