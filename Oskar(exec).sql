@Oskar(create_tabel).sql
@Oskar(create_procedure).sql
@Oskar(create_trigger).sql

insert into Department values('','OTORINOLARYNGOLOGIE');
insert into Department values('','KARDIOLOGIE A ANGIOLOGIE');
insert into Department values('','OCNI');

insert into Diseases values('','ANGINA','');
insert into Diseases values('','INFARKT','');
insert into Diseases values('','VRED ROHOVKY','');

insert into Preparation values(null,'STREPSILS');
insert into Preparation values(null,'MAGNE B6');
insert into Preparation values(null,'ARTELAC CL');
commit;

/* Insert a procedure */
execute ProcPatient('Zuzana','',Sysdate,'Molod, h.6','','420578607777',100);
execute ProcPatient('Zuzana','Beranovska',Sysdate,'Molod, h.6','','-420 578 60 77 77',100);
execute ProcPatient('Zuzana','Beranovska',Sysdate,'Molod, h.6','','420578607777',-1);
/*Пациент модет быть доктором. Двнные доктора заполняются через пациента*/
execute ProcPatient('Jana','Jurisa','01/02/2001','ul. VODICKOVA, h.64, b1','Jana@gmail.com','420578608888',100);
execute ProcPatient('Pavel','Vit','29/02/1996','ul. JELENY, h.73','','420122430757',99);
execute ProcPatient('Adela','Suskova','3/11/1968','ul. JELENY, h.354','Suskova@gmail.com','420578604444',130);
execute ProcPatient('Martin','Hromcik','07/06/93','ul. JELENY, h.111, b3','','4205786003862',0);
execute ProcPatient('Milan','Georges','15/03/77','ul. JELENY, h.2, b.18','MilanGeorges@gmail.com','+420578607576',1000);

Select FIRST_NAME,LAST_NAME,PHONE_NUM,EMAIL From Patient where Pat_ID = FindPatient(5);
/ 

/* insert into Doctors */
execute INS_DOCTOR(FindPatient(3),'OTORINOLARYNGOLOGIE');
execute INS_DOCTOR(FindPatient(5),'KARDIOLOGIE');
select FIRST_NAME, LAST_NAME, PHONE_NUM, Doc_Specialization FROM Doctors INNER JOIN Patient ON Doctors.Doc_Id = Patient.Pat_Id;

/* New Medical Card */
execute InsMedicalCard(FindPatient(2),'ANGINA', 'OTORINOLARYNGOLOGIE','OTORINOLARYNGOLOGIE',1000);
execute InsMedicalCard(FindPatient(4),'ANGINA', 'OTORINOLARYNGOLOGIE','OTORINOLARYNGOLOGIE',800);
execute InsMedicalCard(FindPatient(3),'INFARKT', 'KARDIOLOGIE','KARDIOLOGIE A ANGIOLOGIE',900);
select * from view_mc;
/

update History_Diseases set Cena=800 Where HD_MC = (select MC_ID from MedicalCard where Pat_ID=FindPatient(3) and rownum=1);

explain plan for
select * from view_mc where doctor='Adela Suskova' and Diseases='ANGINA';
select plan_table_output
from table(
  dbms_xplan.display()
  );

Delete from MedicalCard Where pat_id=FindPatient(3);
select * from view_mc;
/
/**/
SELECT * FROM Patient;
delete from Patient WHERE PAT_ID =2;
SELECT * FROM Patient;
select * from view_mc;
delete from Patient WHERE PAT_ID =3;
SELECT * FROM Patient;
update doctors set Is_Valid='N' Where doc_id=3;

/**/

