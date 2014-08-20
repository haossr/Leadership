
 
 
**********************************************************************
**************  a. initialization              ***********************
**********************************************************************

cd ..\RawData
*a.2.PIPE.dta
use .\PIPE\PIPE_081813.dta, clear
rename country PIPECode
drop if PIPECode ==.
replace countryn = lower(countryn)

*a.3.PIPE-imputation
expand 3 if year == 2008
drop if PIPECode==.
bysort PIPECode year: replace year = 2008+_n-1 if _n>1 & PIPECode!=.
sort PIPECode year
save ..\WorkingData\PIPE.dta, replace


**********************************************************************
**************  b. merge and check             ***********************
**********************************************************************
cd ..\WorkingData
*b.1.Merge
use Leadership_0.dta, clear
sort PIPECode
merge 1:1 PIPECode year using PIPE.dta
tab _merge
 
*b.2.Check
if testing{
	tab countryn_L if _merge==1
	tab year if _merge==1
	tab filename if _merge==1
}
drop if _merge==2
drop _merge
save Leadership_1.dta, replace
