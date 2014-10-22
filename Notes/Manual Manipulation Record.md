Manual Manipulation Record
=======
<SUP>\*</SUP>This file records change that has been manually made by Hao S. but not the original author.

###2014-8-14
- Data -55 El Salvador-SJN.xlsx: cen->countryn
- Data - 84 Isreal - YML.xlsx: 隐藏了三列错误信息，导入时没发现，我去年买了个登山包
- Data - 86 Jordan - LC.xlsx: year = 1953 (line==3)
- Clean format and hyperlinks:
	- data- 103 bulgaria-sjn.xlsx 
	- data-104 czechoslovakia-sjn.xlsx 
	- data-129 australia-sjn.xlsx 
	- data-131 new zealand-sjn.xlsx 
	- data-52 canada-sjn.xlsx
	- data-79 china-sjn.xlsx

###2014-8-20
- Data -55 El Salvador-SJN-revised.xlsx: cen->countryn, 更新一次还是错，无语凝噎 
- Data - 59 Honduras  - YML.xlsx: countryn->Honduras, country->59
- Data - 158 Cequatorial guinea- LC-.xlsx:-> Data - 158 equatorial guinea- LC-.xlsx
- Data - 83 iraq- YML: no constituion nor elective law before 1958=[blank]

###2014-8-23
- Data - 119 Poland - SH.xlsx: firstterm_ce <-->Nterm
- Data - 167 Lebanon.xlsx: firstterm_ce <-->Nterm
- Data - 25 Madagascar - SH.xlsx: length_ce = 2(year == 1995); length_ce = 3(year==1996)
- Data - 87 Panama - LC-.xlsx: length_ce = 2(year==2010)
- Data - 67 Bolivia - SH.xlex: length_ce = 2(year == 1966); length_ce = 3(year==1967); length_ce = 4(year==1968)
- Data - 90 Mongolia - SH.xlsx: length_ce = 2(year == 1951); length_ce = 3(year==1952)
- Data - 87 ZhangTianhong1.xlsx: length_ce = 2(year==1955, PIPECode = 96)
- Data - 87 ZhangTianhong1.xlsx: length_ce = 2:8(year==2007:2013, PIPECode = 96)
- Data - 167 Lebanon - SH.xlsx: length_ce = 2(year == 1998); length_ce = 3(year==1999)

###2014-8-24
- Data - 9 central africa - YML: exp_ce_centralyear = 20(year = 1982); exp_ce_militaryyear = 26(year = 1982)

###2014-8-30
- log-revised Zhangtianhong: drop the extra headers

###2014-9-18 From *SJN*
- El Salvador 1956,1967,1977 exp_ce_minister->1
- 1956,1977 exp_ce_central->1
- 1989 exp_ce_legis,exp_ce_manager->1
- 1989,2004 exp_ce_private->1
- 1984,1994 exp_ce_governor,exp_ce_Ngovernor,exp_ce_party->1
- Indonesia 1951 exp_ce_ministeryear->0
- 1951 Exp_ce_legisyear->1
- Saudi Arabia 1950-1952 exp_ce_governor->0

###2014-9-18 From *YSQ*
-Tanzania
	- gender_ce=0
	- 1970: firstterm_ce=0
- Yemen
	- 1991-2010: firstterm_ce=0
	- 1991-2010: exp_ce_vice=1, exp_ce_viceyear=0  note: last for about one month
- Zambia
	- 1964-1967: exp_ce_public=1
- Yugoslavia
	- 1988: exp_ce_vice=0
	- 1991: exp_ce_vice=0
	- 1990: exp_ce_central=1??exp_ce_centralyear=0
- Cyprus
	- 1977: exp_ce_minister=1
	- 2008: exp_ce_private=1
	- 1968: exp_ce_central=1
- Colombia
	- 1953-1957: exp_ce_minister=1
	- 1958: exp_ce_private=1
	- 1982: exp_ce_private=1
	- 1990: exp_ce_private=1
	- 1967: exp_ce_centralyear=1958: exp_ce_party=1
	- 1974: exp_ce_party=1
	- 1990: exp_ce_party=1
- Ecuador 
	- 2007-2010: exp_ce_ministeryear=0     note: last only for four months  
- Turkey
	- 1950-1959: exp_ce_party=0, exp_ce_partyyear=0
	- 1961-1964: exp_ce_partyyear=23
	- 1965-1970: exp_ce_partyyear=1
	- 1999-2001: exp_ce_partyyear=19
	- 2003-2006: exp_ce_partyyear=2
	- 2007-2010: exp_ce_partyyear=2
	- 1965-1968: exp_ce_central=1??exp_ce_centralyear=0
	- 1975: exp_ce_privateyear=3
- Thailand
	- 1955: exp_ce_manager=1
	- 2001: exp_ce_manager=1
	- 1975: exp_ce_private=1
- Taiwan
	- 1988-2002: exp_ce_party=0
- Germany
	- 1998-2004:exp_ce_party=0

###2014-10-1 From *ZTH*
- Nigeria 1960-1965 exp_ce_vice ->0,exp_ce_viceyear->0
- Sri Lanka 1956-1959 exp_ce_Ngovernor->1 
- Namibia 2009 exp_ce_party->1

###2014-10-20 From *LC*
- Thegambia 2008-2010，exp_ce_Ngovernor->1
- Ivory Coast 2008-2010, exp_ce_Ngovernor->1
- Liberia 1960-1961, exp_ce_Ngovernor->1

###2014-10-22 From *XTY*
- Guatemala, 1969-1970 exp_ce_public->1
- Guatemala, 2001-2008, exp_ce_minister->1
- Guatemala, 1973,1976, exp_ce_minister->1
- Guatemala， 1960-1961， exp_ce_party->1
- Guatemala, 1968-1970, exp_ce_public->1
- Honduras, 1970-1973, exp_ce_public->1
- Honduras， 2004-2010, exp_ce_minister->1
- Honduras，  1970-1973, exp_ce_pubic->1
- Isreal, 1996-1998, exp_ce_ministeryear->1
- Isreal, 2009-2010, exp_ce_ministeryear->8
- Iraq, 2004-2010, exp_ce_central->0
- Iran 1980， exp_ce_central->1
- Iran 2005-2010, exp_ce_private->0


