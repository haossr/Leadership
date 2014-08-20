
 
 
**********************************************************************
**************  a. initialization              ***********************
**********************************************************************

cd ..\RawData
*a.2.PIPE.dta
use .\PIPE\PIPE_081813.dta, clear
drop if country ==.
replace countryn = lower(countryn)

*a.3.PIPE-imputation
expand 3 if year == 2008
bysort country year: replace year = 2008+_n-1 if _n>1 & country!=.
sort country year
save ..\WorkingData\PIPE.dta, replace


**********************************************************************
**************  b. merge and check             ***********************
**********************************************************************
cd ..\WorkingData
*b.1.Merge
use Leadership.dta, clear
merge 1:1 country year using PIPE.dta
tab _merge
 
*b.2.Check
if testing{
	tab countryn_L if _merge==1
	tab year if _merge==1
	tab filename if _merge==1
}
if !testing{
drop if _merge==2
}
gen con = 0
replace con =1 if countryn = countryn_L

save LeadershipMerged_1.dta, replace
