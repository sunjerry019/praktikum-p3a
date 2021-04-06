#!/usr/bin/env gnuplot

set term epslatex color size 6in, 4in
set output "leistung.tex"
# set term epscairo color size 6in, 4in
# set output "leistung.eps"
set decimalsign locale 'de_DE.UTF-8'

set title "Intensitätsprofil eines Laserstrahls"
set ylabel "Transmittierte Leistung $P$"
set xlabel "Radius $r$"

set mxtics
set mytics
set samples 10000

# Linien
# set key top right spacing 1.3

set xrange [0:4]

plot (1 - exp(-x**2)) title "Profil" lc rgb 'dark-magenta'

