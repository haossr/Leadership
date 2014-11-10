clear all
set more off
cd D:\GitHub\Leadership\Merge\WorkingData



*Task 1.1
use pwt80.dta, clear
drop if year < 1979 | year >2011

gen rgdp = rgdpe
gen pcgdp = rgdp/pop
keep PWTCode country year pcgdp

bysort country (year): gen GrowthRate = (pcgdp[_N]/pcgdp[1])^(1/32)-1
keep if year == 2011
keep if GrowthRate !=.
replace GrowthRate = GrowthRate/2 if PWTCode =="CHN"

expand 21
bysort country: replace year = year[1]+_n-1
bysort country (year): replace pcgdp = pcgdp[_n-1] * (1+GrowthRate) if _n>1

gen CHN = 0
replace CHN = 1 if PWTCode=="CHN"

bysort year (CHN): gen pcgdpC = pcgdp[_n]/pcgdp[_N]

gen surpassed = 0 
gen surpassed2011 = 0
bysort PWTCode (year): replace surpassed = 1 if (pcgdpC[_n-1] > 1 & pcgdpC[_n]<1)
bysort PWTCode (year): replace surpassed2011 = 1 if (pcgdpC[1] > 1 & pcgdpC[_N]<1)

count if surpassed ==1 & year>2011
keep if surpassed
drop if year==2011
sort year
export excel country year using "..\Output\Country surpassed by China predicted1(each year).xls", firstrow(varlabels) replace

*Task 1.2
use pwt80.dta, clear
drop if year < 1979 | year >2011

gen rgdp = rgdpe
gen pcgdp = rgdp/pop
keep PWTCode country year pcgdp


bysort country (year): gen GrowthRate = (pcgdp[_N]/pcgdp[1])^(1/32)-1
drop if year<2003
bysort country (year): gen GrowthRate2 = (pcgdp[_N-4]/pcgdp[1])^(1/32)-1


keep if year == 2011
keep if GrowthRate !=.
replace GrowthRate = GrowthRate2 if PWTCode!="CHN"
replace GrowthRate = GrowthRate/2 if PWTCode =="CHN"

expand 21
bysort country: replace year = year[1]+_n-1
bysort country (year): replace pcgdp = pcgdp[_n-1] * (1+GrowthRate) if _n>1


gen CHN = 0
replace CHN = 1 if PWTCode=="CHN"

bysort year (CHN): gen pcgdpC = pcgdp[_n]/pcgdp[_N]

gen surpassed = 0 
gen surpassed2011 = 0
bysort PWTCode (year): replace surpassed = 1 if (pcgdpC[_n-1] > 1 & pcgdpC[_n]<1)
bysort PWTCode (year): replace surpassed2011 = 1 if (pcgdpC[1] > 1 & pcgdpC[_N]<1)

count if surpassed ==1 & year>2011
keep if surpassed
drop if year==2011
sort year
export excel country year using "..\Output\Country surpassed by China predicted2(each year).xls", firstrow(varlabels) replace


*Task 1.3
use pwt80.dta, clear
drop if year < 1979 | year >2011

gen rgdp = rgdpe
gen pcgdp = rgdp/pop
keep PWTCode country year pcgdp


bysort country (year): gen GrowthRate = (pcgdp[_N]/pcgdp[1])^(1/32)-1
drop if year<2003
bysort country (year): gen GrowthRate2 = (pcgdp[_N-4]/pcgdp[1])^(1/32)-1


keep if year == 2011
keep if GrowthRate !=.
replace GrowthRate = 0.04 if PWTCode =="CHN"

expand 21
bysort country: replace year = year[1]+_n-1
bysort country (year): replace pcgdp = pcgdp[_n-1] * (1+GrowthRate) if _n>1


gen CHN = 0
replace CHN = 1 if PWTCode=="CHN"

bysort year (CHN): gen pcgdpC = pcgdp[_n]/pcgdp[_N]

gen surpassed = 0 
gen surpassed2011 = 0
bysort PWTCode (year): replace surpassed = 1 if (pcgdpC[_n-1] > 1 & pcgdpC[_n]<1)
bysort PWTCode (year): replace surpassed2011 = 1 if (pcgdpC[1] > 1 & pcgdpC[_N]<1)

count if surpassed ==1 & year>2011
keep if surpassed
drop if year==2011
sort year
export excel country year using "..\Output\Country surpassed by China predicted3(each year).xls", firstrow(varlabels) replace


*Task 1.4
use pwt80.dta, clear
drop if year < 1979 | year >2011

gen rgdp = rgdpe
gen pcgdp = rgdp/pop
keep PWTCode country year pcgdp


bysort country (year): gen GrowthRate = (pcgdp[_N]/pcgdp[1])^(1/32)-1
drop if year<2003
bysort country (year): gen GrowthRate2 = (pcgdp[_N-4]/pcgdp[1])^(1/32)-1


keep if year == 2011
keep if GrowthRate !=.
replace GrowthRate = 0.05 if PWTCode =="CHN"

expand 21
bysort country: replace year = year[1]+_n-1
bysort country (year): replace pcgdp = pcgdp[_n-1] * (1+GrowthRate) if _n>1


gen CHN = 0
replace CHN = 1 if PWTCode=="CHN"

bysort year (CHN): gen pcgdpC = pcgdp[_n]/pcgdp[_N]

gen surpassed = 0 
gen surpassed2011 = 0
bysort PWTCode (year): replace surpassed = 1 if (pcgdpC[_n-1] > 1 & pcgdpC[_n]<1)
bysort PWTCode (year): replace surpassed2011 = 1 if (pcgdpC[1] > 1 & pcgdpC[_N]<1)

count if surpassed ==1 & year>2011
keep if surpassed
drop if year==2011
sort year
export excel country year using "..\Output\Country surpassed by China predicted4(each year).xls", firstrow(varlabels) replace


*Task 2
use Leadership_8.dta, clear
drop if year < 1979 | year >2011

gen rgdp = rgdpe
gen pcgdp = rgdp/pop

bysort country (year): gen GrowthRate = (pcgdp[_N]/pcgdp[1])^(1/32)-1

local varl CC RL agedem stra polity2 xconst
foreach var in  `varl'{
	 bysort country: egen `var'a = mean(`var')
	 winsor2 `var'a, replace cuts(5 95)
	 replace `var' = `var'a
	 two (scatter GrowthRate `var' if PIPECode!=79, mlabel(PWTCode) m(i))(scatter GrowthRate `var' if PIPECode==79, mlabel(PWTCode) mlabcolor(red) m(i))(lfit GrowthRate `var')
	 graph export ..\Graph\Growth_`var'.png, replace
}
