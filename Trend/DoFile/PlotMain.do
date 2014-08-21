drop _all
clear all
set more off
set trace on
sca testing = 1
if c(username)== "Leonard"|c(username)=="Hari"{
	cd D:\GitHub\Leadership\Merge\DoFile
}
else {
cd E:\GitHub\Leadership\Merge\DoFile
}



**********************************************************************
*Manual Manipulating

**********************************************************************


**********************************************************************
**************  I. Initilization             
**********************************************************************
cd ..\DoFile
do PlotIni.do
**********************************************************************
**************  II. Selection                       
**********************************************************************
cd ..\DoFile
do Selection.do


**********************************************************************
**************  III. Education                       
**********************************************************************
cd ..\DoFile
do Education.do

/*
**********************************************************************
**************  IIV. ddrevisited             
**********************************************************************
cd ..\DoFile
do ddrevistedMerge.do

**********************************************************************
**************  V. Archigos                  
**********************************************************************
cd ..\DoFile
do ArchigosMerge.do

**********************************************************************
*************** VI. Format                    
**********************************************************************


**********************************************************************
*************** VI. Save                    
**********************************************************************
save ..\..\Trend\RawData\Leadership.dta, replace
