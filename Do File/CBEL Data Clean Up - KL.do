clear all 
* Changing Working Directory and import
cd "/Users/kirbylam/Desktop/econ 490/cbel"

*****************************************
*************** 2014-2015 ***************
*****************************************
clear all

**___WHL DATA___**
import delimited "CHL Stats 2014 - WHL.csv", case(preserve) 

* 1 - Data clean up for WHL
drop v1
generate League = "WHL"
replace Name = "Dillon Dube (C/LW)" in 295
replace Name = "Blake Orban (D)" in 320

* Drop invalid rows
drop if missing(Team)

* 2 - Replicating player names for players in more than 1 team
gen PlayerName = Name
replace PlayerName = PlayerName[_n-1] if PlayerName == ""

* 3 - Generating role variables by separating them from PlayerName
gen Name2 = trim(usubstr(PlayerName, 1, ustrpos(PlayerName,"(")-1))
gen Role = trim(usubstr(PlayerName, ustrpos(PlayerName,"("), ustrlen(PlayerName)))

save "CHL Stats 2014 - WHL.dta", replace

**___OHL DATA___**
clear all
import delimited "CHL Stats 2014 - OHL.csv", case(preserve) 

* 4 - Data clean up for OHL
drop v1
generate League = "OHL"
replace Name = "Gustaf Franzen (C/RW)" in 208
replace Name = "Markus Soberg (RW/LW)" in 241

* Drop invalid rows
drop if missing(Team)

* 5 - Replicating player names for players in more than 1 team
gen PlayerName = Name
replace PlayerName = PlayerName[_n-1] if PlayerName == ""

* 6 - Generating role variables by separating them from PlayerName
gen Name2 = trim(usubstr(PlayerName, 1, ustrpos(PlayerName,"(")-1))
gen Role = trim(usubstr(PlayerName, ustrpos(PlayerName,"("), ustrlen(PlayerName)))

save "CHL Stats 2014 - OHL.dta", replace

**___QMJHL DATA___**
clear all
import delimited "CHL Stats 2014 - QMJHL.csv", case(preserve) 

* 7 - Data clean up for QMJHL
drop v1
generate League = "QMJHL"
replace Name = "Nicolas Aube-Kubel (RW)" in 21
replace Name = "Frederic Gamelin (C)" in 42
replace Name = "Jeremie Fraser (D)" in 62
replace Name = "Loik Leveille (D)" in 66
replace Name = "Alex Barre-Boulet (C)" in 75
replace Name = "Dylan Labbe (D)" in 76
replace Name = "Jeremy Roy (D)" in 106
replace Name = "Jeremy Gregoire (C)" in 117
replace Name = "Charles-Eric Legare (LW)" in 137
replace Name = "Justin Guenette (D)" in 144
replace Name = "Jeremy Lauzon (D)" in 152
replace Name = "Charles Guevremont (C)" in 162
replace Name = "Elie Berube (D)" in 173
replace Name = "Raphael Corriveau (RW)" in 181
replace Name = "Frederik Gauthier (C)" in 183
replace Name = "Sebastien Gauthier (D)" in 187
replace Name = "Frederic Allard (D)" in 214
replace Name = "Alexis Pepin (LW)" in 235
replace Name = "Raphael Lafontaine (LW/C)" in 239
replace Name = "Raphael Maheux (D)" in 246
replace Name = "Eric Leger (LW)" in 247
replace Name = "Jerome Verrier (RW/C)" in 249
replace Name = "Phelix Martineau (C)" in 253
replace Name = "Jeremy Bouchard (LW)" in 262
replace Name = "Vytal Cote (D/F)" in 264
replace Name = "Francois Beauchemin (C/RW)" in 269
replace Name = "Filip Rydstrom (C)" in 287
replace Name = "Mathieu Sevigny (LW/C)" in 297
replace Name = "Jeremy Auger (C)" in 298
replace Name = "Timothe Simard (RW)" in 307
replace Name = "Luc Deschenes (D)" in 321
replace Name = "Felix Lauzon (C)" in 340
replace Name = "Mickael Beauregard (D)" in 348
replace Name = "Danick Crete (D)" in 382
replace Name = "Cedric Montminy (LW)" in 385
replace Name = "Jeremy Lepine (C)" in 399
replace Name = "Thomas Gregoire (D)" in 412
replace Name = "Julien Carignan-Labbe (D)" in 422
replace Name = "Benjamin Gagne (D)" in 436
replace Name = "Kevin Laliberte (D)" in 438
replace Name = "Jean-Sebastien Taillefer (D)" in 446
replace Name = "Jeremie Beaudin (D)" in 448
replace Name = "Felix Boivin (D)" in 504
replace Name = "Jean-Francois Lavoie (C)" in 515
replace Name = "Nicolas Jones-Gagne (LW)" in 519
replace Name = "Felix-Antoine Bergeron (LW)" in 520
replace Name = "Frederic Aube (D)" in 232
replace Name = "Filip Chlapi­k (C)" in 29
replace Name = "Gabriel Gagne (RW)" in 52

* Drop invalid rows
drop if missing(Team)

* 8 - Replicating player names for players in more than 1 team
gen PlayerName = Name
replace PlayerName = PlayerName[_n-1] if PlayerName == ""

* 9 - Generating role variables by separating them from PlayerName
gen Name2 = trim(usubstr(PlayerName, 1, ustrpos(PlayerName,"(")-1))
gen Role = trim(usubstr(PlayerName, ustrpos(PlayerName,"("), ustrlen(PlayerName)))

save "CHL Stats 2014 - QMJHL.dta", replace

