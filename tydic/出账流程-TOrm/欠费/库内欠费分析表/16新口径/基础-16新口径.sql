DROP TABLE TMP_OWE_KN_NEW03 PURGE;
CREATE TABLE TMP_OWE_KN_NEW03 NOLOGGING AS
 Select A.*,
				Case
					When A.BRANCH_TYPE = '其他' Then
					 Case
						 When A.AREA_CODE In ('0691', '0872', '0873', '0883', '0887', '0877', '0878', '0888', '0879') Then
							'公众'
						 When A.AREA_CODE In ('0692', '0870') Then
							'政企'
						 Else
							Decode(A.BRANCH_TYPE, '其他', Nvl(B.BRANCH_TYPE_TZ, '其他'), A.BRANCH_TYPE)
					 End
					Else
					 A.BRANCH_TYPE
				End BRANCH_TYPE_NEW,
				Case
					When A.CUST_GROUP_NEW = '其他' Then
					 Case
						 When A.AREA_CODE In ('0691', '0872', '0873', '0883', '0887', '0877', '0878', '0888', '0879') Then
							'公众'
						 When A.AREA_CODE In ('0692', '0870') Then
							'政企'
						 Else
							Decode(A.CUST_GROUP_NEW, '其他', Nvl(B.CUST_GROUP_TZ, '其他'), A.CUST_GROUP_NEW)
					 End
					Else
					 A.CUST_GROUP_NEW
				End CUST_GROUP_TZ,
				A.XZQ_AMOUNT_REAL - A.XZQ_OWE_AGE0 + A.XZH_OWE_AGE0 AMOUNT_REAL
	 From (Select /*+PARALLEL(T1,16)*/
					T1.*,
					Decode(Nvl(T2.AREA_TYPE, '其他'), '政企团队', '政企', '政企', '政企', '其他', '其他', '公众') CUST_GROUP_NEW,
					--Decode(T1.IS_ZQ_FLAG, 1, '9000', T1.AREA_CODE) AREA_CODE1,
					Case
						When T4.BRANCH_CODE2 = '85344000000' Then
						 '9004'
						When T3.SERV_ID Is Not Null Then
						 '9000'
						When T4.BRANCH_CODE3 = '85301970000' Then
						 '9003'
						Else
						 T1.AREA_CODE
					End AREA_CODE1,
					Nvl(T2.AREA_TYPE, '其他') BRANCH_TYPE,
					Case
						When Nvl(T1.XZQ_MIN_MONTH, '999999') >= Nvl(T1.XZH_MIN_MONTH, '999999') Then
						 T1.XZH_MIN_MONTH
						Else
						 T1.XZQ_MIN_MONTH
					End MIN_OWE_MONTH,
					Case
						When Nvl(T1.XZQ_MAX_MONTH, '000000') >= Nvl(T1.XZH_MAX_MONTH, '000000') Then
						 T1.XZQ_MAX_MONTH
						Else
						 T1.XZH_MAX_MONTH
					End MAX_OWE_MONTH,
					XZQ_SERV_MONTH_NUM0 + XZH_SERV_MONTH_NUM - XZH_SERV_MONTH_NUM0 OWE_MONTHS
					 From PU_INTF.WT_SERV_OWE_M_201702_ZML T1,
								PU_INTF.I_IN_KG_SERV_GRID Partition(P201702) T5,
								PU_META.D_HX_ZD_ORG_BRANCH_TREE T4,
								(Select * From PU_INTF.I_IN_HX_ZD_ORG_BRANCH Where DATE_NO = 20170306) T2,
								PU_WT.WT_SERV_SHZ_ALL_201702 T3
					Where T1.SERV_ID = T5.PROD_ID(+)
						And T5.SUM_BRANCH_CODE = T4.BRANCH_CODE(+)
						And T4.BRANCH_CODE5 = T2.TEAM_ID(+)
						And T1.SERV_ID = T3.SERV_ID(+)) A
	 Left Join (Select SERV_ID_TZ,
										 Max(Nvl(BRANCH_TYPE_TZ, '其他')) BRANCH_TYPE_TZ,
										 Max(Decode(Nvl(BRANCH_TYPE_TZ, '其他'), '政企团队', '政企', '政企', '政企', '其他', '其他', '公众')) CUST_GROUP_TZ
								From PU_WT.WT_BRANCH_TYPE_TZ_LIST
							 Where SERV_ID_TZ Is Not Null
							 Group By SERV_ID_TZ) B
		 On A.SERV_ID = B.SERV_ID_TZ;
