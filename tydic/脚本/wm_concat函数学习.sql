

drop type ty_str_split;
drop function fn_split;
drop table zxy20;
drop table zxy1;
drop table zxy purge;
truncate table zxy;


select * from zxy;
select * from zxy1;

insert into zxy values('201711',20,'张三');

insert into zxy values('201712',20,'李四');

insert into zxy values('201712',21,'李四1');
insert into zxy values('201712',21,'李四1');
insert into zxy values('201712',21,'李四3');

insert into zxy values('201712',22,'李四5');
insert into zxy values('201712',22,'李四7');
insert into zxy values('201712',22,'李四6');


select to_char(wm_concat(userneme)) from zxy;
select * from zxy1;

select a.age ,
 to_char(wm_concat(distinct a.userneme))names
 from zxy a  
 group by a.age order by a.age 
    

select a.age,
     to_char(wm_concat(a.userneme)) 
     from (
     select * from zxy a order by a.userneme
)a 
group by a.age


select * from table(fn_split('||'select to_char(wm_concat(userneme)) from zxy'||',','));

select instr('abcd,abcd',',',1) from dual;

select substr('abcd11abcd',7) from dual;

select substr('abcd11abcd',instr('abcd11abcd','11',1)+length('11')) from dual;
