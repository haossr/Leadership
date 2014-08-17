drop _all
clear all
set more off
set trace on
cd "E:\Dropbox\Project-Leadership\Data-Cleanup\RawData"
**********************************************************************
**Data -55 El Salvador-SJN: cen->countryn
**********************************************************************

**********************************************************************
**************  1. get the list of filename    ***********************
**********************************************************************
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
save ../WorkingData/filename.dta,replace


**********************************************************************
**************  2. exl2dta                     ***********************
**********************************************************************
clear all
cd "E:\Dropbox\Project-Leadership\Data-Cleanup\RawData" //简化CD部分
local file : dir . files "*", nofail
local obs=1
foreach f of local file {
	cd "E:\Dropbox\Project-Leadership\Data-Cleanup\RawData"
	capture import excel "`f'", sheet("Individuals") firstrow allstring clear
	if !_rc{ //For more than one sheet: Sheet "Individuals"
		cd "E:\Dropbox\Project-Leadership\Data-Cleanup\WorkingData"	
		
		capture drop if cen ==""
		capture drop if year ==""
		capture gen year = 2010 - _N + _n //如果缺少year变量，根据序号生成
		tostring year, replace
		sort year
		save `obs'-2.dta, replace
		clear
		
		cd "E:\Dropbox\Project-Leadership\Data-Cleanup\RawData"
		import excel "`f'", sheet("Institution") firstrow allstring clear
		
		cd "E:\Dropbox\Project-Leadership\Data-Cleanup\WorkingData"	
		capture drop if cen ==""
		capture drop if year ==""
		capture gen year = 2010 - _N + _n //如果缺少year变量，根据序号生成
		tostring year,replace
		sort year
		save `obs'-1.dta, replace
		
		merge 1:1 year using `obs'-2.dta
		drop _merge
		gen sourcefile = `obs'
		save `obs'.dta, replace
		clear
	}
	
	else{	
		cd "E:\Dropbox\Project-Leadership\Data-Cleanup\RawData"
		import excel "`f'", firstrow allstring clear
		
		cd "E:\Dropbox\Project-Leadership\Data-Cleanup\WorkingData"	
		capture gen year = 1949 + _n if _N ==61//如果缺少year变量，根据序号生成
		gen sourcefile = `obs'
		save `obs'.dta, replace
		clear
	}
	local obs=`obs'+1
	sca no = `obs'
}

**********************************************************************
**************  3. merge                       ***********************
**********************************************************************

cd "E:\Dropbox\Project-Leadership\Data-Cleanup\WorkingData"	
use 1.dta,clear
local i = 2
while `i' <no{
	append using `i'.dta 
	local i = `i'+1
}


**********************************************************************
**************  4. variable                    ***********************
**********************************************************************
keep country countryn year cen elig_* edu_* firstterm_ce Nterm_ce length_ce exp_ce_* ocu_ce_sector posttenurefate careerafter gender_ce	birthyear_ce religion_ce source*


