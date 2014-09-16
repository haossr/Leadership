clear all
set more off
set trace off
cd "D:\GitHub\Leadership\Television\WorkingData"

use Leader_TV, clear
keep year country age age_firstterm age_left parli presi democracy
foreach var of varlist age age_firstterm age_left{
	gen `var'_d = `var' if democracy
	gen `var'_nd = `var' if !democracy
}

foreach var of varlist age age_firstterm age_left {
	gen `var'_par = `var' if parli
	gen `var'_pre = `var' if presi
}

foreach var of varlist age*{
	gen se`var' = `var'
}

collapse (mean)age* (semean)se*, by(year)

foreach var of varlist age*{
	gen h`var' = `var' + 1.96 * se`var'
	gen l`var' = `var' - 1.96 * se`var'
}

foreach var of varlist age*{
	if strpos("`var'", "_d"){
	label variable `var' "Democratic countries"
	}
	if strpos("`var'", "_nd"){
	label variable `var' "Non-democratic countries"
	}
	if strpos("`var'", "_par"){
	label variable `var' "Parliamentary"
	}
	if strpos("`var'", "_pre"){
	label variable `var' "presidency"
	}
}	

local subgroup _d _nd _par _pre
foreach var of varlist age age_firstterm age_left{
	foreach suffix in `subgroup'{
	#delimit ;
		twoway (rarea l`var'`suffix' h`var'`suffix' year, sort bcolor(gs14))
		(line `var'`suffix' year),
		legend(label (1 "%95 CI")) ;
	#delimit cr
	graph export ..\Graph\graph_`var'_`suffix'.png, replace
	}
}


use Leader_TV, clear
local divide 1980
gen before = 1
replace before = 0 if year > `divide'
replace before = 1 if year <= `divide'
gen parlib = parli*before
gen parlia = parli*!before
gen presib = presi*before
gen presia = presi*!before
collapse (mean)parlia presia parlib presib, by(country before)
scatter parlia parlib
scatter presia presib
