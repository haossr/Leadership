if c(username)== "Hari"{
	cd D:\GitHub\Leadership\Trend\DoFile
}
else {
cd E:\GitHub\Leadership\Trend\DoFile
}
cd ..\WorkingData
************************************************************************
*************** 1. Initilization
************************************************************************
use Leadership.dta, replace
save education_3_01.dta, replace
drop if year<1950
drop if year>2010
replace edu_ce =. if edu_ce==0
recode edu_ce (1 2 3 = 1)(4 5 = 2)(6 7 8= 3), gen(edu_ce_N)

recode edu_cemajor (1 11 = 1)(2 10 = 2)(3 4 9 = 3)(5 6 7 = 4)(8 = 5), gen(edu_cemajor_N)
drop if edu_cemajor_N > 5
save education_3_0.dta, replace

************************************************************************
*************** 2. Trend: Selection mechanism/barrier to entry
************************************************************************
*3.1
use education_3_0.dta, clear
tabulate edu_ce_N, gen(edu_group)
collapse (mean)edu_group*, by(year)

label variable edu_group1 "Edu. level 1-3"
label variable edu_group2 "Edu. level 4-5"
label variable edu_group3 "Edu. level 6-8"
*label variable edu_group1 "Education level 1-3"
*label variable edu_group2 "Education level 4-5"
*label variable edu_group3 "Education level 6-8"
save education_3_1.dta, replace

twoway (line edu_group* year), title("Education") subtitle("Trend of Education Level")
graph export ..\Graph\3_1.png, replace


*3.2, 3.3
use education_3_0.dta, clear
tabulate edu_ce_N, gen(edu_group)
collapse (mean)edu_group*, by(year democracy)

label variable edu_group1 "Edu. level 1-3"
label variable edu_group2 "Edu. level 4-5"
label variable edu_group3 "Edu. level 6-8"
save education_3_23.dta, replace

twoway line edu_group* year if democracy==1,t2title("Democratic")
graph save Graph ..\Graph\3_2.gph, replace
graph export ..\Graph\3_2.png, replace
twoway line edu_group* year if democracy==0,t2title("Non-democratic")
graph save Graph ..\Graph\3_3.gph, replace
graph export ..\Graph\3_3.png, replace
graph combine ..\Graph\3_2.gph ..\Graph\3_3.gph, ycommon title("Education") subtitle("Trend of Education Level") 
graph export ..\Graph\3_23.png, replace


*3.4
use education_3_0.dta, clear
drop if democracy ==.
drop if year ==.
drop if edu_ce ==.

gen year_b1991 = 1
replace year_b1991 = 0 if year>=1991
tabulate edu_ce, gen(edu_group)
gen weight = 1/r(N)
gen weight_d = weight*democracy
gen weight_n = weight*(1-democracy)
drop weight
collapse (sum)weight*, by(year_b1991 democracy edu_ce)
save education_3_4.dta, replace

label variable weight_d "Democratic countries"
label variable weight_n "Non-democratic countries"
#delimit ;
graph bar weight* if year_b1991==1, 
	over(edu_ce) 
	bar(1, color(navy)) bar(2, color(maroon)) 
	title("Education") 
	subtitle("Frequency of Edu. level, before 1991")
	legend(label (1 "Democratic countries") label (2 "Non-democratic countries"));
	graph save Graph ..\Graph\3_41.gph, replace;
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

*graph combine ..\Graph\3_41.gph ..\Graph\3_42.gph, ycommon title("Education") subtitle("Trend of Education Level") 


*3.5, 3.6
use education_3_0.dta, clear
replace OECD=0 if OECD==.
tabulate edu_ce_N, gen(edu_group)
collapse (mean)edu_group*, by(year OECD)
label variable edu_group1 "Edu. level 1-3"
label variable edu_group2 "Edu. level 4-5"
label variable edu_group3 "Edu. level 6-8"
save education_3_56.dta, replace

twoway line edu_group* year if OECD==1,t2title("OECD")
graph save Graph ..\Graph\3_5.gph, replace
graph export ..\Graph\3_5.png, replace
twoway line edu_group* year if OECD==0,t2title("Non-OECD")
graph save Graph ..\Graph\3_6.gph, replace
graph export ..\Graph\3_6.png, replace
graph combine ..\Graph\3_5.gph ..\Graph\3_6.gph, ycommon title("Education") subtitle("Trend of Education Level") 
graph export ..\Graph\3_56.png, replace

*3.7
use education_3_0.dta, clear
replace OECD=0 if OECD==.
drop if year ==.
drop if edu_ce ==.
gen year_b1991 = 1
replace year_b1991 = 0 if year>=1991
tabulate edu_ce, gen(edu_group)
gen weight = 1/r(N)
gen weight_o = weight*OECD
gen weight_n = weight*(1-OECD)
drop weight
collapse (sum)weight*, by(year_b1991 OECD edu_ce)
save education_3_7.dta, replace

label variable weight_o "OECD countries"
label variable weight_n "Non-OECD countries"
#delimit ;
graph bar weight* if year_b1991==1, 
	over(edu_ce) 
	bar(1, color(navy)) bar(2, color(maroon)) 
	title("Education") 
	subtitle("Frequency of Edu. level, before 1991")
	legend(label (1 "OECD countries") label (2 "Non-OECD countries"));
	graph save Graph ..\Graph\3_71.gph, replace;
	graph export ..\Graph\3_71.png, replace;
	
graph bar weight* if year_b1991==0,
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
use education_3_0.dta, clear
drop if edu_cemajor_N ==.
tabulate edu_cemajor_N, gen(edu_major_)
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
use education_3_0.dta, clear
drop if edu_cemajor_N ==.
gen weight = 1/r(N)
gen weight_d = weight*democracy
gen weight_n = weight*(1-democracy)
drop weight
collapse (sum)weight*, by(democracy edu_cemajor_N)

label define major 1 "Low or other" 2 "Liberal arts" 3 "Science and technology" 4 "Social Science" 5 "Military"
label values edu_cemajor_N major

save education_3_10.dta, replace
label variable weight_d "Democratic countries"
label variable weight_n "Non-democratic countries"
#delimit ;
graph bar weight* , 
	over(edu_cemajor_N) 
	bar(1, color(navy)) bar(2, color(maroon)) 
	title("Education") 
	subtitle("Frequency of Major")
	legend(label (1 "Democratic countries") label (2 "Non-democratic countries"));
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
