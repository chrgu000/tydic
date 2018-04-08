--历史欠费账龄表
--待列账
DROP TABLE TMP_OWE_20170307_DL PURGE;
CREATE TABLE TMP_OWE_20170307_DL  AS
select
     a.serv_id,
     CASE WHEN SUBSTR(a.BILLING_CYCLE_ID, 1, 2) IN ('10', '11') AND SUBSTR(a.billing_cycle_id,4,2)='13' THEN
            '20' || SUBSTR(a.BILLING_CYCLE_ID, 2,2)||'12'
            WHEN SUBSTR(a.BILLING_CYCLE_ID, 1, 2) IN ('10', '11') THEN
            '20' || SUBSTR(a.BILLING_CYCLE_ID, 2,4)
            WHEN SUBSTR(a.billing_cycle_id,4,2)='13' THEN '19' || SUBSTR(a.BILLING_CYCLE_ID, 2,2)||'12'
            ELSE '19' || SUBSTR(a.BILLING_CYCLE_ID,2,4) end fee_month,
     sum(a.tab_amount) dl_amount,
     a.billing_cycle_id 
 from pu_model.TB_BIL_OWE_TAB_201702 a
 Where  a.tab_amount >0 
 and nvl(qf_or_hz,'5JA')<>'5JF'
 group by  
 a.serv_id,
 CASE WHEN SUBSTR(a.BILLING_CYCLE_ID, 1, 2) IN ('10', '11') AND SUBSTR(a.billing_cycle_id,4,2)='13' THEN
            '20' || SUBSTR(a.BILLING_CYCLE_ID, 2,2)||'12'
            WHEN SUBSTR(a.BILLING_CYCLE_ID, 1, 2) IN ('10', '11') THEN
            '20' || SUBSTR(a.BILLING_CYCLE_ID, 2,4)
            WHEN SUBSTR(a.billing_cycle_id,4,2)='13' THEN '19' || SUBSTR(a.BILLING_CYCLE_ID, 2,2)||'12'
            ELSE '19' || SUBSTR(a.BILLING_CYCLE_ID,2,4) end,
 a.billing_cycle_id;

--- 销帐后
DROP TABLE TMP_OWE_20170307_XZH PURGE;
create table TMP_OWE_20170307_XZH as
Select A.*,
       Case
         When A.STATE In ('5JD', '5JF') Then
          A.AMOUNT
         Else
          0
       End XZH_DH_AMONUT,
       Case
         When A.STATE = '5JC' Then
          A.AMOUNT
         Else
          0
       End XZH_ST_AMONUT,
       Case
         When A.STATE = '5JA' Then
          A.AMOUNT
         Else
          0
       End XZH_OWE_AMONTH,
       Case
         When Substr(A.BILLING_CYCLE_ID, 1, 2) In ('10', '11') And
              Substr(A.BILLING_CYCLE_ID, 4, 2) = '13' Then
          '20' || Substr(A.BILLING_CYCLE_ID, 2, 2) || '12'
         When Substr(A.BILLING_CYCLE_ID, 1, 2) In ('10', '11') Then
          '20' || Substr(A.BILLING_CYCLE_ID, 2, 4)
         When Substr(A.BILLING_CYCLE_ID, 4, 2) = '13' Then
          '19' || Substr(A.BILLING_CYCLE_ID, 2, 2) || '12'
         Else
          '19' || Substr(A.BILLING_CYCLE_ID, 2, 4)
       End FEE_MONTH,
       Case
         When Nvl(B.DL_AMOUNT, 0) <> 0 Then
          A.AMOUNT
         Else
          0
       End XZH_DL_AMOUNT,
       Case
         When Nvl(B.DL_AMOUNT, 0) <> 0 Then
          1
         Else
          0
       End IS_DL_FLAG,
       Case
         When Nvl(B.DL_AMOUNT, 0) <> 0 And
              B.FEE_MONTH = '201702' Then
          1
         Else
          0
       End IS_M_DL_FLAG
  From PU_MODEL.TB_BIL_OWE_M_201702 A
  Left Join TMP_OWE_20170307_DL B
    On A.SERV_ID = B.SERV_ID
   And A.BILLING_CYCLE_ID = B.BILLING_CYCLE_ID
 Where A.STATE In ('5JA', '5JD', '5JC', '5JF');
 
 

 --销账前欠费
DROP TABLE TMP_OWE_20170307_XZQ PURGE;
create table TMP_OWE_20170307_XZQ as
Select A.*,
       Case
         When A.STATE In ('5JD', '5JF') Then
          A.AMOUNT
         Else
          0
       End XZQ_DH_AMONUT,
       Case
         When A.STATE = '5JC' Then
          A.AMOUNT
         Else
          0
       End XZQ_ST_AMONUT,
       Case
         When A.STATE = '5JA' Then
          A.AMOUNT
         Else
          0
       End XZQ_OWE_AMONTH,
       Case
         When Substr(A.BILLING_CYCLE_ID, 1, 2) In ('10', '11') And
              Substr(A.BILLING_CYCLE_ID, 4, 2) = '13' Then
          '20' || Substr(A.BILLING_CYCLE_ID, 2, 2) || '12'
         When Substr(A.BILLING_CYCLE_ID, 1, 2) In ('10', '11') Then
          '20' || Substr(A.BILLING_CYCLE_ID, 2, 4)
         When Substr(A.BILLING_CYCLE_ID, 4, 2) = '13' Then
          '19' || Substr(A.BILLING_CYCLE_ID, 2, 2) || '12'
         Else
          '19' || Substr(A.BILLING_CYCLE_ID, 2, 4)
       End FEE_MONTH,
       Case
         When Nvl(B.DL_AMOUNT, 0) <> 0 Then
          A.AMOUNT
         Else
          0
       End XZQ_DL_AMOUNT,
       Case
         When Nvl(B.DL_AMOUNT, 0) <> 0 Then
          1
         Else
          0
       End IS_DL_FLAG,
       Case
         When Nvl(B.DL_AMOUNT, 0) <> 0 And
              B.FEE_MONTH = '201702' Then
          1
         Else
          0
       End IS_M_DL_FLAG
  From PU_MODEL.TB_BIL_OWE_BEF_M_201702 A
  Left Join TMP_OWE_20170307_DL B
    On A.SERV_ID = B.SERV_ID
   And A.BILLING_CYCLE_ID = B.BILLING_CYCLE_ID
 Where A.STATE In ('5JA', '5JD', '5JC', '5JF'); 


 
