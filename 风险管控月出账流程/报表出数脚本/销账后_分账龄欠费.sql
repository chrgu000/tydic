--历史欠费账龄表
--待列账
DROP TABLE TMP_OWE_DL PURGE;
CREATE TABLE TMP_OWE_DL  AS
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
 from pu_model.TB_BIL_OWE_TAB_201801 a   --上月账期
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
DROP TABLE TMP_OWE_XZH PURGE;
create table TMP_OWE_XZH as
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
              B.FEE_MONTH = '201801' Then
          1
         Else
          0
       End IS_M_DL_FLAG
  From PU_MODEL.TB_BIL_OWE_M_201801 A
  Left Join TMP_OWE_DL B
    On A.SERV_ID = B.SERV_ID
   And A.BILLING_CYCLE_ID = B.BILLING_CYCLE_ID
 Where A.STATE In ('5JA', '5JD', '5JC', '5JF');

-- 销账后
DROP TABLE TMP_OWE_XZH_1;
CREATE TABLE TMP_OWE_XZH_1  AS
 SELECT *
 From (　Select T1.*,
 　　　　　　　Decode(T2.SERV_ID, Null, T1.AREA_CODE,t2.Area_Code1) AREA_CODE_NEW
             From   LY.TMP_OWE_XZH T1,   ---销账后    pu_list.sub_OWE_XZH
             (Select Distinct SERV_ID,
             　　　　T.Area_Code1
                  From  PU_busi_IND.bm_OWE_KN_NEW03@dl_newfx T
                  where month_NO='201801')  T2
       Where   T1.IS_DL_FLAG = 0
      And T1.SERV_ID = T2.SERV_ID(+) ) ;

-- 销账后欠费
Select FEE_MONTH,
       Sum(Decode(AREA_NAME, '版纳', XZH_AMOUNT_TDHDL, 0)),
       Sum(Decode(AREA_NAME, '保山', XZH_AMOUNT_TDHDL, 0)),
       Sum(Decode(AREA_NAME, '楚雄', XZH_AMOUNT_TDHDL, 0)),
       Sum(Decode(AREA_NAME, '大理', XZH_AMOUNT_TDHDL, 0)),
       Sum(Decode(AREA_NAME, '德宏', XZH_AMOUNT_TDHDL, 0)),
       Sum(Decode(AREA_NAME, '迪庆', XZH_AMOUNT_TDHDL, 0)),
       Sum(Decode(AREA_NAME, '红河', XZH_AMOUNT_TDHDL, 0)),
       Sum(Decode(AREA_NAME, '昆明', XZH_AMOUNT_TDHDL, 0)),
       Sum(Decode(AREA_NAME, '省政企', XZH_AMOUNT_TDHDL, 0)),
       Sum(Decode(AREA_NAME, '省商业客户部', XZH_AMOUNT_TDHDL, 0)),
       Sum(Decode(AREA_NAME, '丽江', XZH_AMOUNT_TDHDL, 0)),
       Sum(Decode(AREA_NAME, '临沧', XZH_AMOUNT_TDHDL, 0)),
       Sum(Decode(AREA_NAME, '怒江', XZH_AMOUNT_TDHDL, 0)),
       Sum(Decode(AREA_NAME, '曲靖', XZH_AMOUNT_TDHDL, 0)),
       Sum(Decode(AREA_NAME, '普洱', XZH_AMOUNT_TDHDL, 0)),
       Sum(Decode(AREA_NAME, '文山', XZH_AMOUNT_TDHDL, 0)),
       Sum(Decode(AREA_NAME, '玉溪', XZH_AMOUNT_TDHDL, 0)),
       Sum(Decode(AREA_NAME, '昭通', XZH_AMOUNT_TDHDL, 0)),
       Sum(Decode(AREA_NAME, '号百', XZH_AMOUNT_TDHDL, 0)),
       Sum(XZH_AMOUNT_TDHDL)
  From (Select A.FEE_MONTH, A.AREA_CODE_NEW, C.AREA_NAME,
          Sum(A.AMOUNT - A.XZH_DH_AMONUT) / 100 XZH_AMOUNT_TDHDL
          From TMP_OWE_XZH_1 A,
         /* (Select T1.*, Decode(T2.SERV_ID, Null, T1.AREA_CODE,t2.Area_Code1) AREA_CODE_NEW
                  From LY.TMP_OWE_XZH T1,   ---销账后    pu_list.sub_OWE_XZH
                (Select Distinct SERV_ID,t.Area_Code1
                  From  PU_busi_IND.bm_OWE_KN_NEW03@dl_newfx T where month_NO='201801' )  T2
                 Where   T1.IS_DL_FLAG = 0
                   And T1.SERV_ID = T2.SERV_ID(+)) A,*/
               PU_META.LATN_NEW@dl_newfx C
         Where A.AREA_CODE_NEW = C.LOCAL_CODE(+)
         Group By A.FEE_MONTH, A.AREA_CODE_NEW, C.AREA_NAME)
 Group By FEE_MONTH
 Order By FEE_MONTH;