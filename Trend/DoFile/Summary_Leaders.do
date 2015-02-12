cd ..\WorkingData\
set varabbrev off
************************************************************************
*************** Summary: Age and Experience
************************************************************************



*Table A.1
use summary_age.dta, clear
cd ..\Tables
logout, save(A1) excel replace: tabstat  age_d age_nd dage_d age_oecd age_noecd dage_oecd age_poll age_npoll dage_poll, by(year_G) statistics(mean sem)
cd ..\WorkingData\

*Table A.2
use summary_age.dta, clear
replace age_d = . if !firstterm_ce
replace age_nd = . if !firstterm_ce
cd ..\Tables
logout, save(A2) excel replace: tabstat  age_d length_ce_d length_ce_d_par length_ce_d_pre age_nd length_ce_nd length_ce_nd_par length_ce_nd_pre, by(year_G) statistics(mean sem)
cd ..\WorkingData\

*Table A.3
use summary_age.dta, clear
keep if firstterm_ce
cd ..\Tables
logout, save(A3) excel replace: tabstat  age_d exp_ce_publicyear_d exp_ce_privateyear_d dage_exp_d age_nd exp_ce_publicyear_nd exp_ce_privateyear_nd dage_exp_nd, by(year_G) statistics(mean sem)
cd ..\WorkingData\

*Table B.1
use summary_age.dta, clear
keep if firstterm_ce
cd ..\Tables
logout, save(B1) excel replace: tabstat  age_d exp_ce_publicyear_d exp_ce_privateyear_d dage_exp_d edu_ceyear_d rho_d, by(year_G) statistics(mean sem)
cd ..\WorkingData\

*Table B.2
use summary_age.dta, clear
keep if firstterm_ce
cd ..\Tables
logout, save(B2) excel replace: tabstat  age_nd exp_ce_publicyear_nd exp_ce_privateyear_nd dage_exp_nd edu_ceyear_nd rho_nd, by(year_G) statistics(mean sem)
cd ..\WorkingData\
