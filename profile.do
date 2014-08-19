capture log close _all
local fn = subinstr("`c(current_date)'"," ","",2)+"_"+subinstr("`c(current_time)'",":","",2) 
*log using .\log\s`fn'.log, replace
*cmdlog using .\log\c`fn'.log, replace
noisily log using .\log\S_permanent.log, append name("Permanent log file by Hari SHENG")
*quietly log off
*noisily log on
*display "$S_DATE  $S_TIME"
cmdlog using .\log\C_permanent.log, append


sysdir set PLUS ".\ado\plus"
sysdir set PERSONAL ".\ado\personal"

*! gegerate submenu of Meta-analysis
if _caller() >= 8 {
  window menu clear
  window menu append submenu "stUser" "&Meta-Analysis"
  window menu append item "Meta-Analysis" "Of Binary and Continuous (meta&n)" "db metan"
  window menu append item "Meta-Analysis" "Of Effects (&meta)" "db meta"
  window menu append item "Meta-Analysis" "Of p-values (meta&p)" "db metap"
  window menu append item "Meta-Analysis" "Cumulative (meta&cum)" "db metacum"
  window menu append item "Meta-Analysis" "Regression (meta&reg)" "db metareg"
  window menu append item "Meta-Analysis" "Funnel Graph, metan-based (f&unnel)" "db funnel"
  window menu append item "Meta-Analysis" "Funnel Graph, &vertical (metafunnel)" "db metafunnel"
  window menu append item "Meta-Analysis" "L'abbe Graph, metan-based (&labbe)" "db labbe"
  window menu append item "Meta-Analysis" "NNT, metan-based (metann&t)" "db metannt"
  window menu append item "Meta-Analysis" "Influence Analysis, metan-based (metan&inf)" "db metaninf"
  window menu append item "Meta-Analysis" "Influence Analysis, meta-based (metain&f)" "db metainf"
  window menu append item "Meta-Analysis" "Galbraith Plot for Heterogeneity (&galbr)" "db galbr"
  window menu append item "Meta-Analysis" "Publication Bias (meta&bias)" "db metabias"
  window menu append item "Meta-Analysis" "Trim and Fill Analysis (met&atrim)" "db metatrim"
  window menu append item "Meta-Analysis" "Meta_lr" "db meta_lr"
  window menu refresh
}

set type double
set memory 256m
set matsize 2000
set more off, permanently

if c(username)=="Hari"{
cd D:\GitHub
}