* 10 - Combine the 3 CHL leagues into one dataset
use "CHL Stats 2014 - OHL.dta"
append using "CHL Stats 2014 - WHL.dta"
append using "CHL Stats 2014 - QMJHL.dta"
save "2014-15 CHL.dta", replace

**___NHL DATA___**
clear all
import delimited "CHL_NHL Draft Data UBC 2017-2015 - 2015", case(preserve) 
 
* 11 - Make sure variables are consistent with CHL data
rename Player Name
rename Team Team_D
replace Name = "John Dahlstrom (F)" in 4
replace Name = "Vili Saarijarvi (D)" in 49
replace Name = "Gabriel Gagne (F)" in 92
replace Name = "Jeremy Roy (D)" in 90
replace Name = "Jeremy Lauzon (D)" in 91
replace Name = "Filip Chlapi­k (C)" in 108
replace Name = "Julius Nattinen (F)" in 56
drop in 82

* 12 - Generating role variables by separating them from PlayerName
gen Name2 = trim(usubstr(Name, 1, ustrpos(Name,"(")-1))
gen Role = trim(usubstr(Name, ustrpos(Name,"("), ustrlen(Name)))

* 13 - Drop Goaltenders from the dataset 
drop if Role == "(G)"

* 14 - Remove "#" from DraftPosition
destring DraftPosition, replace ignore(`"#"')

* 15 - Delete extra variables (missing observations)
drop G A PTS PIMS GP Seasons

save "CHL_NHL Draft Data UBC 2017-2015 - 2015.dta", replace

**___PICK224 DATA___**
clear all

import delimited "2014-15 Pick224-Juniors", case(upper) 

* 16 - Rename and Drop variables
keep LEAGUE NAME DY DOB AGESEPT15 AGEDEC31 
rename LEAGUE League
rename NAME Name2

* 17 - Rename Player names
replace Name2 = "Connor McDavid" in 1
replace Name2 = "Jake DeBrusk" in 90
replace Name2 = "Nicolas Roy" in 280
replace Name2 = "Riley Bruce" in 1312
replace Name2 = "Yevgeni Svechnikov" in 56

save "2014-15 Pick224.dta", replace

* 18 - Merge NHL and CHL data
use "2014-15 CHL.dta"
merge m:1 Name2 League using "CHL_NHL Draft Data UBC 2017-2015 - 2015.dta"

* 19 - Account for players who played in the CHL after being drafted
sort _merge Name2
generate byte PlayedAfter = 0, after(DraftPosition)
replace PlayedAfter = 1 in 1480
replace PlayedAfter = 1 in 1481
replace PlayedAfter = 1 in 1482
replace PlayedAfter = 1 in 1483
replace PlayedAfter = 1 in 1484
replace PlayedAfter = 1 in 1485
replace PlayedAfter = 1 in 1486
replace PlayedAfter = 1 in 1487
replace PlayedAfter = 1 in 1488
replace PlayedAfter = 1 in 1489
replace PlayedAfter = 1 in 1490
replace PlayedAfter = 1 in 1491
replace PlayedAfter = 1 in 1492
replace PlayedAfter = 1 in 1493
replace PlayedAfter = 1 in 1494
replace PlayedAfter = 1 in 1496
replace PlayedAfter = 1 in 1497

rename _merge merge1

* 20 - Merge with Pick 224
merge m:1 Name2 League using "2014-15 Pick224.dta"

* 21 - Generate draft year variable
gen Year = 2015

* 22 - Drop players who played less than 10 games
drop if GP <=10
drop if missing(Team)

* 23 - Drop players who are under 18 and over 20
drop if AGESEPT15 < 18
keep if AGEDEC31 < 21

* 24 - Generate birth month and birth year
gen BirthMonth=substr(DOB,-5,2)
gen BirthYear=substr(DOB,1,4)
destring BirthYear, replace
destring BirthMonth, replace

save "2014-15 CHL_NHL_PICK224.dta", replace

*****************************************
*************** 2015-2016 ***************
*****************************************
clear all

**___WHL DATA___**
import delimited "CHL Stats 2015 - WHL.csv", case(preserve) 

* 1 - Data clean up for WHL
drop v1
generate League = "WHL"
replace Name = "Dillon Dube (C/LW)" in 54
replace Name = "Calvin Thurkauf (C/LW)" in 159
replace Name = "Juuso Valimaki (D)" in 220
replace Name = "Libor Hajek (D)" in 282

* Drop invalid rows
drop if missing(Team)

* 2 - Replicating player names for players in more than 1 team
gen PlayerName = Name
replace PlayerName = PlayerName[_n-1] if PlayerName == ""

* 3 - Generating role variables by separating them from PlayerName
gen Name2 = trim(usubstr(PlayerName, 1, ustrpos(PlayerName,"(")-1))
gen Role = trim(usubstr(PlayerName, ustrpos(PlayerName,"("), ustrlen(PlayerName)))

save "CHL Stats 2015 - WHL.dta", replace

**___OHL DATA___**
clear all
import delimited "CHL Stats 2015 - OHL.csv", case(preserve) 

* 4 - Data clean up for OHL
drop v1
generate League = "OHL"
replace Name = "Julius Nattinen (C)" in 34
replace Name = "Gustaf Franzen (C/RW)" in 78
replace Name = "Vili Saarijarvi (D)" in 127
replace Name = "Markus Niemelainen (D)" in 229
replace Name = "Markus Soberg (RW/LW)" in 461

* Drop invalid rows
drop if missing(Team)

* 5 - Replicating player names for players in more than 1 team
gen PlayerName = Name
replace PlayerName = PlayerName[_n-1] if PlayerName == ""

* 6 - Generating role variables by separating them from PlayerName
gen Name2 = trim(usubstr(PlayerName, 1, ustrpos(PlayerName,"(")-1))
gen Role = trim(usubstr(PlayerName, ustrpos(PlayerName,"("), ustrlen(PlayerName)))

save "CHL Stats 2015 - OHL.dta", replace

** __ QMJHL DATA __ **
clear all
import delimited "CHL Stats 2015 - QMJHL.csv", case(preserve) 

* 7 - Data clean up for QMJHL
drop v1
generate League = "QMJHL"
replace Name = "Alex Barre-Boulet (C)" in 9
replace Name = "Nicolas Aube-Kubel (RW)" in 22
replace Name = "Frederic Allard (D)" in 76
replace Name = "Filip Chlapik (C)" in 87
replace Name = "Jeremy Lauzon (D)" in 94
replace Name = "Alexis Pepin (LW)" in 103
replace Name = "Filip Rydstrom (C)" in 104
replace Name = "Loik Leveille (D)" in 106
replace Name = "Phelix Martineau (C)" in 125
replace Name = "Frederic Aube (D)" in 137
replace Name = "Francois Beauchemin (C/RW)" in 140
replace Name = "Felix Lauzon (C)" in 148
replace Name = "Jeremy Roy (D)" in 189
replace Name = "Luc Deschenes (D)" in 200
replace Name = "Elie Berube (D)" in 205
replace Name = "Justin Guenette (D)" in 223
replace Name = "Joel Teasdale (LW)" in 232
replace Name = "Mathieu Sevigny (LW/C)" in 261
replace Name = "Raphael Santerre (LW)" in 264
replace Name = "Raphael Maheux (D)" in 287
replace Name = "Jeremy Bouchard (LW)" in 314
replace Name = "Louis-Filip Cote (LW)" in 323
replace Name = "Felix Boivin (D)" in 337
replace Name = "Marc-Andre Gauvreau (D)" in 352
replace Name = "Thomas Gregoire (D)" in 357
replace Name = "Eric Leger (LW)" in 358
replace Name = "Jeremie Beaudin (D)" in 368
replace Name = "Kevin Laliberte (D)" in 373
replace Name = "Raphael Bastille (C)" in 383
replace Name = "Timothe Simard (RW)" in 390
replace Name = "Maximilian Glassl (D)" in 391
replace Name = "Antoine Crete-Belzile (D)" in 429
replace Name = "Felix Girard (C/W)" in 464
replace Name = "Jean-Sebastien Taillefer (D)" in 469
replace Name = "Benjamin Gagne (D)" in 479
replace Name = "Alexandre Grise (C)" in 482
replace Name = "Felix Meunier (C)" in 527
replace Name = "Jeremy Groleau (D)" in 537
replace Name = "Charles Guevremont (C)" in 552
replace Name = "Simon Benoit (D)" in 561
replace Name = "Joel Caron (C/W)" in 571

* Drop invalid rows
drop if missing(Team)

* 8 - Replicating player names for players in more than 1 team
gen PlayerName = Name
replace PlayerName = PlayerName[_n-1] if PlayerName == ""

* 9 - Generating role variables by separating them from PlayerName
gen Name2 = trim(usubstr(PlayerName, 1, ustrpos(PlayerName,"(")-1))
gen Role = trim(usubstr(PlayerName, ustrpos(PlayerName,"("), ustrlen(PlayerName)))

save "CHL Stats 2015 - QMJHL.dta", replace

* 10 - Combine the 3 CHL leagues into one dataset
use "CHL Stats 2015 - OHL.dta"
append using "CHL Stats 2015 - WHL.dta"
append using "CHL Stats 2015 - QMJHL.dta"
save "2015-16 CHL.dta", replace

**___NHL DATA___**
clear all 
import delimited "CHL_NHL Draft Data UBC 2017-2015 - 2016", case(preserve) 
 
* 11 - Make sure variables are consistent with CHL data
rename Player Name
rename Team Team_D
replace Name = "Linus Nassen (D)" in 90

* 12 - Generating position variables -> separate into player name and position
gen Name2 = trim(usubstr(Name, 1, ustrpos(Name,"(")-1))
gen Role = trim(usubstr(Name, ustrpos(Name,"("), ustrlen(Name)))

* 13 - Drop Goaltenders from the dataset 
drop if Role == "(G)"

save "CHL_NHL Draft Data UBC 2017-2015 - 2016.dta", replace

* 14 - Remove "#" from DraftPosition
destring DraftPosition, replace ignore(`"#"')

* 15 - Delete extra variables (missing observations)
drop G A PTS PIMS GP Seasons

save "CHL_NHL Draft Data UBC 2017-2015 - 2016.dta", replace

**___PICK224 DATA___**
clear all

import delimited "2015-16 Pick224-Juniors", case(upper) 

* 16 - Rename and Drop variables
keep LEAGUE NAME DY DOB AGESEPT15 AGEDEC31 
rename LEAGUE League
rename NAME Name2

* 17 - Rename Player Names
replace Name2 = "Josh Anderson" in 1226
replace Name2 = "Max Lajoie" in 521
replace Name2 = "Mikhail Sergachyov" in 223
replace Name2 = "Tim Gettinger" in 256
replace Name2 = "Vladimir Bobylyov" in 158

save "2015-16 Pick224.dta", replace

* 18 - Merge NHL and CHL data
use "2015-16 CHL.dta"
merge m:1 Name2 League using "CHL_NHL Draft Data UBC 2017-2015 - 2016.dta"

* 19 - Account for players who played in the CHL after being drafted
sort _merge Name2
generate byte PlayedAfter = 0, after(DraftPosition)
replace PlayedAfter = 1 in 1458
replace PlayedAfter = 1 in 1459
replace PlayedAfter = 1 in 1460
replace PlayedAfter = 1 in 1461
replace PlayedAfter = 1 in 1462
replace PlayedAfter = 1 in 1463
replace PlayedAfter = 1 in 1464
replace PlayedAfter = 1 in 1465
replace PlayedAfter = 1 in 1466
replace PlayedAfter = 1 in 1467
replace PlayedAfter = 1 in 1458
replace PlayedAfter = 1 in 1459
replace PlayedAfter = 1 in 1460
replace PlayedAfter = 1 in 1461
replace PlayedAfter = 1 in 1462
replace PlayedAfter = 1 in 1463
replace PlayedAfter = 1 in 1464
replace PlayedAfter = 1 in 1465
replace PlayedAfter = 1 in 1466
replace PlayedAfter = 1 in 1467
replace PlayedAfter = 1 in 1470
replace PlayedAfter = 1 in 1471
replace PlayedAfter = 1 in 1472
replace PlayedAfter = 1 in 1473
drop in 1473

rename _merge merge1

* 20 - Merge with Pick 224
merge m:1 Name2 League using "2015-16 Pick224.dta"

* 21 - Generate draft year variable
gen Year = 2016

* 22 - Fix merged dataset
drop if missing(Team)
drop if GP <=10

* 23 - drop if under 18 years old/over 20
drop if AGESEPT15 < 18
keep if AGEDEC31 < 21

* 24 - Generate birth month and birth year
gen BirthMonth=substr(DOB,-5,2)
gen BirthYear=substr(DOB,1,4)
destring BirthYear, replace
destring BirthMonth, replace


save "2015-16 CHL_NHL_PICK224.dta", replace



*****************************************
*************** 2016-2017 ***************
*****************************************
clear all

**___WHL DATA___**
import delimited "CHL Stats 2016 - WHL.csv", case(preserve) 

* 1 - Data clean up for WHL
drop v1
generate League = "WHL"
replace Name = "Juuso Valimaki (D)" in 86
replace Name = "John Dahlstrom (LW/RW)" in 92
replace Name = "Dillon Dube (C/LW)" in 120
replace Name = "Libor Hajek (D)" in 308

* Drop invalid rows
drop if missing(Team)

* 2 - Replicating player names for players in more than 1 team
gen PlayerName = Name
replace PlayerName = PlayerName[_n-1] if PlayerName == ""

* 3 - Generating role variables by separating them from PlayerName
gen Name2 = trim(usubstr(PlayerName, 1, ustrpos(PlayerName,"(")-1))
gen Role = trim(usubstr(PlayerName, ustrpos(PlayerName,"("), ustrlen(PlayerName)))

save "CHL Stats 2016 - WHL.dta", replace

**___OHL DATA___**
clear all
import delimited "CHL Stats 2016 - OHL.csv", case(preserve) 

* 4 - Data clean up for OHL
drop v1
generate League = "OHL"
replace Name = "Gabe Vilardi (C)" in 56
replace Name = "Julius Nattinen (C)" in 165
replace Name = "Vili Saarijarvi (D)" in 227
replace Name = "Otto Makinen (C)" in 234

* Drop invalid rows
drop if missing(Team)

* 5 - Replicating player names for players in more than 1 team
gen PlayerName = Name
replace PlayerName = PlayerName[_n-1] if PlayerName == ""

* 6 - Generating role variables by separating them from PlayerName
gen Name2 = trim(usubstr(PlayerName, 1, ustrpos(PlayerName,"(")-1))
gen Role = trim(usubstr(PlayerName, ustrpos(PlayerName,"("), ustrlen(PlayerName)))

save "CHL Stats 2016 - OHL.dta", replace

**___QMJHL DATA___**
clear all
import delimited "CHL Stats 2016 - QMJHL.csv", case(preserve) 

* 7 - Data clean up for QMJHL
drop v1
generate League = "QMJHL"
replace Name = "Filip Chlapi­k (C)" in 6
replace Name = "Alex Barre-Boulet (C)" in 14
replace Name = "Frederic Allard (D)" in 42
replace Name = "Thomas Gregoire (D)" in 44
replace Name = "Mathieu Sevigny (LW/C)" in 79
replace Name = "Alexis Pepin (LW)" in 84
replace Name = "Felix Lauzon (C)" in 87
replace Name = "Phelix Martineau (C)" in 109
replace Name = "Joel Teasdale (LW)" in 112
replace Name = "Luc Deschenes (D)" in 172
replace Name = "David Noel (D)" in 205
replace Name = "Frederic Aube (D)" in 208
replace Name = "Jeremy Lauzon (D)" in 230
replace Name = "Jeremie Beaudin (D)" in 242
replace Name = "Felix Robert (C)" in 262
replace Name = "Rafael Harvey-Pinard (LW)" in 261
replace Name = "Raphael Maheux (D)" in 269
replace Name = "Alexandre Grise (C)" in 295
replace Name = "Louis-Filip Cote (LW)" in 296
replace Name = "Thomas Ethier (LW)" in 308
replace Name = "Benjamin Gagne (D)" in 324
replace Name = "Cedric Pare (C)" in 344
replace Name = "Mathieu Desgagnes (LW)" in 347
replace Name = "Hugo Despres (C)" in 354
replace Name = "Felix Meunier (C)" in 362
replace Name = "Felix Bibeau (C)" in 377
replace Name = "Mathias Laferriere (RW)" in 388
replace Name = "Jeremy Groleau (D)" in 405
replace Name = "Simon Benoit (D)" in 411
replace Name = "Maxim Trepanier (LW)" in 416
replace Name = "Remy Anglehart (C)" in 446
replace Name = "Raphael Lavoie (C/RW)" in 447
replace Name = "Jean-Sebastien Taillefer (D)" in 461
replace Name = "Jerome Gravel (D)" in 469
replace Name = "Etienne Verrette (D)" in 487
replace Name = "Mederik Racicot (D)" in 488
replace Name = "Alexis Sansfacon (D)" in 489
replace Name = "Jean-Simon Belanger (RW)" in 501
replace Name = "Antoine Crete-Belzile (D)" in 502
replace Name = "Eric Leger (LW)" in 513
replace Name = "Jeremy Manseau (C)" in 514
replace Name = "Jeremy Diotte (D)" in 531
replace Name = "Yann-Felix Lapointe (D)" in 545
replace Name = "Edouard Michaud (C)" in 564
replace Name = "Jeremy Roy (D)" in 573
replace Name = "Cedric Chouinard (D)" in 576
replace Name = "Cedric Desruisseaux (C/LW)" in 577
replace Name = "Alex Lafreniere (LW)" in 578

* Drop invalid rows
drop if missing(Team)

* 8 - Replicating player names for players in more than 1 team
gen PlayerName = Name
replace PlayerName = PlayerName[_n-1] if PlayerName == ""

* 9 - Generating role variables by separating them from PlayerName
gen Name2 = trim(usubstr(PlayerName, 1, ustrpos(PlayerName,"(")-1))
gen Role = trim(usubstr(PlayerName, ustrpos(PlayerName,"("), ustrlen(PlayerName)))

save "CHL Stats 2016 - QMJHL.dta", replace

* 10 - Combine the 3 CHL leagues into one dataset
use "CHL Stats 2016 - OHL.dta"
append using "CHL Stats 2016 - WHL.dta"
append using "CHL Stats 2016 - QMJHL.dta"
save "2016-17 CHL.dta", replace

**___NHL DATA___**
clear all 
import delimited "CHL_NHL Draft Data UBC 2017-2015 - 2017", case(preserve) 
 
* 11 - Make sure variables are consistent with CHL data
rename Player Name
rename Team Team_D
replace Name = "Kristian Roykas Marthinsen (F)" in 96
drop in 98

* 12 - Generating position variables -> separate into player name and position
gen Name2 = trim(usubstr(Name, 1, ustrpos(Name,"(")-1))
gen Role = trim(usubstr(Name, ustrpos(Name,"("), ustrlen(Name)))

* 13 - Drop Goaltenders from the dataset 
drop if Role == "(G)"

save "CHL_NHL Draft Data UBC 2017-2015 - 2017.dta", replace

* 14 - Remove "#" from DraftPosition
destring DraftPosition, replace ignore(`"#"')

* 15 - Delete extra variables (missing observations)
drop G A PTS PIMS GP Seasons

save "CHL_NHL Draft Data UBC 2017-2015 - 2017.dta", replace

**___PICK224 DATA___**
clear all

import delimited "2016-17 Pick224-Juniors", case(upper) 

* 16 - Rename and Drop variables
keep LEAGUE NAME DY DOB AGESEPT15 AGEDEC31 
rename LEAGUE League
rename NAME Name2

* 17 - Rename Player Names
replace Name2 = "Cole Fraser" in 750
replace Name2 = "Gabe Vilardi" in 42
replace Name2 = "Nicolas Hague" in 327
replace Name2 = "Nikita Popugayev" in 120
replace Name2 = "Trent Bourque" in 1266

save "2016-17 Pick224.dta", replace

* 18 - Merge NHL and CHL data
use "2016-17 CHL.dta"
merge m:1 Name2 League using "CHL_NHL Draft Data UBC 2017-2015 - 2017.dta"

* 19 - Account for players who played in the CHL after being drafted
sort _merge Name2
generate byte PlayedAfter = 0, after(DraftPosition)
replace PlayedAfter = 1 in 1513
replace PlayedAfter = 1 in 1514
replace PlayedAfter = 1 in 1517
replace PlayedAfter = 1 in 1518
replace PlayedAfter = 1 in 1519

rename _merge merge1

* 20 - Merge with Pick 224
merge m:1 Name2 League using "2016-17 Pick224.dta"

* 21 - Generate draft year variable
gen Year = 2017

* 22 - Fix merged dataset
drop if missing(Team)
drop if GP <=10

* 23 - drop if under 18 years old/over 20
drop if AGESEPT15 < 18
keep if AGEDEC31 < 21

* 24 - Generate birth month and birth year
gen BirthMonth=substr(DOB,-5,2)
gen BirthYear=substr(DOB,1,4)
destring BirthYear, replace
destring BirthMonth, replace


save "2016-17 CHL_NHL_PICK224.dta", replace



*****************************************
*************** 2017-2018 ***************
*****************************************
clear all

**___WHL DATA___**
import delimited "CHL Stats 2017 - WHL.csv", case(preserve) 

* 1 - Data clean up for WHL
drop v1
generate League = "WHL"
replace Name = "Dillon Dube (C/LW)" in 31
replace Name = "Juuso Valimaki (D)" in 166
replace Name = "Libor Hajek (D)" in 211
replace Name = "Filip Kral (D)" in 235
replace Name = "Linus Nassen (D)" in 325

* Drop invalid rows
drop if missing(Team)

* 2 - Replicating player names for players in more than 1 team
gen PlayerName = Name
replace PlayerName = PlayerName[_n-1] if PlayerName == ""

* 3 - Generating role variables by separating them from PlayerName
gen Name2 = trim(usubstr(PlayerName, 1, ustrpos(PlayerName,"(")-1))
gen Role = trim(usubstr(PlayerName, ustrpos(PlayerName,"("), ustrlen(PlayerName)))

save "CHL Stats 2017 - WHL.dta", replace

**___OHL DATA___**
clear all
import delimited "CHL Stats 2017 - OHL.csv", case(preserve) 

* 4 - Data clean up for OHL
drop v1
generate League = "OHL"
replace Name = "Eemeli Rasanen (D)" in 230

* Drop invalid rows
drop if missing(Team)

* 5 - Replicating player names for players in more than 1 team
gen PlayerName = Name
replace PlayerName = PlayerName[_n-1] if PlayerName == ""

* 6 - Generating role variables by separating them from PlayerName
gen Name2 = trim(usubstr(PlayerName, 1, ustrpos(PlayerName,"(")-1))
gen Role = trim(usubstr(PlayerName, ustrpos(PlayerName,"("), ustrlen(PlayerName)))

save "CHL Stats 2017 - OHL.dta", replace

**___QMJHL DATA___**
clear all
import delimited "CHL Stats 2017 - QMJHL.csv", case(preserve) 

* 7 - Data clean up for QMJHL
drop v1
generate League = "QMJHL"
replace Name = "Alex Barre-Boulet (C)" in 1
replace Name = "Alexis Lafreniere (LW)" in 11
replace Name = "Rafael Harvey-Pinard (LW)" in 22
replace Name = "Joel Teasdale (LW)" in 49
replace Name = "Felix Bibeau (C)" in 53
replace Name = "Raphael Lavoie (C/RW)" in 51
replace Name = "David Noel (D)" in 113
replace Name = "Mathias Laferriere (RW)" in 140
replace Name = "Cedric Pare (C)" in 164
replace Name = "Jeremie Beaudin (D)" in 180
replace Name = "Jeremy Manseau (C)" in 184
replace Name = "Thomas Ethier (LW)" in 190
replace Name = "Maxim Trepanier (LW)" in 192
replace Name = "Remy Anglehart (C)" in 195
replace Name = "Felix Lauzon (C)" in 205
replace Name = "Mathieu Sevigny (LW/C)" in 208
replace Name = "Jeremy Diotte (D)" in 212
replace Name = "Nathan Legare (RW)" in 218
replace Name = "Felix Boivin (D)" in 219
replace Name = "Felix-Antoine Marcotty (RW)" in 223
replace Name = "Simon Benoit (D)" in 226
replace Name = "Edouard St-Laurent (RW)" in 236
replace Name = "Louis-Filip Cote (LW)" in 253
replace Name = "Jerome Gravel (D)" in 263
replace Name = "Jeremy Michel (RW)" in 269
replace Name = "Mederik Racicot (D)" in 296
replace Name = "Etienne Verrette (D)" in 293
replace Name = "Alexandre Grise (C)" in 310
replace Name = "Olivier Crete-Belzile (D/LW)" in 317
replace Name = "Mathieu Desgagnes (LW)" in 319
replace Name = "Yann-Felix Lapointe (D)" in 324
replace Name = "Jeremy Groleau (D)" in 328
replace Name = "Edouard Ouellet (RW)" in 345
replace Name = "Jeremy Fortin (LW)" in 348
replace Name = "Justin Pare(C)" in 354
replace Name = "Maxence Guenette (D)" in 364
replace Name = "Jeremy Cote (LW)" in 370
replace Name = "Charles-Antoine Giguere (LW)" in 375
replace Name = "Frederik Theoret (LW)" in 376
replace Name = "Antoine Crete-Belzile (D)" in 384
replace Name = "Alexis Sansfacon (D)" in 399
replace Name = "Jeremy Laframboise (C)" in 404
replace Name = "Felix-Antoine Drolet (D)" in 412
replace Name = "Marc-Andre LeCouffe (C)" in 425
replace Name = "Jeremy Martin (LW)" in 428
replace Name = "Jean-Simon Belanger (RW)" in 429
replace Name = "Frederic Abraham (RW)" in 448
replace Name = "Felix Meunier (C)" in 487
replace Name = "Pierrick Dube (RW)" in 485
replace Name = "Felix Pare (RW)" in 503
replace Name = "Nathael Roy (RW)" in 515
replace Name = "Alex Lafreniere (LW)" in 516
replace Name = "Marc-Antoine Gagne (F)" in 529

* Drop invalid rows
drop if missing(Team)

* 8 - Replicating player names for players in more than 1 team
gen PlayerName = Name
replace PlayerName = PlayerName[_n-1] if PlayerName == ""

* 9 - Generating role variables by separating them from PlayerName
gen Name2 = trim(usubstr(PlayerName, 1, ustrpos(PlayerName,"(")-1))
gen Role = trim(usubstr(PlayerName, ustrpos(PlayerName,"("), ustrlen(PlayerName)))

save "CHL Stats 2017 - QMJHL.dta", replace

* 10 - Combine the 3 CHL leagues into one dataset
use "CHL Stats 2017 - OHL.dta"
append using "CHL Stats 2017 - WHL.dta"
append using "CHL Stats 2017 - QMJHL.dta"
save "2017-18 CHL.dta", replace


**___NHL DATA___** 
clear all 
import delimited "CHL_NHL Draft Data UBC 2018-2015 - 2018", case(preserve) 

* 11 - Make sure variables are consistent with CHL data
rename Player Name
rename Team Team_D
replace Name = "Filip Kral (D)" in 64
replace Name = "Jan Jeni­k (F)" in 75
replace Name = "Mathias Laferriere (F)" in 41

* 12 - Generating role variables by separating them from PlayerName
gen Name2 = trim(usubstr(Name, 1, ustrpos(Name,"(")-1))
gen Role = trim(usubstr(Name, ustrpos(Name,"("), ustrlen(Name)))

* 13 - Drop Goaltenders from the dataset 
drop if Role == "(G)"

* 14 - Remove "#" from DraftPosition
destring DraftPosition, replace ignore(`"#"')

* 15 - Delete extra variables (missing observations)
drop G A PTS PIMS GP Seasons

save "CHL_NHL Draft Data UBC 2017-2015 - 2018.dta", replace

**___PICK224 DATA___**
clear all

import delimited "2017-18 Pick224-Juniors", case(upper) 

* 16 - Rename and Drop variables
keep LEAGUE NAME DY DOB AGESEPT15 AGEDEC31 
rename LEAGUE League
rename NAME Name2

* 17 - Rename Player names/drop duplicates
replace Name2 = "Dominic Cormier" in 449
replace Name2 = "Josh Anderson" in 852
replace Name2 = "Riley Bruce" in 861
replace Name2 = "Dmitri Zaitsev" in 863
replace Name2 = "Linus Nassen" in 888
replace Name2 = "Cole Fraser" in 1007
replace Name2 = "Dominic Cormier" in 1067
replace Name2 = "Nicolas Roy " in 1126
replace Name2 = "Nikita Alexandrov" in 1257
replace Name2 = "Joshua Anderson" in 1335
replace Name2 = "Nikita Alexandrov" in 413
drop in 1322
drop in 1257
drop in 1253
drop in 1067

save "2017-18 Pick224.dta", replace

* 18 - Merge NHL and CHL data
use "2017-18 CHL.dta"
merge m:1 Name2 League using "CHL_NHL Draft Data UBC 2017-2015 - 2018.dta"

* 19 - Account for players who played in the CHL after being drafted
sort _merge Name2
generate byte PlayedAfter = 0, after(DraftPosition)
replace PlayedAfter = 1 in 1511
replace PlayedAfter = 1 in 1512
replace PlayedAfter = 1 in 1513
replace PlayedAfter = 1 in 1515
replace PlayedAfter = 1 in 1516
replace PlayedAfter = 1 in 1517
replace PlayedAfter = 1 in 1518
replace PlayedAfter = 1 in 1519
replace PlayedAfter = 1 in 1520

rename _merge merge1

* 20 - Merge with Pick 224
merge m:1 Name2 League using "2017-18 Pick224.dta"

* 21 - Generate draft year variable
gen Year = 2018

* 22 - Fix merged dataset
drop if GP <=10
drop if missing(Team)

* 23 - drop if under 18 years old/over 20
drop if AGESEPT15 < 18
keep if AGEDEC31 < 21

* 24 - Generate birth month and birth year
gen BirthMonth=substr(DOB,-5,2)
gen BirthYear=substr(DOB,1,4)
destring BirthYear, replace
destring BirthMonth, replace


save "2017-18 CHL_NHL_PICK224.dta", replace

*****************************************
*************** 2018-2019 ***************
*****************************************

**___NHL DATA___** 
clear all
import delimited "CHL Stats 2018 - CHL_NHL", case(preserve) 

* Data clean up
rename Team Team_D
replace Name = "Jérémy Michel (F)" in 44
replace Name = "Raphaël Lavoie (F)" in 45
replace Name = "Maxence Guénette (D)" in 43
replace Name = "Michal Teply (F)" in 52
replace Name = "Rafaël Harvey-Pinard (F)" in 49
replace Name = "Félix Bibeau (F)" in 48
replace Name = "Nathan Légaré (F)" in 41
replace Name = "Mads Sogaard (G)" in 54
 
* 1 - Generating position variables -> separate into player name and position
gen Name2 = trim(usubstr(Name, 1, ustrpos(Name,"(")-1))
gen Role = trim(usubstr(Name, ustrpos(Name,"("), ustrlen(Name)))

* 2 - Drop Goaltenders from the dataset 
drop if Role == "(G)"

save "CHL Stats 2019 - CHL_NHL.dta", replace

* 3 - Delete extra variables (missing observations)
drop G A PTS PIMS GP Seasons

save "CHL Stats 2019 - CHL_NHL.dta", replace

**___PICK224 DATA___**
clear all

import delimited "2018-19 Pick224-Juniors", case(upper) 

* 4 - Rename and Drop variables
keep LEAGUE NAME DY DOB AGESEPT15 AGEDEC31 
rename LEAGUE League
rename NAME Name2

* 5 - Rename Player Names
replace Name2 = "Alexei Protas" in 280
replace Name2 = "Artemi Knyazev" in 356
replace Name2 = "Félix Bibeau" in 136
replace Name2 = "Henrik Rybinski" in 239
replace Name2 = "Jérémy Michel" in 357
replace Name2 = "Maxence Guénette" in 558
replace Name2 = "Mikhail Abramov" in 234
replace Name2 = "Nathan Légaré" in 35
replace Name2 = "Nikita Alexandrov" in 167
replace Name2 = "Rafaël Harvey-Pinard" in 67
replace Name2 = "Raphaël Lavoie" in 89
replace Name2 = "Yegor Serdyuk" in 130

save "2018-19 Pick224.dta", replace

* 6 - Merge NHL and CHL data
use "2018-19 CHL.dta"
merge m:1 Name2 League using "CHL Stats 2019 - CHL_NHL.dta"

* 7 - Account for players who played in the CHL after being drafted
sort _merge Name2
generate byte PlayedAfter = 0, after(DraftPosition)
replace PlayedAfter = 1 in 1284
replace PlayedAfter = 1 in 1285
replace PlayedAfter = 1 in 1286
replace PlayedAfter = 1 in 1287
replace PlayedAfter = 1 in 1288
replace PlayedAfter = 1 in 1289
replace PlayedAfter = 1 in 1290

rename _merge merge1

* 8 - Merge with Pick 224
merge m:1 Name2 League using "2018-19 Pick224.dta"

* 9 - Generate draft year variable
gen Year = 2019

* 10 - Fix merged dataset
drop if missing(Team)
drop if GP <=10

* 11 - drop if under 18 years old/over 20
drop if AGESEPT15 < 18
keep if AGEDEC31 < 21

* 12 - Generate birth month and birth year
drop BirthYear
gen BirthMonth=substr(DOB,-5,2)
gen BirthYear=substr(DOB,1,4)
destring BirthYear, replace
destring BirthMonth, replace


save "2018-19 CHL_NHL_PICK224.dta", replace


*****************************************
*************** MERGED DATA *************
*****************************************

use "2014-15 CHL_NHL_PICK224.dta"

append using "2015-16 CHL_NHL_PICK224.dta" "2016-17 CHL_NHL_PICK224.dta" "2017-18 CHL_NHL_PICK224.dta" "2018-19 CHL_NHL_PICK224.dta"

save "***MASTER DATA FILE-KL***.dta", replace

*** _____ CLEAN UP MERGED DATA _____ ***

* Generating Dummy variable to separate Forwards from Defensemen
gen Forward = 1
replace Forward = 0 if Role == "(D)"
replace Forward = 2 if Role == "(D/F)"
replace Forward = 2 if Role == "(D/LW)"
replace Forward = 2 if Role == "(D/RW)"
replace Forward = 2 if Role == "(LW/D)"
replace Forward = 2 if Role == "(RW/D)"
replace Forward = 2 if Role == "(C/D)"

* Generating Dummy Variable for TeamChange
gen TeamChange = 0
replace TeamChange = 1 if Team == "totals"

* Generating Dummy variable for Drafted = 1 when players got drafted to NHL
gen Drafted = 1
replace Drafted = 0 if DraftPosition == .
drop _merge

* Generating per game averages for Goals and Assists
gen A_GM = A/GP
gen G_GM = G/GP

* Deleting duplicate variables
drop if missing(Name)
drop Name
drop PlayerName
drop Role
drop merge1
drop DY
drop DOB
drop AGEDEC31

* Delete players who played in CHL after being drafted
drop if PlayedAfter == 1

* Reorder variables
order Name2, before (GP)
order Year, before (Name2)
order DraftPosition, before(Name2)
order A_GM, before(PTSGM)
order G_GM, before(A_GM)
order PIMS, before(G_GM)
order PLUSMINUS, before(G_GM)
order Team, before (PlayedAfter)
order BirthYear, before (League)
order BirthMonth, before (League)
order AGESEPT15, before (BirthYear)
order Team_D, before (PlayedAfter)

* Generate draft round
sort DraftPosition
generate byte DraftRound = ., before(Name) 
replace DraftRound = 1 if DraftPosition >=1 & DraftPosition <=31
replace DraftRound = 2 if DraftPosition >=32 & DraftPosition <=62
replace DraftRound = 3 if DraftPosition >=63 & DraftPosition <=93
replace DraftRound = 4 if DraftPosition >=94 & DraftPosition <=124
replace DraftRound = 5 if DraftPosition >=125 & DraftPosition <=155
replace DraftRound = 6 if DraftPosition >=156 & DraftPosition <=186
replace DraftRound = 7 if DraftPosition >=187 & DraftPosition <=217

* Generate variable that categorizes birth months into quarters
generate byte BirthQuarter = 1, after(BirthMonth)
replace BirthQuarter = 2 if BirthMonth ==4|BirthMonth ==5|BirthMonth ==6
replace BirthQuarter = 3 if BirthMonth ==7|BirthMonth ==8|BirthMonth ==9
replace BirthQuarter = 4 if BirthMonth ==10|BirthMonth ==11|BirthMonth ==12

* Generate variable that shows age in terms of months
generate long AGE_month = AGESEPT15 *12, after(AGESEPT15)

* Rename and Label variables
rename Name2 Name
label variable Year "Draft Year"
label variable Team "CHL Team"
label variable Name "Name"
label variable GP "Games Played"
label variable G "Games"
label variable A "Assists"
label variable PTS "Points"
label variable PIMS "Penalty Minutes"
label variable League "CHL League"
label variable Team_D "NHL Team"
label variable Forward "=1 if forward, =0 if defensemen, =2 if both"
label variable TeamChange "=1 if changed teams, =0 if did not change teams"
label variable Drafted "=1 if drafted, =0 if not drafted"
label variable A_GM "Assists Per Game"
label variable G_GM "Goals Per Game"
label variable PTSGM "Points Per Game"
label variable DraftRound "Draft Round"
label variable PlayedAfter "=1 if played in CHL after drafted, =0 if otherwise"
label variable BirthMonth "Birth Month"
label variable BirthYear "Birth Year"
label variable BirthQuarter "Birth Quarter of Player"
label variable AGESEPT15 "Age on NHL Draft Cutoff"
label variable AGE_month "Age (in months) on NHL Draft Cutoff during Draft Year"

save "***MASTER DATA FILE-KL***.dta", replace

//by Year, sort: tabulate Year Drafted
** show birthmonths and drafted
summarize DraftPosition GP G A PTS G_GM A_GM PTSGM PIMS PLUSMINUS AGESEPT15 

* drop defensemen
keep if Forward ==1|Forward ==2



