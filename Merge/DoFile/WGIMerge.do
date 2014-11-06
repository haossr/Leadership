
 
 
**********************************************************************
**************  a. download              ***********************
**********************************************************************

cd ..\RawData
*a.WGI.dta
/*
set timeout1 10
set timeout2 10
local var "NY.GDP.MKTP.KD CC.STD.ERR;CC.EST;CC.NO.SRC;CC.PER.RNK;GE.EST;GE.NO.SRC;GE.PER.RNK;GE.STD.ERR;PV.EST;PV.NO.SRC;PV.PER.RNK;PV.STD.ERR;RQ.EST;RQ.NO.SRC;RQ.PER.RNK;RQ.STD.ERR;RL.EST;RL.NO.SRC;RL.PER.RNK;RL.STD.ERR;VA.EST;VA.NO.SRC;VA.PER.RNK;VA.STD.ERR;"
wbopendata, language(en - English) country() topics() indicator(`var') clear long
save WGI.dta, replace
*/

use WGI\WGI.dta, clear

rename rl_est RL
drop rl_*

rename cc_est CC
drop cc_*

rename countrycode WorldBankCode

drop if WorldBankCode =="."
drop if year < 1950
sort WorldBankCode year

save ..\WorkingData\WGI.dta,replace

**********************************************************************
**************  b. merge and check             ***********************
**********************************************************************
cd ..\WorkingData
*b.1.Merge
use Leadership_7.dta, clear
sort WorldBankCode
replace WorldBankCode = "." if strlen(PolityIVCode)>3
drop if WorldBankCode=="."
drop if WorldBankCode == ""
capture drop _merge
merge 1:1 WorldBankCode year using WGI.dta
tab _merge
 
*b.2.Check
if testing{
	tab countryn_L if _merge==1
	tab year if _merge==1
	tab filename if _merge==1
}
drop if _merge==2
drop _merge
save Leadership_8.dta, replace
