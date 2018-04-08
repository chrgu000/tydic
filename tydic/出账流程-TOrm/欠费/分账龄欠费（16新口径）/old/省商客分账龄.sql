-- ÀúÊ·Ç··Ñ
Select T1.FEE_MONTH,
			 Sum(T1.AMOUNT) / 100 XZQ_AMOUNT_TOTAL,
			 Sum(Case
						 When T1.IS_DL_FLAG = 0 Then
							T1.XZQ_DH_AMONUT
						 Else
							0
					 End) / 100 XZQ_AMOUNT_DX,
			 Sum(Case
						 When T1.IS_DL_FLAG = 0 Then
							T1.XZQ_ST_AMONUT
						 Else
							0
					 End) / 100 XZQ_AMOUNT_ST,
			 Sum(Case
						 When T1.IS_DL_FLAG = 1 Then
							T1.AMOUNT
						 Else
							0
					 End) / 100 XZQ_AMOUNT_DL,
			 Sum(Case
						 When T1.IS_DL_FLAG = 0 Then
							T1.AMOUNT - T1.XZQ_DH_AMONUT
						 Else
							0
					 End) / 100 XZQ_AMOUNT_REAL
	From ZML.TMP_OWE_20170307_XZQ@Dl_Edw_Yn T1,
			 PU_WT.WT_SERV_SHZ_ALL_201702 T2,
			 (Select Distinct SERV_ID From TMP_OWE_KN_NEW03 T Where T.area_code1 = '9003') T3
 Where T1.FEE_MONTH <= 201701
	 And T1.SERV_ID = T2.SERV_ID(+)
	 And T2.SERV_ID Is Null
	 And T1.SERV_ID = T3.SERV_ID
 Group By T1.FEE_MONTH
 Order By T1.FEE_MONTH; 
-- ÁãÕÊ
Select /*+PARALLEL(T1,16)*/
 T1.FEE_MONTH,
 Sum(T1.AMOUNT) / 100 XZH_AMOUNT_TOTAL,
 Sum(Case
       When T1.IS_DL_FLAG = 0 Then
        T1.XZH_DH_AMONUT
       Else
        0
     End) / 100 XZH_AMOUNT_DX,
 Sum(Case
       When T1.IS_DL_FLAG = 0 Then
        T1.XZH_ST_AMONUT
       Else
        0
     End) / 100 XZH_AMOUNT_ST,
 Sum(Case
       When T1.IS_DL_FLAG = 1 Then
        T1.AMOUNT
       Else
        0
     End) / 100 XZH_AMOUNT_DL,
 Sum(Case
       When T1.IS_DL_FLAG = 0 Then
        T1.AMOUNT - T1.XZH_DH_AMONUT
       Else
        0
     End) / 100 XZH_AMOUNT_REAL
  From ZML.TMP_OWE_20170307_XZH@Dl_Edw_Yn T1, PU_WT.WT_SERV_SHZ_ALL_201702 T2,
			 (Select Distinct SERV_ID From TMP_OWE_KN_NEW03 T Where T.area_code1 = '9003') T3
 Where T1.SERV_ID = T2.SERV_ID(+)
 and t2.serv_id is null
 and t1.serv_id  = t3.serv_id
 AND T1.Fee_Month <= 201702
 Group By T1.FEE_MONTH
 Order By T1.FEE_MONTH;
