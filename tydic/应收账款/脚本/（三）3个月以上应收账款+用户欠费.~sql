----
分公司  当期3个月以上应收账款  当期应收账款总额  当月累计收入  去年同期3个月以上应收帐款  去年同期应收帐款总额  去年同期累计收入  同比增加  同比增幅  当期占收比  去年同期占收比  占收比变化  上月3个月以上应收账款  环比增加  环比增幅  上月占收比  占收比环比变化  当期占应收账款总额比  去年同期占应收账款总额比  总额占比变化  当期3个月以上应收全省占比  去年同期3个月以上应收全省占比  占比变化

create table PU_BUSI_IND.BM_ACCOUNTS_RECV_M3
(
  tab_type    VARCHAR2(6),
  data_type   VARCHAR2(6),
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
  value_num18 NUMBER,
  value_num19 NUMBER,
  value_num20 NUMBER,
  value_num21 NUMBER,
  value_num22 NUMBER
) ;
-- Add comments to the columns 
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M3.tab_type
  is '01：应收账款  02：用户欠费';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M3.data_type
  is '01：主营收入  02：国际准则收入';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M3.value_num1
  is '当期3个月以上应收账款';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M3.value_num2
  is '当期应收账款总额';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M3.value_num3
  is '当月累计收入';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M3.value_num4
  is '去年同期3个月以上应收帐款';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M3.value_num5
  is '去年同期应收帐款总额';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M3.value_num6
  is '去年同期累计收入';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M3.value_num7
  is '同比增加';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M3.value_num8
  is '同比增幅';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M3.value_num9
  is '当期占收比';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M3.value_num10
  is '去年同期占收比';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M3.value_num11
  is '占收比变化';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M3.value_num12
  is '上月3个月以上应收账款';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M3.value_num13
  is '环比增加';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M3.value_num14
  is '环比增幅';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M3.value_num15
  is '上月占收比';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M3.value_num16
  is '占收比环比变化';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M3.value_num17
  is '当期占应收账款总额比';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M3.value_num18
  is '去年同期占应收账款总额比';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M3.value_num19
  is '总额占比变化';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M3.value_num20
  is '当期3个月以上应收全省占比';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M3.value_num21
  is '去年同期3个月以上应收全省占比';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M3.value_num22
  is '占比变化';

---临时表 处理应收账款
truncate table pu_busi_ind.tmp1_Accounts_recv_m3;

insert into  pu_busi_ind.tmp1_Accounts_recv_m3  
select nvl(b.local_code, '9999') local_code,
       nvl(b.show_order2, 99) area_index,
       nvl(b.area_name, '未知') area_name,
       case
         when id_zbcode in ('CWYSZL1118_04',
                            'CWYSZL1118_05',
                            'CWYSZL1118_06',
                            'CWYSZL1118_07',
                            'CWYSZL1118_18',
                            'CWYSZL1118_19',
                            'CWYSZL1118_20',
                            'CWYSZL1118_21') then
          '01'
         else
          '02'
       end tab_type,
       sum(case
             when id_zbcode in ('CWYSZL1118_18',
                                'CWYSZL1118_19',
                                'CWYSZL1118_20', 
                                'CWYSZL1101_18',
                                'CWYSZL1101_19',
                                'CWYSZL1101_20' ) then
              ID_VALUE
             else
              0
           end)/10000 ID_VALUE1, --当期
           sum(case
             when id_zbcode in ( 'CWYSZL1118_21', 
                                'CWYSZL1101_21') then
              ID_VALUE
             else
              0
           end)/10000 ID_VALUE2, --当期总额
       sum(case
             when id_zbcode in ('CWYSZL1118_04',
                                'CWYSZL1118_05',
                                'CWYSZL1118_06',
                                'CWYSZL1101_04',
                                'CWYSZL1101_05',
                                'CWYSZL1101_06') then
              ID_VALUE
             else
              0
           end) /10000 ID_VALUE11， --去年同期 
         sum(case
             when id_zbcode in ('CWYSZL1118_07',
                                'CWYSZL1101_07') then
              ID_VALUE
             else
              0
           end)/10000 ID_VALUE22 --去年同期 总额
  from PU_INTF.INTF_DATA_M@dl_edw_yn a, pu_meta.d_cw_area_info2 b
 where a.id_unitcode = b.jq_code(+)
   and a.month_no = '201701'
   and a.ID_UNITCODE<>'C0535500'---此处不取省政企
   and id_zbcode in ('CWYSZL1101_04',
                     'CWYSZL1101_05',
                     'CWYSZL1101_06',
                     'CWYSZL1101_07',
                     'CWYSZL1101_18',
                     'CWYSZL1101_19',
                     'CWYSZL1101_20',
                     'CWYSZL1101_21',
                     'CWYSZL1118_04',
                     'CWYSZL1118_05',
                     'CWYSZL1118_06',
                     'CWYSZL1118_07',
                     'CWYSZL1118_18',
                     'CWYSZL1118_19',
                     'CWYSZL1118_20' ， 'CWYSZL1118_21')
 group by nvl(b.local_code, '9999'),
          nvl(b.show_order2, 99),
          nvl(b.area_name, '未知'),
          case
            when id_zbcode in ('CWYSZL1118_04',
                               'CWYSZL1118_05',
                               'CWYSZL1118_06',
                               'CWYSZL1118_07',
                               'CWYSZL1118_18',
                               'CWYSZL1118_19',
                               'CWYSZL1118_20',
                               'CWYSZL1118_21') then
             '01'
            else
             '02'
          end;
