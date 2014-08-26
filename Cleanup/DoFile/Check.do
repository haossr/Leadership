/*set more off
set trace on
clear all
*/
/*
cd "E:\Dropbox\Project-Leadership\Data-Cleanup\WorkingData"
use Leadership.dta, clear
*/

cd ..\WorkingData

use Leadership.dta, clear
noisily list countryn year exp_ce_central exp_ce_centralyear if exp_ce_central>1&exp_ce_central!=.

************************************************************
********1.dummy variable: exp_ce*
************************************************************
local dummyyear 
local dummy 
foreach var of varlist exp_ce_public-exp_ce_manageryear{
	if strpos("`var'","year"){
	local dummyyear = "`dummyyear'  `var'"
	}
	else{
	local dummy = "`dummy' `var'"
	}
}

foreach var of varlist `dummy' {
	if "`var'" == "exp_ce_Ngovernor"{
		continue
	}
	capture noisily list countryn year `var' `var'year filename sourcen if `var'>1 &`var'!=., ab(33)
	if _rc{
		capture noisily list countryn year `var' filename sourcen if `var'>1 &`var'!=., ab(33)
	}
}
