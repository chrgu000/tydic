分公司  当期1年以上应收账款  当期累计收入  去年同期1年以上应收账款  
"去年同期累计收入"  当期累计收入全省占比  当期1年以上应收账款全省占比  去年同期1年以上应收账款全省占比  占比变化  当期占收比  去年同期占收比  占收比变化  同比增加 同比增幅  上月1年以上应收账款  环比增加  环比增幅  上月占收比  占收比环比变化

-- Create table
create table PU_BUSI_IND.BM_ACCOUNTS_RECV_M4
(  data_type   VARCHAR2(6),
  month_no    VARCHAR2(6),
  area_code   VARCHAR2(6),
  area_index  NUMBER,
  area_name   VARCHAR2(16),
  value_num1  NUMBER,
  value_num2  NUMBER,
  value_num3  NUMBER,
  value_num4  NUMBER,
  value_num5  NUMBER,
  value_num6  NUMBER,
  value_num7  NUMBER,
  value_num8  NUMBER,
  value_num9  NUMBER,
  value_num10 NUMBER,
  value_num11 NUMBER,
  value_num12 NUMBER,
  value_num13 NUMBER,
  value_num14 NUMBER,
  value_num15 NUMBER,
  value_num16 NUMBER,
  value_num17 NUMBER,
  value_num18 NUMBER
) ;
-- Add comments to the columns 
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M4.value_num1
  is '当期1年以上应收账款';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M4.value_num2
  is '当期累计收入';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M4.value_num3
  is '去年同期1年以上应收账款';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M4.value_num4
  is '去年同期累计收入';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M4.value_num5
  is '当期累计收入全省占比';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M4.value_num6
  is '当期1年以上应收账款全省占比';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M4.value_num7
  is '去年同期1年以上应收账款全省占比';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M4.value_num8
  is '占比变化';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M4.value_num9
  is '当期占收比';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M4.value_num10
  is '去年同期占收比';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M4.value_num11
  is '占收比变化';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M4.value_num12
  is '同比增加';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M4.value_num13
  is '同比增幅';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M4.value_num14
  is '上月1年以上应收账款';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M4.value_num15
  is '环比增加';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M4.value_num16
  is '环比增幅';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M4.value_num17
  is '上月占收比';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M4.value_num18
  is '占收比环比变化';



---临时表 处理1年以上应收账款
truncate table pu_busi_ind.tmp1_Accounts_recv_m4;

insert into pu_busi_ind.tmp1_Accounts_recv_m4
  select case
           when nvl(b.local_code, '9999') in ('9003', '9006') then
            '9003'
           else
            nvl(b.local_code, '9999')
         end local_code,
         case
           when nvl(b.local_code, '9999') in ('9003', '9006') then
            19
           else
            nvl(b.show_order2, 99)
         end area_index,
         case
           when nvl(b.local_code, '9999') in ('9003', '9006') then
            '信产'
           else
            nvl(b.area_name, '未知')
         end area_name,
         sum(case
               when id_zbcode in ('CWYSZL1118_19', 'CWYSZL1118_20') then
                ID_VALUE
               else
                0
             end) / 10000 ID_VALUE1, --当期 
         sum(case
               when id_zbcode in ('CWYSZL1118_05', 'CWYSZL1118_06') then
                ID_VALUE
               else
                0
             end) / 10000 ID_VALUE11 --去年同期  
    from PU_INTF.INTF_DATA_M@dl_edw_yn a, pu_meta.d_cw_area_info2 b
   where a.id_unitcode = b.jq_code(+)
     and a.month_no = '201701'
     and a.ID_UNITCODE <> 'C0535500' ---此处不取省政企
     and id_zbcode in ('CWYSZL1118_05',
                       'CWYSZL1118_06',
                       'CWYSZL1118_19',
                       'CWYSZL1118_20')
   group by case
              when nvl(b.local_code, '9999') in ('9003', '9006') then
               '9003'
              else
               nvl(b.local_code, '9999')
            end,
            case
              when nvl(b.local_code, '9999') in ('9003', '9006') then
               19
              else
               nvl(b.show_order2, 99)
            end,
            case
              when nvl(b.local_code, '9999') in ('9003', '9006') then
               '信产'
              else
               nvl(b.area_name, '未知')
            end;
