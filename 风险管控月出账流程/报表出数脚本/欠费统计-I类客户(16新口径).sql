DROP TABLE tmp_owe_age_count2 PURGE;
CREATE TABLE tmp_owe_age_count2 PARALLEL 4 NOLOGGING AS
Select  B.AREA_NAME 分公司,
			 A.ACCT_ID 合同号,
			 A.ACCT_NAME 合同号名称,
			 Count(*) 设备数,
			 Sum(Case
						 When A.AMOUNT_REAL > 0 Then
							1
						 Else
							0
					 End) 欠费设备数,
			 C.OPER_DATE 设置时间,
			 C.EFF_DATE 生效时间,
			 C.EXP_DATE 失效时间,
			 Sum(A.XZQ_AMOUNT_TOTAL - A.XZQ_AMOUNT_TOTAL_AGE0 + A.XZH_AMOUNT_TOTAL_AGE0) / 100 "总欠费金额(元)",
			 Sum(A.XZQ_AMOUNT_DX - A.XZQ_AMOUNT_DX_AGE0 + A.XZH_AMOUNT_DX_AGE0) / 100 "呆坏账(元)",
			 Sum(A.XZQ_AMOUNT_DL - A.XZQ_AMOUNT_DL_AGE0 + A.XZH_AMOUNT_DL_AGE0) / 100 "待列账(元)",
			 Sum(A.XZQ_AMOUNT_REAL - A.XZQ_OWE_AGE0 + A.XZH_OWE_AGE0)/100 "剔除待列呆坏后欠费金额(元)",
       Min(A.MIN_OWE_MONTH) 最小欠费月,
			 Max(A.MAX_OWE_MONTH) 最大欠费月,
			 Max(A.OWE_MONTHS) 欠费月数
	From PU_busi_IND.bm_OWE_KN_NEW03 A
	Left Join PU_META.LATN_NEW B
		On A.AREA_CODE1 = B.LOCAL_CODE
	Left Join PU_INTF.I_PRD_VIP_ACCT Partition(P201801) C
		On A.ACCT_ID = C.ACCT_ID
	 And TO_CHAR(EXP_DATE, 'YYYYMM') >= '201801'
 Where A.IS_I_FLAG = 1
 AND A.MONTH_NO='201801'
 Group By  B.AREA_NAME,
					A.ACCT_ID,
					A.ACCT_NAME,
					C.OPER_DATE,
					C.EFF_DATE,
					C.EXP_DATE; 
					
					
          
Select * from tmp_owe_age_count2 Order By 分公司;
select * from PU_busi_IND.bm_OWE_KN_NEW03 where month_no='201801'


