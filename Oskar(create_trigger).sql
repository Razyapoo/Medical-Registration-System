/* create sequence */
create sequence Department$;
create sequence History_Diseases$;
create sequence MedicalCard$;
create sequence Preparation$;
create sequence Patient$;
create sequence Diseases$;

/* create or replace trigger */
-- Department 
create or replace trigger Department  
   before insert on "DEPARTMENT" 
   for each row 
begin  
      if :NEW."Dep_ID" is null then 
         select Department$.nextval into :NEW."Dep_ID" from dual; 
      end if; 
end;
/
/*Diseases*/
create or replace trigger Diseases  
   before insert on "DISEASES" 
   for each row 
begin  
      if :NEW."DIS_ID" is null then 
         select Diseases$.nextval into :NEW."DIS_ID" from dual; 
      end if; 
end;
/
/*Preparation*/
create or replace trigger Preparation  
   before insert on "PREPARATION" 
   for each row 
begin  
      if :NEW."PREP_ID" is null then 
         select Preparation$.nextval into :NEW."PREP_ID" from dual; 
      end if; 
end;
/
/*Preparation*/
create or replace trigger Patient  
   before insert or delete on "PATIENT" 
   for each row 
declare
    count_doc number;
begin  
    count_doc := 0;
    if inserting then
      if :NEW."PAT_ID" is null then 
         select Patient$.nextval into :NEW."PAT_ID" from dual; 
      end if; 
      :new.BirthDate := trunc(:new.BirthDate);
    end if;
    if deleting then
        SELECT count(1) INTO count_doc FROM doctors WHERE doc_id=:OLD."PAT_ID";
        IF (count_doc > 0) THEN
            RAISE_APPLICATION_ERROR(-20001,'Doctor cannot be deleted.');
        end if;
    end if;
end;
/
/*History_Diseases*/
create or replace trigger History_Diseases  
   before insert on "HISTORY_DISEASES" 
   for each row 
begin  
      if :NEW."HD_ID" is null then 
         select History_Diseases$.nextval into :NEW."HD_ID" from dual; 
      end if; 
end;
/
/*MedicalCard*/
create or replace trigger MedicalCard
	before insert on MedicalCard
	for each row
declare
    count_doc number := 0;
begin
        SELECT count(1) INTO count_doc FROM MedicalCard WHERE PAT_ID=:NEW."PAT_ID";
        if :NEW."MC_ID" is null and count_doc=0 then 
             select MedicalCard$.nextval into :NEW."MC_ID" from dual; 
        else 
             RAISE_APPLICATION_ERROR(-20001,'The card is already exists.');
        end if;
end MedicalCard$;
/
