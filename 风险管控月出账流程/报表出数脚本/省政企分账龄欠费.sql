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
 
  ---01:销账前   02：销账后
  
  
 
P_BM_OWN_FEE_AGE_M
 
 
 
