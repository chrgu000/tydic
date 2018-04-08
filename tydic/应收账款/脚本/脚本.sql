---欠费账龄统计 党政军 手工
create table pu_intf.f_owe_month_dzj_m
(data_type number,
 month_no varchar2(6),
 area_code varchar2(30),
 area_name varchar2(30),
 owe_fee1 number,
 owe_fee2 number,
 owe_fee3 number,
 owe_fee4 number,
 owe_fee5 number,
 owe_fee6 number,
 owe_fee7 number
)
--党政军分账龄201706格式变化
create table pu_intf.f_owe_month_dzj_m2  
(data_type number,
 month_no varchar2(6),
 area_code varchar2(30),
 area_name varchar2(30),
 owe_fee1 number,
 owe_fee2 number,
 owe_fee3 number,
 owe_fee4 number,
 owe_fee5 number,
 owe_fee6 number,
 owe_fee7 number,
 owe_fee8 number,
 owe_fee9 number,
 owe_fee10 number
)

---营业款结算清单表 手工
create table pu_intf.f_business_balance_m
( month_no varchar2(6),
  index_num number,
  area_code varchar2(30),
  area_name varchar2(30),
  end_balance number,
  ddwfx_balance number,
  other_balance number,
  checks varchar2(30),
  Remarks varchar2(30),
  end_balance_last number,
  end_balance_increase number,
  end_balance_hb number,
  ddwfx_balance_last number,
  ddwfx_balance_increase number,
  ddwfx_balance_hb number,
  begging_balance number,
  begging_balance_increase number,
  begging_balance_hb number 
)

---省政企 省商客经营收入接口  通过页面手工输入
create table pu_intf.f_charge_jysr_m
(month_no varchar2(6),
 area_code varchar2(10),
 area_name varchar2(20),
 kpi_code  varchar2(10),
 kpi_name varchar2(50),
 kpi_value1 number,
 kpi_value2 number)

select * from pu_intf.f_charge_jysr_m where month_NO='201702' for update 

----经营收入号百划入昆明的数据
pu_intf.f_charge_haobai_km 

----加权表 手工一年倒一次
CREATE TABLE pu_intf.f_Accounts_receiv_y
(year_no varchar2(4), 
 local_code varchar2(6),
 VALUE_NUM1  NUMBER,
 VALUE_NUM2  NUMBER,
 VALUE_NUM3  NUMBER,
 VALUE_NUM4  NUMBER,
 VALUE_NUM5  NUMBER,
 VALUE_NUM6  NUMBER,
 VALUE_NUM7  NUMBER,
 VALUE_NUM8  NUMBER,
 VALUE_NUM9  NUMBER,
 VALUE_NUM10  NUMBER,
 VALUE_NUM11  NUMBER,
 VALUE_NUM12  NUMBER) 

select * from  pu_intf.f_Accounts_receiv_y for update

---坏账准备预算值
create table pu_intf.f_Bad_debt_budget_y
(year_no varchar2(4),
area_code varchar2(10),
area_name varchar2(15),
budget_value number)

 

---省政企商客分账龄
pu_busi_ind.bm_own_fee_age_m

---- 省政企 省商客历史应收账款（用户欠费）表
create table pu_busi_ind.bm_own_fee_age_m2
(month_no	varchar2(6),
area_code	varchar2(6),
area_name	varchar2(16),
charge_type	varchar2(6),
id_value1	number,
id_value2	number,
id_value11	number
)

select * from pu_busi_ind.bm_own_fee_age_m2 for update 

select a.*,b.local_code
 from tmp_wrm_area a,
pu_meta.d_cw_area_info2 b
where a.area_name=b.area_name(+)
order by a.order_id

------------------------------------经分一键导出配置表------------------------------------------

select t.*, rowid
  from META_SYS_MG.META_TAB_LEVL t
  where TASK_ID=70000
 order by TASK_ID, SHEET_ID;
 
  select t.*, rowid
  from META_SYS_MG.META_TAB_LEVL t
    where  TASK_NAME LIKE '%经营收入%'
  order by TASK_ID, SHEET_ID;
 
 select t.*, rowid
  from META_SYS_MG.META_TAB_LEVL t
    where  TASK_NAME LIKE '%主营收入%'
  order by TASK_ID, SHEET_ID;
 
 
 
------------------------------ 更新手工数据的area_code--------------------------------------------
-----更新地市编码
--党政军有两张表PU_INTF.F_OWE_MONTH_DZJ_M  201705之后表结构有变 后续用该表201705之前数据的时候用PU_INTF.F_OWE_MONTH_DZJ_M表

update PU_INTF.F_OWE_MONTH_DZJ_M2 a
   set area_code =
         (select local_code
            from pu_meta.d_cw_area_info2 b
           where trim(decode(a.area_name,
                        '号百',
                        '号百（创新部）',
                        '合计',
                        '全省',
                        a.area_name)) = trim(b.area_name)) 
    where a.month_no='201711' ;
    commit;

update PU_INTF.F_OWE_MONTH_DZJ_M2 
set area_name=trim(replace(replace(area_name,chr(13),''), chr(10),''))
where month_no='201711';
commit; 
-----------------
update pu_intf.f_business_balance_m  a
   set area_code =
         (select local_code
            from pu_meta.d_cw_area_info2 b
           where trim(decode(a.area_name,
                        '号百',
                        '号百（创新部）',
                        '全省-汇总)',
                        '全省', 
                        a.area_name)) = trim(b.area_name))
    where a.month_no='201711';
    commit;
    
--修改中文地市中的回车符、换行符
update PU_INTF.F_BUSINESS_BALANCE_M 
set area_name=trim(replace(replace(area_name,chr(13),''), chr(10),''))
where month_no='201711';
commit;

------------------------------------------------begin------------------------------------------------
---总流程：
  --  1、alter table PU_INTF.p_INTF_DATA_M2 add partition p201707 values('201707'); 11号左右取数 经分
  --  2、更新手工数据的area_code ->经分基础欠费(RULE_ID:300030049)
  --  ->风险管控库内欠费数据（pu_busi_ind.p_bm_Accounts_recv_m10 日参数 每月7日跑 ETL(库内欠费及用户数分析)
  --  ->省政企、商客欠费账龄(经分pu_busi_ind.p_bm_own_fee_age_m)
  --  ->风险管控应收账款流程(ETL--应收账款调度流)-->经分前台导出
