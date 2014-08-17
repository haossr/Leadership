set more off
set trace on
clear all
cd "E:\Dropbox\Project-Leadership\Data-Cleanup\WorkingData"

use Leadership.dta,clear

**********************************************************************
*********1.countryn<->country
**********************************************************************
gen cnlen = length(countryn)
gen clen = length(country)
gen temp = countryn if cnlen<clen
replace countryn = country if cnlen<clen
replace country = temp if cnlen<clen
destring country, replace
drop temp cnlen clen

* source
sort country
merge m:1 country using Task.dta
drop _merge

************************************************************
********2.messy code, ASCII, strange symbols
************************************************************
tostring _all, replace
foreach var of varlist _all{
	*capture count if `var' =="?"
	*disp `var'
	replace `var'="." if `var' =="?"
	replace `var'="." if `var' =="£¿"
	replace `var'="." if `var' ==""
	replace `var'="." if `var' ==" "	
	replace `var'="." if `var' =="/"	
	
}
************************************************************
********3.exp_ce_sector
************************************************************
replace ocu_ce_sector = exp_ce_sector if sourcen == "YML"
count if exp_ce_private!="1" && ocu_ce_sector!=""

************************************************************
********4.error: drop to generate in excel, for Boolean type
************************************************************
set varabbrev off //incase ambiguous abbreviation in `Boole'
destring _all, replace
/*local Boole ""
foreach var of varlist _all{
	local tp`var': type `var'
	di "`tp`var''"
	if "`tp`var''"=="byte"{
		local Boole = "`Boole'"+" "+"`var'"
	di "`Boole'"
	}
}
*/
local Boole elig_citizen elig_edu elig_inc elig_exp elig_end elig_ocu elig_age elig_reg elig_crm elig_race exp_ce_public exp_ce_vice exp_ce_minister exp_ce_legis exp_ce_governor exp_ce_party exp_ce_central exp_ce_military exp_ce_private exp_ce_manager 

foreach var of var `Boole'{
	bysort country: gen indic`var' = `var'- year
	*sort country year
	*sort year
	bysort country indic`var' (year): replace `var' = `var'[1] 
}
drop indic*
