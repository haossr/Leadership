
 
 
**********************************************************************
**************  a. initialization              ***********************
**********************************************************************

cd ..\RawData
*a.GWF.dta
use .\GWF\GWF_AllPoliticalRegimes.dta, clear
rename cowcode COWCode
drop if COWCode ==.
drop if year < 1950
save ..\WorkingData\GWF.dta,replace

**********************************************************************
**************  b. merge and check             ***********************
**********************************************************************
cd ..\WorkingData
*b.1.Merge
use Leadership_5.dta, clear
sort COWCode
drop if COWCode==.
capture drop _merge
merge 1:1 COWCode year using GWF.dta
tab _merge
 
*b.2.Check
if testing{
	tab countryn_L if _merge==1
	tab year if _merge==1
	tab filename if _merge==1
}
drop if _merge==2
drop _merge
save Leadership_6.dta, replace
