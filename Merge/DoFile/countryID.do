**********************************************************************
**************  a. initialization 
**********************************************************************

cd ..\RawData
*a.1.Leadership.dta
use Leadership.dta, clear
rename countryn countryn_L
replace countryn_L = lower(countryn_L)
sort country year
save ..\WorkingData\Leadership.dta, replace

import excel ..\ReferenceData\countryID.xlsx, sheet("ISO3166_1 and DataCovered") firstrow clear
rename PIPECode country
sort country
drop if country ==.
save ..\WorkingData\countryID.dta, replace


**********************************************************************
**************  b. merge and check
**********************************************************************
cd ..\WorkingData
use Leadership.dta, clear
merge m:1 country using countryID.dta
tab _merge
if testing{
	tab countryn_L country if _merge==1
	keep if _merge==1
	bysort country: keep if _n==1
}

**********************************************************************
**************  c. individual cases: Czechoslovakia, Yugoslavia, Yemensouth, Germany
**********************************************************************
