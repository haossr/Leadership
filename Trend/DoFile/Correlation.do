cd ..\WorkingData\
************************************************************************
*************** Trend: Correlation
************************************************************************


*6.1
use correlation.dta, clear
keep if year == 2008

#delimit ;
	twoway
	(scatter GDP_pc eligibility)
	(lfit GDP_pc eligibility)
	(qfit GDP_pc eligibility),
	title("GDP per Capita/Eligibility, Year 2008") 
	ytitle("GDP per Capita")
	xtitle("Eligibility")
	legend(label (1 "Observation") label (2 "Linear fit") label (3 "Quadratic fit")) 
	;
#delimit cr

*6.2
use correlation.dta, clear
keep if year == 1989
reg GDP_pc eligibility 
predict GDP_pc_hat 
#delimit ;
	twoway
	(scatter GDP_pc eligibility)
	(lfit GDP_pc eligibility)
	(qfit GDP_pc eligibility),
	title("GDP per Capita/Eligibility, Year 2008") 
	ytitle("GDP per Capita")
	xtitle("Eligibility")
	legend(label (1 "Observation") label (2 "Linear fit") label (3 "Quadratic fit")) 
	;
#delimit cr

*6.3
use correlation.dta, clear
keep if year>1991
drop if PIPECode==.
tsset PIPECode year, yearly
gen gdp_d = D.GDP/L.GDP
*gen gdp_d2 = ln(GDP/L.GDP)
collapse (mean)edu_ceyear (mean)gdp_d, by(PIPECode)
*reg gdp_d edu_ceyear
*predict gdp_d_hat
#delimit ;
	twoway
	(scatter gdp_d edu_ceyear)
	(lfit gdp_d edu_ceyear)
	(qfit gdp_d edu_ceyear),
	title("Growth rate of GDP/Years of Education, after 1991") 
	ytitle("Growth rate of GDP")
	xtitle("Years of Education(on average)")
	legend(label (1 "Observation") label (2 "Linear fit") label (3 "Quadratic fit")) 
	;
#delimit cr

*6.4
use correlation.dta, clear
keep if year<1991
drop if PIPECode==.
tsset PIPECode year, yearly
gen gdp_d = D.GDP/L.GDP
*gen gdp_d2 = ln(GDP/L.GDP)
collapse (mean)edu_ceyear (mean)gdp_d, by(PIPECode)
#delimit ;
	twoway
	(scatter gdp_d edu_ceyear)
	(lfit gdp_d edu_ceyear)
	(qfit gdp_d edu_ceyear),
	title("Growth rate of GDP/Years of Education, after 1991") 
	ytitle("Growth rate of GDP")
	xtitle("Years of Education(on average)")
	legend(label (1 "Observation") label (2 "Linear fit") label (3 "Quadratic fit")) 
	;
#delimit cr

*6.5
use correlation.dta, clear
keep if democracy == 1
keep if year>1991
drop if PIPECode==.
tsset PIPECode year, yearly
gen gdp_d = D.GDP/L.GDP
*gen gdp_d2 = ln(GDP/L.GDP)
collapse (mean)edu_ceyear (mean)gdp_d, by(PIPECode)
#delimit ;
	twoway
	(scatter gdp_d edu_ceyear)
	(lfit gdp_d edu_ceyear)
	(qfit gdp_d edu_ceyear),
	title("Growth rate of GDP/Years of Education, after 1991") 
	ytitle("Growth rate of GDP")
	xtitle("Years of Education(on average)")
	legend(label (1 "Observation") label (2 "Linear fit") label (3 "Quadratic fit")) 
	;
#delimit cr

*6.6
use correlation.dta, clear
keep if democracy == 1
keep if year<1991
drop if PIPECode==.
tsset PIPECode year, yearly
gen gdp_d = D.GDP/L.GDP
*gen gdp_d2 = ln(GDP/L.GDP)
collapse (mean)edu_ceyear (mean)gdp_d, by(PIPECode)
#delimit ;
	twoway
	(scatter gdp_d edu_ceyear)
	(lfit gdp_d edu_ceyear)
	(qfit gdp_d edu_ceyear),
	title("Growth rate of GDP/Years of Education, after 1991") 
	ytitle("Growth rate of GDP")
	xtitle("Years of Education(on average)")
	legend(label (1 "Observation") label (2 "Linear fit") label (3 "Quadratic fit")) 
	;
#delimit cr

*6.7
use correlation.dta, clear
keep if democracy == 0
keep if year>1991
drop if PIPECode==.
tsset PIPECode year, yearly
gen gdp_d = D.GDP/L.GDP
*gen gdp_d2 = ln(GDP/L.GDP)
collapse (mean)edu_ceyear (mean)gdp_d, by(PIPECode)
#delimit ;
	twoway
	(scatter gdp_d edu_ceyear)
	(lfit gdp_d edu_ceyear)
	(qfit gdp_d edu_ceyear),
	title("Growth rate of GDP/Years of Education, after 1991") 
	ytitle("Growth rate of GDP")
	xtitle("Years of Education(on average)")
	legend(label (1 "Observation") label (2 "Linear fit") label (3 "Quadratic fit")) 
	;
#delimit cr

*6.8
use correlation.dta, clear
keep if democracy == 0
keep if year<1991
drop if PIPECode==.
tsset PIPECode year, yearly
gen gdp_d = D.GDP/L.GDP
*gen gdp_d2 = ln(GDP/L.GDP)
collapse (mean)edu_ceyear (mean)gdp_d, by(PIPECode)
#delimit ;
	twoway
	(scatter gdp_d edu_ceyear)
	(lfit gdp_d edu_ceyear)
	(qfit gdp_d edu_ceyear),
	title("Growth rate of GDP/Years of Education, after 1991") 
	ytitle("Growth rate of GDP")
	xtitle("Years of Education(on average)")
	legend(label (1 "Observation") label (2 "Linear fit") label (3 "Quadratic fit")) 
	;
#delimit cr



*testing
use correlation.dta, clear
gen a1991=1
replace a1991 =0 if year<=1991
drop if PIPECode==.
tsset PIPECode year, yearly
gen gdp_d = D.GDP/L.GDP
*gen gdp_d2 = ln(GDP/L.GDP)
collapse (mean)edu_ceyear (mean)gdp_d, by(PIPECode democracy a1991)
*reg gdp_d edu_ceyear
*predict gdp_d_hat
#delimit ;
	twoway
	(scatter gdp_d edu_ceyear, msize(vsmall))
	(lfit gdp_d edu_ceyear)
	(qfit gdp_d edu_ceyear),
	by(democracy a1991,
		title("Growth rate of GDP/Years of Education, after 1991")
		legend(off)
		)
	ytitle("Growth rate of GDP")
	xtitle("Years of Education(on average)")
	
	
	;
#delimit cr
*legend(label (1 "Observation") label (2 "Linear fit") label (3 "Quadratic fit"))