--------------------------------------------------end-------------------------------------------------
--依赖数据：
接口数据
经营分析模板（经分）
欠费基础数据（经分）300030049
pu_busi_ind.p_bm_Accounts_recv_m10(出表pu_base_ind.DM_OWE_KN_NEW03) 库内欠费数据 日参数 --fxgk
省政企、商客欠费账龄(经分) 600010040
省政企、商客欠费账龄(风险管控) pu_busi_ind.p_bm_own_fee_age_m  pu_busi_ind.bm_own_fee_age_m2 重跑历史数据的时候需要先重跑经分的欠费基础数据

select * from PU_INTF.INTF_DATA_M2@DL_EDW_YN where month_no=201801 and ID_ZBCODE='CWYSMX1200_03';

pu_busi_ind.p_bm_Accounts_recv_m1 其中有收入数据生成沉淀表 故是后面1到10存过的依赖基础 select * from PU_INTF.INTF_DATA_M2@DL_EDW_YN where month_no=201711 and ID_ZBCODE='CWYSMX1200_03';
pu_busi_ind.p_bm_Accounts_recv_m2 
pu_busi_ind.p_bm_Accounts_recv_m3  
pu_busi_ind.p_bm_Accounts_recv_m4 必须依赖存过3
pu_busi_ind.p_bm_Accounts_recv_m5 
pu_busi_ind.p_bm_Accounts_recv_m6 
pu_busi_ind.p_bm_Accounts_recv_m7 
pu_busi_Ind.p_bm_Accounts_recv_m8 

  
  declare
  v_date varchar2(6);
  begin
  v_date :='201705';  --上月账期
  --Call the procedure
  pu_busi_ind.p_bm_Accounts_recv_m1(v_date);
  pu_busi_ind.p_bm_Accounts_recv_m2(v_date);
  pu_busi_ind.p_bm_Accounts_recv_m3(v_date);
  pu_busi_ind.p_bm_Accounts_recv_m4(v_date);
  pu_busi_ind.p_bm_Accounts_recv_m5(v_date);
  pu_busi_ind.p_bm_Accounts_recv_m6(v_date); 
  pu_busi_ind.p_bm_Accounts_recv_m7(v_date); 
  pu_busi_ind.p_bm_Accounts_recv_m8(v_date);  
  end;
  

