
cd ..\WorkingData

use ..\RawData\Leadership.dta, replace
drop if year<1950
drop if year>2010
save Leadership.dta, replace
************************************************************************
*************** 1. Selection
************************************************************************
use Leadership.dta, clear
gen elig_ac = 1
replace elig_ac = 0 if elig_citizen == 0
replace elig_ac = 0 if elig_age == 0
replace elig_ac = 0 if elig_edu == 1
replace elig_ac = 0 if elig_ocu == 1
replace elig_ac = 0 if elig_reg == 1
replace elig_ac = 0 if elig_race == 1
replace elig_ac = 0 if elig_exp == 1
replace elig_ac = 0 if elig_end == 1


collapse (mean) elig*, by(year)
*foreach var in elig*{
*	twoway line `var' year
*}
save selection.dta, replace

************************************************************************
*************** 2. Education
************************************************************************
use Leadership.dta, clear
replace OECD=0 if OECD==.
replace edu_ce =. if edu_ce==0
drop if democracy ==.
drop if year ==.
drop if edu_ce ==.
drop if edu_cemajor==.


recode edu_ce (1 2 3 = 1)(4 5 = 2)(6 7 8= 3), gen(edu_ce_N)
recode edu_cemajor (1 11 = 1)(2 10 = 2)(3 4 9 = 3)(5 6 7 = 4)(8 = 5), gen(edu_cemajor_N)
drop if edu_cemajor_N > 5
label define major 1 "Low or other" 2 "Liberal arts" 3 "Science and technology" 4 "Social Science" 5 "Military"
label values edu_cemajor_N major


gen year_b1991 = 1
replace year_b1991 = 0 if year>=1991




tabulate edu_ce, gen(edu_ce_)

tabulate edu_ce_N, gen(edu_ce_N_)
label variable edu_ce_N_1 "Edu. level 1-3"
label variable edu_ce_N_2 "Edu. level 4-5"
label variable edu_ce_N_3 "Edu. level 6-8"
*label variable edu_group1 "Education level 1-3"
*label variable edu_group2 "Education level 4-5"
*label variable edu_group3 "Education level 6-8"


tabulate edu_cemajor_N, gen(edu_major_)
label variable edu_major_1 "Low or other"
label variable edu_major_2 "Liberal arts"
label variable edu_major_3 "Science and technology"
label variable edu_major_4 "Social Science"
label variable edu_major_5 "Military"


quietly sum 
gen weight = 1/r(N)
gen weight_d = weight*democracy
gen weight_nd = weight*(1-democracy)
label variable weight_d "Democratic countries"
label variable weight_nd "Non-democratic countries"

gen weight_oecd = weight*OECD
gen weight_noecd = weight*(1-OECD)
label variable weight_oecd "OECD countries"
label variable weight_noecd "Non-OECD countries"


save education.dta, replace