commit;

----省政企、省商客分账龄应收账款和用户欠费
insert into pu_busi_ind.tmp1_Accounts_recv_m3
select
  area_code,
  show_order2 area_index,
  area_name, 
  '01',
  sum(case when fee_type='01' 
           and MONTH_NO='201701' 
           AND FEE_MONTH<'201610' 
           THEN amount_real 
      ELSE 0 END )/10000  ,  
  sum(case when fee_type='01' 
           and MONTH_NO='201701'  
           AND FEE_MONTH<'201701'  
           THEN amount_real
       when fee_type='02' 
        and MONTH_NO='201701'  
        AND FEE_MONTH='201701'  
        THEN amount_real
      ELSE 0 END )/10000 this_month ,  
  sum(case when fee_type='01' 
           and MONTH_NO='201601' 
           AND FEE_MONTH<'201510' 
           THEN amount_real 
      ELSE 0 END )/10000 last_year,
  sum(case when fee_type='01' 
           and MONTH_NO='201601' 
           AND FEE_MONTH<'201601' 
           THEN amount_real
       when fee_type='02' 
        and MONTH_NO='201601' 
        AND FEE_MONTH='201601' 
        THEN amount_real
      ELSE 0 END )/10000 last_year
  from PU_BUSI_IND.BM_OWN_FEE_AGE_M a,
  pu_meta.d_cw_area_info2 b
  where a.area_code=b.local_code(+) 
  and a.month_no in('201701','201601')
group by area_code,
  show_order2 ,
  area_name
union all
select
  area_code,
  show_order2 area_index,
  area_name, 
  '02',
  sum(case when fee_type='01' 
           and MONTH_NO='201701' 
           AND FEE_MONTH<'201610' 
           THEN amount_real 
      ELSE 0 END )/10000  ,  
  sum(case when fee_type='01' 
           and MONTH_NO='201701'  
           AND FEE_MONTH<'201701'  
           THEN amount_real
       when fee_type='02' 
        and MONTH_NO='201701'  
        AND FEE_MONTH='201701'  
        THEN amount_real
      ELSE 0 END )/10000 this_month ,  
  sum(case when fee_type='01' 
           and MONTH_NO='201601' 
           AND FEE_MONTH<'201510' 
           THEN amount_real 
      ELSE 0 END )/10000 last_year,
  sum(case when fee_type='01' 
           and MONTH_NO='201601' 
           AND FEE_MONTH<'201601' 
           THEN amount_real
       when fee_type='02' 
        and MONTH_NO='201601' 
        AND FEE_MONTH='201601' 
        THEN amount_real
      ELSE 0 END )/10000 last_year
  from PU_BUSI_IND.BM_OWN_FEE_AGE_M a,
  pu_meta.d_cw_area_info2 b
  where a.area_code=b.local_code(+) 
  and a.month_no in('201701','201601')
group by area_code,
  show_order2 ,
  area_name;
commit;

 
----昆电
insert into pu_busi_ind.tmp1_Accounts_recv_m3
select '9011',
21,
'其中：昆电',
'01',
sum(case when local_code ='0871' then id_value1 else -id_value1 end),
sum(case when local_code ='0871' then id_value1 else -id_value2 end),
sum(case when local_code ='0871' then id_value1 else -id_value11 end),
sum(case when local_code ='0871' then id_value1 else -id_value22 end) 
from pu_busi_ind.tmp1_Accounts_recv_m3
where local_code in('0871','9008','9010')
union all
select '9011',
21,
'其中：昆电',
'02',
sum(case when local_code ='0871' then id_value1 else -id_value1 end),
sum(case when local_code ='0871' then id_value1 else -id_value2 end),
sum(case when local_code ='0871' then id_value1 else -id_value11 end),
sum(case when local_code ='0871' then id_value1 else -id_value22 end) 
from pu_busi_ind.tmp1_Accounts_recv_m3
where local_code in('0871','9008','9010');
commit;


