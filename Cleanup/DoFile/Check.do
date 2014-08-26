/*set more off
set trace on
clear all
*/
/*
cd "E:\Dropbox\Project-Leadership\Data-Cleanup\WorkingData"
use Leadership.dta, clear
*/

cd ..\WorkingData

use Leadership.dta, clear
noisily list countryn year exp_ce_central exp_ce_centralyear if exp_ce_central>1&exp_ce_central!=.
