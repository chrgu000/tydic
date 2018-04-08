/***
 脚本名：SQL_WT_BIL_OWE_SP_4PRE.sql
 描述：增值业务次月欠费情况
 源表：PU_INTF.I_ACCT_ITEM_M 
       PU_WT.F_1_SERV_D_JF
       PU_INTF.I_PRD_SERV
       PU_WT.WT_BIL_SERV_OWE_D_201702 
       PU_WT.WT_OWE_TAB_RESULT_HIS_M
****/

-- FIRST : 取 product_id IS NOT NULL AND TERM_TYPE_ID IS NULL
drop table TMP1_BIL_OWE_SP purge;
CREATE TABLE TMP1_BIL_OWE_SP AS
Select B.SERV_ID, A.SP_ITEM_ID, B.OFFER_ID, B.CHARGE,A.BALANCE_TYPE1,a.Balance_Range
  From (Select Distinct SP_ITEM_ID, PRODUCT_ID,T.Balance_Type1,t.Balance_Range
          From PU_META.D_SP_ITEM_CODE T
         Where T.PRODUCT_ID Is Not Null
           And T.TERM_TYPE_ID Is Null) A,
       PU_INTF.I_ACCT_ITEM_M Partition(P201611) B
 Where A.SP_ITEM_ID = B.ACCT_ITEM_TYPE_ID
   And A.PRODUCT_ID = B.OFFER_ID;
   
--SECOND :取 product_id IS  NULL AND TERM_TYPE_ID IS NOT NULL
--剔除 套餐不为空的，在剩下的收入里取
drop table TMP2_BIL_OWE_SP purge;
CREATE TABLE TMP2_BIL_OWE_SP AS
Select A.*
  From (Select T1.*, T2.TERM_TYPE_ID From PU_INTF.I_ACCT_ITEM_M Partition(P201611) T1, F_1_SERV_D_JF T2 Where T1.SERV_ID = T2.SERV_ID) A,
       (Select Distinct SP_ITEM_ID, PRODUCT_ID
          From PU_META.D_SP_ITEM_CODE T
         Where T.PRODUCT_ID Is Not Null
           And T.TERM_TYPE_ID Is Null) B
 Where A.ACCT_ITEM_TYPE_ID = B.SP_ITEM_ID(+)
   And A.OFFER_ID = B.PRODUCT_ID(+)
   And (B.SP_ITEM_ID Is Null Or B.PRODUCT_ID Is Null);


DROP TABLE TMP3_BIL_OWE_SP PURGE;
CREATE TABLE TMP3_BIL_OWE_SP AS
Select A.SERV_ID, B.SP_ITEM_ID, A.TERM_TYPE_ID, A.OFFER_ID, A.CHARGE,B.Balance_Type1,b.Balance_Range
  From TMP2_BIL_OWE_SP A,
       (Select Distinct SP_ITEM_ID, TERM_TYPE_ID,T.Balance_Type1,t.Balance_Range
          From PU_META.D_SP_ITEM_CODE T
         Where T.PRODUCT_ID Is Null
           And T.TERM_TYPE_ID Is Not Null) B
 Where A.ACCT_ITEM_TYPE_ID = B.SP_ITEM_ID
   And A.TERM_TYPE_ID = B.TERM_TYPE_ID; 
   
   
--THIRD : 取 PRODUCT_ID IS NULL 并且  TERM_TYPE_ID IS NULL
-- 在剔除以上两种情况剩下的收入里取
DROP TABLE TMP4_BIL_OWE_SP PURGE;
CREATE TABLE TMP4_BIL_OWE_SP AS
Select A.*
  From TMP2_BIL_OWE_SP A,
       (Select Distinct SP_ITEM_ID, TERM_TYPE_ID
          From PU_META.D_SP_ITEM_CODE T
         Where T.PRODUCT_ID Is  Null
           And T.TERM_TYPE_ID Is NOT  Null) B
 Where A.ACCT_ITEM_TYPE_ID = B.SP_ITEM_ID(+)
   And A.TERM_TYPE_ID = B.TERM_TYPE_ID(+)
   AND (B.SP_ITEM_ID IS NULL OR B.TERM_TYPE_ID IS NULL);
   

