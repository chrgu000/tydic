CREATE OR REPLACE PROCEDURE (V_DATE IN VARCHAR2) IS
 
  V_DAY        VARCHAR2(8);
  V_MONTH      VARCHAR2(6);
  V_MONTH_PRE VARCHAR2(6);
  V_YEAR  VARCHAR2(6);
  V_YEAR_PRE VARCHAR2(6);
  V_LAST_DATE  VARCHAR2(8); 
  V_NUMS       NUMBER; 
  
BEGIN
  V_DAY        := SUBSTR(V_DATE, 1, 8);
  V_MONTH      := SUBSTR(V_DATE, 1, 6);
  V_YEAR      := SUBSTR(V_DATE, 1, 4);
  V_YEAR_PRE  :=V_YEAR-1;
  V_MONTH_PRE := TO_CHAR(ADD_MONTHS(TO_DATE(V_MONTH, 'YYYYMM'), -1),
                          'YYYYMM');
  v_nums    :=to_number(substr(v_month,-2));
  

--临时表 收入
truncate table pu_busi_ind.tmp1_Accounts_recv_m1;
insert into  pu_busi_ind.tmp1_Accounts_recv_m1 
select '01' data_type,a.area_code, 
sum(case when a.CHARGE_TYPE_ID='01'then a.REAL_CHARGE else 0 end)/10000 charge_year3, 
sum(case when a.CHARGE_TYPE_ID='02'then a.REAL_CHARGE else 0 end)/10000 charge_year31  
from PU_BASE_IND.DM_INCHARGE_ANALYSIS_CMPLETE@DL_EDW_YN a 
where month_no=v_month 
and a.result_kpi_code in('1000','2000','3000') 
group by a.area_code 
union all
select '01' data_type,'9011',
sum(case when a.CHARGE_TYPE_ID='01' and area_code='0871' then a.REAL_CHARGE 
         when a.CHARGE_TYPE_ID='01' and area_code='9005' then -a.REAL_CHARGE 
        else 0 end)/10000, 
sum(case when a.CHARGE_TYPE_ID='02' and area_code= '0871' then a.REAL_CHARGE 
         when a.CHARGE_TYPE_ID='02' and area_code= '9005' then -a.REAL_CHARGE 
         else 0 end)/10000  
from PU_BASE_IND.DM_INCHARGE_ANALYSIS_CMPLETE@DL_EDW_YN a 
where month_no=v_month
and area_code in('0871','9005')
and a.result_kpi_code in('1000','2000','3000') ;
commit;

---国际准则收入
insert into  pu_busi_ind.tmp1_Accounts_recv_m1 
select '02'data_type,b.local_code,
sum(case when ID_ZBCODE='CJS00001_3' then ID_VALUE else 0 end),
sum(case when ID_ZBCODE='CJS00001_6' then ID_VALUE else 0 end)
from PU_INTF.INTF_DATA_M@DL_EDW_YN a,
pu_meta.d_cw_area_info2 b
where a.ID_UNITCODE=b.jq_code(+)
and month_no='201701'  
group by b.local_code
union all
select '02'data_type,'9011',
sum(case when ID_ZBCODE='CJS00001_3' and ID_UNITCODE ='C0530100' then ID_VALUE
         when ID_ZBCODE='CJS00001_3' and ID_UNITCODE ='C0535200' then -ID_VALUE
    else 0 end),
sum(case when ID_ZBCODE='CJS00001_6' and ID_UNITCODE ='C0530100' then ID_VALUE
         when ID_ZBCODE='CJS00001_6' and ID_UNITCODE ='C0535200' then -ID_VALUE
    else 0 end)
from PU_INTF.INTF_DATA_M@DL_EDW_YN a,
pu_meta.d_cw_area_info2 b
where a.ID_UNITCODE=b.jq_code(+)
and month_no='201701' 
and ID_UNITCODE in ('C0530100','C0535200');
commit;


---临时表2  应收账款
truncate table pu_busi_ind.tmp2_Accounts_recv_m1;
insert into pu_busi_ind.tmp2_Accounts_recv_m1 
select  
nvl(b.local_code,'0000') local_code,
sum(case when month_no= v_month 
         and ID_ZBCODE='CWYSMX1200_01' 
    then id_value else 0 end)/10000 last_year,
