clear all 
set more off

set trace on
cd D:\GitHub\Leadership\Merge\WorkingData



*1. Replication
use Leadership_8.dta, clear
recode polity2 (-99/0 = 0)(1/99 = 1), gen(Democracy)
gen gdp = rgdpn	 //or rgdpn 
gen gdppc = gdp/pop
xtset PIPECode year
	
gen lgdppc = (gdppc - L.gdppc)/gdppc
gen ggdppc = log(gdppc)
keep if year >=1950 & year<=2011

*1.1. Fixed Effect
xtreg lgdppc Democracy L1.lgdppc i.year, fe
est store model11
xtreg lgdppc Democracy L(1/4).lgdppc i.year, fe
est store model12

*1.2. GMM
xtabond2 lgdppc Democracy L.lgdppc i.year, gmm(Democracy) iv(L.lgdppc) noleveleq small
est store model13
xtabond2 lgdppc Democracy L(1/4).lgdppc i.year, gmm(Democracy) iv(L(1/4).lgdppc) noleveleq small
est store model14


#delimit ;
esttab model1* using ..\TeX\Table1.tex, drop(*year) replace
title("Replication"\label{tab:regression1})
mtitle("FE" "FE" "GMM" "GMM")
b(%6.4f) se(%6.4f) star(* 0.1 ** 0.05 *** 0.01) ar2 
coeflabels(mpg2 "mpg$?2$" _cons Constant);
#delimit cr

*2. Heterogeneity
gen year1979 = 0
replace year1979 = 1 if year == 1979
bysort PIPECode (year1979): gen lgdppc1979 = lgdppc[_N]
recode gdppc (0/4000 = 1) (4000/12000 = 2) (12000/99999999999 = 3), gen(rich)

sort PIPECode year
gen gdppc1979d = c.lgdppc1979#Democracy 
gen gdppcld = c.L.lgdppc#Democracy
xtreg lgdppc Democracy gdppc1979d L.lgdppc i.year, fe
est store model21
xtreg lgdppc Democracy gdppcld L.lgdppc i.year, fe
est store model22

forvalue i =1(1)3{
capture xtreg lgdppc Democracy gdppc1979d L.lgdppc i.year if rich ==`i', fe
if !_rc{
est store model21`i'
}
capture{ xtreg lgdppc Democracy gdppcld L.lgdppc i.year if rich ==`i', fe
if !_rc{
est store model22`i'
}
}

#delimit ;
esttab model21* model22* using ..\TeX\Table2.tex, drop(*year) replace
title("Heterogeneity"\label{tab:regression2})
mtitle("Benchmark" "Poor" "Median" "Rich" "Benchmark" "Poor" "Median" "Rich")
b(%6.4f) se(%6.4f) star(* 0.1 ** 0.05 *** 0.01) ar2 
coeflabels(mpg2 "mpg$?2$" _cons Constant);
#delimit cr

*3. Testing for channels
use Leadership_8.dta, clear
recode polity2 (-99/0 = 0)(1/99 = 1), gen(Democracy)
gen gdp = ny_
gen gdppc = gdp/pop
recode gdppc (0/4000 = 1) (4000/12000 = 2) (12000/99999999999 = 3), gen(rich)
xtset PIPECode year

gen csh_nx = csh_x - csh_m
gen k = rkna/pop
gen gk =(k - L.k)/k
gen l = emp*avh/pop
gen gl =(l - L.l)/l
gen ghc = (hc - L.hc)/hc
gen gTFP = (rtfpna - L.rtfpna)/rtfpna
gen lgdppc = (gdppc - L.gdppc)/gdppc

keep if year >=1950 & year<=2011

local Y csh_c csh_i csh_g csh_nx gk gl ghc gTFP labsh
local j = 1

foreach var in `Y'{
	xtreg `var' Democracy L.`var' `control' i.year, fe
	est store model`j'0
	forvalue i =2(1)3{
		capture xtreg `var' Democracy L.`var' `control' i.year if rich ==`i', fe
		if !_rc{
			est store model`j'`i'
		}
	}
	#delimit ;
	esttab model`j'* using ..\TeX\Table3`j'.tex, drop(*year) replace
	title("Testing for `var'"\label{tab:regression`j'})
	mtitle("Benchmark" "Median" "Rich")
	b(%6.4f) se(%6.4f) star(* 0.1 ** 0.05 *** 0.01) ar2 
	coeflabels(mpg2 "mpg$?2$" _cons Constant);
	#delimit cr

	local j = `j' + 1
}
	
