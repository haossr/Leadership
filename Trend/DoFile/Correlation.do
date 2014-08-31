cd ..\WorkingData\
************************************************************************
*************** Trend: Correlation
************************************************************************


*6.1
use correlation.dta, clear
keep if year == 2008

#delimit ;
	twoway
	(scatter GDP_pc eligibility)
	(lfit GDP_pc eligibility)
	(qfit GDP_pc eligibility),
	title("GDP per Capita/Eligibility, Year 2008") 
	ytitle("GDP per Capita")
	xtitle("Eligibility")
	legend(label (1 "Observation") label (2 "Linear fit") label (3 "Quadratic fit")) 
	;
#delimit cr
graph export ..\Graph\6_1.png, replace

*6.2
use correlation.dta, clear
keep if year == 1989
reg GDP_pc eligibility 
predict GDP_pc_hat 
#delimit ;
twoway
(scatter GDP_pc eligibility)
(lfit GDP_pc eligibility)
(qfit GDP_pc eligibility),
title("GDP per Capita/Eligibility, Year 2008") 
ytitle("GDP per Capita")
xtitle("Eligibility")
legend(label (1 "Observation") label (2 "Linear fit") label (3 "Quadratic fit")) 
;
#delimit cr
graph export ..\Graph\6_2.png, replace

*by democracy
use correlation.dta, clear
local xvar age edu_ceyear length_ce exp_ce_publicyear exp_ce_governoryear exp_ce_centralyear exp_ce_manageryear

