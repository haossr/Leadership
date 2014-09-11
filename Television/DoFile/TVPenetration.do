clear all
set more off
cd "D:\GitHub\Leadership\Television\WorkingData"

forvalue year = 1975(1)2005{
	insheet using "..\RawData\TVPenetration\\`year'.csv", clear
	save `year'.dta, replace
}

use 1975.dta, clear
forvalue year = 1976(1)2005{
	append using `year'.dta
}

rename date year
replace amount = subinstr(amount, "%", "", 1)
destring amount, replace

save TVPenetration.dta, replace
