clear all
set more off
set trace off

cd D:\GitHub\Leadership\Trend\WorkingData

use correlation.dta, clear
local xvar age
*local xvar age edu_ceyear length_ce exp_ce_publicyear exp_ce_governoryear exp_ce_centralyear exp_ce_manageryear

*collapse (mean)`xvar' (mean)gdp_d, by(PIPECode democracy a1991)

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
	(scatter gdp_d `var',msize(vsmall))
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
	(scatter gdp_d `var',msize(vsmall))
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
	(scatter gdp_d `var',msize(vsmall))
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
	(scatter gdp_d `var',msize(vsmall))
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
	(scatter gdp_d `var',msize(vsmall))
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
