
 
 
**********************************************************************
**************  a. initialization              ***********************
**********************************************************************
cd ..\RawData
*a.1.PWT80.dta
use .\PWT80\pwt80.dta, clear
rename countrycode PWTCode
sort PWTCode year
save ..\WorkingData\pwt80.dta, replace

**********************************************************************
**************  b. merge and check
**********************************************************************
cd ..\WorkingData
use Leadership_1.dta, clear
drop if PWTCode=="."
drop if PWTCode == ""
sort PWTCode year
merge m:1 PWTCode year using pwt80.dta
tab _merge
if testing{
	tab countryn_L PIPECode if _merge==1
*	keep if _merge==1
*	bysort country: keep if _n==1
}
drop _merge
save Leadership_2.dta, replace
