#!/usr/bin/env gnuplot

set term epslatex color size 6in, 4in
set output "tv4-plot.tex"
# set term epscairo color size 6in, 4in
# set output "tv4.eps"
set decimalsign locale 'de_DE.UTF-8'

set title "Transmittierte Leistung gegen Strahldurchmesser"
set ylabel "Transmittierte Leistung $P$ ($\\si{\\milli\\watt}$)"
set xlabel "Durchmesser $d$ ($\\si{\\milli\\meter}$)"

set mxtics
set mytics
set samples 10000

f(x) = A*W*(1 - exp(-(x**2)/(2*W)))

# (x, y, xdelta, ydelta)
fit f(x) "tv4.dat" u 2:1:(0.1):(0.1) xyerrors via A,W

# set xrange [0:16]

# Linien
set key bottom right spacing 2

titel = "$".gprintf("%.5f", A)."\\cdot".gprintf("%.5f", W)."\\left(1 - \\exp{-\\frac{d^2}{2(".gprintf("%.5f", W).")}}\\right)$"
plot f(x) title titel lc rgb 'dark-magenta', \
	"tv4.dat" u 2:1:(0.1):(0.1) with xyerrorbars title "Messpunkte" pointtype 0 lc rgb 'dark-goldenrod'
