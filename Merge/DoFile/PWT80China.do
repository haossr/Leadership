clear all
set more off
cd D:\GitHub\Leadership\Merge\WorkingData
use pwt80.dta

*ini
drop if year < 1979 | year >2011
egen PWT = group(PWTCode)
xtset PWT year

gen rgdp = rgdpe
**The following matrix is done concerning per capita gdpo
gen pcgdp = rgdp/pop

bysort year (pcgdp): gen pcgdpR = _N - _n
bysort year (pcgdp): gen pcgdpP = (_N - _n)/ _N

label variable pcgdpR "Rank of Per Capita GDP"
label variable pcgdpP "Quantile of Per Capita GDP"

save PWTChina.dta, replace

*0.rank and quantile
use PWTChina.dta, clear
/*
twoway (line rgdp year if PWTCode =="CHN", sort)
#delimit ;
twoway 
(line pcgdpR year if PWTCode =="CHN", sort yaxis(1))
(line pcgdpP year if PWTCode =="CHN", sort yaxis(2))
;
#delimit cr
*/
export excel country year rgdp pcgdpR pcgdpP if PWTCode=="CHN" using "..\Output\Rank and Quantile of China's pcGDP.xls", firstrow(varlabels) replace

*1.surpassing
gen CHN = 0
gen USA = 0 
replace CHN = 1 if PWTCode=="CHN"
replace USA = 1 if PWTCode=="USA"

bysort year (CHN): gen pcgdpC = pcgdp[_n]/pcgdp[_N]
bysort year (USA): gen pcgdpU = pcgdp[_n]/pcgdp[_N]

gen surpassed = 0 
gen surpassed2011 = 0
bysort PWTCode (year): replace surpassed = 1 if (pcgdpC[_n-1] > 1 & pcgdpC[_n]<1)
bysort PWTCode (year): replace surpassed2011 = 1 if (pcgdpC[1] > 1 & pcgdpC[_N]<1)

count if surpassed ==1 & year>1979
count if surpassed2011 == 1 & year==2011
preserve
keep if surpassed
drop if year==1979
sort year
export excel country year using "..\Output\Country surpassed by China(each year).xls", firstrow(varlabels) replace
restore

*2.ratio: CN as benchmark
keep if (year == 2011|year==1979)
keep country year pcgdpU pcgdpC
reshape wide pcgdpU pcgdpC, i(country) j(year)
gen d_pcgdpC = (pcgdpC2011-pcgdpC1979)/pcgdpC1979
*list if pcgdpC2011>pcgdpC1979 & pcgdpC1979>1
label variable pcgdpC1979 "Per Capita GDP at 1979 compared with China"
label variable pcgdpC2011 "Per Capita GDP at 2011 compared with China"
label variable d_pcgdpC "Growth rate of pcGDP1979-2011(CN as benchmark)"

gsort -d_pcgdpC
export excel country d_pcgdpC pcgdpC1979 pcgdpC2011 if d_pcgdpC!=. using "..\Output\Growth rate of pcGDP1979-2011(CN as benchmark).xls", firstrow(varlabels) replace

*3.ratio: US as benchmark
gen d_pcgdpU = (pcgdpU2011-pcgdpU1979)/pcgdpU1979
label variable pcgdpU1979 "Per Capita GDP at 1979 compared with U.S."
label variable pcgdpU2011 "Per Capita GDP at 2011 compared with U.S."
label variable d_pcgdpU "Growth rate of pcGDP1979-2011(US as benchmark)"

gsort -d_pcgdpU
export excel country d_pcgdpU pcgdpU1979 pcgdpU2011 if d_pcgdpU!=. using "..\Output\Growth rate of pcGDP1979-2011(US as benchmark).xls", firstrow(varlabels) replace
export excel country if pcgdpC1979>1 & pcgdpC2011<1 &pcgdpC1979!=. using "..\Output\Country surpassed by China(1979-2011).xls", firstrow(varlabels) replace
















/*
capture drop developed
gen developed = 0
bysort PWT (year): replace developed = 1 if pcgdpC[1]>=1
preserve
keep if developed
capture drop lgpcgdpC

gen lgpcgdpC = log(pcgdpC)
#delimit ;
xtline lgpcgdpC, 
overlay
legend(off)
;
#delimit cr


restore

*3.
keep if (year == 2011|year==1979)
bysort PWT (year):gen noyear = _N
drop if noyear <2
drop noyear
bysort PWT (year):gen d_pcgdpU = (pcgdpU[2]-pcgdpU[1])/pcgdpU[1]
bysort PWT (year):gen pcgdpU1973 = pcgdpU[1]
bysort PWT (year):gen pcgdpU2011 = pcgdpU[2]
drop if year ==2011


scatter pcgdpU1973 pcgdpU2011
sort d_pcgdpU
label variable d_pcgdpU "Growth rate of pcGDP(US as benchmark)" 

