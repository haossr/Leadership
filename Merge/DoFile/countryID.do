**********************************************************************
**************  a. initialization 
**********************************************************************

cd ..\RawData
*a.1.Leadership.dta
use Leadership.dta, clear
rename countryn countryn_L
replace countryn_L = lower(countryn_L)
rename country PIPECode
sort PIPECode year
save ..\WorkingData\Leadership.dta, replace

import excel ..\ReferenceData\countryID.xlsx, sheet("ISO3166_1 and DataCovered") firstrow clear
rename COWCODE COWCode
sort PIPECode
drop if PIPECode ==.
save ..\WorkingData\countryID.dta, replace


**********************************************************************
**************  b. merge and check
**********************************************************************
cd ..\WorkingData
use Leadership.dta, clear
merge m:1 PIPECode using countryID.dta
tab _merge
if testing{
	tab countryn_L PIPECode if _merge==1
*	keep if _merge==1
*	bysort country: keep if _n==1
}
keep if _merge == 3
drop _merge
save Leadership_0.dta, replace
*****************************************************************************************************
**************  c. individual cases: Czechoslovakia, Yugoslavia, Yemensouth, Germany
*****************************************************************************************************