commit;
 
 
----省政企、省商客分账龄应收账款和用户欠费 
insert into pu_busi_ind.tmp1_Accounts_recv_m4
select area_code,
       show_order2 area_index,
       area_name,
       sum(case
             when fee_type = '01' and MONTH_NO = '201701' AND
                  FEE_MONTH < '201601' THEN
              amount_real
             ELSE
              0
           END) / 10000,
       sum(case
             when fee_type = '01' and MONTH_NO = '201601' AND
                  FEE_MONTH < '201501' THEN
              amount_real
             ELSE
              0
           END) / 10000 last_year
  from PU_BUSI_IND.BM_OWN_FEE_AGE_M a, pu_meta.d_cw_area_info2 b
 where a.area_code = b.local_code(+)
   and a.month_no in ('201701', '201601')
 group by area_code, show_order2, area_name;
commit;
---昆电
insert into pu_busi_ind.tmp1_Accounts_recv_m4
select '9011',
21，
'其中：昆电',
sum(case when local_code='0871' then id_value1  else -id_value1 end), 
sum(case when local_code='0871' then id_value11  else -id_value11 end)
from  pu_busi_ind.tmp1_Accounts_recv_m4
where local_code in('0871','9008','9010');
commit;
 
truncate table pu_busi_ind.tmp2_Accounts_recv_m4;

insert into pu_busi_ind.tmp2_Accounts_recv_m4   
select
 nvl(b.data_type,'00') data_type	  ,           		
'201701' month_no	  ,           		
a.local_code area_code	  ,           		
a.area_index area_index  ,           
a.area_name area_name	  ,           		
a.id_value1  value_num1 , --当期1年以上应收账款
b.charge_year3 value_num2 , --当期累计收入
a.id_value11 alue_num3 , --去年同期1年以上应收账款
b.charge_year31 value_num4 , --去年同期累计收入
decode(c.charge_year3,0,0,b.charge_year3/c.charge_year3) value_num5 , --当期累计收入全省占比
decode(d.id_value1,0,0,a.id_value1/d.id_value1) value_num6 , --当期1年以上应收账款全省占比
decode(d.id_value11,0,0,a.id_value11/d.id_value11) value_num7 , --去年同期1年以上应收账款全省占比
decode(d.id_value1,0,0,a.id_value1/d.id_value1)-
decode(d.id_value11,0,0,a.id_value11/d.id_value11) value_num8 , --占比变化
decode(b.charge_year3,0,0,a.id_value1 /b.charge_year3)*(1/12)  value_num9 , --当期占收比
decode(b.charge_year31,0,0,a.id_value11 /b.charge_year31)*(1/12)  value_num10, -- 去年同期占收比
decode(b.charge_year3,0,0,a.id_value1 /b.charge_year3)*(1/12) -
decode(b.charge_year31,0,0,a.id_value11 /b.charge_year31)*(1/12) value_num11, -- 占收比变化
a.id_value1-a.id_value11 value_num12, -- 同比增加
decode(a.id_value11,0,0,a.id_value1/a.id_value11-1)value_num13  -- 同比增幅
from pu_busi_ind.tmp1_Accounts_recv_m4 a
left join pu_busi_ind.bm_charge_all_m b
on a.local_code=b.area_code  and b.month_no ='201701'
left join pu_busi_ind.bm_charge_all_m c
on b.data_type=c.data_type and c.month_no ='201701' and c.area_code='9998'
left join pu_busi_ind.tmp1_Accounts_recv_m4 d
on 1=1 and d.local_code='9998';
commit;

truncate table pu_busi_ind.tmp3_Accounts_recv_m4;

insert into pu_busi_ind.tmp3_Accounts_recv_m4   
select a.* ,
b.value_num1 value_num14, -- 上月1年以上应收账款
a.value_num1-b.value_num1 value_num15, -- 环比增加
decode(b.value_num1,0,0,a.value_num1/b.value_num1-1) value_num16, -- 环比增幅
b.value_num9 value_num17, -- 上月占收比
a.value_num9-b.value_num9 value_num18  -- 占收比环比变化
from pu_busi_ind.tmp2_Accounts_recv_m4  a
left join pu_busi_ind.bm_Accounts_recv_m4 b
on a.area_code=b.area_code and a.data_type=b.data_type and b.month_no='201612';

 
delete from PU_BUSI_IND.BM_ACCOUNTS_RECV_M4 where month_no='201701';
commit;
insert into PU_BUSI_IND.BM_ACCOUNTS_RECV_M4
select * 
from pu_busi_ind.tmp3_Accounts_recv_m4;
commit;


select * from PU_BUSI_IND.BM_ACCOUNTS_RECV_M4 where data_type='01'


 select * from PU_INTF.INTF_DATA_M@DL_EDW_YN 
where month_no='201701'
and id_zbcode like'%CWYSZL1118%'
and id_unitcode='530103757190184'


select * from pu_meta.d_cw_area_info2
 
