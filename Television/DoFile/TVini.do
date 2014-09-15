clear all
set more off
cd "D:\GitHub\Leadership\Television\WorkingData"
**********************************************************************
**************  a. importing & merging              ******************
**********************************************************************
forvalue year = 1975(1)2005{
	insheet using "..\RawData\TVPenetration\\`year'.csv", clear
	gen sourceTV = `year'
	save `year'.dta, replace
}

use 1975.dta, clear
forvalue year = 1976(1)2005{
	append using `year'.dta
}

rename date year
replace amount = subinstr(amount, "%", "", 1)
destring amount, replace
rename amount TVPenetration
sort country

merge m:1 country using Index.dta
drop _merge
sort PIPECode year
save TVPenetration.dta, replace

use ..\RawData\Leadership.dta, clear
capture drop if year ==. | PIPECode ==. | countryn==""
capture drop _merge
sort PIPECode year
merge m:m PIPECode year using TVPenetration.dta
tab _merge
keep if _merge==3
drop if countryn == ""
drop _merge
save Leader_TV.dta, replace

**********************************************************************
**************  b. cleaning and generating          ******************
**********************************************************************
use Leader_TV.dta, replace
*age
gen age = year - birthyear_ce
gen age_firstterm = age
gen age_left = age
bysort PIPECode cen birthyear_ce (year): replace age_firstterm = age_firstterm[1] if _n!=1
bysort PIPECode cen birthyear_ce (year): replace age_left = age_left[_N] if _n!=_N

*democracy 


*regime
gen presi = 0
replace presi = 1 if title_ce==3
gen parli = 0 
replace parli = 1 if title_ce==2

*duplicates check
bysort PIPECode year: gen dup_check = _n
list country* year sourceTV PIPECode if dup_check>1

*time set
tsset PIPECode year

save Leader_TV.dta, replace

