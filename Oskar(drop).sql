/* drop sequence */
drop sequence MedicalCard$;
drop sequence History_Diseases$;
drop sequence Patient$;
drop sequence Preparation$;
drop sequence Department$;
drop sequence Diseases$;

/* drop trigger */
drop trigger MedicalCard;
drop trigger Patient;
drop trigger Preparation;
drop trigger Diseases;
drop trigger Department;
drop trigger History_Diseases;

/* drop procedure */
drop procedure ProcPatient;
drop procedure Ins_Doctor;
drop procedure InsMedicalCArd;

/* drop function */
drop function FindPatient;

/* drop view */
drop view View_MC;

/* table */
drop table History_Diseases;
drop table MedicalCard;
drop table Doctors;
drop table Patient;
drop table Preparation;
drop table Diseases;
drop table Department;