DROP TABLE TMP5_BIL_OWE_SP PURGE;
CREATE TABLE TMP5_BIL_OWE_SP AS
Select B.SERV_ID, A.SP_ITEM_ID, B.OFFER_ID, B.CHARGE,A.Balance_Type1,a.Balance_Range
  From (Select Distinct SP_ITEM_ID,T.Balance_Type1,t.Balance_Range
          From PU_META.D_SP_ITEM_CODE T
         Where T.PRODUCT_ID Is Null
           And T.TERM_TYPE_ID Is Null) A,
       TMP4_BIL_OWE_SP B
 Where A.SP_ITEM_ID = B.ACCT_ITEM_TYPE_ID;
 
 --FOURTH : 取 PRODUCT_ID IS not NULL 并且  TERM_TYPE_ID IS not  NULL
  -- 在剔除以上三种情况剩下的收入里取
DROP TABLE TMP4_1_BIL_OWE_SP PURGE;
CREATE TABLE TMP4_1_BIL_OWE_SP AS
Select A.*
  From TMP4_BIL_OWE_SP A,
       (Select Distinct SP_ITEM_ID, TERM_TYPE_ID
          From PU_META.D_SP_ITEM_CODE T
         Where T.PRODUCT_ID Is  Null
           And T.TERM_TYPE_ID Is   Null) B
 Where A.ACCT_ITEM_TYPE_ID = B.SP_ITEM_ID(+)
   AND B.SP_ITEM_ID IS NULL ;
   

DROP TABLE TMP5_1_BIL_OWE_SP PURGE;
CREATE TABLE TMP5_1_BIL_OWE_SP AS
Select B.SERV_ID, A.SP_ITEM_ID, B.OFFER_ID, b.term_type_id,B.CHARGE,A.Balance_Type1,a.Balance_Range
  From (Select Distinct SP_ITEM_ID,T.Balance_Type1,t.Balance_Range,t.term_type_id,t.product_id
          From PU_META.D_SP_ITEM_CODE T
         Where T.PRODUCT_ID Is not  Null
           And T.TERM_TYPE_ID Is not Null) A,
       TMP4_1_BIL_OWE_SP B
 Where A.SP_ITEM_ID = B.ACCT_ITEM_TYPE_ID
 And A.TERM_TYPE_ID = B.TERM_TYPE_ID
   And A.PRODUCT_ID = B.OFFER_ID;

--- sp 费用汇总
drop table TMP6_BIL_OWE_SP purge;
create table TMP6_BIL_OWE_SP as
Select SERV_ID, SP_ITEM_ID, Null TERM_TYPE_ID, OFFER_ID, CHARGE,balance_type1,balance_range
  From TMP5_BIL_OWE_SP
Union All
Select SERV_ID, SP_ITEM_ID, Null TERM_TYPE_ID, OFFER_ID, CHARGE,balance_type1,balance_range
  From TMP1_BIL_OWE_SP
Union All
Select SERV_ID, SP_ITEM_ID, TERM_TYPE_ID, OFFER_ID, CHARGE,balance_type1,balance_range
  From TMP3_BIL_OWE_SP
 Union All
Select SERV_ID, SP_ITEM_ID, TERM_TYPE_ID, OFFER_ID, CHARGE,balance_type1,balance_range
  From TMP5_1_BIL_OWE_SP
 ;

drop table TMP7_BIL_OWE_SP purge;
create table TMP7_BIL_OWE_SP as
Select A.*, B.ACC_NBR, B.AREA_CODE, B.USER_NAME, B.ADDRESS_NAME, B.DVLP_CHANNEL_ID, B.DVLP_STAFF_ID, C.BILLING_MODE_ID,b.state
  From TMP6_BIL_OWE_SP A, F_1_SERV_D_JF B, PU_INTF.I_PRD_SERV Partition(P20170306) C
 Where A.SERV_ID = B.SERV_ID(+)
   And A.SERV_ID = C.SERV_ID(+); 

