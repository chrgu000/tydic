---结果sql
select FEE_MONTH,
       AMOUNT_TOTAL,
       AMOUNT_DH,
       XZQ_AMOUNT_DL,
       AMOUNT_REAL,
       '',
       amount_st
  from pu_busi_ind.bm_own_fee_age_m
 where month_no = '201711'
   and area_code = '9008'
   and fee_type = '02'
 order by FEE_MONTH;
 
-- 历史欠费
Select t1.FEE_MONTH,   
       SUM(T1.amount)/100 xzq_amount_total,
       SUM(case when T1.is_dl_flag = 0 then T1.xzq_dh_amonut else 0 end )/100 xzq_amount_dx,
       SUM(case when T1.is_dl_flag = 0 then T1.xzq_st_amonut else 0 end )/100 xzq_amount_st,
       SUM(case  when T1.is_dl_flag=1 then T1.amount else 0 end)/100 xzq_amount_dl,
       SUM(case when T1.is_dl_flag=0 then T1.amount-T1.xzq_dh_amonut  else 0 end)/100 xzq_amount_real
	From wrm.TMP_OWE_20170407_XZQ@Dl_Edw_Yn T1, PU_WT.WT_SERV_SHZ_ALL_201703 T2
 Where T1.FEE_MONTH <= 201702
	 And T1.SERV_ID = T2.SERV_ID
 Group By t1.FEE_MONTH
 Order By T1.FEE_MONTH;
 
-- 零帐
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
  From wrm.TMP_OWE_20170407_XZH@Dl_Edw_Yn T1, PU_WT.WT_SERV_SHZ_ALL_201703 T2
 Where T1.SERV_ID = T2.SERV_ID
 Group By T1.FEE_MONTH
 Order By T1.FEE_MONTH;
 
 
 
 
