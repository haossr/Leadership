cd ..\WorkingData\
************************************************************************
*************** Trend: Selection mechanism/barrier to entry
************************************************************************
*2.0
use selection.dta, clear
drop elig_ac
foreach var of varlist elig_* {
local l`var' : variable label `var'
label variable `var' "Proportion(RHS)"
label variable N`var' "# of obs(LHS)"
#delimit ;
	twoway 
	(bar N`var' year, fcolor(grey) fintensity(inten10) lcolor(white) lwidth(0))
	(line `var' year, yaxis(2)) , 
	title("Selection") 
	subtitle("Proportion of entry barrier: `l`var''")
	saving(..\Graph\selection_`var'.gph, replace);
#delimit cr
graph export ..\Graph\selection_`var'.png, replace
}

use selection.dta, clear
*2.1.proportion of countries in which the only barrier to entry is citizenship and age
*twoway (line elig_ac year) ,title("Selection mechanism") subtitle("Proportion of countries in which the only barrier to entry is citizenship and age")
twoway (line elig_citizen year)(line elig_age year),title("Selection mechanism") subtitle("Proportion of countries in which the only barrier to entry is citizenship and age")
graph save Graph ..\Graph\selection_citizen_age.gph, replace
graph export ..\Graph\selection_citizen_age.png, replace
graph export ..\Graph\2_1.png, replace
*twoway line elig_age year
*graph save Graph ..\selection_citizen.gph, replace


*2.2.proportion of countries which restrict entry according to education, or occupation
twoway (line elig_edu year)(line elig_ocu year),title("Selection mechanism") subtitle("Proportion of countries which restrict entry according to education, or occupation")
graph save Graph ..\Graph\selection_edu_ocu.gph, replace
graph export ..\Graph\selection_edu_ocu.png, replace
graph export ..\Graph\2_2.png, replace
*twoway line elig_ocu year


*2.3.proportion of countries which restrict entry according to race, or religion
twoway (line elig_race year)(line elig_reg year),title("Selection mechanism") subtitle("Proportion of countries which restrict entry according to race, or religion")
graph save Graph ..\Graph\selection_race_reg.gph, replace
graph export ..\Graph\selection_race_reg.png, replace
graph export ..\Graph\2_3.png, replace
*twoway line elig_reg year


*2.4.proportion of countries which restrict entry according to endorsement or experience in public office 
twoway (line elig_exp year)(line elig_end year),title("Selection mechanism") subtitle("Proportion of countries which restrict entry according to endorsement or experience in public office ")
graph save Graph ..\Graph\selection_exp_end.gph, replace
graph export ..\Graph\selection_exp_end.png, replace
graph export ..\Graph\2_4.png, replace
*twoway line elig_end year

window manage close graph