collapse (mean)`xvar' (mean)gdp_d, by(PIPECode democracy a1991)

label variable age "Age"
label variable edu_ceyear "Years of Education"
label variable length_ce "Years at Office"
label variable exp_ce_publicyear "Years of Public Service"
label variable exp_ce_governoryear "Years as Governor"
label variable exp_ce_centralyear "Years in the Central Government"
label variable exp_ce_manageryear "Years as Manager"



foreach var of varlist `xvar'{
	local l`var':variable label `var'
	gen `var'_sq = `var'^2
	reg gdp_d `var' if a1991
	local r2l: display %5.4f e(r2)
	reg gdp_d `var' `var'_sq if a1991
	local r2q: display %5.4f e(r2)
	#delimit ;
	twoway
	(scatter gdp_d `var')
	(lfit gdp_d `var')
	(qfit gdp_d `var') if a1991,
	title("Growth rate of GDP/`l`var''") 
	subtitle("Overall, After 1991")
	ytitle("Growth rate of GDP")
	xtitle("`l`var''(on average)")
	legend(label (1 "Observation") label (2 "Linear fit") label (3 "Quadratic fit"))
	note("L-fit R-squared=`r2l'" "Q-fit R-squared=`r2q'")
	;
	#delimit cr
	graph export "..\Graph\6_[`var']_All_After1991.png", replace
	
	reg gdp_d `var' if !a1991
	local r2l: display %5.4f e(r2)
	reg gdp_d `var' `var'_sq if !a1991
	local r2q: display %5.4f e(r2)
	#delimit ;
	twoway
	(scatter gdp_d `var')
	(lfit gdp_d `var')
	(qfit gdp_d `var') if !a1991,
	title("Growth rate of GDP/`l`var''") 
	subtitle("Overall, Before 1991")
	ytitle("Growth rate of GDP")
	xtitle("`l`var''(on average)")
	legend(label (1 "Observation") label (2 "Linear fit") label (3 "Quadratic fit"))
	note("L-fit R-squared=`r2l'" "Q-fit R-squared=`r2q'")
	;
	#delimit cr
	graph export "..\Graph\6_[`var']_All_Before1991.png", replace
	
	
	reg gdp_d `var' if a1991 & democracy
	local r2l: display %5.4f e(r2)
	reg gdp_d `var' `var'_sq if a1991 & democracy
	local r2q: display %5.4f e(r2)
	#delimit ;
	twoway
	(scatter gdp_d `var')
	(lfit gdp_d `var')
	(qfit gdp_d `var') if a1991 & democracy,
	title("Growth rate of GDP/`l`var''") 
	subtitle("Democratic Countries, After 1991")
	ytitle("Growth rate of GDP")
	xtitle("`l`var''(on average)")
	legend(label (1 "Observation") label (2 "Linear fit") label (3 "Quadratic fit"))
	note("L-fit R-squared=`r2l'" "Q-fit R-squared=`r2q'")
	;
	#delimit cr
	graph export "..\Graph\6_[`var']_Democratic_After1991.png", replace
	
	reg gdp_d `var' if !a1991 & democracy
	local r2l: display %5.4f e(r2)
	reg gdp_d `var' `var'_sq if !a1991 & democracy
	local r2q: display %5.4f e(r2)
	#delimit ;
	twoway
	(scatter gdp_d `var')
	(lfit gdp_d `var')
	(qfit gdp_d `var') if !a1991 & democracy,
	title("Growth rate of GDP/`l`var''") 
	subtitle("Democratic Countries, Before 1991")
	ytitle("Growth rate of GDP")
	xtitle("`l`var''(on average)")
	legend(label (1 "Observation") label (2 "Linear fit") label (3 "Quadratic fit"))
	note("L-fit R-squared=`r2l'" "Q-fit R-squared=`r2q'")
	;
	#delimit cr
	graph export "..\Graph\6_[`var']_Democratic_Before1991.png", replace
	
	reg gdp_d `var' if a1991 & !democracy
	local r2l: display %5.4f e(r2)
	reg gdp_d `var' `var'_sq if a1991 & !democracy
	local r2q: display %5.4f e(r2)
	#delimit ;
	twoway
	(scatter gdp_d `var')
	(lfit gdp_d `var')
	(qfit gdp_d `var') if a1991 & !democracy,
	title("Growth rate of GDP/`l`var''") 
	subtitle("Non-democratic Countries, After 1991")
	ytitle("Growth rate of GDP")
	xtitle("`l`var''(on average)")
	legend(label (1 "Observation") label (2 "Linear fit") label (3 "Quadratic fit"))
	note("L-fit R-squared=`r2l'" "Q-fit R-squared=`r2q'")
	;
	#delimit cr
	graph export "..\Graph\6_[`var']_NonDemocratic_After1991.png", replace
	
	reg gdp_d `var' if !a1991 & !democracy
	local r2l: display %5.4f e(r2)
	reg gdp_d `var' `var'_sq if !a1991 & !democracy
	local r2q: display %5.4f e(r2)
	#delimit ;
	twoway
	(scatter gdp_d `var')
	(lfit gdp_d `var')
	(qfit gdp_d `var') if !a1991 & !democracy,
	title("Growth rate of GDP/`l`var''") 
	subtitle("Non-democratic Countries, Before 1991")
	ytitle("Growth rate of GDP")
	xtitle("`l`var''(on average)")
	legend(label (1 "Observation") label (2 "Linear fit") label (3 "Quadratic fit"))
	note("L-fit R-squared=`r2l'" "Q-fit R-squared=`r2q'")
	;
	#delimit cr
	graph export "..\Graph\6_[`var']_NonDemocratic_Before1991.png", replace
}

*by OECD
use correlation.dta, clear
collapse (mean)edu_ceyear (mean)gdp_d, by(PIPECode OECD a1991)
label variable edu_ceyear "Years of Education"
local xvar edu_ceyear

foreach var of varlist `xvar'{
	local l`var':variable label `var'
	gen `var'_sq = `var'^2
	reg gdp_d `var' if a1991
	local r2l: display %5.4f e(r2)
	reg gdp_d `var' `var'_sq if a1991
	local r2q: display %5.4f e(r2)
	#delimit ;
	twoway
	(scatter gdp_d `var')
	(lfit gdp_d `var')
	(qfit gdp_d `var') if a1991,
	title("Growth rate of GDP/`l`var''") 
	subtitle("Overall, After 1991")
	ytitle("Growth rate of GDP")
	xtitle("`l`var''(on average)")
	legend(label (1 "Observation") label (2 "Linear fit") label (3 "Quadratic fit"))
	note("L-fit R-squared=`r2l'" "Q-fit R-squared=`r2q'")
	;
	#delimit cr
	graph export "..\Graph\6_[`var']_All_After1991.png", replace
	
	reg gdp_d `var' if !a1991
	local r2l: display %5.4f e(r2)
	reg gdp_d `var' `var'_sq if !a1991
	local r2q: display %5.4f e(r2)
	#delimit ;
	twoway
	(scatter gdp_d `var')
	(lfit gdp_d `var')
	(qfit gdp_d `var') if !a1991,
	title("Growth rate of GDP/`l`var''") 
	subtitle("Overall, Before 1991")
	ytitle("Growth rate of GDP")
	xtitle("`l`var''(on average)")
	legend(label (1 "Observation") label (2 "Linear fit") label (3 "Quadratic fit"))
	note("L-fit R-squared=`r2l'" "Q-fit R-squared=`r2q'")
	;
	#delimit cr
	graph export "..\Graph\6_[`var']_All_Before1991.png", replace
	
	
	reg gdp_d `var' if a1991 & OECD
	local r2l: display %5.4f e(r2)
	reg gdp_d `var' `var'_sq if a1991 & OECD
	local r2q: display %5.4f e(r2)
	#delimit ;
	twoway
	(scatter gdp_d `var')
	(lfit gdp_d `var')
	(qfit gdp_d `var') if a1991 & OECD,
	title("Growth rate of GDP/`l`var''") 
	subtitle("OECD Countries, After 1991")
	ytitle("Growth rate of GDP")
	xtitle("`l`var''(on average)")
	legend(label (1 "Observation") label (2 "Linear fit") label (3 "Quadratic fit"))
	note("L-fit R-squared=`r2l'" "Q-fit R-squared=`r2q'")
	;
	#delimit cr
	graph export "..\Graph\6_[`var']_OECD_After1991.png", replace
	
	reg gdp_d `var' if !a1991 & OECD
	local r2l: display %5.4f e(r2)
	reg gdp_d `var' `var'_sq if !a1991 & OECD
	local r2q: display %5.4f e(r2)
	#delimit ;
	twoway
	(scatter gdp_d `var')
	(lfit gdp_d `var')
	(qfit gdp_d `var') if !a1991 & OECD,
	title("Growth rate of GDP/`l`var''") 
	subtitle("OECD Countries, Before 1991")
	ytitle("Growth rate of GDP")
	xtitle("`l`var''(on average)")
	legend(label (1 "Observation") label (2 "Linear fit") label (3 "Quadratic fit"))
	note("L-fit R-squared=`r2l'" "Q-fit R-squared=`r2q'")
	;
	#delimit cr
	graph export "..\Graph\6_[`var']_OECD_Before1991.png", replace
	
	reg gdp_d `var' if a1991 & !OECD
	local r2l: display %5.4f e(r2)
	reg gdp_d `var' `var'_sq if a1991 & !OECD
	local r2q: display %5.4f e(r2)
	#delimit ;
	twoway
	(scatter gdp_d `var')
	(lfit gdp_d `var')
	(qfit gdp_d `var') if a1991 & !OECD,
	title("Growth rate of GDP/`l`var''") 
	subtitle("Non-OECD Countries, After 1991")
	ytitle("Growth rate of GDP")
	xtitle("`l`var''(on average)")
	legend(label (1 "Observation") label (2 "Linear fit") label (3 "Quadratic fit"))
	note("L-fit R-squared=`r2l'" "Q-fit R-squared=`r2q'")
	;
	#delimit cr
	graph export "..\Graph\6_[`var']_NonOECD_After1991.png", replace
	
	reg gdp_d `var' if !a1991 & !OECD
	local r2l: display %5.4f e(r2)
	reg gdp_d `var' `var'_sq if !a1991 & !OECD
	local r2q: display %5.4f e(r2)
	#delimit ;
	twoway
	(scatter gdp_d `var')
	(lfit gdp_d `var')
	(qfit gdp_d `var') if !a1991 & !OECD,
	title("Growth rate of GDP/`l`var''") 
	subtitle("Non-OECD Countries, Before 1991")
	ytitle("Growth rate of GDP")
	xtitle("`l`var''(on average)")
	legend(label (1 "Observation") label (2 "Linear fit") label (3 "Quadratic fit"))
	note("L-fit R-squared=`r2l'" "Q-fit R-squared=`r2q'")
	;
	#delimit cr
	graph export "..\Graph\6_[`var']_NonOECD_Before1991.png", replace
}

/*
*6.3
use correlation.dta, clear
keep if year>1991
drop if PIPECode==.
tsset PIPECode year, yearly
gen gdp_d = D.GDP/L.GDP
*gen gdp_d2 = ln(GDP/L.GDP)
collapse (mean)edu_ceyear (mean)gdp_d, by(PIPECode)
*reg gdp_d edu_ceyear
*predict gdp_d_hat
#delimit ;
	twoway
	(scatter gdp_d edu_ceyear)
	(lfit gdp_d edu_ceyear)
	(qfit gdp_d edu_ceyear),
	title("Growth rate of GDP/Years of Education, after 1991") 
	ytitle("Growth rate of GDP")
	xtitle("Years of Education(on average)")
	legend(label (1 "Observation") label (2 "Linear fit") label (3 "Quadratic fit")) 
	;
#delimit cr

*6.4
use correlation.dta, clear
keep if year<1991
drop if PIPECode==.
tsset PIPECode year, yearly
gen gdp_d = D.GDP/L.GDP
*gen gdp_d2 = ln(GDP/L.GDP)
collapse (mean)edu_ceyear (mean)gdp_d, by(PIPECode)
#delimit ;
	twoway
	(scatter gdp_d edu_ceyear)
	(lfit gdp_d edu_ceyear)
	(qfit gdp_d edu_ceyear),
	title("Growth rate of GDP/Years of Education, after 1991") 
	ytitle("Growth rate of GDP")
	xtitle("Years of Education(on average)")
	legend(label (1 "Observation") label (2 "Linear fit") label (3 "Quadratic fit")) 
	;
#delimit cr

*6.5
use correlation.dta, clear
keep if democracy == 1
keep if year>1991
drop if PIPECode==.
tsset PIPECode year, yearly
gen gdp_d = D.GDP/L.GDP
*gen gdp_d2 = ln(GDP/L.GDP)
collapse (mean)edu_ceyear (mean)gdp_d, by(PIPECode)
#delimit ;
	twoway
	(scatter gdp_d edu_ceyear)
	(lfit gdp_d edu_ceyear)
	(qfit gdp_d edu_ceyear),
	title("Growth rate of GDP/Years of Education, after 1991") 
	ytitle("Growth rate of GDP")
	xtitle("Years of Education(on average)")
	legend(label (1 "Observation") label (2 "Linear fit") label (3 "Quadratic fit")) 
	;
#delimit cr

*6.6
use correlation.dta, clear
keep if democracy == 1
keep if year<1991
drop if PIPECode==.
tsset PIPECode year, yearly
gen gdp_d = D.GDP/L.GDP
*gen gdp_d2 = ln(GDP/L.GDP)
collapse (mean)edu_ceyear (mean)gdp_d, by(PIPECode)
#delimit ;
	twoway
	(scatter gdp_d edu_ceyear)
	(lfit gdp_d edu_ceyear)
	(qfit gdp_d edu_ceyear),
	title("Growth rate of GDP/Years of Education, after 1991") 
	ytitle("Growth rate of GDP")
	xtitle("Years of Education(on average)")
	legend(label (1 "Observation") label (2 "Linear fit") label (3 "Quadratic fit")) 
	;
#delimit cr

*6.7
use correlation.dta, clear
keep if democracy == 0
keep if year>1991
drop if PIPECode==.
tsset PIPECode year, yearly
gen gdp_d = D.GDP/L.GDP
*gen gdp_d2 = ln(GDP/L.GDP)
collapse (mean)edu_ceyear (mean)gdp_d, by(PIPECode)
#delimit ;
	twoway
	(scatter gdp_d edu_ceyear)
	(lfit gdp_d edu_ceyear)
	(qfit gdp_d edu_ceyear),
	title("Growth rate of GDP/Years of Education, after 1991") 
	ytitle("Growth rate of GDP")
	xtitle("Years of Education(on average)")
	legend(label (1 "Observation") label (2 "Linear fit") label (3 "Quadratic fit")) 
	;
#delimit cr

*6.8
use correlation.dta, clear
keep if democracy == 0
keep if year<1991
drop if PIPECode==.
tsset PIPECode year, yearly
gen gdp_d = D.GDP/L.GDP
*gen gdp_d2 = ln(GDP/L.GDP)
collapse (mean)edu_ceyear (mean)gdp_d, by(PIPECode)
#delimit ;
	twoway
	(scatter gdp_d edu_ceyear)
	(lfit gdp_d edu_ceyear)
	(qfit gdp_d edu_ceyear),
	title("Growth rate of GDP/Years of Education, after 1991") 
	ytitle("Growth rate of GDP")
	xtitle("Years of Education(on average)")
	legend(label (1 "Observation") label (2 "Linear fit") label (3 "Quadratic fit")) 
	;
#delimit cr



*testing
use correlation.dta, clear
gen a1991=1
replace a1991 =0 if year<=1991
drop if PIPECode==.
tsset PIPECode year, yearly
gen gdp_d = D.GDP/L.GDP
*gen gdp_d2 = ln(GDP/L.GDP)
collapse (mean)edu_ceyear (mean)gdp_d, by(PIPECode democracy a1991)
*reg gdp_d edu_ceyear
*predict gdp_d_hat
#delimit ;
	twoway
	(scatter gdp_d edu_ceyear, msize(vsmall))
	(lfit gdp_d edu_ceyear)
	(qfit gdp_d edu_ceyear),
	by(democracy a1991,
		title("Growth rate of GDP/Years of Education, after 1991")
		legend(off)
		)
	ytitle("Growth rate of GDP")
	xtitle("Years of Education(on average)")
	
	
	;
#delimit cr
*legend(label (1 "Observation") label (2 "Linear fit") label (3 "Quadratic fit"))
