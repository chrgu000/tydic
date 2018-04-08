

create table pu_busi_ind.bm_Accounts_recv_m1
(data_type varchar2(5),
month_no varchar2(6),
local_code varchar2(10),
area_name varchar2(50),
index_area number,
Accounts_recv_this number,
charge_this_year number,
Accounts_recv_last number,
charge_last_year number,
bnlz_zb_qs number,
dq_zb_qs number,
qntq_zb_qs number,
zb_increase number,
dqys_zsb number,
qntq_zsb number,
zsb_increase number,
tb_increase number, 
tb number,
Accounts_recv_last2 number,
hb_increase number,
hb number,
sy_zsb number,
sy_zsb_increase number,
Accounts_recv_last22 number,
hb_increase2 number,
hb2 number,
sy_zsb2 number,
sy_zsb_increase2 number  
);
      
comment on column bm_Accounts_recv_m1.data_type    is '01：主营收入 02：国际准则经营收入 ';
comment on column bm_Accounts_recv_m1.month_no                  is '账期';
comment on column bm_Accounts_recv_m1.area_name                 is '地市';
comment on column bm_Accounts_recv_m1.index_area                is '地市编号';
comment on column bm_Accounts_recv_m1.accounts_recv_this        is '当期应收账款';
comment on column bm_Accounts_recv_m1.charge_this_year   is '当期累计收入';
comment on column bm_Accounts_recv_m1.accounts_recv_last        is '去年同期应收账款';
comment on column bm_Accounts_recv_m1.charge_last_year   is '去年同期累计收入';
comment on column bm_Accounts_recv_m1.bnlz_zb_qs                is '当期累计收入全省占比';
comment on column bm_Accounts_recv_m1.dq_zb_qs                  is '当期应收账款全省占比';
comment on column bm_Accounts_recv_m1.qntq_zb_qs           is '去年同期应收账款全省占比';
comment on column bm_Accounts_recv_m1.zb_increase               is '占比变化';
comment on column bm_Accounts_recv_m1.dqys_zsb                  is '当期占收比';
comment on column bm_Accounts_recv_m1.qntq_zsb                  is '去年同期占收比';
comment on column bm_Accounts_recv_m1.zsb_increase              is '占收比同比变化';
comment on column bm_Accounts_recv_m1.tb_increase               is '同比增加';
comment on column bm_Accounts_recv_m1.tb                        is '同比增幅';
comment on column bm_Accounts_recv_m1.accounts_recv_last2      is '上月应收账款（加权前）';
comment on column bm_Accounts_recv_m1.hb_increase               is '环比增加';
comment on column bm_Accounts_recv_m1.hb                        is '环比增幅';
comment on column bm_Accounts_recv_m1.sy_zsb                    is '上月占收比';
comment on column bm_Accounts_recv_m1.sy_zsb_increase           is '占收比环比变化';
comment on column bm_Accounts_recv_m1.accounts_recv_last22     is '上月应收账款（加权后）';
comment on column bm_Accounts_recv_m1.hb_increase2              is '环比增加';
comment on column bm_Accounts_recv_m1.hb2                       is '环比增幅';
comment on column bm_Accounts_recv_m1.sy_zsb2                   is '上月占收比';
comment on column bm_Accounts_recv_m1.sy_zsb_increase2          is '占收比环比变化'; 




--临时表 收入
truncate table pu_busi_ind.tmp1_Accounts_recv_m1;
insert into  pu_busi_ind.tmp1_Accounts_recv_m1 
select a.area_code, 
sum(case when a.CHARGE_TYPE_ID='01'then a.REAL_CHARGE else 0 end)/10000 charge_year3, 
sum(case when a.CHARGE_TYPE_ID='02'then a.REAL_CHARGE else 0 end)/10000 charge_year31  
from PU_BASE_IND.DM_INCHARGE_ANALYSIS_CMPLETE@DL_EDW_YN a 
where month_no='201701' 
and a.result_kpi_code in('1000','2000','3000') 
group by a.area_code 
union all
select '9011',
sum(case when a.CHARGE_TYPE_ID='01' and area_code='0871' then a.REAL_CHARGE 
         when a.CHARGE_TYPE_ID='01' and area_code='9005' then -a.REAL_CHARGE 
        else 0 end)/10000, 
sum(case when a.CHARGE_TYPE_ID='02' and area_code= '0871' then a.REAL_CHARGE 
         when a.CHARGE_TYPE_ID='02' and area_code= '9005' then -a.REAL_CHARGE 
         else 0 end)/10000  
from PU_BASE_IND.DM_INCHARGE_ANALYSIS_CMPLETE@DL_EDW_YN a 
where month_no='201701'
and area_code in('0871','9005')
and a.result_kpi_code in('1000','2000','3000') ;
---临时表2  应收账款
truncate table pu_busi_ind.tmp2_Accounts_recv_m1;
insert into pu_busi_ind.tmp2_Accounts_recv_m1 
select  
nvl(b.local_code,'0000') local_code,
sum(case when month_no= '201701' 
         and ID_ZBCODE='CWYSMX1200_01' 
    then id_value else 0 end)/10000 last_year,
sum(case when month_no= '201701' 
         and ID_ZBCODE='CWYSMX1200_03' 
    then id_value else 0 end)/10000 this_month,
