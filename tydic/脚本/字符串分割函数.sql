CREATE OR REPLACE TYPE ty_str_split IS TABLE OF VARCHAR2 (400);
CREATE OR REPLACE FUNCTION fn_split (p_str IN VARCHAR2, p_delimiter IN VARCHAR2)
RETURN ty_str_split PIPELINED    --p_str ����ȡ���ַ��� ��p_delimiter �ָ���
IS
j INT := 0;
leng INT := 0;
lensp INT := 0;
rstr varchar2(100); -- ��ȡ�������ַ���   ����
str VARCHAR2 (4000):=p_str;--����ȡ�ַ���
BEGIN
  
leng := LENGTH (str); --����ȡ�ַ�������
lensp:= length(p_delimiter); ---�ָ�������

WHILE leng>0 LOOP
  
j := INSTR (str, p_delimiter, 1); --��һ�� �ָ�����λ��
 
if j=0 then 
  PIPE ROW (str); --��û���� �ָ��������һ���ַ�����
  exit;
  else
rstr:=substr(str,1,j-1); --��ȡ���ص��ַ���

str:=substr(str,j+lensp); --��ȡʣ�µ��ַ���

leng := LENGTH (str);--ʣ���ַ����ĳ���

PIPE ROW (rstr); --�����ַ���
end if;
END LOOP; 
RETURN;
END fn_split;


------------- �洢����

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

