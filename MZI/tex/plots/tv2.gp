#!/usr/bin/env gnuplot
# Version >= 5.2

set term epslatex color size 6in, 4in
set output "tv2-plot.tex"
# set term epscairo color size 6in, 4in
# set output "tv2-plot.eps"
set decimalsign locale 'de_DE.UTF-8'

set title "Druck gegen die Anzahl der Durchgängen"
set ylabel "Anzahl der Durchgängen $\\Delta m$ (Einheitslos)"
set xlabel "Druck $P$ ($\\si{\\hecto\\pascal}$)"

set mxtics
set mytics
set samples 10000

f(x) = g*x + c

array A_m[4]
array A_m_err[4]
array A_c[4]
array A_c_err[4]
array chisq[4]
array titel[4]

# https://stackoverflow.com/a/17884635
do for [t=2:4] {
	g = 0.130; c = 60; # Reset params
	fit f(x) "tv2.dat" u t:1 via g,c
	A_m[t] = g
	A_m_err[t] = g_err
	A_c[t] = c
	A_c_err[t] = c_err
	chisq[t] = FIT_STDFIT**2
	titel[t] = "$".gprintf("%.5f", g)."P + (".gprintf("%.5f", c).")$"
}
# Linien
set key bottom right vertical maxrows 10 width -8

plot for [i=2:4] "tv2.dat" u i:1 title "Messung ".(i-1) pointtype 77 lc (i-1) ps 2, for [i=2:4] A_m[i]*x+A_c[i] title titel[i] lc (i-1) lw 2

# LaTeX table output
print "\\toprule"
print "Messung & $g/\\si{\\per\\hecto\\pascal}$ & $c$ & $\\chi^2_\\text{red}$ \\\\"
print "\\midrule"
do for [t=2:4] {
	print "\t$".(t-1)."$ & \\num{".gprintf("%.5f", A_m[t])."(".gprintf("%.0f", A_m_err[t]*10**5).")} & \\num{".gprintf("%.5f", A_c[t])."(".gprintf("%.0f", A_c_err[t]*10**5).")}"." & \\num{".gprintf("%.5f", chisq[t])."} \\\\"
}
print "\\bottomrule"

# Raw data output in table form
print "# Nr\tg/hPa-1 \tg_err/hPa-1"
do for [t=2:4] {
	print "".(t-1)."\t".sprintf("%.10f", A_m[t])."\t".sprintf("%.10f", A_m_err[t])
}