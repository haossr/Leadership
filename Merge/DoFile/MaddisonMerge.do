**********************************************************************
**************  a. importing              ***********************
**********************************************************************
cd ..\WorkingData
import excel ..\RawData\Maddison\Maddison_Merged.xlsx, sheet("Population") firstrow clear
drop if Year==.
destring _all, replace
reshape long Var, i(Year) j(id)
drop if Year > 2008
rename Var Population
sort id Year
save Maddison_Population.dta, replace

import excel ..\RawData\Maddison\Maddison_Merged.xlsx, sheet("GDP") firstrow clear
drop if Year==.
destring _all, replace
reshape long Var, i(Year) j(id)
rename Var GDP
sort id Year
save Maddison_GDP.dta, replace


import excel ..\RawData\Maddison\Maddison_Merged.xlsx, sheet("GDP Per Capita") firstrow clear
drop if Year==.
destring _all, replace
reshape long Var, i(Year) j(id)
rename Var GDP_pc
sort id Year
save Maddison_GDP_perCapita.dta, replace

import excel ..\RawData\Maddison\Maddison_Merged.xlsx, sheet("Index") clear
rename A id 
rename B countryname
sort id
destring _all, replace
save Maddison_Index.dta, replace

**********************************************************************
**************  b. constructing
**********************************************************************
use Maddison_Population.dta, clear
merge 1:1 id Year using Maddison_GDP.dta
tab _merge
tab id Year if _merge==1
drop _merge

merge 1:1 id Year using Maddison_GDP_perCapita.dta
tab _merge
drop _merge

merge m:1 id using Maddison_Index.dta
tab _merge
drop _merge

rename Year year
rename id MaddisonCode
sort MaddisonCode year
save Maddison.dta, replace

**********************************************************************
**************  b. constructing
**********************************************************************
use Leadership_4.dta, clear
drop if year>2008
sort MaddisonCode year
merge MaddisonCode year using Maddison.dta
tab _merge
save Leadership_5.dta, replace
