CREATE OR REPLACE TYPE ty_str_split IS TABLE OF VARCHAR2 (400);
CREATE OR REPLACE FUNCTION fn_split (p_str IN VARCHAR2, p_delimiter IN VARCHAR2)
RETURN ty_str_split PIPELINED    --p_str 待截取的字符串 ，p_delimiter 分隔符
IS
j INT := 0;
leng INT := 0;
lensp INT := 0;
rstr varchar2(100); -- 截取下来的字符串   返回
str VARCHAR2 (4000):=p_str;--待截取字符串
BEGIN
  
leng := LENGTH (str); --待截取字符串长度
lensp:= length(p_delimiter); ---分隔符长度

WHILE leng>0 LOOP
  
j := INSTR (str, p_delimiter, 1); --第一个 分隔符的位置
 
if j=0 then 
  PIPE ROW (str); --当没有了 分隔符（最后一个字符串）
  exit;
  else
rstr:=substr(str,1,j-1); --截取返回的字符串

str:=substr(str,j+lensp); --截取剩下的字符串

leng := LENGTH (str);--剩下字符串的长度

PIPE ROW (rstr); --返回字符串
end if;
END LOOP; 
RETURN;
END fn_split;


------------- 存储过程

create or replace procedure zxytest(vs out varchar2) is
begin  
select to_char(wm_concat(a.userneme)) into vs from zxy a;
  begin
   execute immediate' drop table zxy1';
   exception when others then null;
  end; 
    execute immediate'
    create table zxy1 as
     select * from table(fn_split('''||vs||''','',''))
    ';
    end;

