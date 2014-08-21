cd ..\WorkingData\
set graphics on
************************************************************************
*************** Trend: Education
************************************************************************
*3.0
use education.dta, clear
drop edu_ce_N*
forvalue i =1/8{
	gen Nedu_ce_`i' = edu_ce_`i'
}
collapse (mean)edu_ce_* (sum)Nedu_ce_*, by(year)
save education_3_0.dta, replace

forvalue i =1/8{
label variable edu_ce_`i' "Frequency"
label variable Nedu_ce_`i' "# of obs"
#delimit ;
	twoway 
	(bar Nedu_ce_`i' year, color(ltgrey) fintensity(inten10) lcolor(white) lwidth(0))
	(line edu_ce_`i' year, yaxis(2)) , 
	title("Education") 
	subtitle("Trend of Education Level, Edu. level = `i'")
	saving(..\Graph\3_0_`i'.gph, replace);
#delimit cr
graph export ..\Graph\3_0_`i'.png, replace
}

*3.1
use education.dta, clear
collapse (mean)edu_ce_N_*, by(year)
label variable edu_ce_N_1 "Edu. level 1-3"
label variable edu_ce_N_2 "Edu. level 4-5"
label variable edu_ce_N_3 "Edu. level 6-8"
save education_3_1.dta, replace

#delimit ;
	twoway (line edu_ce_N_* year), 
	title("Education") 
	subtitle("Trend of Education Level")
	legend(label (1 "Edu. level 1-3") label (2 "Edu. level 4-5") label (3 "Edu. level 6-8"));
#delimit cr
graph export ..\Graph\3_1.png, replace


*3.2, 3.3
use education.dta, clear
collapse (mean)edu_ce_N_*, by(year democracy)
label variable edu_ce_N_1 "Edu. level 1-3"
label variable edu_ce_N_2 "Edu. level 4-5"
label variable edu_ce_N_3 "Edu. level 6-8"
save education_3_23.dta, replace

twoway line edu_ce_N_* year if democracy==1,t2title("Democratic")
graph save Graph ..\Graph\3_2.gph, replace
graph export ..\Graph\3_2.png, replace
twoway line edu_ce_N_* year if democracy==0,t2title("Non-democratic")
graph save Graph ..\Graph\3_3.gph, replace
graph export ..\Graph\3_3.png, replace

#delimit ;
graph combine ..\Graph\3_2.gph ..\Graph\3_3.gph,
	ycommon 
	title("Education") 
	subtitle("Trend of Education Level");
#delimit cr
graph export ..\Graph\3_23.png, replace


*3.4
use education.dta, clear
collapse (sum)weight_d weight_nd, by(year_b1991 democracy edu_ce)
save education_3_4.dta, replace

#delimit ;
graph bar weight_d weight_nd if year_b1991==1, 
	over(edu_ce) 
	bar(1, color(navy)) bar(2, color(maroon)) 
	subtitle("Frequency of Edu. level, before 1991")
	legend(label (1 "Democratic countries") label (2 "Non-democratic countries"));
#delimit cr
graph save Graph ..\Graph\3_41.gph, replace
*graph export ..\Graph\3_41.png, replace

#delimit ;	
graph bar weight* if year_b1991==0,
	over(edu_ce) 
	bar(1, color(navy)) bar(2, color(maroon)) 
	subtitle("Frequency of Edu. level, after 1991")
	legend(label (1 "Democratic countries") label (2 "Non-democratic countries"));
#delimit cr
graph save Graph ..\Graph\3_42.gph, replace
*graph export ..\Graph\3_42.png, replace

#delimit ;
graph combine ..\Graph\3_41.gph ..\Graph\3_42.gph, 
	ycommon 
	title("Education"); 
#delimit cr
graph export ..\Graph\3_4.png, replace


*3.5, 3.6
use education.dta, clear
collapse (mean)edu_ce_N_*, by(year OECD)
label variable edu_ce_N_1 "Edu. level 1-3"
label variable edu_ce_N_2 "Edu. level 4-5"
label variable edu_ce_N_3 "Edu. level 6-8"
save education_3_56.dta, replace

twoway line edu_ce_N_* year if OECD==1,t2title("OECD")
graph save Graph ..\Graph\3_5.gph, replace
graph export ..\Graph\3_5.png, replace
twoway line edu_ce_N_* year if OECD==0,t2title("Non-OECD")
graph save Graph ..\Graph\3_6.gph, replace
graph export ..\Graph\3_6.png, replace

#delimit ;
graph combine ..\Graph\3_5.gph ..\Graph\3_6.gph, 
	ycommon 
	title("Education") 
	subtitle("Trend of Education Level"); 
#delimit cr
graph export ..\Graph\3_56.png, replace



*3.7
use education.dta, clear
collapse (sum)weight_oecd weight_noecd, by(year_b1991 OECD edu_ce)
save education_3_7.dta, replace

#delimit ;
graph bar weight_oecd weight_noecd if year_b1991==1, 
	over(edu_ce) 
	bar(1, color(navy)) bar(2, color(maroon)) 
	title("Education") 
	subtitle("Frequency of Edu. level, before 1991")
	legend(label (1 "OECD countries") label (2 "Non-OECD countries"));
#delimit cr
graph save Graph ..\Graph\3_71.gph, replace
graph export ..\Graph\3_71.png, replace
#delimit ;	
graph bar weight_oecd weight_noecd if year_b1991==0,
	over(edu_ce) 
	bar(1, color(navy)) bar(2, color(maroon)) 
	title("Education") 
	subtitle("Frequency of Edu. level, after 1991")
	legend(label (1 "OECD countries") label (2 "Non-OECD countries"));
	graph save Graph ..\Graph\3_72.gph, replace;
	graph export ..\Graph\3_72.png, replace;
#delimit cr

*3.8
*Soviet Union
*Albania 339
*Bulgaria 355
*Cambodia 811
*Romania 
*Poland
*Hungary
*Laos
*-Cuba
*-China
*-vietnam

*3.9
use education.dta, clear
collapse (mean)edu_major_*, by(year democracy)
label variable edu_major_1 "Low or other"
label variable edu_major_2 "Liberal arts"
label variable edu_major_3 "Science and technology"
label variable edu_major_4 "Social Science"
label variable edu_major_5 "Military"
save education_3_9.dta, replace

twoway line edu_major_* year if democracy==1,t2title("Democratic")
graph save Graph ..\Graph\3_9_1.gph, replace
graph export ..\Graph\3_9_1.png, replace
twoway line edu_major_* year if democracy==0,t2title("Non-democratic")
graph save Graph ..\Graph\3_9_2.gph, replace
graph export ..\Graph\3_9_2.png, replace
graph combine ..\Graph\3_9_1.gph ..\Graph\3_9_2.gph, ycommon title("Education") subtitle("Trend of Education Level") 
graph export ..\Graph\3_9.png, replace


*3.10
use education.dta, clear
collapse (sum)weight_d weight_nd, by(edu_cemajor_N democracy)
save education_3_10.dta, replace

#delimit ;
graph bar weight_d weight_nd , 
	over(edu_cemajor_N) 
	bar(1, color(navy)) bar(2, color(maroon)) 
	title("Education") 
	subtitle("Frequency of Major")
	legend(label (1 "Democratic countries") label (2 "Non-democratic countries"));
#delimit cr
graph export ..\Graph\3_10.png, replace
/*	graph save Graph ..\Graph\3_41.gph, replace;
	graph export ..\Graph\3_41.png, replace;
	
graph bar weight* if year_b1991==0,
	over(edu_ce) 
	bar(1, color(navy)) bar(2, color(maroon)) 
	title("Education") 
	subtitle("Frequency of Edu. level, after 1991")
	legend(label (1 "Democratic countries") label (2 "Non-democratic countries"));
	graph save Graph ..\Graph\3_42.gph, replace;
	graph export ..\Graph\3_42.png, replace;
#delimit cr
*/

*3.11
use education.dta, clear
collapse (sum)weight_oecd weight_noecd, by(edu_cemajor_N OECD)
save education_3_11.dta, replace

#delimit ;
graph bar weight_noecd weight_oecd, 
	over(edu_cemajor_N) 
	bar(1, color(navy)) bar(2, color(maroon)) 
	title("Education") 
	subtitle("Frequency of Major")
	legend(label (1 "OECD countries") label (2 "Non-OECD countries"));
#delimit cr
graph export ..\Graph\3_11.png, replace
/*	graph save Graph ..\Graph\3_41.gph, replace;
	graph export ..\Graph\3_41.png, replace;
	
graph bar weight* if year_b1991==0,
	over(edu_ce) 
	bar(1, color(navy)) bar(2, color(maroon)) 
	title("Education") 
	subtitle("Frequency of Edu. level, after 1991")
	legend(label (1 "OECD countries") label (2 "Non-OECD countries"));
	graph save Graph ..\Graph\3_42.gph, replace;
	graph export ..\Graph\3_42.png, replace;
#delimit cr
*/

*3.13
use education.dta, clear
collapse (mean)edu_ceyear, by(year democracy)

#delimit ;
twoway (line edu_ceyear year if democracy == 1)(line edu_ceyear year if democracy == 0),
	title("Education")
	subtitle("Year or education")
	legend(label (1 "Democratic countries") label (2 "Non-democratic countries"));
#delimit cr
graph export ..\Graph\3_13.png, replace


*3.14
use education.dta, clear
collapse (mean)edu_ceyear, by(year OECD)

#delimit ;
twoway (line edu_ceyear year if OECD == 1)(line edu_ceyear year if OECD == 0),
	title("Education")
	subtitle("Year or education")
	legend(label (1 "OECD countries") label (2 "Non-OECD countries"));
#delimit cr
graph export ..\Graph\3_14.png, replace

window manage close graph
