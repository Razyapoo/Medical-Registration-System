--Find Patient
create or replace function FindPatient
   ( Num_Patient IN number)
   return number
is
   pnumber number;
   cursor c1 is select Pat_ID from Patient where pat_id = Num_Patient;
begin
   open c1;
   fetch c1 into pnumber;
   if c1%NOTFOUND then
      pnumber := null;
   end if;
   close c1;
return pnumber;
 
exception	 	 
when others then	 	 
 raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
end;
/
/* Insert Patient. */
create or replace procedure ProcPatient(
Firstname  patient.First_Name%TYPE,
Lastname   Patient.Last_Name%TYPE,
BirthDate  Patient.BirthDate%TYPE,
Adress     Patient.Adress%TYPE,
Email      Patient.Email%TYPE,
Phonenum   Patient.Phone_num%TYPE,
Balance    Patient.Balance%TYPE)
is
    rep varchar2(50);
begin
	if (Firstname is null or Lastname is null) then
        raise_application_error(-20001,'Firstname or Lastname of the Patient must be set.');
    end if;
	if BirthDate is null then
        raise_application_error(-20002,'Birth Date must be set.');
    end if;
	if Adress is null then
        raise_application_error(-20003,'Adress must be set.');
    end if;
	if not regexp_like(Phonenum, '^\+?[[:digit:]]*$') then
        raise_application_error(-20004,'Wrong format of Phone.');
    end if;
	if (Email not LIKE '%@%.%') then
        raise_application_error(-20004,'Wrong format of email.');
    end if;
    if Balance < 0 then
        raise_application_error(-20006,'Negative Balance cannot be transferred!');
    end if;

    insert into Patient( First_name, Last_name, BirthDate, Adress, Email, Phone_num, Balance )
        values( Firstname, Lastname, BirthDate, Adress, Email, Phonenum, Balance );
end;
/
/* Insert Doctor. */
create or replace procedure Ins_Doctor(
Num_Patient  patient.pat_id%TYPE,
Specialization Doctors.Doc_Specialization%TYPE)
is
    rep varchar2(50);
begin
    if FindPatient(Num_Patient) is null then
            raise_application_error(-20001,'Patient cannot be found.');
    end if;
    insert into Doctors( Doc_ID, Doc_Specialization )
        values( FindPatient(Num_Patient), Specialization );
end;
/
/* MedicalCard*/
create or replace procedure InsMedicalCard(
Num_Patient  patient.pat_id%type,
IDDiseases Diseases.Diseases%type,
SDoctor Doctors.Doc_Specialization%type,
IDDepartment Department.Department%type,
Cena History_Diseases.cena%type)
as
per integer;
begin
    if FindPatient(Num_Patient) is null then
            raise_application_error(-20001,'Patient cannot be found.');
    end if;
    insert into MedicalCard values('',FindPatient(Num_Patient));
    
    insert into History_Diseases(HD_MC, Diseases, Doctor, Department, AppealDate, Cena) values( 
        (select MC_ID from MedicalCard WHERE Pat_ID = FindPatient(Num_Patient) and rownum =1), 
        (select Dis_ID from Diseases WHERE Diseases = IDDiseases), 
        (select Doc_ID from Doctors WHERE Doc_Specialization = SDoctor), 
        (select Dep_ID from Department WHERE Department = IDDepartment), 
        Sysdate, Cena );
    
end;
/