sum(case when month_no= v_month 
         and ID_ZBCODE='CWYSMX1200_03' 
    then id_value else 0 end)/10000 this_month,
sum(case when month_no= v_month_pre 
         and ID_ZBCODE='CWYSMX1200_03' 
    then id_value else 0 end)/10000 last_month  
  from PU_INTF.INTF_DATA_M@DL_EDW_YN a,  
  pu_meta.d_cw_area_info2 b
  where a.ID_UNITCODE=b.jq_code(+)
and month_no in(v_month,v_month_pre)
and id_zbcode like '%CWYSMX1200%'
group by nvl(b.local_code,'0000')
union all---
select  
'9011' local_code,
sum(case when month_no= v_month and ID_ZBCODE='CWYSMX1200_01' and ID_UNITCODE ='C0530100' 
         then id_value 
         when month_no= v_month and ID_ZBCODE='CWYSMX1200_01' and ID_UNITCODE ='C0535200' 
        then -id_value 
         else 0 end)/10000 last_year,
sum(case when month_no= v_month and ID_ZBCODE='CWYSMX1200_03' and ID_UNITCODE ='C0530100' 
         then id_value 
         when month_no= v_month and ID_ZBCODE='CWYSMX1200_03' and ID_UNITCODE ='C0535200' 
         then -id_value
       else 0 end)/10000 this_month,
sum(case when month_no= v_month_pre and ID_ZBCODE='CWYSMX1200_03' and ID_UNITCODE ='C0530100'  
         then id_value
         when month_no= v_month_pre and ID_ZBCODE='CWYSMX1200_03' and ID_UNITCODE ='C0535200'  
        then -id_value else 0 end)/10000 last_month  
  from PU_INTF.INTF_DATA_M@DL_EDW_YN a,  
  pu_meta.d_cw_area_info2 b
  where a.ID_UNITCODE=b.jq_code(+)
and month_no in(v_month,v_month_pre)
and ID_UNITCODE in ('C0530100','C0535200')
and id_zbcode like '%CWYSMX1200%' ; 
commit; 

 
----临时表3  部分整合

