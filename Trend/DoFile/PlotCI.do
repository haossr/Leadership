clear all
set trace off
set more off

cd D:\GitHub\Leadership\Trend\WorkingData
use correlation.dta, clear
recode age (30/39 = 1 "30-39") (40/49 = 2 "40-49") (50/59 = 3 "50-59") (60/69 = 4 "60-69") (70/79 = 5 "70-79") (nonmissing =.), gen(age_range)
#delimit ;
	ciplot gdp_d, by (age_range)
	title("Growth rate(GDP)/age") 
	subtitle("Overall")
	xtitle("")
	ytitle("Growth rate")
	;
#delimit cr
graph export ..\Graph\CI_age_all.png, replace

#delimit ;
	ciplot gdp_d if democracy, by (age_range)
	title("Growth rate(GDP)/age") 
	subtitle("Democratic countries")
	xtitle("")
	ytitle("Growth rate")
	;
#delimit cr
graph export ..\Graph\CI_age_d.png, replace

#delimit ;
	ciplot gdp_d if !democracy, by (age_range)
	title("Growth rate(GDP)/age") 
	subtitle("Non-democratic countries")
	xtitle("")
	ytitle("Growth rate")
	;
#delimit cr
graph export ..\Graph\CI_age_nd.png, replace


#delimit ;
	ciplot gdp_d if Nterm_ce>0 & Nterm_ce<6, by (Nterm_ce)
	title("Growth rate(GDP)/number of terms") 
	subtitle("Overall")
	xtitle("Number of Terms")
	ytitle("Growth rate")
	;
#delimit cr
graph export ..\Graph\CI_term_all.png, replace

#delimit ;
	ciplot gdp_d if Nterm_ce>0 & Nterm_ce<6 & democracy, by (Nterm_ce)
	title("Growth rate(GDP)/number of terms") 
	subtitle("Democratic countries")
	xtitle("Number of Terms")
	ytitle("Growth rate")
	;
#delimit cr
graph export ..\Graph\CI_term_d.png, replace

#delimit ;
	ciplot gdp_d if Nterm_ce>0 & Nterm_ce<6 & !democracy, by (Nterm_ce)
	title("Growth rate(GDP)/number of terms") 
	subtitle("Non-democratic countries")
	xtitle("Number of Terms")
	ytitle("Growth rate")
	;
#delimit cr
graph export ..\Graph\CI_term_nd.png, replace



