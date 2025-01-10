set terminal postscript color solid "Courier" 8
set output "/home/mariana/uni/exercise_02/blast/chrM-x-SRR6130428/chrM-x-SRR6130428_megablast.dnadiff.ps"
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
 "5642" 86917, \
 "727" 87114, \
 "6622" 87178, \
 "3041" 87560, \
 "1401" 87648, \
 "187" 87715, \
 "2567" 87778, \
 "1879" 87857, \
 "3561" 87928, \
 "2265" 88031, \
 "2715" 88106, \
 "9638" 88187, \
 "2375" 118725, \
 "6644" 118801, \
 "6370" 119193, \
 "2347" 119500, \
 "2549" 119576, \
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
 "/home/mariana/uni/exercise_02/blast/chrM-x-SRR6130428/chrM-x-SRR6130428_megablast.dnadiff.fplot" title "FWD" w lp ls 1, \
 "/home/mariana/uni/exercise_02/blast/chrM-x-SRR6130428/chrM-x-SRR6130428_megablast.dnadiff.rplot" title "REV" w lp ls 2