sum(case when month_no= '201612' 
         and ID_ZBCODE='CWYSMX1200_03' 
    then id_value else 0 end)/10000 last_month  
  from PU_INTF.INTF_DATA_M@DL_EDW_YN a,  
  pu_meta.d_cw_area_info2 b
  where a.ID_UNITCODE=b.jq_code(+)
and month_no in('201701','201612')
and id_zbcode like '%CWYSMX1200%'
group by nvl(b.local_code,'0000')
union all---
select  
'9011' local_code,
sum(case when month_no= '201701' and ID_ZBCODE='CWYSMX1200_01' and ID_UNITCODE ='C0530100' 
         then id_value 
         when month_no= '201701' and ID_ZBCODE='CWYSMX1200_01' and ID_UNITCODE ='C0535200' 
        then -id_value 
         else 0 end)/10000 last_year,
sum(case when month_no= '201701' and ID_ZBCODE='CWYSMX1200_03' and ID_UNITCODE ='C0530100' 
         then id_value 
         when month_no= '201701' and ID_ZBCODE='CWYSMX1200_03' and ID_UNITCODE ='C0535200' 
         then -id_value
       else 0 end)/10000 this_month,
sum(case when month_no= '201612' and ID_ZBCODE='CWYSMX1200_03' and ID_UNITCODE ='C0530100'  
         then id_value
         when month_no= '201612' and ID_ZBCODE='CWYSMX1200_03' and ID_UNITCODE ='C0535200'  
        then -id_value else 0 end)/10000 last_month  
  from PU_INTF.INTF_DATA_M@DL_EDW_YN a,  
  pu_meta.d_cw_area_info2 b
  where a.ID_UNITCODE=b.jq_code(+)
and month_no in('201701','201612')
and ID_UNITCODE in ('C0530100','C0535200')
and id_zbcode like '%CWYSMX1200%' ;  


 
数据类型 账期 地市    
    
去年同期占收比 占收比同比变化 同比增加 同比增幅 上月应收账款（加权前） 环比增加 环比增幅
上月占收比 占收比环比变化 上月应收账款（加权后） 环比增加 环比增幅 上月占收比 占收比环比变化

----临时表3  部分整合

truncate table pu_busi_ind.tmp3_Accounts_recv_m1;
insert into  pu_busi_ind.tmp3_Accounts_recv_m1   
select 
'01' data_type,
'201702' month_no,
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
decode(b.charge_year3,0,0,c.this_month/b.charge_year3)*(1/12) dqys_zsb，--当期占收比
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
 
 ----临时表4 加权后的数据
 truncate table pu_busi_ind.tmp4_Accounts_recv_m1;
 create table pu_busi_ind.tmp4_Accounts_recv_m1 as
 select '201612' year_no,
 a.local_code,
 sum(case when a.month_no='201612'||'01' then a.accounts_recv_this*b.value_num1 else 0 end+
 case when a.month_no='201612'||'02' then a.accounts_recv_this*b.value_num2 else 0 end+
 case when a.month_no='201612'||'03' then a.accounts_recv_this*b.value_num3 else 0 end+
 case when a.month_no='201612'||'04' then a.accounts_recv_this*b.value_num4 else 0 end+ 
 case when a.month_no='201612'||'05' then a.accounts_recv_this*b.value_num5 else 0 end+ 
 case when a.month_no='201612'||'06' then a.accounts_recv_this*b.value_num6 else 0 end+ 
 case when a.month_no='201612'||'07' then a.accounts_recv_this*b.value_num7 else 0 end+ 
 case when a.month_no='201612'||'08' then a.accounts_recv_this*b.value_num8 else 0 end+ 
 case when a.month_no='201612'||'09' then a.accounts_recv_this*b.value_num9 else 0 end+ 
 case when a.month_no='201612'||'10' then a.accounts_recv_this*b.value_num10 else 0 end+ 
 case when a.month_no='201612'||'11' then a.accounts_recv_this*b.value_num11 else 0 end+ 
 case when a.month_no='201612'||'12' then a.accounts_recv_this*b.value_num12 else 0 end)value_num
 from pu_busi_ind.bm_Accounts_recv_m1 a
 left join  pu_intf.f_Accounts_receiv_y b
 on 1=1 
 where month_no between '201612'||'01' and '201612'||'12'
 group by a.local_code;
 
 
 
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
 on a.local_code=b.local_code and b.month_no='201612' and b.data_type='01'  
 left join pu_busi_ind.tmp4_Accounts_recv_m1 c
 on a.local_code=c.local_code and c.year_no='201612';
 commit;
  
  

PU_BUSI_IND.P_BM_HH_NOTICE_OCS_DEV_M

select * from  PU_BASE_IND.DM_INCHARGE_ANALYSIS_CMPLETE


select * from 
  PU_INTF.INTF_DATA_M@DL_EDW_YN a  
   
where month_no='201701' 
and id_zbcode like '%CWYSMX1200%'
--and ID_ZBTITLE='          合计应收账款总额-上年同期余额'
and ID_UNITCODE='530103757190184'


--CWYSMX1200_01	643806572.22	          合计应收账款总额-上年同期余额
--CWYSMX1200_03	594792527.94	          合计应收账款总额-期末余额
--
 
select * from pu_meta.d_cw_area_info2
