drop _all
clear all
set more off
set trace on

*cd "E:\Dropbox\Project-Leadership\Data-Cleanup\RawData"
cd ..\RawData

**********************************************************************
**************  1. get the list of filename    ***********************
**********************************************************************
/*
quietly{
	local file : dir . files "*", nofail
	gen filename=""
	local obs=1
	foreach f of local file {
			set obs `obs'
			replace file="`f'" in `obs'
			local obs=`obs'+1
	}
}
gen soucefile =_n
save ../WorkingData/filename.dta,replace
*/

**********************************************************************
**************  2. exl2dta                     ***********************
**********************************************************************
clear all
local file : dir . files "*", nofail
local obs=1
cd ..\WorkingData
foreach f of local file {
	local f = "..\RawData\"+"`f'"
	clear
	capture import excel "`f'", sheet("Individuals") firstrow allstring 
	sca _rc1 = _rc
	capture import excel "`f'", sheet("Individual") firstrow allstring 
	if !(_rc) | !(_rc1){ //For more than one sheet: Sheet "Individuals"

		capture drop if cen ==""
		capture drop if year ==""
		capture gen year = 2010 - _N + _n //如果缺少year变量，根据序号生成
		tostring year, replace
		sort year
		save `obs'-2.dta, replace
		clear
		

		clear
		capture import excel "`f'", sheet("Institution") firstrow allstring 
		capture import excel "`f'", sheet("Institutions") firstrow allstring 
		
		capture drop if cen ==""
		capture drop if year ==""
		capture gen year = 2010 - _N + _n //如果缺少year变量，根据序号生成
		tostring year,replace
		sort year
		save `obs'-1.dta, replace
		
		merge 1:1 year using `obs'-2.dta
		drop _merge
		
		gen ismerge = 1
	}
	
	else{	

		import excel "`f'", firstrow allstring clear
		

		capture gen year = 1949 + _n if _N ==61//如果缺少year变量，根据序号生成
		
		gen ismerge = 0
	}
	
	gen sourcefile = `obs'
	replace cen ="#" if cen==countryn //处理领导人名字乱码
	
	*先统一所有变量名为小写
	rename _all, lower
	capture rename exp_ce_ngovernor exp_ce_Ngovernor 
	capture rename nterm_ce Nterm_ce //YSQ
	capture rename exp_cengovernor exp_ce_Ngovernor //ZTH
	save `obs'.dta, replace
	clear
	
	local obs=`obs'+1
	sca no = `obs'
}

**********************************************************************
**************  3. merge                       ***********************
**********************************************************************

cd ..\WorkingData
use 1.dta,clear
local i = 2
while `i' <no{
	append using `i'.dta 
	local i = `i'+1
}


**********************************************************************
**************  4. variable                    ***********************
**********************************************************************
*keep country countryn year cen elig_* edu_* firstterm_ce Nterm_ce length_ce exp_ce_* ocu_ce_sector posttenurefate careerafter gender_ce	birthyear_ce religion_ce source* ismerge


**********************************************************************
**************  5. save                        ***********************
**********************************************************************
save Leadership_merged.dta, replace

