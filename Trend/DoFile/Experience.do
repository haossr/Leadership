cd ..\WorkingData\
set trace off
************************************************************************
*************** Trend: Age and gender
************************************************************************
local dummy exp_ce_public exp_ce_vice exp_ce_minister exp_ce_legis exp_ce_governor exp_ce_Ngovernor exp_ce_party exp_ce_central exp_ce_military exp_ce_private exp_ce_manager
local dummyyear exp_ce_publicyear  exp_ce_viceyear  exp_ce_ministeryear  exp_ce_legisyear  exp_ce_governoryear  exp_ce_leglocalyear  exp_ce_partyyear  exp_ce_centralyear  exp_ce_militaryyear  exp_ce_privateyear  exp_ce_manageryear
local subgroup _d _nd _oecd _noecd

*5.1
use experience, clear

#delimit ;
	graph bar (mean)Nterm_d_pre Nterm_nd_pre,

	legend(label (1 "Democratic countries") label (2 "Non-democratic countries"))
	t2title("conditional on presidentialism");
#delimit cr
graph save ..\Graph\5_1_1.gph, replace

#delimit ;
	graph bar (mean)Nterm_d_par Nterm_nd_par,
	legend(label (1 "Democratic countries") label (2 "Non-democratic countries"))
	t2title("conditional on parliamentary");
#delimit cr
graph save ..\Graph\5_1_2.gph, replace

#delimit ;
graph combine  ..\Graph\5_1_1.gph ..\Graph\5_1_2.gph,
	ycommon
	title("Experience")
	subtitle("Number of terms");
#delimit cr
graph display, ysize(8) xsize(20)
graph export ..\Graph\5_1.png, height(345) width(948) replace


*5.2
use experience, clear
#delimit ;
	twoway (rarea llength_ce hlength_ce year, sort bcolor(gs14))
	(line length_ce year),
	title("Experience")
	subtitle("In office year")
	legend(label (1 "%95 CI")) ;
#delimit cr
graph export ..\Graph\5_2.png, replace

*5.3
use experience, clear
#delimit ;
	twoway (rarea llength_ce_d hlength_ce_d year, sort bcolor(gs14))
	(line length_ce_d year),
	t2title("Democratic countries")
	legend(label (1 "%95 CI")) ;
#delimit cr
graph save ..\Graph\5_3_1.gph, replace

#delimit ;
	twoway (rarea llength_ce_nd hlength_ce_nd year, sort bcolor(gs14))
	(line length_ce_nd year),
	t2title("Non-democratic countries")
	legend(label (1 "%95 CI")) ;
#delimit cr
graph save ..\Graph\5_3_2.gph, replace

#delimit ;
graph combine  ..\Graph\5_3_1.gph ..\Graph\5_3_2.gph,
	ycommon
	title("Experience")
	subtitle("In office year");
#delimit cr
graph export ..\Graph\5_3.png, height(345) width(948) replace



*5.4
use experience, clear
#delimit ;
	twoway (rarea llength_ce_oecd hlength_ce_oecd year, sort bcolor(gs14))
	(line length_ce_oecd year),
	t2title("OECD countries")
	legend(label (1 "%95 CI")) ;
#delimit cr
graph save ..\Graph\5_4_1.gph, replace

#delimit ;
	twoway (rarea llength_ce_noecd hlength_ce_noecd year, sort bcolor(gs14))
	(line length_ce_noecd year),
	t2title("Non-OECD countries")
	legend(label (1 "%95 CI")) ;
#delimit cr
graph save ..\Graph\5_4_2.gph, replace


#delimit ;
graph combine  ..\Graph\5_4_1.gph ..\Graph\5_4_2.gph,
	ycommon
	title("Experience")
	subtitle("In office year");
#delimit cr
graph export ..\Graph\5_4.png, height(345) width(948) replace


/*
*5.5
use experience, clear

foreach var of new `dummy'{
	foreach suffix in `subgroup'{ 
		local l`var'`suffix': variable label `var'`suffix'
		#delimit ;
			twoway (rarea l`var'`suffix' h`var'`suffix' year, sort bcolor(gs14))
			(line `var'`suffix' year),
			t2title("`l`var'`suffix''")
			legend(label (1 "%95 CI")) ;
		#delimit cr
		
		graph save ..\Graph\5_5_`var'`suffix'.gph, replace
	}
	#delimit ;
	graph combine ..\Graph\5_5_`var'_d.gph ..\Graph\5_5_`var'_nd.gph,
		ycommon
		title("Experience") 
		subtitle("Trend of variable: `var'");
	#delimit cr
	graph display, ysize(8) xsize(20)
	graph export ..\Graph\5_5_`var'_byd.png, height(345) width(948) replace
	
	#delimit ;
	graph combine ..\Graph\5_5_`var'_oecd.gph ..\Graph\5_5_`var'_noecd.gph,
		ycommon
		title("Experience") 
		subtitle("Trend of variable: `var'");
	#delimit cr
	graph display, ysize(8) xsize(20)
	graph export ..\Graph\5_5_`var'_byOECD.png, height(345) width(948) replace
	}

*5.6
foreach var of new `dummyyear'{
	foreach suffix in `subgroup'{ 
		local l`var'`suffix': variable label `var'`suffix'
		#delimit ;
			twoway (rarea l`var'`suffix' h`var'`suffix' year, sort bcolor(gs14))
			(line `var'`suffix' year),
			t2title("`l`var'`suffix''")
			legend(label (1 "%95 CI")) ;
		#delimit cr
		
		graph save ..\Graph\5_6_`var'`suffix'.gph, replace
	}
	#delimit ;
	graph combine ..\Graph\5_6_`var'_d.gph ..\Graph\5_5_`var'_nd.gph,
		ycommon
		title("Experience") 
		subtitle("Trend of variable: `var'");
	#delimit cr
	graph display, ysize(8) xsize(20)
	graph export ..\Graph\5_6_`var'_byd.png, height(345) width(948) replace
	
	#delimit ;
	graph combine ..\Graph\5_6_`var'_oecd.gph ..\Graph\5_6_`var'_noecd.gph,
		ycommon
		title("Experience") 
		subtitle("Trend of variable: `var'");
	#delimit cr
	graph display, ysize(8) xsize(20)
	graph export ..\Graph\5_6_`var'_byOECD.png, height(345) width(948) replace
}
