/*set more off
set trace on
clear all
*/
/*
cd "E:\Dropbox\Project-Leadership\Data-Cleanup\WorkingData"
use Leadership.dta, clear
*/

sort source
sample 1, count by(source)
