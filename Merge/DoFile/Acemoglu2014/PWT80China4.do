clear all 
set more off

set trace off
cd D:\GitHub\Leadership\Merge\WorkingData



*1. Projection
forvalue i =3(1)5{
	use pwt80.dta, clear
	drop if year < 1979 | year >2011

	gen rgdp = rgdpe
	gen pcgdp = rgdp/pop
	keep PWTCode country year pcgdp

	bysort country (year): gen GrowthRate = (pcgdp[_N]/pcgdp[1])^(1/32)-1
	keep if year == 2011
	keep if GrowthRate !=.
	replace GrowthRate = `i'/100 if PWTCode =="CHN"

	expand 31
	bysort country: replace year = year[1]+_n-1
	bysort country (year): replace pcgdp = pcgdp[_n-1] * (1+GrowthRate) if _n>1

	gen CHN = 0
	replace CHN = 1 if PWTCode=="CHN"
	
	bysort year (CHN): gen gpppcC = pcgdp[_N]
	bysort year (CHN): gen pcgdpC = pcgdp[_n]/pcgdp[_N]

	gen surpassed = 0 
	gen surpassed2011 = 0
	bysort PWTCode (year): replace surpassed = 1 if (pcgdpC[_n-1] > 1 & pcgdpC[_n]<1)
	bysort PWTCode (year): replace surpassed2011 = 1 if (pcgdpC[1] > 1 & pcgdpC[_N]<1)

	count if surpassed ==1 & year>2011
	keep if surpassed
	drop if year==2011
	sort year
	export excel country year gdppcC using "..\Output\Country surpassed by China 2041(each year, Gc=`i').xls", firstrow(varlabels) replace
}


*2. Replication
use Leadership_8.dta, clear
gen year2 = year^2
gen year3 = year^3
local control year2 year3

rename democracy democracyR
recode polity2 (-99/0 = 0)(1/99 = 1), gen(democracyP)


gen gdp = rgdpn //or rgdpn 
gen gdppc = gdp/pop
xtset PIPECode year

gen lgdppcP = log(gdppc)
gen lgdppcW = log(ny_)
keep if year >=1950 & year<=2011

*2.2. 
gen lgdppc =.
gen democracy =.
replace lgdppc = lgdppcW 
replace democracy = democracyP
xtreg lgdppc democracy L.lgdppc `control', fe
est store model22
*2.2. 
replace lgdppc = lgdppcW 
replace democracy = democracyR
xtreg lgdppc democracy L.lgdppc `control', fe
est store model23
*2.2. 
replace lgdppc = lgdppcP
replace democracy = democracyP
xtreg lgdppc democracy L.lgdppc `control', fe
est store model24
*2.2. 
replace lgdppc = lgdppcP 
replace democracy = democracyR
xtreg lgdppc democracy L.lgdppc `control', fe
est store model25


#delimit ;
esttab model2* using ..\TeX\Replication.tex, drop(year* _cons) replace
title("Replication"\label{tab:Replication})
mtitle("WDI-POLITY" "WDI-REVISTIED" "PWT-POLITY" "WDI-REVISTIED")
b(%6.4f) se(%6.4f) star(* 0.1 ** 0.05 *** 0.01) ar2 
coeflabels(mpg2 "mpg$?2$" _cons Constant);
#delimit cr

*3. Heterogeneity
sort PIPECode year

replace lgdppc = lgdppcP
replace democracy = democracyP
*3.1
xtreg lgdppc democracy L.lgdppc `control', fe
est store model31
*3.2
xtreg lgdppc democracy L.lgdppc `control' if year<1980, fe
est store model32
*3.3
xtreg lgdppc democracy L.lgdppc `control' if year>1980, fe
est store model33
*3.4
xtreg lgdppc democracy L.lgdppc `control' if L1.gdppc<4000, fe
est store model34
*3.5
xtreg lgdppc democracy L.lgdppc `control' if L1.gdppc>=4000 & L1.gdppc<=8000, fe
est store model35
*3.6
xtreg lgdppc democracy L.lgdppc `control' if L1.gdppc>8000, fe
est store model36

#delimit ;
esttab model3* using ..\TeX\Heterogeneity.tex, drop(year*) replace
title("Heterogeneity"\label{tab:Heterogeneity})
mtitle("Benchmark" "50-79" "80-11" "Poor" "Median" "Rich")
b(%6.4f) se(%6.4f) star(* 0.1 ** 0.05 *** 0.01) ar2 
coeflabels(mpg2 "mpg$?2$" _cons Constant);
#delimit cr

*4. Testing for channels
use Leadership_8.dta, clear
gen year2 = year^2
gen year3 = year^3
recode polity2 (-99/0 = 0) (1/99 = 1), gen(democracyP)
gen gdp = rgdpe
gen gdppc = gdp/pop
recode gdppc (0/12000 = 1) (12000/99999999999 = 2), gen(rich)
xtset PIPECode year

gen csh_nx = csh_x - csh_m
gen k = rkna/pop
gen gk =(k - L.k)/k
gen l = emp*avh/pop
gen gl =(l - L.l)/l
gen ghc = (hc - L.hc)/hc
gen gTFP = (rtfpna - L.rtfpna)/rtfpna
gen lgdppc = (gdppc - L.gdppc)/gdppc

gen logk = log(k)
gen logl = log(l)
gen loghc = log(hc)
gen logTFP = log(rtfpna)
keep if year >=1950 & year<=2011

