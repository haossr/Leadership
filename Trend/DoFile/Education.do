if c(username)== "Hari"{
	cd D:\GitHub\Leadership\Trend\DoFile
}
else {
cd E:\GitHub\Leadership\Trend\DoFile
}
cd ..\WorkingData
************************************************************************
*************** 1. Initilization
************************************************************************
use Leadership.dta
drop if year<1950
drop if year>2010
replace edu_ce =. if edu_ce==0
recode edu_ce (1 2 3 = 1)(4 5 = 2)(6 7 8= 3), gen(edu_ce_N)
save education_3_0.dta, replace

************************************************************************
*************** 2. Trend: Selection mechanism/barrier to entry
************************************************************************
*3.1
use education_3_0.dta, clear
tabulate edu_ce_N, gen(edu_group)
collapse (mean)edu_group*, by(year)

label variable edu_group1 "Education level 1-3"
label variable edu_group2 "Education level 4-5"
label variable edu_group3 "Education level 6-8"

save education_3_1.dta, replace
twoway (line edu_group* year), title("Selection") subtitle("Trend of Education Level")
graph export ..\Graph\3_1.png, replace


*3.2, 3.3
use education_3_0.dta, clear
tabulate edu_ce_N, gen(edu_group)
collapse (mean)edu_group*, by(year democracy)
