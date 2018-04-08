
select * from pu_meta.etl_program_rule where rule_id='3003186';---规则表 

---库内欠费及用户数分析   pu_busi_ind.p_bm_accounts_recv_m10

-- 源表----------
SELECT * FROM  PU_INTF.WT_SERV_OWE_M_201802_ZML 
SELECT * FROM  PU_INTF.I_IN_KG_SERV_GRID Partition(P201802) 

SELECT * FROM  PU_INTF.I_IN_HX_ZD_ORG_BRANCH Where DATE_NO ='20180307'

SELECT * FROM PU_WT.WT_SERV_SHZ_ALL_201802

SELECT * FROM  PU_WT.WT_BRANCH_TYPE_TZ_LIST

--------目标表
SELECT * FROM  PU_busi_IND.bm_OWE_KN_NEW03 PARTITION (P201802)
----------------

---省商客欠费账龄表 （报表）
SELECT * FROM  pu_wt.rpt_owe_ssk_xzq;  --销账前

SELECT * FROM  pu_wt.rpt_owe_ssk_xzh;  --销账后
 
---省政企客户部直管客户欠费账龄表 （报表）

SELECT * FROM  pu_wt.rpt_owe_szq_xzq_201802; --销账前

SELECT * FROM  pu_wt.rpt_owe_szq_xzh_201802;  --销账后


----欠费统计-I类客户(16新口径)（报表）
SELECT * FROM  pu_wt.tmp_owe_age_count2  Order By AREA_NAME;

 ------  分账龄欠费（16新口径）（报表） (经分库)
 SELECT * FROM  ly.rpt_owe_flh_201802 
 
 

 
 
 
