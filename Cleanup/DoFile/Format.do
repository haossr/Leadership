
*/
cd ..\WorkingData
**********************************************************************
*********1. variables
**********************************************************************
drop if countryn =="."
keep countryn country year cen elig_citizen elig_edu elig_inc elig_exp elig_end elig_ocu elig_age elig_reg elig_crm edu_ce edu_ceyear edu_cemajor firstterm_ce length_ce exp_ce_public exp_ce_publicyear exp_ce_vice exp_ce_viceyear exp_ce_minister exp_ce_ministeryear exp_ce_legis exp_ce_legisyear exp_ce_governor exp_ce_governoryear exp_ce_Ngovernor exp_ce_leglocalyear exp_ce_party exp_ce_partyyear exp_ce_central exp_ce_centralyear exp_ce_military exp_ce_militaryyear exp_ce_private exp_ce_privateyear exp_ce_manager exp_ce_manageryear ocu_ce_sector posttenurefate careerafter gender_ce birthyear_ce religion_ce elig_race Nterm_ce exp_ce_sector sourcefile sourcen source sourcefile_n filename ismerge
sort countryn year
save Leadership_temp.dta,replace
**********************************************************************
*********1. format      
**********************************************************************
use Leadership_temp.dta,clear
bysort countryn: keep if _n==1
keep countryn year country source* filename
expand 60
bysort countryn: replace year = 1949+_n
sort countryn year
merge countryn year using Leadership_temp.dta
capture drop _merge
/*tostring _all, replace
foreach var of varlist _all{
	*capture count if `var' =="?"
	*disp `var'
	replace `var'="." if `var' =="?"
	replace `var'="." if `var' =="£¿"
	replace `var'="." if `var' ==""
	replace `var'="." if `var' ==" "	
	replace `var'="." if `var' =="/"	
	
	capture replace `var' = itrim(`var')
	capture replace `var' = rtrim(`var')
	capture replace `var' = ltrim(`var')
}
destring _all, replace
*/

replace countryn = proper(countryn)
replace cen = proper(cen)
bysort country year: drop if _n==2
order source* file*, after( exp_ce_sector)
drop sourcefile_n
replace  cen ="." if cen ==""
replace exp_ce_sector = ocu_ce_sector if exp_ce_sector ==.
replace ocu_ce_sector = exp_ce_sector if ocu_ce_sector ==.

**********************************************************************
*********3. source
**********************************************************************
use Leadership_temp, clear
sort country
capture drop source sourcen filename
merge m:1 country using ..\ReferenceData\Task.dta
drop _merge
sort sourcefile
merge m:1 sourcefile using ..\ReferenceData\filename.dta
drop _merge
order source* file*, after( exp_ce_sector)
drop if year>2010
drop if year<1950
save ..\Leadership, replace
save ..\..\Merge\RawData\Leadership, replace
