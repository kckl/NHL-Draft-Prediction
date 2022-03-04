clear all 
* Changing Working Directory and import
cd "/Users/kirbylam/Desktop/econ 490/cbel"

use "***MASTER DATA FILE-KL***.dta"

keep if Forward ==1|Forward ==2


**___TABLE 1___**
summarize GP G A PTS PIMS PLUSMINUS G_GM A_GM PTSGM AGESEPT15
by Year, sort : summarize GP G A PTS PIMS PLUSMINUS G_GM A_GM PTSGM AGESEPT15



**__TABLE 2__**
heckman DraftPosition G_GM A_GM PIMS PLUSMINUS, select(GP G_GM A_GM PIMS PLUSMINUS) twostep
est store main

heckman DraftPosition G_GM A_GM PIMS PLUSMINUS AGESEPT15, select(GP G_GM A_GM PIMS PLUSMINUS AGESEPT15) twostep
est store main_age

heckman DraftPosition G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.Year, select(GP G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.Year)
est store main_year

heckman DraftPosition G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.Year i.BirthQuarter, select(GP G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.Year i.BirthQuarter) twostep
est store main_bq

outreg2 [main main_age main_year main_bq] using Table2, replace word label stats(coef se pval)


**__TABLE 3__**
heckman DraftPosition G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.BirthQuarter, select(GP G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.BirthQuarter) twostep, if Year == 2015
est store main_2015

heckman DraftPosition G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.BirthQuarter, select(GP G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.BirthQuarter) twostep, if Year == 2016
est store main_2016

heckman DraftPosition G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.BirthQuarter, select(GP G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.BirthQuarter) twostep, if Year == 2017
est store main_2017

heckman DraftPosition G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.BirthQuarter, select(GP G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.BirthQuarter) twostep, if Year == 2018
est store main_2018

heckman DraftPosition G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.BirthQuarter, select(GP G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.BirthQuarter) twostep, if Year == 2019
est store main_2019

outreg2 [main_2015 main_2016 main_2017 main_2018 main_2019] using Table3, replace word label stats(coef se pval)



**___TABLE 4___**
heckman DraftPosition GP G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.Year i.BirthQuarter, select(GP G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.Year i.BirthQuarter) twostep
est store robust_gp

heckman DraftPosition PTSGM PIMS PLUSMINUS AGESEPT15 i.Year i.BirthQuarter, select(GP PTSGM PIMS PLUSMINUS AGESEPT15 i.Year i.BirthQuarter) twostep
est store robust_ptsgm

heckman DraftRound G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.Year i.BirthQuarter, select(GP G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.Year i.BirthQuarter) twostep
est store robust_dr

outreg2 [robust_gp robust_ptsgm robust_dr] using Table4, replace word label stats(coef se pval)


**___TABLE 5___**
heckman DraftRound G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.BirthQuarter, select(GP G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.BirthQuarter) twostep, if Year == 2015
est store dr_2015

heckman DraftRound G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.BirthQuarter, select(GP G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.BirthQuarter) twostep, if Year == 2016
est store dr_2016

heckman DraftRound G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.BirthQuarter, select(GP G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.BirthQuarter) twostep, if Year == 2017
est store dr_2017

heckman DraftRound G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.BirthQuarter, select(GP G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.BirthQuarter) twostep, if Year == 2018
est store dr_2018

heckman DraftRound G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.BirthQuarter, select(GP G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.BirthQuarter) twostep, if Year == 2019
est store dr_2019

outreg2 [dr_2015 dr_2016 dr_2017 dr_2018 dr_2019] using Table5, replace word label stats(coef se pval)




**__FIGURE 1__**
graph bar (count) if Drafted == 1, over(BirthQuarter)

**___FIGURE 2___**
graph box GP, over(DraftRound) nooutsides

**___FIGURE 3___**
heckman DraftPosition G_GM A_GM PIMS PLUSMINUS, select(GP G_GM A_GM PIMS PLUSMINUS) twostep
predict fitted, xb
graph twoway (lfit DraftPosition fitted) (scatter DraftPosition fitted)

**___FIGURE 4___**
heckman DraftPosition G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.Year i.BirthQuarter, select(GP G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.Year i.BirthQuarter)
predict fitted2, xb
graph twoway (lfit DraftPosition fitted2) (scatter DraftPosition fitted2)

**___FIGURE 5___**
heckman DraftPosition GP G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.Year i.BirthQuarter, select(GP G_GM A_GM PIMS PLUSMINUS AGESEPT15 i.Year i.BirthQuarter) twostep
predict fitted3, xb
graph twoway (lfit DraftPosition fitted3) (scatter DraftPosition fitted3)





