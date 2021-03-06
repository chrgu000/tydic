delete from pu_busi_ind.bm_own_fee_age_m where month_No=v_month;
---省政企
execute immediate'insert into pu_busi_ind.bm_own_fee_age_m
select '||v_month||',
       ''9008'',
       ''01'',
       t1.FEE_MONTH,
       SUM(T1.amount) / 100 xzq_amount_total,
       SUM(case
             when T1.is_dl_flag = 0 then
              T1.xzq_dh_amonut
             else
              0
           end) / 100 xzq_amount_dx, 
       SUM(case
             when T1.is_dl_flag = 1 then
              T1.amount
             else
              0
           end) / 100 xzq_amount_dl,
       SUM(case
             when T1.is_dl_flag = 0 then
              T1.amount - T1.xzq_dh_amonut
             else
              0
           end) / 100 xzq_amount_real
  From pu_list.tmp_OWE_XZQ@Dl_Edw_Yn T1, 
       PU_WT.WT_SERV_SHZ_ALL_'||v_month||' T2
 Where T1.FEE_MONTH <= '||v_month_pre||'
   And T1.SERV_ID = T2.SERV_ID
 Group By t1.FEE_MONTH 
 union all
 Select /*+PARALLEL(T1,16)*/
      '||v_month||',
       ''9008'',
       ''02'',
 T1.FEE_MONTH,
 Sum(T1.AMOUNT) / 100 XZH_AMOUNT_TOTAL,
 Sum(Case
       When T1.IS_DL_FLAG = 0 Then
        T1.XZH_DH_AMONUT
       Else
        0
     End) / 100 XZH_AMOUNT_DX, 
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
  From PU_LIST.TMP_OWE_XZH@Dl_Edw_Yn T1, PU_WT.WT_SERV_SHZ_ALL_'||v_month||' T2
 Where T1.SERV_ID = T2.SERV_ID
 Group By T1.FEE_MONTH ';
 
 ---省商客
 execute immediate'insert into pu_busi_ind.bm_own_fee_age_m
select '||v_month||',
       ''9010'',
       ''01'',
       T1.FEE_MONTH,
			 Sum(T1.AMOUNT) / 100 XZQ_AMOUNT_TOTAL,
			 Sum(Case
						 When T1.IS_DL_FLAG = 0 Then
							T1.XZQ_DH_AMONUT
						 Else
							0
					 End) / 100 XZQ_AMOUNT_DX, 
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
	From pu_list.TMP_OWE_XZQ@Dl_Edw_Yn T1,
			 PU_WT.WT_SERV_SHZ_ALL_'||v_month||' T2,
			 (Select Distinct SERV_ID From TMP_OWE_KN_NEW03 T Where T.area_code1 = ''9003'') T3
 Where T1.FEE_MONTH <= '||v_month_pre||'
	 And T1.SERV_ID = T2.SERV_ID(+)
	 And T2.SERV_ID Is Null
	 And T1.SERV_ID = T3.SERV_ID
 Group By T1.FEE_MONTH 
 union all
 Select /*+PARALLEL(T1,16)*/
      '||v_month||',
       ''9010'',
       ''02'',
 T1.FEE_MONTH,
 Sum(T1.AMOUNT) / 100 XZH_AMOUNT_TOTAL,
 Sum(Case
       When T1.IS_DL_FLAG = 0 Then
        T1.XZH_DH_AMONUT
       Else
        0
     End) / 100 XZH_AMOUNT_DX, 
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
  From PU_LIST.TMP_OWE_XZH@Dl_Edw_Yn T1, PU_WT.WT_SERV_SHZ_ALL_'||v_month||' T2
 Where T1.SERV_ID = T2.SERV_ID
 Group By T1.FEE_MONTH
 Order By T1.FEE_MONTH';
 
  
