clear all
set more off
set trace off
cd "D:\GitHub\Leadership\Television\WorkingData"
use Leader_TV, clear
tsset PIPECode year 


forvalue divide = 1960(1)2000{
use Leader_TV, clear
tsset PIPECode year 
gen before = 1
replace before = 0 if year > `divide'
replace before =1 if year <= `divide'
keep if democracy
gen d_age_firstterm = d.age_firstterm
gen absd_age_firstterm = abs(d.age_firstterm)
gen d_TV = d.TVPenetration
*scatter d_age_firstterm d_TV if democracy & d_age_firstterm 
*scatter absd_age_firstterm d_TV if presi & d_age_firstterm 
*scatter d_age_firstterm d_TV if parli & d_age_firstterm 
gen se_age_firstterm = age_firstterm

bysort PIPECode before: egen mean_TV = mean(TVPenetration)
bysort PIPECode (year): gen D_TV = mean_TV[_N]-mean_TV[1]



collapse (mean)d_TV age age_firstterm age_left presi Population GDP_pc D_TV (semean)se_age_firstterm, by(country before)
gen presi_D_TV = presi*D_TV
sqreg age_firstterm presi presi_D_TV D_TV GDP_pc Population, q(0.1 0.9)
*sqreg se_age_firstterm presi presi_D_TV D_TV GDP_pc Population, q(0.1 0.9)
}
	
