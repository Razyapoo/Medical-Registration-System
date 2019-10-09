/* Create tabls */
/* Department*/
create table  Department ( /* отделение */
     Dep_ID numeric(10, 0)
        constraint Dep_PK
        primary key,
     Department character varying(30) unique not null
);
/
/*Diseases*/
create table Diseases ( /* заболевание */
    Dis_ID numeric(10, 0)
        constraint Dis_PK
        primary key,
    Diseases varchar2(100) unique not null,
    Description varchar2(4000 Byte)
); 
/
/*Preparation*/
create table Preparation ( /* лекарства */
    Prep_ID numeric(10, 0)
        constraint Prep_PK
        primary key,
    Preparat character varying(50) unique not null
);
/
/*Patient*/
create table Patient( /* пациенты */
    Pat_ID numeric(10, 0)
        constraint Pat_PK
        primary key not null,
    First_name character varying(15) not null,
    Last_name character varying(20) not null,
    BirthDate date not null,
    Adress character varying(30) not null,
    Email character varying(40)
        constraint Unique_Patient_Email
            unique
        constraint Email_Patient_CHK
            check (Email like '_%@_%._%'),
    Phone_num character varying(14),
        constraint Phone_Patient_num
            check (regexp_like(Phone_num, '^\+?[[:digit:]]*$')),
    Balance numeric(10, 0) default 0 check (Balance >= 0),
    Currency char(3) default 'CZK'
    check (Currency in ('CZK','EUR','USD'))
);
/
/*Doctors*/
create table Doctors ( /* врачи */
    Doc_ID numeric(10, 0)
        constraint Doc_PK
        primary key
      references Patient(Pat_ID), 
    Doc_Specialization character varying(25) unique not null,
    Is_Valid char(1) default 'Y' check (Is_Valid in ('N','Y'))
);
/
/*MedicalCard*/
create table MedicalCard (
    MC_ID numeric(10, 0) not null
        constraint MC_PK
        primary key,
    Pat_ID numeric(10, 0)
            unique
        references Patient(Pat_ID)
        on delete cascade
);
/
/*History_Diseases*/
create table History_Diseases( 
    HD_ID numeric(10, 0)
        constraint HD_PK
            primary key,
    HD_MC numeric(10, 0) not null, 
        constraint FK_HD_MC
        foreign key (HD_MC) 
        references MedicalCard (MC_ID)
        on delete cascade,
    Diseases numeric(10, 0),
        foreign key (Diseases) 
        references Diseases(Dis_ID),
    Department numeric(10, 0),
        foreign key (Department) 
        references  Department(Dep_ID),
    Doctor numeric(10, 0),
        foreign key (Doctor) 
        references Doctors(Doc_ID),
    Prescription numeric(10, 0),
        foreign key (Prescription) 
        references Preparation(Prep_ID),
    Allergy char(1) default 'N' check (Allergy in ('N','Y')),
    AppealDate date,
    Cena numeric(10, 0) check (Cena >= 0),
    Currency char(3) default 'CZK' not null
        check (Currency in ('CZK','EUR','USD'))
);
/

create index idx_Patient_Last on Patient(Last_name);
create index idx_Patient_First on Patient(First_name);
create index idx_Doc_Spec on Doctors(idx_Doc_Specialization);

create index idx_HD_MC on HISTORY_DISEASES(HD_MC);
create index idx_HD_Diseases on HISTORY_DISEASES(Diseases);
create index idx_HD_Department on HISTORY_DISEASES(Department);
create index idx_HD_Doctor on HISTORY_DISEASES(Doctor);
create index idx_HD_Prescription on HISTORY_DISEASES(Prescription);


/* Create views */
create or replace view View_MC (NumCart, Patient, Diseases,  Department, Doctor, Doctor_Specialization, Appeal_Date, Cena, Currency)
as select 
    MC_ID, Patient.First_Name||' '||Patient.Last_Name,
    Diseases.Diseases, Department.Department,p.First_Name||' '||p.Last_Name,
    Doctors.Doc_Specialization,History_Diseases.Appealdate, History_Diseases.Cena,
    History_Diseases.Currency
from MedicalCard inner join History_Diseases on MedicalCard.MC_Id = History_Diseases.HD_MC
left outer join Patient on (Patient.Pat_ID = MedicalCard.Pat_ID)
left outer join Diseases on (Diseases.Dis_Id = History_Diseases.Diseases)
left outer join Department on (Department.Dep_ID = History_Diseases.Department)
left outer join Doctors on (Doctors.Doc_ID = History_Diseases.Doctor)
left outer join Patient p on (p.Pat_ID = Doctors.Doc_ID)
;
