 
**********************************************************************
**************  a. initialization              ***********************
**********************************************************************
cd ..\RawData
use .\ddrevisited\ddrevisited_data_v1.dta, clear
rename cowcode COWCode
sort COWCode year
save ..\WorkingData\ddrevisited.dta, replace


**********************************************************************
**************  b. merge and check
**********************************************************************
cd ..\WorkingData
use Leadership_2.dta, clear
sort COWCode
merge m:1 COWCode year using ddrevisited.dta
tab _merge
if testing{
	tab year if _merge==1
*	keep if _merge==1
*	bysort country: keep if _n==1
}
drop _merge
save Leadership_3.dta, replace