truncate table pu_busi_ind.tmp2_Accounts_recv_m3 ;
insert into pu_busi_ind.tmp2_Accounts_recv_m3 
select 
a.tab_type,	--01：应收账款  02：用户欠费
b.data_type	  ,--01：主营收入  02：国际准则收入
'201701' month_no	  ,
a.local_code	  ,
a.area_index	,
a.area_name	  ,
ID_VALUE1 value_num1	,--当期3个月以上应收账款
ID_VALUE2 value_num2	,--当期应收账款总额
b.charge_year3 value_num3	,--当月累计收入
ID_VALUE11 value_num4	,--去年同期3个月以上应收帐款
ID_VALUE22 value_num5	,--去年同期应收帐款总额
b.charge_year31 value_num6	,--去年同期累计收入
ID_VALUE1-ID_VALUE11 value_num7	,--同比增加
decode(ID_VALUE11,0,0,ID_VALUE1/ID_VALUE11) value_num8	,--同比增幅
decode(b.charge_year3,0,0,ID_VALUE1/b.charge_year3)*(1/12) value_num9	,--当期占收比
decode(b.charge_year31,0,0,ID_VALUE11/b.charge_year31)*(1/12) value_num10	,--去年同期占收比
decode(b.charge_year3,0,0,ID_VALUE1/b.charge_year3)*(1/12)-
decode(b.charge_year31,0,0,ID_VALUE11/b.charge_year31)*(1/12) value_num11--占收比变化
from pu_busi_ind.tmp1_Accounts_recv_m3 a,
pu_busi_ind.bm_charge_all_m b
where a.local_code=b.area_code(+)
and b.month_no(+)='201701';
commit;

truncate table pu_busi_ind.tmp3_Accounts_recv_m3;
insert into pu_busi_ind.tmp3_Accounts_recv_m3  
select a.*,
       b.value_num1 value_num12, --上月3个月以上应收账款
       a.value_num1 - b.value_num1 value_num13, --环比增加
       decode(b.value_num1, 0, 0, a.value_num1 / b.value_num1 - 1) value_num14, --环比增幅
       b.value_num9 value_num15, --上月占收比
       a.value_num9 - b.value_num9 value_num16, --占收比环比变化
       decode(a.value_num2, 0, 0, a.value_num1 / a.value_num2) value_num17, --当期占应收账款总额比
       decode(a.value_num5, 0, 0, a.value_num4 / a.value_num5) value_num18, --去年同期占应收账款总额比
       decode(a.value_num2, 0, 0, a.value_num1 / a.value_num2) -
       decode(a.value_num5, 0, 0, a.value_num4 / a.value_num5) value_num19, --总额占比变化
       decode(c.value_num2, 0, 0, a.value_num1 / c.value_num2) value_num20, --当期3个月以上应收全省占比
       decode(c.value_num5, 0, 0, a.value_num4 / c.value_num5) value_num21, --去年同期3个月以上应收全省占比
       decode(a.value_num5, 0, 0, a.value_num4 / a.value_num5) -
       decode(c.value_num2, 0, 0, a.value_num1 / c.value_num2) value_num22 --占比变化
  from pu_busi_ind.tmp2_Accounts_recv_m3 a
  left join PU_BUSI_IND.BM_ACCOUNTS_RECV_M3 b
    on a.tab_type = b.tab_type
   and a.data_type = b.data_type
   and a.local_code=b.area_code
   and b.month_no = '201612'
  left join pu_busi_ind.tmp2_Accounts_recv_m3 c
    on a.tab_type = c.tab_type
   and a.data_type = c.data_type
   and c.local_code = '9998';
commit;
 
   
delete from PU_BUSI_IND.BM_ACCOUNTS_RECV_M3 where month_no='201701';
commit;
insert into PU_BUSI_IND.BM_ACCOUNTS_RECV_M3
select * 
from pu_busi_ind.tmp3_Accounts_recv_m3;
commit;



select * from PU_BUSI_IND.BM_ACCOUNTS_RECV_M3
where month_no='201701'
and tab_type='01'
and data_type='01'


 select * from PU_INTF.INTF_DATA_M@DL_EDW_YN 
where month_no='201701'
and id_zbcode like'%CWYSZL1118%'
and id_unitcode='530103757190184'

create table 
 
 
