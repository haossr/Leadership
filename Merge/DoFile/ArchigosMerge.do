 
**********************************************************************
**************  a. initialization              ***********************
**********************************************************************
cd ..\RawData
use .\Archigos\Archigos_2.9-Public.dta, clear
rename ccode COWCode
sort COWCode
save ..\WorkingData\Archigos.dta, replace


**********************************************************************
**************  b. merge and check
**********************************************************************
cd ..\WorkingData
use Leadership_3.dta, clear
sort COWCode
merge m:1 COWCode using countryID.dta
tab _merge
if testing{
	tab countryn_L PIPECode if _merge==1
*	keep if _merge==1
*	bysort country: keep if _n==1
}
drop _merge
save Leadership_4.dta, replace