truncate table pu_busi_ind.tmp3_Accounts_recv_m1;
insert into  pu_busi_ind.tmp3_Accounts_recv_m1   
select 
'01' data_type,
v_month month_no,
a.local_code,
a.area_name area_name,
a.show_order2  index_area,
c.this_month accounts_recv_this ,---当期应收账款
b.charge_year3 charge_this_year,--当期累计收入
c.last_year accounts_recv_last,--去年同期应收账款
b.charge_year31 charge_last_year, --去年同期累计收入
decode(d.charge_year3,0,0,b.charge_year3/d.charge_year3) bnlz_zb_qs,-- 当期累计收入全省占比
decode(d.charge_year3,0,0,c.this_month/d.charge_year3) dq_zb_qs，--当期应收账款全省占比
decode(d.charge_year3,0,0,c.last_year/d.charge_year3) qntq_zb_qs ，--去年同期应收账款全省占比
decode(d.charge_year3,0,0,c.this_month/d.charge_year3)-decode(b.charge_year3,0,0,c.last_year/b.charge_year3) zb_increase，--占比变化
decode(b.charge_year3,0,0,c.this_month/b.charge_year3)*(v_nums/12) dqys_zsb，--当期占收比
decode(b.charge_year3,0,0,c.last_year/b.charge_year3) qntq_zsb，
decode(b.charge_year3,0,0,c.this_month/b.charge_year3)-
decode(b.charge_year3,0,0,c.last_year/b.charge_year3)   zsb_increase，
c.this_month-c.last_year tb_increase,               --同比增加              
decode(c.last_year,0,0,c.this_month/c.last_year-1) tb     ,                   --同比增幅              
c.last_month accounts_recv_last2,       --上月应收账款（加权前）
c.this_month-c.last_month hb_increase  ,             --环比增加              
decode(c.last_month,0,0,c.this_month/c.last_month-1) hb --环比增幅 
  from pu_meta.d_cw_area_info2 a
 left join pu_busi_ind.tmp1_Accounts_recv_m1 b on a.local_code = b.area_code
 left join pu_busi_ind.tmp2_Accounts_recv_m1 c on a.local_code = c.local_code
 left join pu_busi_ind.tmp1_Accounts_recv_m1 d on 1=1 and d.area_code='9999'; 
 commit;
 
 ----临时表4 加权后的数据
 truncate table pu_busi_ind.tmp4_Accounts_recv_m1;
 insert into pu_busi_ind.tmp4_Accounts_recv_m1  
 select v_month_pre year_no,
 a.local_code,
 sum(case when a.month_no=v_year_pre||'01' then a.accounts_recv_this*b.value_num1 else 0 end+
 case when a.month_no=v_year_pre||'02' then a.accounts_recv_this*b.value_num2 else 0 end+
 case when a.month_no=v_year_pre||'03' then a.accounts_recv_this*b.value_num3 else 0 end+
 case when a.month_no=v_year_pre||'04' then a.accounts_recv_this*b.value_num4 else 0 end+ 
 case when a.month_no=v_year_pre||'05' then a.accounts_recv_this*b.value_num5 else 0 end+ 
 case when a.month_no=v_year_pre||'06' then a.accounts_recv_this*b.value_num6 else 0 end+ 
 case when a.month_no=v_year_pre||'07' then a.accounts_recv_this*b.value_num7 else 0 end+ 
 case when a.month_no=v_year_pre||'08' then a.accounts_recv_this*b.value_num8 else 0 end+ 
 case when a.month_no=v_year_pre||'09' then a.accounts_recv_this*b.value_num9 else 0 end+ 
 case when a.month_no=v_year_pre||'10' then a.accounts_recv_this*b.value_num10 else 0 end+ 
 case when a.month_no=v_year_pre||'11' then a.accounts_recv_this*b.value_num11 else 0 end+ 
 case when a.month_no=v_year_pre||'12' then a.accounts_recv_this*b.value_num12 else 0 end)value_num
 from pu_busi_ind.bm_Accounts_recv_m1 a
 left join  pu_intf.f_Accounts_receiv_y b
 on 1=1 
 where month_no between v_year_pre||'01' and v_year_pre||'12'
 group by a.local_code;
 commit;
 
 
 delete from pu_busi_ind.bm_Accounts_recv_m1 where month_no=v_month;
 commit;
 insert into pu_busi_ind.bm_Accounts_recv_m1
 (data_type
,month_no
,local_code
,area_name
,index_area
,accounts_recv_this
,charge_this_year
,accounts_recv_last
,charge_last_year
,bnlz_zb_qs
,dq_zb_qs
,qntq_zb_qs
,zb_increase
,dqys_zsb
,qntq_zsb
,zsb_increase
,tb_increase
,tb
,accounts_recv_last2
,hb_increase
,hb
,sy_zsb
,sy_zsb_increase
,accounts_recv_last22
,hb_increase2
,hb2
,sy_zsb2
,sy_zsb_increase2
)
select a.* ,            
 b.dqys_zsb sy_zsb,                    --上月占收比            
 a.dqys_zsb- b.sy_zsb sy_zsb_increase,           --占收比环比变化        
 c.value_num accounts_recv_last22,      --上月应收账款（加权后）
 a.accounts_recv_this-c.value_num hb_increase2 ,             --环比增加              
 decode(c.value_num,0,0,a.accounts_recv_this/c.value_num -1) hb2,                     --环比增幅              
 decode(b.charge_this_year,0,0,c.value_num/b.charge_this_year) sy_zsb2,              --上月占收比            
  a.dqys_zsb- decode(b.charge_this_year,0,0,c.value_num/b.charge_this_year) sy_zsb_increase2          --占收比环比变化 
from  pu_busi_ind.tmp3_Accounts_recv_m1 a
 left join pu_busi_ind.bm_Accounts_recv_m1  b
 on a.local_code=b.local_code and b.month_no=v_month_pre and b.data_type='01'  
 left join pu_busi_ind.tmp4_Accounts_recv_m1 c
 on a.local_code=c.local_code and c.year_no=v_month_pre;
 commit;
  
 
END;
