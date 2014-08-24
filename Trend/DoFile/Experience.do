cd ..\WorkingData\

************************************************************************
*************** Trend: Age and gender
************************************************************************
*5.1
use age_gender, clear
keep age age_d age_nd year
#delimit ;
	twoway (line age* year), 
	title("Age and gender") 
	subtitle("Trend of age");
#delimit cr
graph export ..\Graph\4_1.png, replace


*4.2
use age_gender, clear
keep age age_oecd age_noecd year
#delimit ;
	twoway (line age* year), 
	title("Age and gender") 
	subtitle("Trend of age");
#delimit cr
graph export ..\Graph\4_2.png, replace


*4.3
use age_gender, clear
keep hage_firstterm_d hage_firstterm_nd age_firstterm_d age_firstterm_nd lage_firstterm_d lage_firstterm_nd year
#delimit ;
	twoway (rarea lage_firstterm_d hage_firstterm_d year, sort bcolor(gs14))
	(line age_firstterm_d year),
	title("Age and gender") 
	subtitle("Trend of age, upon taking office")
	legend(label (1 "%95 CI")) ;
#delimit cr
graph export ..\Graph\4_3_1.png, replace
#delimit ;
	twoway (rarea lage_firstterm_nd hage_firstterm_nd year, sort bcolor(gs14))
	(line age_firstterm_nd year),
	title("Age and gender") 
	subtitle("Trend of age, upon taking office")
	legend(label (1 "%95 CI")) ;
#delimit cr
graph export ..\Graph\4_3_2.png, replace


*4.4
use age_gender, clear
keep hage_firstterm_oecd hage_firstterm_noecd age_firstterm_oecd age_firstterm_noecd lage_firstterm_oecd lage_firstterm_noecd year
#delimit ;
	twoway (rarea lage_firstterm_oecd hage_firstterm_oecd year, sort bcolor(gs14))
	(line age_firstterm_oecd year),
	title("Age and gender") 
	subtitle("Trend of age, upon taking office")
	legend(label (1 "%95 CI")) ;
#delimit cr
graph export ..\Graph\4_4_1.png, replace

#delimit ;
	twoway (rarea lage_firstterm_noecd hage_firstterm_noecd year, sort bcolor(gs14))
	(line age_firstterm_noecd year),
	title("Age and gender") 
	subtitle("Trend of age, upon taking office")
	legend(label (1 "%95 CI")) ;
#delimit cr
graph export ..\Graph\4_4_2.png, replace

*4.5
use age_gender, clear
keep hage_left_d hage_left_nd age_left_d age_left_nd lage_left_d lage_left_nd year
#delimit ;
	twoway (rarea lage_left_d hage_left_d year, sort bcolor(gs14))
	(line age_left_d year),
	title("Age and gender") 
	subtitle("Trend of age, upon leaving office")
	legend(label (1 "%95 CI")) ;
#delimit cr
graph export ..\Graph\4_5_1.png, replace

#delimit ;
	twoway (rarea lage_left_nd hage_left_nd year, sort bcolor(gs14))
	(line age_left_nd year),
	title("Age and gender") 
	subtitle("Trend of age, upon leaving office")
	legend(label (1 "%95 CI")) ;
#delimit cr
graph export ..\Graph\4_5_2.png, replace


*4.6
use age_gender, clear
keep hage_left_oecd hage_left_noecd age_left_oecd age_left_noecd lage_left_oecd lage_left_noecd year
#delimit ;
	twoway (rarea lage_left_oecd hage_left_oecd year, sort bcolor(gs14))
	(line age_left_oecd year),
	title("Age and gender") 
	subtitle("Trend of age, upon leaving office")
	legend(label (1 "%95 CI")) ;
#delimit cr
graph export ..\Graph\4_6_1.png, replace

#delimit ;
	twoway (rarea lage_left_noecd hage_left_noecd year, sort bcolor(gs14))
	(line age_left_noecd year),
	title("Age and gender") 
	subtitle("Trend of age, upon leaving office")
	legend(label (1 "%95 CI")) ;
#delimit cr
graph export ..\Graph\4_6_2.png, replace

*4.7
use age_gender, clear
keep gender_d gender_nd year
#delimit ;
	twoway (line gender* year), 
	title("Age and gender") 
	subtitle("Female ratio");
#delimit cr
graph export ..\Graph\4_7.png, replace


*4.8
use age_gender, clear
keep gender_oecd gender_noecd year
#delimit ;
	twoway (line gender* year), 
	title("Age and gender") 
	subtitle("Female ratio");
#delimit cr
graph export ..\Graph\4_8.png, replace

