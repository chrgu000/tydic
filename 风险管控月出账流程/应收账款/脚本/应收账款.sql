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
------------------------------------------------begin------------------------------------------------
---总流程：
         
  --  1、经分基础欠费(RULE_ID:300030049)
  --  ->风险管控 库内欠费数据（pu_busi_ind.p_bm_Accounts_recv_m10 日参数 每月7日跑 ETL(库内欠费及用户数分析)
  --  ->省政企、商客欠费账龄(经分 pu_busi_ind.p_bm_own_fee_age_m)
       -- 更新手工数据的area_code
  --  2、alter table PU_INTF.INTF_DATA_M2 add partition p201707 values('201707'); （分区添加 -->执行存过PU_INTF.p_INTF_DATA_M2） 11号左右取数 经分
  --  ->风险管控应收账款流程(ETL--应收账款调度流)-->经分前台导出
--------------------------------------------------end-------------------------------------------------


------------------------------------经分一键导出配置表------------------------------------------
          -----配置表有相应的出数脚本----
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

----------- select * from PU_INTF.F_OWE_MONTH_DZJ_M2 a where a.month_no='201711' ;
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

----------------- select * from  pu_intf.f_business_balance_m  a where a.month_no='201711';
update pu_intf.f_business_balance_m  a
   set area_code =
         (select local_code
            from pu_meta.d_cw_area_info2 b
           where trim(decode(a.area_name,
                        '号百',
                        '号百（创新部）',
                        '全省（汇总）',
                        '全省', 
                        a.area_name)) = trim(b.area_name))
    where a.month_no='201711';
    commit;
    
--修改中文地市中的回车符、换行符
update PU_INTF.F_BUSINESS_BALANCE_M 
set area_name=trim(replace(replace(area_name,chr(13),''), chr(10),''))
where month_no='201711';
commit;




--依赖数据：
接口数据
经营分析模板（经分）
欠费基础数据（经分）300030049
pu_busi_ind.p_bm_Accounts_recv_m10(出表pu_base_ind.DM_OWE_KN_NEW03) 库内欠费数据 日参数 --fxgk
省政企、商客欠费账龄(经分) 600010040
省政企、商客欠费账龄(风险管控) pu_busi_ind.p_bm_own_fee_age_m  pu_busi_ind.bm_own_fee_age_m2 重跑历史数据的时候需要先重跑经分的欠费基础数据

pu_busi_ind.p_bm_Accounts_recv_m1 其中有收入数据生成沉淀表 故是后面1到10存过的依赖基础 select * from PU_INTF.INTF_DATA_M2@DL_EDW_YN where month_no=201711 and ID_ZBCODE='CWYSMX1200_03';
pu_busi_ind.p_bm_Accounts_recv_m2 
pu_busi_ind.p_bm_Accounts_recv_m3  
pu_busi_ind.p_bm_Accounts_recv_m4 必须依赖存过3
pu_busi_ind.p_bm_Accounts_recv_m5 
pu_busi_ind.p_bm_Accounts_recv_m6 
pu_busi_ind.p_bm_Accounts_recv_m7 
pu_busi_Ind.p_bm_Accounts_recv_m8 

------------------  
  declare
  v_date varchar2(6);
  begin
  v_date :='201705'; -- 上月账期
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
  