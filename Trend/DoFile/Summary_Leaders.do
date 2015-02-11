cd ..\WorkingData\

************************************************************************
*************** Summary: Age and Experience
************************************************************************

use summary_age.dta, clear
set varabbrev off
*Table A.1
drop age_left age_firstterm
cd ..\Tables
logout, save(A1) excel replace: tabstat  age_d age_nd dage_d age_oecd age_noecd dage_oecd age_poll age_npoll dage_poll, by(year_G) statistics(mean sem)

*Table A.2
drop 
