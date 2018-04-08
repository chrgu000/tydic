

select * from pu_meta.etl_program_rule where rule_id='7001135';---规则表 

PU_BUSI_IND.P_BM_BIL_OWE_RECOVER_INFO

select a.owe_month_no from PU_BUSI_IND.BM_BIL_OWE_RECOVER_INFO_LIST a  ---201611 循环到 账期前一个月
where a.date_no='20180228'
group by a.owe_month_no
order by a.owe_month_no;
----------
SELECT date_no FROM  PU_BUSI_IND.TMP_BM_BIL_OWE_RECOVER_INFO group by date_no order by date_no ;

SELECT * FROM  PU_BUSI_IND.BM_BIL_OWE_RECOVER_INFO a WHERE a.date_no='20180228'; --目标表
