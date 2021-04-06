#!/usr/bin/env gnuplot

set term epslatex color size 6in, 4in
set output "tv1-senkrecht.tex"
# set term epscairo color size 6in, 4in
# set output "tv1-senkrecht.eps"
set decimalsign locale 'de_DE.UTF-8'

set title "Reflektionskoeffizient gegen Einfallswinkel"
set ylabel "Reflektionskoeffizient $\\zeta^\\bot$ (Einheitslos)"
set xlabel "Einfallswinkel $\\alpha$ ($\\si{\\degree}$)"

set mxtics
set mytics
set samples 10000

f(x) = ((sqrt(n**2 - (sin(pi*x/180))**2) - cos(pi*x/180))**2)/(n**2 - 1)

n = 1.55
# (x, y, xdelta, ydelta)
fit f(x) "senkrecht.dat" u 1:2:(2.5):3 xyerrors via n

# Linien
set key bottom right spacing 2

titel = "$\\frac{\\left(\\sqrt{(".gprintf("%.5f", n).")^2 - \\sin^2\\alpha} - \\cos\\alpha\\right)^2}{(".gprintf("%.5f", n).")^2 - 1}$"
plot f(x) title titel lc rgb 'dark-magenta', \
	"senkrecht.dat" u 1:2:(2.5):3 with xyerrorbars title "Messpunkte" pointtype 0 lc rgb 'dark-goldenrod'