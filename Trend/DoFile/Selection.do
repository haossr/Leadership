if c(username)== "Leonard"{
	cd D:\GitHub\Leadership\Trend\DoFile
}
else {
cd E:\GitHub\Leadership\Trend\DoFile
}
cd ..\RawData
************************************************************************
*************** 1. Initilization
************************************************************************

use Leadership.dta,clear
save ..\WorkingData\Leadership.dta, replace

cd ..\Workingdata
drop if year<1950
drop if year>2010


collapse (mean) elig*, by(year)
*foreach var in elig*{
*	twoway line `var' year
*}
save selection.dta, replace

************************************************************************
*************** 2. Trend: Selection mechanism/barrier to entry
************************************************************************
use selection.dta, clear
*2.1.proportion of countries in which the only barrier to entry is citizenship and age
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
