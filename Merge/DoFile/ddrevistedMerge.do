 
**********************************************************************
**************  a. initialization              ***********************
**********************************************************************
cd ..\RawData
use .\ddrevisited\ddrevisited_data_v1.dta, clear
rename cowcode COWCode
sort COWCode
save ..\WorkingData\ddrevisited.dta, replace


**********************************************************************
**************  b. merge and check
**********************************************************************
cd ..\WorkingData
use Leadership_2.dta, clear
sort COWCode
merge m:1 COWCode using countryID.dta
tab _merge
if testing{
	tab countryn_L PIPECode if _merge==1
*	keep if _merge==1
*	bysort country: keep if _n==1
}
drop _merge
save Leadership_3.dta, replace