-- 欠费
DROP TABLE TMP8_1_BIL_OWE_SP PURGE;
CREATE TABLE TMP8_1_BIL_OWE_SP AS
 Select A.SERV_ID,
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
        Sum(A.TAB_AMOUNT) DL_AMOUNT,
        A.BILLING_CYCLE_ID
   From PU_MODEL.TB_BIL_OWE_TAB_201702@DL_EDW_YN A
  Where A.TAB_AMOUNT > 0
  Group By A.SERV_ID,
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
           End,
           A.BILLING_CYCLE_ID; 
 
DROP TABLE TMP8_BIL_OWE_SP PURGE;
CREATE TABLE TMP8_BIL_OWE_SP AS
 Select A.SERV_ID,
        Sum(A.AMOUNT) TOTAL_AMOUNT,
        Sum(Case
              When Nvl(B.DL_AMOUNT, 0) = 0 And
                   Substr(A.STATE_TR, -1) In ('D', 'F') Then
               A.AMOUNT
              Else
               0
            End) DH_AMOUNT,
        Sum(Case
              When Nvl(B.DL_AMOUNT, 0) <> 0 Then
               A.AMOUNT
              Else
               0
            End) DL_AMOUNT,
        Sum(Case
              When Nvl(B.DL_AMOUNT, 0) = 0 And
                   Substr(A.STATE_TR, -1) = 'C' Then
               A.AMOUNT
              Else
               0
            End) ST_AMOUNT,
        Sum(Case
              When Nvl(B.DL_AMOUNT, 0) = 0 And
                   Substr(A.STATE_TR, -1) In ('A', 'C') Then
               A.AMOUNT
              Else
               0
            End) AMOUNT
   From (Select *
           From PU_MODEL.TB_BIL_SERV_OWE_TRACK_201702@DL_EDW_YN A
          Where DATE_NO = '20170306'
            AND FEE_CYCLE_ID  = '201611') A
   Left Join TMP8_1_BIL_OWE_SP B
     On A.SERV_ID = B.SERV_ID
    And A.FEE_CYCLE_ID = B.FEE_MONTH
  Where A.IS_M_ETS_FLAG = 1
    And Substr(A.STATE_TR, -1) In ('A', 'D','C', 'F')
  Group By A.SERV_ID;

ALTER table PU_WT.WT_BIL_OWE_SP_4PRE add  PARTITION P201611 values (201611);
ALTER table PU_WT.WT_BIL_OWE_SP_4PRE TRUNCATE PARTITION(P201611);
INSERT INTO  PU_WT.WT_BIL_OWE_SP_4PRE 
Select '201611' MONTH_NO,
       '20170306' DATE_NO,
       A.SERV_ID,
       SP_ITEM_ID,
       TERM_TYPE_ID,
       OFFER_ID,
       CHARGE,
       BALANCE_TYPE1,
       BALANCE_RANGE,
       Case
         When Nvl(B.TOTAL_AMOUNT, 0) <> 0 Then
          '是'
         Else
          '否'
       End IS_OWE,
       ACC_NBR,
       AREA_CODE,
       USER_NAME,
       ADDRESS_NAME,
       DVLP_CHANNEL_ID,
       DVLP_STAFF_ID,
       C.STATUS_NAME,
       A.Billing_Mode_Id,
       Case
         When Nvl(B.AMOUNT, 0) <> 0 Then
          '是'
         Else
          '否'
       End IS_OWE_REAL
  From TMP7_BIL_OWE_SP A, TMP8_BIL_OWE_SP B, PU_META.D_USER_STATUS C
 Where A.SERV_ID = B.SERV_ID(+)
   And A.STATE = C.STATUS_CODE(+);
COMMIT;
 
