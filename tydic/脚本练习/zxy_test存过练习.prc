CREATE OR REPLACE Procedure zxy_test(V_DATE In Varchar2,sb out varchar2) Is
  i number;
  d int :=0;
    v_month varchar2(10);
begin
   i:=555;
   v_month:=substr(V_DATE,1,6);
   
   
   select * into i from dual;
   /*
begin
  execute immediate'drop table zxy';
  Exception
    When Others Then
      Null;
end;
begin
 execute immediate' 
create table zxy (
   date_no varchar2(10),
   month_no varchar2(6),   
   user_name  varchar2(10) not null,
   age char(50)
) ';
 end;
 
 for s in 0..2 loop
execute immediate' 
  insert all 
    into zxy values('''||V_DATE||''','''||v_month||''',''张学应'',0)
    into zxy values('''||V_DATE||''','''||v_month||''',''张学应2'',length('''||V_DATE||'''))
    into zxy values('''||V_DATE||''','''||v_month||''',''张学应3'','''||i||''') select * from dual   
  '; 
  commit;
 end loop; 
     begin 
  execute immediate'drop table zxy2';
  exception when others then null;
  end;
  
  
  execute immediate'
  create table zxy2 as select * from zxy where 1=2';  
 while d<3 loop
  execute immediate'
  insert into zxy2 
      select 
              a.date_no,
              a.month_no,
              decode(a.user_name,''张学应'',''学应'',a.user_name),
              to_char(round(a.age/10,2),''fm9999999990.90'')
        from zxy a 
   ';
commit;
  d:=d+1;
end loop;
end if;*/
end;


 
        
      /*  to_char(round(case  when  a.age>100 
                   then a.age/10 
                      else a.age 
                   end,2),''99990.00'')*/
        
/
