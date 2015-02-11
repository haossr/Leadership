cd ..\WorkingData
set trace off

use ..\RawData\Leadership.dta, clear
replace OECD = 0 if OECD ==.
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
replace elig_ac = 0 if elig_crm == 1
replace elig_ac = 0 if elig_inc == 1

foreach var of varlist elig_* {
	gen N`var' =`var'
}
collapse (mean)elig_* (sum)Nelig_*, by(year)
label variable elig_citizen "Citizenship"
label variable elig_age "Age"
label variable elig_edu "Education"
label variable elig_ocu "Occupation"
label variable elig_reg "Religion"
label variable elig_race "Race"
label variable elig_exp "Experience"
label variable elig_end "Endorsement"
label variable elig_crm "Crime"
label variable elig_inc "Income"
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


************************************************************************
*************** 3. Age and gender
************************************************************************
use Leadership.dta, clear
gen age = year - birthyear_ce
gen age_firstterm = age
gen age_left = age
bysort PIPECode cen birthyear_ce (year): replace age_firstterm = age_firstterm[1] if _n!=1
bysort PIPECode cen birthyear_ce (year): replace age_left = age_left[_N] if _n!=_N

*check
/*
sort PIPECode cen year
gen temp = age==age1
tab temp firstterm_ce
bro countryn PIPECode cen year birthyear_ce age* length_ce source* filename if length_ce==1 & temp==0
*/

gen age_d = age if democracy
gen age_nd = age if !democracy
*label variable age_d "Democratic countries"
*label variable age_nd "Non-democratic countries"

gen age_oecd = age if OECD
gen age_noecd = age if !OECD
*label variable age_oecd "OECD countries"
*label variable age_noecd "Non-OECD countries"

gen age_firstterm_d = age_firstterm if democracy
gen age_firstterm_nd = age_firstterm if !democracy
*label variable age_firstterm_d "Democratic countries"
*label variable age_firstterm_nd "Non-democratic countries"

gen age_firstterm_oecd = age_firstterm if OECD
gen age_firstterm_noecd = age_firstterm if !OECD
*label variable age_firstterm_oecd "OECD countries"
*label variable age_firstterm_noecd "Non-OECD countries"

gen age_left_d = age_left if democracy
gen age_left_nd = age_left if !democracy
*label variable age_left_d "Democratic countries"
*label variable age_left_nd "Non-democratic countries"

gen age_left_oecd = age_left if OECD
gen age_left_noecd = age_left if !OECD
*label variable age_left_oecd "OECD countries"
*label variable age_left_noecd "Non-OECD countries"

gen gender_d = gender_ce if democracy
gen gender_nd = gender_ce if !democracy
*label variable gender_d "Democratic countries"
*label variable gender_nd "Non-democratic countries"

gen gender_oecd = gender_ce if OECD
gen gender_noecd = gender_ce if !OECD
*label variable gender_oecd "OECD countries"
*label variable gender_noecd "Non-OECD countries"


foreach var of varlist age*{
	gen se`var' = `var'
}

collapse (mean)gender* (mean)age* (semean)seage*, by(year)
label variable age "Age overall"
label variable gender_ce "Gender overall"
label variable age_d "Democratic countries"
label variable age_nd "Non-democratic countries"
label variable age_oecd "OECD countries"
label variable age_noecd "Non-OECD countries"
label variable age_firstterm_d "Democratic countries"
label variable age_firstterm_nd "Non-democratic countries"
label variable age_firstterm_oecd "OECD countries"
label variable age_firstterm_noecd "Non-OECD countries"
label variable gender_d "Democratic countries"
label variable gender_nd "Non-democratic countries"
label variable gender_oecd "OECD countries"
label variable gender_noecd "Non-OECD countries"
label variable age_left_d "Democratic countries"
label variable age_left_nd "Non-democratic countries"
label variable age_left_oecd "OECD countries"
label variable age_left_noecd "Non-OECD countries"
*quietly dscribe age_firstterm_* age_left_*
*local myvars3 
quietly ds age_firstterm_* age_left_*
local boundvar `r(varlist)'
foreach var in `boundvar'{
	gen h`var' = `var' + 1.96 * se`var'
	gen l`var' = `var' - 1.96 * se`var'
}

/*
foreach var of varlist {
	gen h`var' = `var' + 1.96 * se`var'
	gen l`var' = `var' - 1.96 * se`var'
}
*/
save age_gender.dta, replace

************************************************************************
*************** 4. Experience
************************************************************************
use Leadership.dta, clear

*length_ce
gen length_ce_d = length_ce if democracy
gen length_ce_nd = length_ce if !democracy

gen length_ce_oecd = length_ce if OECD
gen length_ce_noecd = length_ce if !OECD

*Nterm
gen Nterm_d = Nterm_ce if democracy
gen Nterm_nd = Nterm_ce if !democracy
foreach var in Nterm_d Nterm_nd {
	gen `var'_par = `var' if title_ce==2
	gen `var'_pre = `var' if title_ce==3
}


