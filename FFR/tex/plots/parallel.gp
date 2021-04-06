#!/usr/bin/env gnuplot
# gnuplot > 5.4

set term epslatex color size 6in, 4in
set output "tv1-parallel.tex"
# set term epscairo color size 6in, 4in
# set output "tv1-parallel.eps"
set decimalsign locale 'de_DE.UTF-8'

set title "Reflektionskoeffizient$^2$ gegen Einfallswinkel"
set ylabel "Reflektionskoeffizient$^2$ $\\left(\\zeta^\\parallel\\right)^2$ (Einheitslos)"
set xlabel "Einfallswinkel $\\alpha$ ($\\si{\\degree}$)"

set mxtics
set mytics
set samples 10000

f(x) = ((n*n*cos(x*pi/180)-sqrt(n*n - sin(x*pi/180)*sin(x*pi/180))) / (n*n*cos(x*pi/180)+sqrt(n*n - sin(x*pi/180)*sin(x*pi/180))))**2

n = 1.55
# (x, y, xdelta, ydelta)
fit f(x) "parallel.dat" u 1:2:(2.5):3 xyerrors via n

# # get min
# array A[1000]
# do for [i=1:1000] { A[i] = f(54 + i*(6/1000))}
# stats A nooutput prefix "A"
# m = A_index_min*(6/1000) + 54
# set arrow from m,0 to m,0.35 nohead lc rgb 'red'
# set label "\\textcolor{red}{\\scriptsize Minimum $= \\num{".gprintf("%.1f", m)."}$}" at (m+1),27 font ',9'

# Linien
set key top right spacing 2

titel = "$\\left(\\frac{(".gprintf("%.5f", n).")^2\\cos(\\alpha) - \\sqrt{(".gprintf("%.5f", n).")^2-\\sin^2(\\alpha)}}{(".gprintf("%.5f", n).")^2\\cos(\\alpha) + \\sqrt{(".gprintf("%.5f", n).")^2-\\sin^2(\\alpha)}}\\right)^2$"
plot f(x) title titel lc rgb 'dark-magenta', \
	"parallel.dat" u 1:2:(2.5):3 with xyerrorbars title "Messpunkte" pointtype 0 lc rgb 'dark-goldenrod'

	# A_min notitle lc rgb 'red', \