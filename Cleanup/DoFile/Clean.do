*set more off
*set trace on
*clear all

cd "E:\Dropbox\Project-Leadership\Data-Cleanup\WorkingData"
use Leadership_merged.dta,clear
set trace on
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

**********************************************************************
*********2'. add source                
**********************************************************************
capture destring country, replace
sort country
merge m:1 country using E:\Dropbox\Project-Leadership\Data-Cleanup\WorkingData\Task.dta
drop _merge
sort sourcefile
merge m:1 sourcefile using E:\Dropbox\Project-Leadership\Data-Cleanup\WorkingData\filename.dta
drop _merge

************************************************************
********2.error: messy code, ASCII, strange symbols and extra space
************************************************************
tostring _all, replace
foreach var of varlist _all{
	*capture count if `var' =="?"
	*disp `var'
	replace `var'="." if `var' =="?"
	replace `var'="." if `var' =="?"
	replace `var'="." if `var' =="？"
	replace `var'="." if `var' ==""
	replace `var'="." if `var' ==" "	
	replace `var'="." if `var' =="/"	
	replace `var'="." if `var' =="-"	
	
	capture replace `var' = trim(`var')
	*capture replace `var' = itrim(`var')
	*capture replace `var' = rtrim(`var')
	*capture replace `var' = ltrim(`var')
}


************************************************************
********3.error: import(check)
************************************************************
destring ismerge source, replace
tab filename if ismerge==0 & source <5

************************************************************
********4.error: exp_ce_sector
************************************************************
capture replace ocu_ce_sector = exp_ce_sector if expce_ce_sector!="."


************************************************************
********5.error: sequence in excel, for numeric type
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
*local Boole elig_citizen elig_edu elig_inc elig_exp elig_end elig_ocu elig_age elig_reg elig_crm elig_race exp_ce_public exp_ce_vice exp_ce_minister exp_ce_legis exp_ce_governor exp_ce_party exp_ce_central exp_ce_military exp_ce_private exp_ce_manager 
local var2check  countryn country year cen edu_ce edu_ceyear edu_cemajor firstterm_ce exp_ce_public exp_ce_publicyear exp_ce_vice exp_ce_viceyear exp_ce_minister exp_ce_ministeryear exp_ce_legis exp_ce_legisyear exp_ce_governor exp_ce_governoryear exp_ce_Ngovernor exp_ce_leglocalyear exp_ce_party exp_ce_partyyear exp_ce_central exp_ce_centralyear exp_ce_military exp_ce_militaryyear exp_ce_private exp_ce_privateyear exp_ce_manager exp_ce_manageryear ocu_ce_sector posttenurefate careerafter gender_ce birthyear_ce religion_ce sourcefile elig_race Nterm_ce exp_ce_sector
*length_ce
foreach var of var `var2check'{
*foreach var of varlist _all{
	disp "`var'"
	
	if "`var'"=="year"{
		continue
	}
	
	if "`var'"!="country"{
		local baseline country
	}
	else{
		local baseline countryn
	}
	
	capture bysort country: gen indic`var' = `var'- year
		if _rc{
			continue
		}
	
		gen Gn`var' = -1
		gen n`var' = -1
		bysort country (year): gen `var'_n = _n
		
		//
		*bysort country indic`var': gen indic`var'N = _N
		*bysort country indic`var' (year): replace `var' = `var'[1] if _N>=3 & `var'[1]!=.
		bysort `baseline' (year): replace Gn`var' = 1 if _n==1
		//有没有办法让bysort后面有多重判断
		*bysort country (year): if _n ==1 {replace Gn`var' = 1}else{if indic`var'[_n] == indic`var'[_n-1]{replace Gn`var' = Gn`var'[_n-1]}else{replace Gn`var' = Gn`var'[_n-1] + 1}}
		
		forvalues i = 1(1)60{
			bysort `baseline' (year): replace Gn`var' = Gn`var'[_n-1] if indic`var'[_n] == indic`var'[_n-1] & _n!=1
			bysort `baseline' (year): replace Gn`var' = Gn`var'[_n-1] if indic`var'[_n] == indic`var'[_n-1] & _n!=1
			bysort `baseline' (year): replace Gn`var' = Gn`var'[_n-1] + 1 if indic`var'[_n] != indic`var'[_n-1] & _n!=1
			
			bysort `baseline' (year): replace n`var' = 1 if _n==1
			bysort `baseline' (year): replace n`var' = n`var'[_n-1] + 1  if indic`var'[_n] == indic`var'[_n-1] & _n!=1
			bysort `baseline' (year): replace n`var' = 1 if indic`var'[_n] != indic`var'[_n-1] & _n!=1
		}
		bysort `baseline' (year): egen N`var' = max(n`var')
		sum N`var' if `var'!=. , d
		gen err_excel`var' = 0
		*replace err_excel`var' = 1 if N`var' > r(p95)+2*r(sd) & `var'!=.
		replace err_excel`var' = 1 if n`var' > 1 & N`var'>=3 & `var'!=.
		replace `var' = `var'[_n -n`var'] if n`var' > 1 & N`var'>=3 & `var'!=.
	*drop indic`var'
}

foreach var of var `var2check'{
	capture tab n`var' if `var'!=.
}

foreach var of var err_excel*{
	capture tab `var'
}
drop err_excel*
