drop _all
clear all
set more off
set trace on
sca testing = 1
if c(username)== "Leonard"{
	cd D:\GitHub\Leadership\Merge\DoFile
}
else {
cd E:\GitHub\Leadership\Merge\DoFile
}



**********************************************************************
*Manual Manipulating

**********************************************************************

**********************************************************************
**************  I. Country code               
**********************************************************************
cd ..\DoFile
do countryID.do
**********************************************************************
**************  II. PIPE                       
**********************************************************************
cd ..\DoFile
do PIPEMerge.do


**********************************************************************
**************  III. PWT80                       
**********************************************************************
cd ..\DoFile
do PWT80Merge.do

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