*dummy variable and dummy year variable
local dummyyear 
local dummy 
foreach var of varlist exp_ce_public-exp_ce_manageryear{
	if strpos("`var'","year"){
	local dummyyear = "`dummyyear'  `var'"
	}
	else{
	local dummy = "`dummy' `var'"
	}
}

disp "`dummy'"
disp "`dummyyear'"

foreach var of varlist `dummy' `dummyyear' {
	gen `var'_d = `var' if democracy
	gen `var'_nd = `var' if !democracy
	gen `var'_oecd = `var' if OECD
	gen `var'_noecd = `var' if !OECD
}

ds exp*d
foreach var of varlist exp*d length*{
	gen se`var' = `var'
}

ds se*d
capture drop sequence
collapse (mean)exp*d (mean)Nterm* (mean)length* (semean)se*, by(year)

foreach var of varlist exp*d length*{
	gen h`var' = `var' + 1.96 * se`var'
	gen l`var' = `var' - 1.96 * se`var'
}

foreach var of varlist exp*d Nterm* length*d{
	if strpos("`var'", "_d"){
	label variable `var' "Democratic countries"
	}
	if strpos("`var'", "_nd"){
	label variable `var' "Non-democratic countries"
	}
	if strpos("`var'", "_oecd"){
	label variable `var' "OECD countries"
	}
	if strpos("`var'", "_noecd"){
	label variable `var' "Non-OECD countries"
	}
}	
label variable length_ce "Overall"

save experience.dta, replace


************************************************************************
*************** 5. Corelation
************************************************************************
use Leadership.dta, clear
*growth rate
drop if PIPECode==.
tsset PIPECode year, yearly
gen gdp_d = D.GDP/L.GDP

*a1991
gen a1991 = 1
replace a1991 = 0 if year <=1991

*age
gen age = year - birthyear_ce

*eligibility(missing if one of elig_* mising)
egen eligibility = rowtotal(elig_*)
egen eligmiss = rowmiss(elig_*)
replace eligibility = . if eligmiss>0
save correlation.dta, replace


************************************************************************
*************** 6. Summary Leaders
************************************************************************
use Leadership.dta, clear
gen age = year - birthyear_ce
gen age_firstterm = age
gen age_left = age
bysort PIPECode cen birthyear_ce (year): replace age_firstterm = age_firstterm[1] if _n!=1
bysort PIPECode cen birthyear_ce (year): replace age_left = age_left[_N] if _n!=_N



replace OECD=0 if OECD==.
replace edu_ce =. if edu_ce==0
drop if democracy ==.
drop if year ==.


gen pollable = 0
replace pollable =1 if eligible_pr>0.5

recode year (1950/1960 = 1)(1961/1970 = 2)(1971/1980 = 3)(1981/1990 = 4)(1991/2000 = 5)(2001/2010 = 6), gen(year_G)
label variable year_G "Year group" 
label define l_year_G 1 "1950-1960" 2 "1961-1970" 3 "1971-1980" 4 "1981-1990" 5 "1991-2000" 6 "2001-2010"
label values year_G l_year_G


gen age_d = age if democracy
gen age_nd = age if !democracy

bysort year_G: egen mage_d = mean(age_d)
bysort year_G: egen mage_nd = mean(age_nd)
gen dage_d = mage_d - mage_nd

gen age_oecd = age if OECD
gen age_noecd = age if !OECD
bysort year_G: egen mage_oecd = mean(age_oecd)
bysort year_G: egen mage_noecd = mean(age_noecd)
gen dage_oecd = mage_oecd - mage_noecd

gen age_poll = age if democracy & pollable
gen age_npoll = age if !(democracy & pollable)
bysort year_G: egen mage_poll = mean(age_poll)
bysort year_G: egen mage_npoll = mean(age_npoll)
gen dage_poll = mage_poll-mage_npoll

capture drop mage_*

*collapse (mean)age*, by(year_G)
foreach var of varlist age_*{
	if strpos("`var'", "_d"){
	label variable `var' "Democratic countries"
	}
	if strpos("`var'", "_nd"){
	label variable `var' "Non-democratic countries"
	}
	if strpos("`var'", "_oecd"){
	label variable `var' "OECD countries"
	}
	if strpos("`var'", "_noecd"){
	label variable `var' "Non-OECD countries"
	}
	if strpos("`var'", "_poll"){
	label variable `var' "Demo & Pollable countries"
	}
	if strpos("`var'", "_npoll"){
	label variable `var' "Non-Demo or not Pollable countries"
	}
}	

foreach var of varlist age_d age_nd{
	gen `var'_par = `var' if head_title == 1 
	gen `var'_pre = `var' if head_title == 2
}


save summary_age.dta, replace

*!!!
*check length_ce
gen c_length_ce = length_ce - year
bysort cen c_length_ce: keep if _n==1
bysort cen: gen Error = _N
*tab cen Error if Error >3
sort cen year
export excel countryn year cen length_ce sourcen using "..\Log\Length_ce.xls" if Error>3, firstrow(variables) replace