local Y logk logl loghc logTFP
local control year2 year3
local j = 1

foreach var in `Y'{
	xtreg `var' democracy L.`var' `control' , fe
	est store model4`j'0
	forvalue i =1(1)2{
		xtreg `var' democracy L.`var' `control' if rich ==`i', fe
		if !_rc{
			est store model4`j'`i'
		}
	}
	#delimit ;
	esttab model4`j'* using ..\TeX\Table4`j'.tex, drop(year*) replace
	title("Testing for `var'"\label{tab:testing`var'})
	mtitle("Benchmark" "Poor" "Rich")
	b(%6.4f) se(%6.4f) star(* 0.1 ** 0.05 *** 0.01) ar2 
	coeflabels(mpg2 "mpg$?2$" _cons Constant);
	#delimit cr

	local j = `j' + 1
}


*5.
use Leadership_8.dta, clear
gen year2 = year^2
gen year3 = year^3
recode polity2 (-99/0 = 0) (1/99 = 1), gen(democracyP)
gen gdp = rgdpe
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
gen GrowthRate = (gdppc - L.gdppc)/gdppc

*5.1
local control year2 year3
xtreg GrowthRate gk gl hc democracy `control', fe
est store model51
*5.2
xtabond2 GrowthRate gk gl hc democracy , gmm(democracy) iv(L.democracy L.GrowthRate gl gk hc) noleveleq small
est store model52
*5.3
xtabond2 GrowthRate gk gl hc democracy if rich == 1, gmm(democracy) iv(L.democracy L.GrowthRate gl gk hc) noleveleq small
est store model53
*5.4
xtabond2 GrowthRate gk gl hc democracy if rich == 2, gmm(democracy) iv(L.democracy L.GrowthRate gl gk hc) noleveleq small
est store model54
*5.5
xtabond2 GrowthRate gk gl hc democracy if rich == 3, gmm(democracy) iv(L.democracy L.GrowthRate gl gk hc) noleveleq small
est store model55

#delimit ;
esttab model5* using ..\TeX\Table5.tex, drop(year*) replace
title("GMM"\label{tab:GMM})
mtitle("Benchmark" "GMM" "Poor" "Median" "Rich")
b(%6.4f) se(%6.4f) star(* 0.1 ** 0.05 *** 0.01) ar2 
coeflabels(mpg2 "mpg$?2$" _cons Constant);
#delimit cr

*6.Shares
use Leadership_8.dta, clear
gen gdp = rgdpe
gen gdppc = gdp/pop
gen csh_nx = csh_x - csh_m
xtset PIPECode year
sort PIPECode year
gen k = rkna/pop
gen gk =(k - L.k)/k
gen l = emp*avh/pop
gen gl =(l - L.l)/l
gen ghc = (hc - L.hc)/hc
gen gTFP = (rtfpna - L.rtfpna)/rtfpna
gen GrowthRate = (gdppc - L.gdppc)/gdppc

drop if gdppc > 50000

local vars csh_c csh_i csh_g csh_nx labsh 	
foreach var in `vars'{
	gen `var'd = `var' if democracy
	gen `var'nd = `var' if !democracy
	#delimit ;
	twoway (qfitci `var'd gdppc, cip(rline))(qfitci `var'nd gdppc, cip(rline)),
	title(`var')
	legend(label (2 "Democractic") label (3 "Non-Democratic"));
	#delimit cr
	graph export ..\Graph\GDPPC_`var'.png, replace
}

*7.gk gl gTFP
local vars gl gk gTFP
foreach var in `vars'{
	gen `var'd = `var' if democracy
	gen `var'nd = `var' if !democracy
	#delimit ;
	twoway (qfitci `var'd gdppc, cip(rline))(qfitci `var'nd gdppc, cip(rline)),
	title(`var')
	legend(label (2 "Democractic") label (3 "Non-Democratic"));
	#delimit cr
	graph export ..\Graph\GDPPC_`var'.png, replace
}

*8 gl gk TFP
use Leadership_8.dta, clear
gen gdp = rgdpe
gen gdppc = gdp/pop
gen csh_nx = csh_x - csh_m
xtset PIPECode year
sort PIPECode year
gen k = rkna/pop
gen gk =(k - L.k)/k
gen l = emp*avh/pop
gen gl =(l - L.l)/l
gen ghc = (hc - L.hc)/hc
gen gTFP = (rtfpna - L.rtfpna)/rtfpna
gen GrowthRate = (gdppc - L.gdppc)/gdppc


recode gdppc (0/3000 = 1) (3000/6000 = 2) (6000/10000 = 3) (10000/15000 = 4) (15000/20000 = 5) (20000/30000 = 6)(30000/40000 = 7) (nonm = .), gen(gdppcG)
label define gdppcG 1 "0-3000" 2 "3000-6000" 3 "6000-10000" 4 "10000-15000" 5 "15000-20000" 6 "20000-30000" 7 "30000-40000"
label value gdppcG gdppcG
collapse (mean)meangl = gl meangk = gk meanTFP = rtfpna (sem)sdgl = gl sdgk = gk sdTFP = rtfpna, by(democracy gdppcG)
keep if gdppcG!=. & democracy!=.
export excel using "D:\GitHub\Leadership\Merge\Output\gl,gk,TFP by demo and gdppc.xls", sheetreplace firstrow(varlabels)
