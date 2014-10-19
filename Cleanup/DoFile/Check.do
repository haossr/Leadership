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
*keep if sourcen == "YML"
************************************************************
********1.dummy variable: exp_ce*
************************************************************
local dummyyear 
local dummy exp_ce_public exp_ce_vice exp_ce_minister exp_ce_legis exp_ce_governor exp_ce_central exp_ce_party exp_ce_private exp_ce_military exp_ce_manager
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
	noisily list countryn year `var' `var'year sourcen if (`var'>0 & `var'!=.) & (`var'year==0), ab(33)
	noisily list countryn year `var' `var'year sourcen if (`var'year>0 &`var'year!=.) & (`var'==0|`var'==.), ab(33)
	/*
	if _rc{
		 noisily list countryn year `var' sourcen if `var'>1 &`var'!=., ab(33)
	}
	*/
}


************************************************************
*********From Prof.XI
************************************************************
*1.dummy variable
list countryn year exp_ce_public exp_ce_publicyear sourcen if exp_ce_public==4
list countryn year firstterm_ce sourcen if firstterm_ce==2
list countryn year exp_ce_legis exp_ce_legisyear sourcen if exp_ce_legis==4
list countryn year exp_ce_party exp_ce_partyyear sourcen if exp_ce_party==29

*2.term
list countryn year firstterm_ce Nterm_ce sourcen if firstterm_ce==0&Nterm_ce<=1
list countryn year firstterm_ce Nterm_ce sourcen if firstterm_ce==1&Nterm_ce>1

*3.exp_*, dummy~dummy year
list countryn year exp_ce_public exp_ce_publicyear sourcen if exp_ce_public==0&exp_ce_publicyear>0
list countryn year exp_ce_public exp_ce_publicyear sourcen if exp_ce_public>0&exp_ce_publicyear<1
list countryn year exp_ce_vice exp_ce_viceyear sourcen if exp_ce_vice==0&exp_ce_viceyear>0
list countryn year exp_ce_vice exp_ce_viceyear sourcen if exp_ce_vice>0&exp_ce_viceyear<1
list countryn year exp_ce_minister exp_ce_ministeryear sourcen if exp_ce_minister==0&exp_ce_ministeryear>0
list countryn year exp_ce_minister exp_ce_ministeryear sourcen if exp_ce_minister>0&exp_ce_ministeryear<1
list countryn year exp_ce_legis exp_ce_legisyear sourcen if exp_ce_legis==0&exp_ce_legisyear>0
list countryn year exp_ce_legis exp_ce_legisyear sourcen if exp_ce_legis>0&exp_ce_legisyear<1
list countryn year exp_ce_governor exp_ce_governoryear sourcen if exp_ce_governor==0&exp_ce_governoryear>0
list countryn year exp_ce_governor exp_ce_governoryear sourcen if exp_ce_governor>0&exp_ce_governoryear<1
list countryn year exp_ce_Ngovernor exp_ce_governoryear sourcen if exp_ce_Ngovernor==0&exp_ce_governoryear>0
list countryn year exp_ce_Ngovernor exp_ce_governoryear sourcen if exp_ce_Ngovernor>0&exp_ce_governoryear<1
list countryn year exp_ce_party exp_ce_partyyear sourcen if exp_ce_party==0&exp_ce_partyyear>0
list countryn year exp_ce_party exp_ce_partyyear sourcen if exp_ce_party>0&exp_ce_partyyear<1
list countryn year exp_ce_central exp_ce_centralyear sourcen if exp_ce_central==0&exp_ce_centralyear>0
list countryn year exp_ce_central exp_ce_centralyear sourcen if exp_ce_central==1&exp_ce_centralyear<1
list countryn year exp_ce_military exp_ce_militaryyear sourcen if exp_ce_military==0&exp_ce_militaryyear>0
list countryn year exp_ce_military exp_ce_militaryyear sourcen if exp_ce_military>0&exp_ce_militaryyear<1
list countryn year exp_ce_private exp_ce_privateyear sourcen if exp_ce_private==0&exp_ce_privateyear>0
list countryn year exp_ce_private exp_ce_privateyear sourcen if exp_ce_private>0&exp_ce_privateyear<1
list countryn year exp_ce_manager exp_ce_manageryear sourcen if exp_ce_manager==0&exp_ce_manageryear>0
list countryn year exp_ce_manager exp_ce_manageryear sourcen if exp_ce_manager>0&exp_ce_manageryear<1