--------------------------------------页面sql
---(一）总体情况（按累计主营收入）
select '序号',
'分公司 ',
'当期应收账款',
'当期累计收入',
'去年同期应收账款',
'去年同期累计收入',
'当期累计收入全省占比',
'当期应收账款全省占比',
'去年同期应收账款全省占比',
'占比变化',
'当期占收比',
'去年同期占收比',
'占收比同比变化',
'同比增加',
'同比增幅',
'上月应收账款（加权前）',
'环比增加',
'环比增幅',
'上月占收比',
'占收比环比变化',
'上月应收账款（加权后）',
'环比增加',
'环比增幅',
'上月占收比',
'占收比环比变化'  
from dual
union all 
select *
 from 
(select to_char(t.index_area)index_area,
        t.AREA_NAME ,
       to_char(round(ACCOUNTS_RECV_THIS,6),'fm999999990.900000') ACCOUNTS_RECV_THIS,
       to_char(round(CHARGE_THIS_YEAR,6),'fm999999990.900000') CHARGE_THIS_YEAR,
       to_char(round(ACCOUNTS_RECV_LAST,6),'fm999999990.900000') ACCOUNTS_RECV_LAST,
       to_char(round(CHARGE_LAST_YEAR,6),'fm999999990.900000') CHARGE_LAST_YEAR,
       to_char(round(BNLZ_ZB_QS*100,2),'9990.99')||'%' BNLZ_ZB_QS,
       to_char(round(DQ_ZB_QS*100,2),'9990.99')||'%' DQ_ZB_QS,
       to_char(round(QNTQ_ZB_QS*100,2),'9990.99')||'%' QNTQ_ZB_QS,
       to_char(round(ZB_INCREASE*100,2),'9990.99')||'%' ZB_INCREASE,
       to_char(round(DQYS_ZSB*100,2),'9990.99')||'%' DQYS_ZSB,
       to_char(round(QNTQ_ZSB*100,2),'9990.99')||'%' QNTQ_ZSB,
       to_char(round(ZSB_INCREASE*100,2),'9990.99')||'%' ZSB_INCREASE,
       to_char(round(TB_INCREASE,6),'fm999999990.900000') TB_INCREASE,
       to_char(round(TB*100,2),'9990.99')||'%' TB,
       to_char(round(ACCOUNTS_RECV_LAST2,6),'fm999999990.900000') ACCOUNTS_RECV_LAST2,
       to_char(round(HB_INCREASE,6),'fm999999990.900000') HB_INCREASE,
       to_char(round(HB*100,2),'9990.99')||'%' HB,
       to_char(round(SY_ZSB*100,2),'9990.99')||'%' SY_ZSB,
       to_char(round(SY_ZSB_INCREASE*100,2),'9990.99')||'%' SY_ZSB_INCREASE,
       to_char(round(ACCOUNTS_RECV_LAST22,6),'fm999999990.900000') ACCOUNTS_RECV_LAST22,
       to_char(round(HB_INCREASE2,6),'fm999999990.900000') HB_INCREASE2,
       to_char(round(HB2,6),'fm999999990.900000') HB2,
       to_char(round(SY_ZSB2,6),'fm999999990.900000') SY_ZSB2,
       to_char(round(SY_ZSB_INCREASE2,6),'fm999999990.900000') SY_ZSB_INCREASE2
  from pu_busi_ind.bm_Accounts_recv_m1 t
 where month_no = '201706'
   and data_type = '02'
   order by t.index_area) ;



----（二）结构分析

select '序号',
'科目/科目描述',
'1122010000应收账款.用户欠费',
'其中：打单未返销 ',
'1122020199应收账款.应收结算款.集团内结算款.其他',
'1122020201应收账款.集团外.网间 ',
'1122020202应收账款.集团外.应收电路及其他网元服务 ',
'1122020203应收账款.集团外.SP结算 ',
'1122020299应收账款.应收结算款.集团外结算款.其他',
'1122030000应收账款.应收ICT业务结算款 ',
'1122080000应收账款.代办单位营业款',
'1122240000应收账款.应收号百业务款',
'1122990000应收账款.其他',
'1124000000营业款结算 ',
'合计 ',
'库外 ',
'库外（不含营业款结算） '  
from dual
union all 
select * from 
(select   
to_char(area_index),
to_char(area_name),
to_char(round(value_nums1,6),'fm999999990.900000'),
to_char(round(value_nums2,6),'fm999999990.900000'),
to_char(round(value_nums3,6),'fm999999990.900000'),
to_char(round(value_nums4,6),'fm999999990.900000'),
to_char(round(value_nums5,6),'fm999999990.900000'),
to_char(round(value_nums6,6),'fm999999990.900000'),
to_char(round(value_nums7,6),'fm999999990.900000'),
to_char(round(value_nums8,6),'fm999999990.900000'),
to_char(round(value_nums9,6),'fm999999990.900000'),
to_char(round(value_nums10,6),'fm999999990.900000'),
to_char(round(value_nums11,6),'fm999999990.900000'),
to_char(round(value_nums12,6),'fm999999990.900000'),
to_char(round(value_nums13,6),'fm999999990.900000'),
to_char(round(value_nums14,6),'fm999999990.900000'),
to_char(round(value_nums15,6),'fm999999990.900000') 
  from pu_busi_ind.bm_Accounts_recv_m2
 where month_no = '201706'
 and area_index is not null
 order by area_index);
 
 
 
---（三）3个月以上应收账款

select '序号',
'分公司',
'当期3个月以上应收账款',
'当期应收账款总额', 
'当月累计收入',
'去年同期3个月以上应收帐款',
'去年同期应收帐款总额',
'去年同期累计收入',
'同比增加',
'同比增幅',
'当期占收比',
'去年同期占收比',
'占收比变化',
'上月3个月以上应收账款',
'环比增加',
'环比增幅',
'上月占收比',
'占收比环比变化',
'当期占应收账款总额比',
'去年同期占应收账款总额比',
'总额占比变化',
'当期3个月以上应收全省占比',
'去年同期3个月以上应收全省占比',
'占比变化'  
from dual
union all 
select * from 
(select   
to_char(area_index),
to_char(area_name),  
to_char(round(value_num1,6),'fm999999990.900000'),
to_char(round(value_num2,6),'fm999999990.900000'),
to_char(round(value_num3,6),'fm999999990.900000'),
to_char(round(value_num4,6),'fm999999990.900000'),
to_char(round(value_num5,6),'fm999999990.900000'),
to_char(round(value_num6,6),'fm999999990.900000'),
to_char(round(value_num7,6),'fm999999990.900000'),
to_char(round(value_num8*100,2),'9990.99')||'%',
to_char(round(value_num9*100,2),'9990.99')||'%',
to_char(round(value_num10*100,2),'9990.99')||'%',
to_char(round(value_num11*100,2),'9990.99')||'%',
to_char(round(value_num12,6),'fm999999990.900000'),
to_char(round(value_num13,6),'fm999999990.900000'),
to_char(round(value_num14*100,2),'9990.99')||'%',
to_char(round(value_num15*100,2),'9990.99')||'%',
to_char(round(value_num16*100,2),'9990.99')||'%',
to_char(round(value_num17*100,2),'9990.99')||'%',
to_char(round(value_num18*100,2),'9990.99')||'%',
to_char(round(value_num19*100,2),'9990.99')||'%', 
to_char(round(value_num23*100,2),'9990.99')||'%',
to_char(round(value_num24*100,2),'9990.99')||'%',
to_char(round(value_num25*100,2),'9990.99')||'%' 
  from pu_busi_ind.bm_Accounts_recv_m3
 where month_no = '201706' 
 and tab_type='01'
 and data_type='01'
 order by area_index);
 
 
select '序号',
'分公司',
'当期3个月以上应收账款',
'当期应收账款总额', 
'当月累计收入',
'去年同期3个月以上应收帐款',
'去年同期应收帐款总额',
'去年同期累计收入',
'同比增加',
'同比增幅',
'当期占收比',
'去年同期占收比',
'占收比变化',
'上月3个月以上应收账款',
'环比增加',
'环比增幅',
'上月占收比',
'占收比环比变化',
'当期占应收账款总额比',
'去年同期占应收账款总额比',
'总额占比变化',
'当期3个月以上应收全省占比',
'去年同期3个月以上应收全省占比',
'占比变化'  
from dual
union all 
select * from 
(select   
to_char(area_index),
to_char(area_name),  
to_char(round(value_num1,6),'fm999999990.900000'),
to_char(round(value_num2,6),'fm999999990.900000'),
to_char(round(value_num3,6),'fm999999990.900000'),
to_char(round(value_num4,6),'fm999999990.900000'),
to_char(round(value_num5,6),'fm999999990.900000'),
to_char(round(value_num6,6),'fm999999990.900000'),
to_char(round(value_num7,6),'fm999999990.900000'),
to_char(round(value_num8*100,2),'9990.99')||'%',
to_char(round(value_num9*100,2),'9990.99')||'%',
to_char(round(value_num10*100,2),'9990.99')||'%',
to_char(round(value_num11*100,2),'9990.99')||'%',
to_char(round(value_num12,6),'fm999999990.900000'),
to_char(round(value_num13,6),'fm999999990.900000'),
to_char(round(value_num14*100,2),'9990.99')||'%',
to_char(round(value_num15*100,2),'9990.99')||'%',
to_char(round(value_num16*100,2),'9990.99')||'%',
to_char(round(value_num17*100,2),'9990.99')||'%',
to_char(round(value_num18*100,2),'9990.99')||'%',
to_char(round(value_num19*100,2),'9990.99')||'%', 
to_char(round(value_num23*100,2),'9990.99')||'%',
to_char(round(value_num24*100,2),'9990.99')||'%',
to_char(round(value_num25*100,2),'9990.99')||'%' 
  from pu_busi_ind.bm_Accounts_recv_m3
 where month_no = '201706' 
 and tab_type='01'
 and data_type='02'
 order by area_index);
 
 
----3个月以上用户欠费 
select '序号',
'分公司',
'当期3个月以上欠费',
'当期用户欠费',
'当月累计收入',
'去年同期3个月以上欠费',
'去年同期用户欠费',
'去年同期累计收入',
'同比增加',
'同比增幅',
'当期3个月以上欠费占收比',
'去年同期3个月以上欠费占收比',
'占收比同比变化',
'上月3个月以上用户欠费',
'环比增加',
'环比增幅',
'上月占收比',
'占收比环比变化',
'当期占用户欠费总额比',
'去年同期占用户欠费总额比',
'占比变化',
'当期用户欠费全省占比',
'去年同期用户欠费全省占比',
'占比变化',
'当期3个月以上欠费全省占比',
'去年同期3个月以上欠费全省占比',
'占比变化'  
from dual
union all 
select   
to_char(area_index),
to_char(area_name),  
to_char(round(value_num1,6),'fm999999990.900000'),
to_char(round(value_num2,6),'fm999999990.900000'),
to_char(round(value_num3,6),'fm999999990.900000'),
to_char(round(value_num4,6),'fm999999990.900000'),
to_char(round(value_num5,6),'fm999999990.900000'),
to_char(round(value_num6,6),'fm999999990.900000'),
to_char(round(value_num7,6),'fm999999990.900000'),
to_char(round(value_num8*100,2),'9990.99')||'%',
to_char(round(value_num9*100,2),'9990.99')||'%',
to_char(round(value_num10*100,2),'9990.99')||'%',
to_char(round(value_num11*100,2),'9990.99')||'%',
to_char(round(value_num12,6),'fm999999990.900000'),
to_char(round(value_num13,6),'fm999999990.900000'),
to_char(round(value_num14*100,2),'9990.99')||'%',
to_char(round(value_num15*100,2),'9990.99')||'%',
to_char(round(value_num16*100,2),'9990.99')||'%',
to_char(round(value_num17*100,2),'9990.99')||'%',
to_char(round(value_num18*100,2),'9990.99')||'%',
to_char(round(value_num19*100,2),'9990.99')||'%',
to_char(round(value_num20*100,2),'9990.99')||'%',
to_char(round(value_num21*100,2),'9990.99')||'%',
to_char(round(value_num22*100,2),'9990.99')||'%', 
to_char(round(value_num23*100,2),'9990.99')||'%',
to_char(round(value_num24*100,2),'9990.99')||'%',
to_char(round(value_num25*100,2),'9990.99')||'%' 
  from pu_busi_ind.bm_Accounts_recv_m3
 where month_no = '201706' 
 and tab_type='02'
 and data_type='01';


select '序号',
'分公司',
'当期3个月以上欠费',
'当期用户欠费',
'当月累计收入',
'去年同期3个月以上欠费',
'去年同期用户欠费',
'去年同期累计收入',
'同比增加',
'同比增幅',
'当期3个月以上欠费占收比',
'去年同期3个月以上欠费占收比',
'占收比同比变化',
'上月3个月以上用户欠费',
'环比增加',
'环比增幅',
'上月占收比',
'占收比环比变化',
'当期占用户欠费总额比',
'去年同期占用户欠费总额比',
'占比变化',
'当期用户欠费全省占比',
'去年同期用户欠费全省占比',
'占比变化',
'当期3个月以上欠费全省占比',
'去年同期3个月以上欠费全省占比',
'占比变化'  
from dual
union all 
select   
to_char(area_index),
to_char(area_name),  
to_char(round(value_num1,6),'fm999999990.900000'),
to_char(round(value_num2,6),'fm999999990.900000'),
to_char(round(value_num3,6),'fm999999990.900000'),
to_char(round(value_num4,6),'fm999999990.900000'),
to_char(round(value_num5,6),'fm999999990.900000'),
to_char(round(value_num6,6),'fm999999990.900000'),
to_char(round(value_num7,6),'fm999999990.900000'),
to_char(round(value_num8*100,2),'9990.99')||'%',
to_char(round(value_num9*100,2),'9990.99')||'%',
to_char(round(value_num10*100,2),'9990.99')||'%',
to_char(round(value_num11*100,2),'9990.99')||'%',
to_char(round(value_num12,6),'fm999999990.900000'),
to_char(round(value_num13,6),'fm999999990.900000'),
to_char(round(value_num14*100,2),'9990.99')||'%',
to_char(round(value_num15*100,2),'9990.99')||'%',
to_char(round(value_num16*100,2),'9990.99')||'%',
to_char(round(value_num17*100,2),'9990.99')||'%',
to_char(round(value_num18*100,2),'9990.99')||'%',
to_char(round(value_num19*100,2),'9990.99')||'%',
to_char(round(value_num20*100,2),'9990.99')||'%',
to_char(round(value_num21*100,2),'9990.99')||'%',
to_char(round(value_num22*100,2),'9990.99')||'%', 
to_char(round(value_num23*100,2),'9990.99')||'%',
to_char(round(value_num24*100,2),'9990.99')||'%',
to_char(round(value_num25*100,2),'9990.99')||'%' 
  from pu_busi_ind.bm_Accounts_recv_m3
 where month_no = '201706' 
 and tab_type='02'
 and data_type='02';

---大于1年以上占收比

select '序号',
'分公司',
'当期1年以上应收账款',
'当期累计收入',
'去年同期1年以上应收账款',
'去年同期累计收入',
'当期累计收入全省占比',
'当期1年以上应收账款全省占比',
'去年同期1年以上应收账款全省占比',
'占比变化',
'当期占收比',
'去年同期占收比',
'占收比变化',
'同比增加',
'同比增幅',
'上月1年以上应收账款',
'环比增加',
'环比增幅',
'上月占收比',
'占收比环比变化' 
from dual
union all 
select * from 
(select   
to_char(area_index),
to_char(area_name),  
to_char(round(value_num1,6),'fm999999990.900000'),
to_char(round(value_num2,6),'fm999999990.900000'),
to_char(round(value_num3,6),'fm999999990.900000'),
to_char(round(value_num4,6),'fm999999990.900000'),
to_char(round(value_num5*100,2),'9990.99')||'%',
to_char(round(value_num6*100,2),'9990.99')||'%',
to_char(round(value_num7*100,2),'9990.99')||'%',
to_char(round(value_num8*100,2),'9990.99')||'%',
to_char(round(value_num9*100,2),'9990.99')||'%',
to_char(round(value_num10*100,2),'9990.99')||'%',
to_char(round(value_num11*100,2),'9990.99')||'%',
to_char(round(value_num12,6),'fm999999990.900000'),
to_char(round(value_num13*100,2),'9990.99')||'%',
to_char(round(value_num14,6),'fm999999990.900000'),
to_char(round(value_num15,6),'fm999999990.900000'),
to_char(round(value_num16*100,2),'9990.99')||'%',
to_char(round(value_num17*100,2),'9990.99')||'%',
to_char(round(value_num18*100,2),'9990.99')||'%' 
  from pu_busi_ind.bm_Accounts_recv_m4
 where month_no = '201706'  
 and data_type='01'
 order by area_index);
 
 
select '序号',
'分公司',
'当期1年以上应收账款',
'当期累计收入',
'去年同期1年以上应收账款',
'去年同期累计收入',
'当期累计收入全省占比',
'当期1年以上应收账款全省占比',
'去年同期1年以上应收账款全省占比',
'占比变化',
'当期占收比',
'去年同期占收比',
'占收比变化',
'同比增加',
'同比增幅',
'上月1年以上应收账款',
'环比增加',
'环比增幅',
'上月占收比',
'占收比环比变化' 
from dual
union all 
select   
to_char(area_index),
to_char(area_name),  
to_char(round(value_num1,6),'fm999999990.900000'),
to_char(round(value_num2,6),'fm999999990.900000'),
to_char(round(value_num3,6),'fm999999990.900000'),
to_char(round(value_num4,6),'fm999999990.900000'),
to_char(round(value_num5*100,2),'9990.99')||'%',
to_char(round(value_num6*100,2),'9990.99')||'%',
to_char(round(value_num7*100,2),'9990.99')||'%',
to_char(round(value_num8*100,2),'9990.99')||'%',
to_char(round(value_num9*100,2),'9990.99')||'%',
to_char(round(value_num10*100,2),'9990.99')||'%',
to_char(round(value_num11*100,2),'9990.99')||'%',
to_char(round(value_num12,6),'fm999999990.900000'),
to_char(round(value_num13*100,2),'9990.99')||'%',
to_char(round(value_num14,6),'fm999999990.900000'),
to_char(round(value_num15,6),'fm999999990.900000'),
to_char(round(value_num16*100,2),'9990.99')||'%',
to_char(round(value_num17*100,2),'9990.99')||'%',
to_char(round(value_num18*100,2),'9990.99')||'%' 
  from pu_busi_ind.bm_Accounts_recv_m4
 where month_no = '201706'  
 and data_type='02';
 
---打单未返销
select '序号',
'分公司',
substr('201706',1,4)||'12',
substr('201706',1,4)||'11',
substr('201706',1,4)||'10',
substr('201706',1,4)||'09',
substr('201706',1,4)||'08',
substr('201706',1,4)||'07',
substr('201706',1,4)||'06',
substr('201706',1,4)||'05',
substr('201706',1,4)||'04',
substr('201706',1,4)||'03',
substr('201706',1,4)||'02',
substr('201706',1,4)||'01', 
substr('201706',1,4)||'年初',
'环比增加',
'环比增幅',
'较年初增加',
'较年初增幅' 
from dual
union all  
select * from 
(select 
to_char(area_index),
to_char(area_name),
to_char(round(value_num1,6),'fm999999990.900000'),
to_char(round(value_num2,6),'fm999999990.900000'),
to_char(round(value_num3,6),'fm999999990.900000'),
to_char(round(value_num4,6),'fm999999990.900000'),
to_char(round(value_num5,6),'fm999999990.900000'),
to_char(round(value_num6,6),'fm999999990.900000'),
to_char(round(value_num7,6),'fm999999990.900000'),
to_char(round(value_num8,6),'fm999999990.900000'),
to_char(round(value_num9,6),'fm999999990.900000'),
to_char(round(value_num10,6),'fm999999990.900000'),
to_char(round(value_num11,6),'fm999999990.900000'),
to_char(round(value_num12,6),'fm999999990.900000'),
to_char(round(value_num13,6),'fm999999990.900000'),
to_char(round(value_num14,6),'fm999999990.900000'),
to_char(round(value_num15*100,2),'9990.99')||'%',
to_char(round(value_num16,6),'fm999999990.900000'),
to_char(round(value_num17*100,2),'9990.99')||'%' 
from pu_busi_ind.bm_Accounts_recv_m5
where month_no='201705'
order by area_index);

------坏账准备
select '序号',
'分公司',
'本年预算',
'当月累计',
'去年同期',
'同比增加',
'同比增幅',
'当期累计收入',
'去年同期累计收入',
'当期占收比',
'去年同期占收比',
'占收比同比变化',
'上月累计',
'环比增加',
'环比增幅',
'上月占收比',
'占收比环比变化',
'当期超预算额度（时序）',
'预算完成率（时序）',
'超预算进度（时序）',
'预算完成率',
'当期超预算进度' 
from dual
union all
select * from 
(select 
to_char(index_area),
to_char(area_name),
to_char(round(target_value,6),'fm999999990.900000'),
to_char(round(value_num1,6),'fm999999990.900000'),
to_char(round(value_num2,6),'fm999999990.900000'),
to_char(round(value_num3,6),'fm999999990.900000'),
to_char(round(value_num4*100,2),'9990.99')||'%',
to_char(round(value_num5,6),'fm999999990.900000'),
to_char(round(value_num6,6),'fm999999990.900000'),
to_char(round(value_num7*100,2),'9990.99')||'%',
to_char(round(value_num8*100,2),'9990.99')||'%',
to_char(round(value_num9*100,2),'9990.99')||'%',
to_char(round(value_num10,6),'fm999999990.900000'),
to_char(round(value_num11,6),'fm999999990.900000'),
to_char(round(value_num12*100,2),'9990.99')||'%',
to_char(round(value_num13*100,2),'9990.99')||'%',
to_char(round(value_num14*100,2),'9990.99')||'%',
to_char(round(value_num15,6),'fm999999990.900000'),
to_char(round(value_num16*100,2),'9990.99')||'%',
to_char(round(value_num17*100,2),'9990.99')||'%',
to_char(round(value_num18*100,2),'9990.99')||'%',
to_char(round(value_num19*100,2),'9990.99')||'%' 
from pu_busi_ind.bm_Accounts_recv_m6
where month_no='201706'
and data_type='01'
order by index_area);

----新装用户预付费占比 
select  '序号', 
'分公司',
'本月固网后付费',
'本月固网预付费',
'本月固网预付费占比',
'本月移动后付费',
'本月移动预付费',
'本月移动预付费占比',
'本月宽带后付费',
'本月宽带预付费',
'本月宽带预付费占比',
'上月固网后付费',
'上月固网预付费',
'上月固网预付费占比',
'上月移动后付费',
'上月移动预付费',
'上月移动预付费占比',
'上月宽带后付费',
'上月宽带预付费',
'上月宽带预付费占比',
'固网预付费占比提升',
'移动预付费占比提升',
'宽带预付费占比提升' 
from dual
union all
select * from  
(select 
to_char(city_nm),
org_nm,
to_char(add_nums10),
to_char(add_nums11),
to_char(round(add_nums12*100,2),'9990.99')||'%',
to_char(add_nums13),
to_char(add_nums14),
to_char(round(add_nums15*100,2),'9990.99')||'%',
to_char(add_nums16),
to_char(add_nums17),
to_char(round(add_nums18*100,2),'9990.99')||'%',
to_char(add_nums1),
to_char(add_nums2),
to_char(round(add_nums3*100,2),'9990.99')||'%',
to_char(add_nums4),
to_char(add_nums5),
to_char(round(add_nums6*100,2),'9990.99')||'%',
to_char(add_nums7),
to_char(add_nums8),
to_char(round(add_nums9*100,2),'9990.99')||'%',
to_char(round((add_nums12-add_nums3)*100,2),'9990.99')||'%',
to_char(round((add_nums15-add_nums6)*100,2),'9990.99')||'%',
to_char(round((add_nums18-add_nums9)*100,2),'9990.99')||'%'
from  pu_busi_ind.bm_Accounts_recv_m7
where month_no='201706'
order by city_nm);

----欠费回收率1
select  '序号', 
'分公司',
'上月账期累计欠费',
'截止当月末欠费回收',
'截止当月末欠费回收率',
'上上月账期累计欠费',
'截止上月末欠费回收',
'截止上月末欠费回收率',
'回收率环比增加' 
from dual
union all  
select * from 
(select
to_char(nvl(SHOW_ORDER,22)),  
A.area_name,
to_char(round(month_amount_real,6),'fm999999990.900000'),
to_char(round(rec_amount,6),'fm999999990.900000'),
to_char(round(rec_pecent*100,2),'9990.99')||'%',
to_char(round(month_amount_real2,6),'fm999999990.900000'),
to_char(round(rec_amount2,6),'fm999999990.900000'),
to_char(round(rec_pecent2*100,2),'9990.99')||'%',
to_char(round(rec_pecent_increase*100,2),'9990.99')||'%' 
from pu_busi_Ind.bm_Accounts_recv_m8_1 a,
PU_META.D_CW_AREA_INFO2  b
where A.area_code=B.local_code(+)
AND month_no='201706'
order by nvl(SHOW_ORDER,22)) ;

--欠费回收率2

select  '序号', 
'分公司',
'上月零账龄欠费',
'截止当月末欠费回收',
'截止当月末欠费回收率',
'上上月零账龄欠费',
'截止上月末欠费回收',
'截止上月末欠费回收率',
'回收率环比增加' 
from dual
union all 
select * from  
(select
nvl(SHOW_ORDER,22),  
A.area_name,
to_char(round(month_amount_real,6),'fm999999990.900000'),
to_char(round(rec_amount,6),'fm999999990.900000'),
to_char(round(rec_pecent*100,2),'9990.99')||'%',
to_char(round(month_amount_real2,6),'fm999999990.900000'),
to_char(round(rec_amount2,6),'fm999999990.900000'),
to_char(round(rec_pecent2*100,2),'9990.99')||'%',
to_char(round(rec_pecent_increase*100,2),'9990.99')||'%' 
from pu_busi_Ind.bm_Accounts_recv_m8_2 a,
PU_META.D_CW_AREA_INFO2 b
where A.area_code=B.local_code(+)
AND month_no='201706'
order by nvl(SHOW_ORDER,22));


---(九)大额欠费及坏账信息填录
select
'序号',
'序号',
'计提坏账排本单位前300名',   
'计提坏账排本单位前301名',
'计提坏账排本单位前302名',
'合同号欠费≥2000元',
'合同号欠费≥2001元',
'合同号欠费≥2002元',
'长账龄设备欠费≥500元',
'长账龄设备欠费≥501元',
'长账龄设备欠费≥502元',
'欠费责任人及回收期信息填录完成进度',
'欠费责任人及回收期信息填录完成进度',
'欠费责任人及回收期信息填录完成进度' 
from dual
union all
select
'序号',
'分公司',
'金额(万元)',
'合同号数量（个）',
'截止统计日已填报合同号数',
'金额(万元)',
'合同号数量（个）',
'截止统计日已填报合同号数',
'金额(万元)',
'设备数量（个）',
'截止统计日已填报设备数',
'计提坏账前300完成率',
'欠费≥2000元完成率',
'长账龄欠费≥500元完成率' 
from dual
union all 
Select '1',  
       to_char(t.AREA_NAME),
       to_char(round(JTHZ_AMOUNT_QC,6),'fm999999990.900000'),
       to_char(JTHZ_CNT_QC),
       to_char(JTHZ_CNT_QM),
       to_char(round(QF_AMOUNT_QC,6),'fm999999990.900000'),
       to_char(QF_CNT_QC),
       to_char(QF_CNT_QM),
       to_char(round(OLD_QF_AMOUNT_QC,6),'fm999999990.900000'),
       to_char(OLD_QF_CNT_QC),
       to_char(OLD_QF_CNT_QM),
       to_char(round(decode(JTHZ_CNT_QC, 0, 0, JTHZ_CNT_QM / JTHZ_CNT_QC)*100,2),'9990.99')||'%',
       to_char(round(decode(QF_CNT_QC, 0, 0, QF_CNT_QM / QF_CNT_QC)*100,2),'9990.99')||'%',
       to_char(round(decode(OLD_QF_CNT_QC, 0, 0, OLD_QF_CNT_QM / OLD_QF_CNT_QC)*100,2),'9990.99')||'%'
  From PU_BUSI_IND.BM_OWE_REC_ROLLING_CONTROL_CK T 
 Where T.DATE_NO = to_char(add_months(to_date('201706','yyyymm'),1),'yyyymm')||'24'
   and area_code  = '9999' 
union all
select * from 
(Select to_char(SHOW_ORDER),  
       to_char(t.AREA_NAME),
       to_char(round(JTHZ_AMOUNT_QC,6),'fm999999990.900000'),
       to_char(JTHZ_CNT_QC),
       to_char(JTHZ_CNT_QM),
       to_char(round(QF_AMOUNT_QC,6),'fm999999990.900000'),
       to_char(QF_CNT_QC),
       to_char(QF_CNT_QM),
       to_char(round(OLD_QF_AMOUNT_QC,6),'fm999999990.900000'),
       to_char(OLD_QF_CNT_QC),
       to_char(OLD_QF_CNT_QM),
       to_char(round(decode(JTHZ_CNT_QC, 0, 0, JTHZ_CNT_QM / JTHZ_CNT_QC)*100,2),'9990.99')||'%',
       to_char(round(decode(QF_CNT_QC, 0, 0, QF_CNT_QM / QF_CNT_QC)*100,2),'9990.99')||'%',
       to_char(round(decode(OLD_QF_CNT_QC, 0, 0, OLD_QF_CNT_QM / OLD_QF_CNT_QC)*100,2),'9990.99')||'%'
  From PU_BUSI_IND.BM_OWE_REC_ROLLING_CONTROL_CK T,
       pu_meta.d_cw_area_info2 t1
 Where decode(substr(t.area_code,1,4),'9000','9008','9003','9010','9004','9005',substr(t.area_code,1,4))
       =t1.local_code 
   and T.DATE_NO = to_char(add_months(to_date('201706','yyyymm'),1),'yyyymm')||'24'
   and length(area_code) = '5'
   order by SHOW_ORDER) 

----欠费用户数

select  '序号', 
'合并',
'总欠费用户数',
'总欠费用户数',
'总欠费用户数',
'总欠费用户数',
'总欠费用户数',
'存量预付费用户数',
'存量预付费用户数',
'存量预付费用户数',
'存量预付费用户数',
'存量预付费用户数',
'存量后付费用户数',
'存量后付费用户数',
'存量后付费用户数',
'存量后付费用户数',
'存量后付费用户数',
'增量预付费用户数',
'增量预付费用户数',
'增量预付费用户数',
'增量预付费用户数',
'增量预付费用户数',
'增量后付费用户数',
'增量后付费用户数',
'增量后付费用户数',
'增量后付费用户数',
'增量后付费用户数'
from dual
union all 
select  '序号',  
'分公司',
'0账龄',
'[1-3账龄]',
'[4-12账龄]',
'一年以上',
'总用户数',
'0账龄',
'[1-3账龄]',
'[4-12账龄]',
'一年以上',
'总计',
'0账龄',
'[1-3账龄]',
'[4-12账龄]',
'一年以上',
'总计',
'0账龄',
'[1-3账龄]',
'[4-12账龄]',
'一年以上',
'总计',
'0账龄',
'[1-3账龄]',
'[4-12账龄]',
'一年以上',
'总计' 
from dual
union all  
select * from 
(select
to_char(a.order_no) ,  
to_char(A.area_name),
to_char(nvl(values_num1,0)),
to_char(nvl(values_num2,0)),
to_char(nvl(values_num3,0)),
to_char(nvl(values_num4,0)),
to_char(nvl(values_num5,0)),
to_char(nvl(values_num6,0)),
to_char(nvl(values_num7,0)),
to_char(nvl(values_num8,0)),
to_char(nvl(values_num9,0)),
to_char(nvl(values_num10,0)),
to_char(nvl(values_num11,0)),
to_char(nvl(values_num12,0)),
to_char(nvl(values_num13,0)),
to_char(nvl(values_num14,0)),
to_char(nvl(values_num15,0)),
to_char(nvl(values_num16,0)),
to_char(nvl(values_num17,0)),
to_char(nvl(values_num18,0)),
to_char(nvl(values_num19,0)),
to_char(nvl(values_num20,0)),
to_char(nvl(values_num21,0)),
to_char(nvl(values_num22,0)),
to_char(nvl(values_num23,0)),
to_char(nvl(values_num24,0)),
to_char(nvl(values_num25,0))
from PU_META.LATN_NEW_ORDER A,
pu_busi_ind.bm_Accounts_recv_m10_1 B
where a.local_code=b.area_code(+)
and a.local_code not in ('9001','9002')
AND B.month_no(+)='201706'
and B.cust_type(+)='合并' 
order by decode(a.order_no,0,20));

----欠费金额
select  '合并', 
'分公司',
'总欠费',
'总欠费',
'总欠费',
'总欠费',
'总欠费',
'存量欠费',
'存量欠费',
'存量欠费',
'存量欠费',
'存量欠费',
'存量欠费',
'存量欠费',
'存量欠费',
'增量欠费',
'增量欠费',
'增量欠费',
'增量欠费',
'增量欠费',
'增量欠费',
'增量欠费',
'增量欠费',
'状态正常',
'状态正常',
'状态正常',
'状态正常',
'状态正常',
'单停、停机保号+单停、用户要求停机',
'单停、停机保号+单停、用户要求停机',
'单停、停机保号+单停、用户要求停机',
'单停、停机保号+单停、用户要求停机',
'单停、停机保号+单停、用户要求停机',
'双停',
'双停',
'双停',
'双停',
'双停',
'欠费被拆机、用户申请拆机、预拆机',
'欠费被拆机、用户申请拆机、预拆机',
'欠费被拆机、用户申请拆机、预拆机',
'欠费被拆机、用户申请拆机、预拆机',
'欠费被拆机、用户申请拆机、预拆机',
'活卡',
'活卡',
'活卡',
'活卡',
'活卡',
'挂失',
'挂失',
'挂失',
'挂失',
'挂失',
'是I类',
'是I类',
'是I类',
'是I类',
'是I类',
'是I类'
from dual
union all 
select  
'序号', 
'分公司', 
'0账龄',
'[1-3账龄]',
'[4-12账龄]',
'一年以上',
'总计',
'0账龄',
'[1-3账龄]',
'[4-12账龄]',
'一年以上',
'总计',
'占比',
'预付费欠费金额',
'后付费欠费金额',
'0账龄',
'[1-3账龄]',
'[4-12账龄]',
'一年以上',
'总计',
'占比',
'预付费欠费金额',
'后付费欠费金额',
'0账龄',
'[1-3账龄]',
'[4-12账龄]',
'一年以上',
'总计',
'0账龄',
'[1-3账龄]',
'[4-12账龄]',
'一年以上',
'总计',
'0账龄',
'[1-3账龄]',
'[4-12账龄]',
'一年以上',
'总计',
'0账龄',
'[1-3账龄]',
'[4-12账龄]',
'一年以上',
'总计',
'0账龄',
'[1-3账龄]',
'[4-12账龄]',
'一年以上',
'总计',
'0账龄',
'[1-3账龄]',
'[4-12账龄]',
'一年以上',
'总计',
'0账龄',
'[1-3账龄]',
'[4-12账龄]',
'一年以上',
'总计',
'占总欠费比' 
from dual
union all  
select * from 
(select
to_char(a.order_no) ,  
to_char(A.area_name),
nvl(to_char(round(values_num1   ,6),'fm999999990.900000'),0),
nvl(to_char(round(values_num2   ,6),'fm999999990.900000'),0),
nvl(to_char(round(values_num3   ,6),'fm999999990.900000'),0),
nvl(to_char(round(values_num4   ,6),'fm999999990.900000'),0),
nvl(to_char(round(values_num5   ,6),'fm999999990.900000'),0),
nvl(to_char(round(values_num6   ,6),'fm999999990.900000'),0),
nvl(to_char(round(values_num7   ,6),'fm999999990.900000'),0),
nvl(to_char(round(values_num8   ,6),'fm999999990.900000'),0),
nvl(to_char(round(values_num9   ,6),'fm999999990.900000'),0),
nvl(to_char(round(values_num10  ,6),'fm999999990.900000'),0),
nvl(to_char(round(values_num11  ,6),'fm999999990.900000'),0),
nvl(to_char(round(values_num12  ,6),'fm999999990.900000'),0),
nvl(to_char(round(values_num13  ,6),'fm999999990.900000'),0),
nvl(to_char(round(values_num14  ,6),'fm999999990.900000'),0),
nvl(to_char(round(values_num15  ,6),'fm999999990.900000'),0),
nvl(to_char(round(values_num16  ,6),'fm999999990.900000'),0),
nvl(to_char(round(values_num17  ,6),'fm999999990.900000'),0),
nvl(to_char(round(values_num18  ,6),'fm999999990.900000'),0),
nvl(to_char(round(values_num19  ,6),'fm999999990.900000'),0),
nvl(to_char(round(values_num20  ,6),'fm999999990.900000'),0),
nvl(to_char(round(values_num21  ,6),'fm999999990.900000'),0),
nvl(to_char(round(values_num22  ,6),'fm999999990.900000'),0),
nvl(to_char(round(values_num23  ,6),'fm999999990.900000'),0),
nvl(to_char(round(values_num24  ,6),'fm999999990.900000'),0),
nvl(to_char(round(values_num25  ,6),'fm999999990.900000'),0),
nvl(to_char(round(values_num26  ,6),'fm999999990.900000'),0),
nvl(to_char(round(values_num27  ,6),'fm999999990.900000'),0),
nvl(to_char(round(values_num28  ,6),'fm999999990.900000'),0),
nvl(to_char(round(values_num29  ,6),'fm999999990.900000'),0),
nvl(to_char(round(values_num30  ,6),'fm999999990.900000'),0),
nvl(to_char(round(values_num31  ,6),'fm999999990.900000'),0),
nvl(to_char(round(values_num32  ,6),'fm999999990.900000'),0),
nvl(to_char(round(values_num33  ,6),'fm999999990.900000'),0),
nvl(to_char(round(values_num34  ,6),'fm999999990.900000'),0),
nvl(to_char(round(values_num35  ,6),'fm999999990.900000'),0),
nvl(to_char(round(values_num36  ,6),'fm999999990.900000'),0),
nvl(to_char(round(values_num37  ,6),'fm999999990.900000'),0),
nvl(to_char(round(values_num38  ,6),'fm999999990.900000'),0),
nvl(to_char(round(values_num39  ,6),'fm999999990.900000'),0),
nvl(to_char(round(values_num40  ,6),'fm999999990.900000'),0),
nvl(to_char(round(values_num41  ,6),'fm999999990.900000'),0),
nvl(to_char(round(values_num42  ,6),'fm999999990.900000'),0),
nvl(to_char(round(values_num43  ,6),'fm999999990.900000'),0),
nvl(to_char(round(values_num44  ,6),'fm999999990.900000'),0),
nvl(to_char(round(values_num45  ,6),'fm999999990.900000'),0),
nvl(to_char(round(values_num46  ,6),'fm999999990.900000'),0),
nvl(to_char(round(values_num47  ,6),'fm999999990.900000'),0),
nvl(to_char(round(values_num48  ,6),'fm999999990.900000'),0),
nvl(to_char(round(values_num49  ,6),'fm999999990.900000'),0),
nvl(to_char(round(values_num50  ,6),'fm999999990.900000'),0),
nvl(to_char(round(values_num51  ,6),'fm999999990.900000'),0),
nvl(to_char(round(values_num52  ,6),'fm999999990.900000'),0),
nvl(to_char(round(values_num53  ,6),'fm999999990.900000'),0),
nvl(to_char(round(values_num54  ,6),'fm999999990.900000'),0),
nvl(to_char(round(values_num55  ,6),'fm999999990.900000'),0),
nvl(to_char(round(values_num56  ,6),'fm999999990.900000'),0),
nvl(to_char(round(decode(values_num5,0,0,values_num56/values_num5) *100,2),'9990.99')||'%',0)
from PU_META.LATN_NEW_ORDER A,
pu_busi_ind.bm_Accounts_recv_m10_2 B
where a.local_code=b.area_code(+)
and a.local_code not in ('9001','9002')
AND B.month_no(+)='201706'
and B.cust_type(+)='合并' 
order by a.order_no)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      ; 

-- 
