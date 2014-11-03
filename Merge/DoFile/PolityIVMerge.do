
 
 
**********************************************************************
**************  a. initialization              ***********************
**********************************************************************

cd ..\RawData
*a.GWF.dta
import excel "D:\GitHub\Leadership\Merge\RawData\PolityIV\p4v2013.xls", sheet("p4v2013") firstrow clear
rename scode PolityIVCode
drop if PolityIVCode =="."
drop if year < 1950
save ..\WorkingData\PolityIV.dta,replace

**********************************************************************
**************  b. merge and check             ***********************
**********************************************************************
cd ..\WorkingData
*b.1.Merge
use Leadership_6.dta, clear
sort PolityIVCode
replace PolityIVCode = "." if strlen(PolityIVCode)>3
drop if PolityIVCode=="."
drop if PolityIVCode == ""
capture drop _merge
merge 1:1 PolityIVCode year using PolityIV.dta
tab _merge
 
*b.2.Check
if testing{
	tab countryn_L if _merge==1
	tab year if _merge==1
	tab filename if _merge==1
}
drop if _merge==2
drop _merge
save Leadership_7.dta, replace
