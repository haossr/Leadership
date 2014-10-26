drop _all
clear all
set more off
set trace off
sca checking = 1
sca sampling = 0
if c(username)== "Hari"|c(username)=="Leonard"{
	cd D:\GitHub\Leadership\Cleanup\DoFile
}
else {
cd E:\GitHub\Leadership\Cleanup\DoFile
}
*cd E:\GitHub\Leadership\Cleanup\DoFile

**********************************************************************
*Manual Manipulating
**Data -55 El Salvador-SJN.xlsx: cen->countryn
**Data - 84 Isreal - YML.xlsx: 隐藏了三列错误信息，导入时没发现，我去年买了个登山包
**Data - 86 Jordan - LC.xlsx: 第三行 year->1953
**清除格式、超链接：  
*			data- 103 bulgaria-sjn.xlsx 
*      data-104 czechoslovakia-sjn.xlsx 
*           data-129 australia-sjn.xlsx 
*         data-131 new zealand-sjn.xlsx 
*               data-52 canada-sjn.xlsx
*                data-79 china-sjn.xlsx
*
**2014-8-20
**Data -55 El Salvador-SJN-revised.xlsx: cen->countryn, 还是错，无语凝噎 
**Data - 59 Honduras  - YML.xlsx: countryn->Honduras, country->59
**Data - 158 Cequatorial guinea- LC-.xlsx:-> Data - 158 equatorial guinea- LC-
**Data - 83 iraq- YML： no constituion nor elective law before 1958-[blank]

**2014-8-23
**Data - 119 Poland - SH.xlsx: firstterm_ce <-->Nterm
**Data - 167 Lebanon.xlsx: firstterm_ce <-->Nterm
**Data - 25 Madagascar - SH.xlsx: length_ce = 2(year == 1995); length_ce = 3(year==1996)
**Data - 87 Panama - LC-.xlsx: length_ce = 2(year==2010)
**Data - 67 Bolivia - SH.xlex: length_ce = 2(year == 1966); length_ce = 3(year==1967); length_ce = 4(year==1968)
**Data - 90 Mongolia - SH.xlsx: length_ce = 2(year == 1951); length_ce = 3(year==1952)
**Data - 87 ZhangTianhong1.xlsx: length_ce = 2(year==1955, PIPECode = 96)
**Data - 87 ZhangTianhong1.xlsx: length_ce = 2:8(year==2007:2013, PIPECode = 96)
**Data - 167 Lebanon - SH.xlsx: length_ce = 2(year == 1998); length_ce = 3(year==1999)

**2014-8-24
**Data - 9 central africa - YML: exp_ce_centralyear = 20(year = 1982); exp_ce_militaryyear = 26(year = 1982)
**********************************************************************

**********************************************************************
**************  I. Merge                       ***********************
**********************************************************************
cd ..\DoFile
do Merge.do

**********************************************************************
**************  II. Clean (and add source marker)*********************
**********************************************************************
cd ..\DoFile
do Clean.do


**********************************************************************
**************  III. Format                     ***********************
**********************************************************************
cd ..\DoFile
do Format.do

**********************************************************************
***************  IV. Save                      ***********************
**********************************************************************
save ..\..\Merge\RawData\Leadership, replace



*Appendix

**********************************************************************
***************  V. Sample                     ***********************
**********************************************************************
if sampling{
	cd ..\DoFile
	do Sample.do
}


**********************************************************************
**************  Vi. Check                     ***********************
**********************************************************************
if checking{
	cd ..\DoFile
	do Check.do
}



