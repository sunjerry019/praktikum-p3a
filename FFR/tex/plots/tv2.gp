#!/usr/bin/env gnuplot

set term epslatex color size 6in, 4in
set output "tv2-plot.tex"
# set term epscairo color size 6in, 4in
# set output "tv2-plot.eps"
set decimalsign locale 'de_DE.UTF-8'

set title "Drehwinkel der Polarisationsebene gegen Einfallswinkel"
set ylabel "Drehwinkel $\\Psi$ ($\\si{\\degree}$)"
set xlabel "Einfallswinkel $\\alpha$ ($\\si{\\degree}$)"

set mxtics
set mytics
set samples 10000

f(x) = (180/pi)*atan(-(cos(x*pi/180)*sqrt(n*n - sin(x*pi/180)*sin(x*pi/180)))/(sin(x*pi/180)*sin(x*pi/180)))

n = 1.55
# (x, y, xdelta, ydelta)
fit f(x) "tv2.dat" u 1:2:(2.5):(0.8) xyerrors via n

# Linien
set key bottom right spacing 2

titel = "$\\arctan \\left(- \\frac{\\cos\\alpha \\sqrt{(".gprintf("%.5f", n).")^2-\\sin^2\\alpha}}{\\sin^2\\alpha} \\right)$"
plot f(x) title titel lc rgb 'dark-magenta', \
	"tv2.dat" u 1:2:(2.5):(0.8) with xyerrorbars title "Messpunkte" pointtype 0 lc rgb 'dark-goldenrod'
