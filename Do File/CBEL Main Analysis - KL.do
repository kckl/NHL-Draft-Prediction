clear all 
* Changing Working Directory and import
cd "/Users/kirbylam/Desktop/econ 490/cbel"

use "***MASTER DATA FILE-KL***.dta"

keep if Forward ==1|Forward ==2

*****************************************
*************** HECKMAN *****************
*****************************************


**___MAIN SPECIFICATION___**
*a) baseline regression
heckman DraftPosition G_GM A_GM PIMS PLUSMINUS, select(GP G_GM A_GM PIMS PLUSMINUS) twostep
*b) control for age
heckman DraftPosition G_GM A_GM PIMS PLUSMINUS AGESEPT15, select(GP G_GM A_GM PIMS PLUSMINUS AGESEPT15) twostep
*c) control for age + year
heckman DraftPosition G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.Year, select(GP G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.Year)
*d) control for age + year + birthquarter
heckman DraftPosition G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.Year i.BirthQuarter, select(GP G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.Year i.BirthQuarter) twostep
*d) sort main Heckman by Years
by Year, sort : heckman DraftPosition G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.BirthQuarter, select(GP G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.BirthQuarter) twostep 
heckman DraftPosition G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.BirthQuarter, select(GP G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.BirthQuarter) twostep, if Year == 2015
heckman DraftPosition G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.BirthQuarter, select(GP G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.BirthQuarter) twostep, if Year == 2016
heckman DraftPosition G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.BirthQuarter, select(GP G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.BirthQuarter) twostep, if Year == 2017
heckman DraftPosition G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.BirthQuarter, select(GP G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.BirthQuarter) twostep, if Year == 2018
heckman DraftPosition G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.BirthQuarter, select(GP G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.BirthQuarter) twostep, if Year == 2019




*****************************************
********** ROBUSTNESS CHECK *************
*****************************************

**___ALTERNATIVE SPECIFICATION___**

*1 - Substitute PTSGM for G_GM and A_GM
heckman DraftPosition PTSGM PIMS PLUSMINUS AGESEPT15 i.Year i.BirthQuarter, select(GP PTSGM PIMS PLUSMINUS AGESEPT15 i.Year i.BirthQuarter) twostep

*2 - Use DraftRound as outcome variable
heckman DraftRound G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.Year i.BirthQuarter, select(GP G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.Year i.BirthQuarter) twostep
**sort by years
heckman DraftRound G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.BirthQuarter, select(GP G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.BirthQuarter) twostep, if Year == 2015
heckman DraftRound G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.BirthQuarter, select(GP G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.BirthQuarter) twostep, if Year == 2016
heckman DraftRound G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.BirthQuarter, select(GP G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.BirthQuarter) twostep, if Year == 2017
heckman DraftRound G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.BirthQuarter, select(GP G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.BirthQuarter) twostep, if Year == 2018
heckman DraftRound G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.BirthQuarter, select(GP G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.BirthQuarter) twostep, if Year == 2019

*3 - Include GP in second stage heckman
heckman DraftPosition GP G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.Year i.BirthQuarter, select(GP G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.Year i.BirthQuarter) twostep






