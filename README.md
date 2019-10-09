Elektronická zdravotní knížka
===
**Elektronická zdravotní knížka je vysoce zabezpečený souhrn zdravotních informací o pacientovi, který je přístupný v elektronické podobě.**

verze 0.1.0

# 
***Aplikace slouží jako elektronická knížka, která obsahuje informací o pacientovi.***

Nejdříve je nutné přidat oddělení, nemocí a léky.  Pak je možnost přidávat pacienty pomocí procedury “ProcPatient”. Aby přidat lékaře do bázy, je nutné nejdříve ho přidat do bázy pacientů, a pak už přidat do bázy lékařů pomocí procedury ***“INS_DOCTOR”***. Tedy báza pacientů je globální (lékař může být pacientem).  Pomocí procedury ***„InsMedicalCard”*** je možnost vytvořit zdravotní knížku pacienta.

Update a Delete jsou standartní. 

Tabulka ***„Department“*** obsahuje ID a název oddělení. 

Tabulka ***„Preparation“*** obsahuje ID a název leků.

Tabulka ***„Patient“*** obsahuje údaje o pacientovi (jeho ID, jméno, příjmení, datum narození, adresu, email, telefonní číslo, balance a měnu).

Pomocí Indexu sortujeme pacienty.

Tabulka ***“Doctors”*** obsahuje ID doktora a jeho specializace. 

Tabulka ***„History_Diseases“*** obsahuje HD_ID, HD_MC(medical card), nemocí, oddělení, doktory, recepty, alergie, datum návštěvy, cenu procedury a měnu.

Tabulka ***„MedicalCard“*** obsahuje MC_ID, Pat_ID (ID pacienta).

# 
View sloučí několik atributů. Využívá se pro popis návštěvy pacienta. Obsahuje MC_ID, jméno a příjmení pacientu, důvod (nemoc), oddělení (kterou navštívil pacient), jméno a příjmení doktora, jeho specializace, datum návštěvy, cenu procedury a měnu.

Procedura ***“ProcPatient”*** přijímá jako argumenty Jméno (povinné), Příjmení (povinné), datum narození (povinné), adresu (povinné), email (dle potřeby), telefonní číslo (dle potřeby), balance (nemůže být záporný).

Procedura ***„Ins_Doctor“*** přijímá jako argumenty Jméno, Příjmení a specializace pracovníka. Sloučí pracovníka s jeho specializací a přidá ho do bázy ***„Doctors“***. Nejdříve musíme ověřit, jestli vůbec existuje pracovník jako pacient.  

Procedura ***„InsMedicalCard“*** vytvoří pro pacienta novou zdravotní knížku. Přidá pacienta do bázy ***„MedicalCard“*** a do ***„History_Deseases“*** ho historie.

Procedura ***“FindPatient“*** vyhledá pacienta pomocí jména a příjmení. Pokud neexistuje, nahlásí chybu. 
 
Trigger ***„Department“*** se zavolá před vložením nového oddělení. Jestli oddělení ID je prázdné, tedy do nového ODD_ID se vloží další po pořadí ID.

Triggery ***„Diseases“***, ***„Preparation“***, ***„History_Diseases“*** jsou analogické triggeru ***„Department“***.

Trigger ***„Patient“*** se zavolá při insertu nebo updatu pacienta. Pokud pacienta smažíme, odstraní se z tabulek ***„Medical_Card“*** a ***„Doctors“***.



