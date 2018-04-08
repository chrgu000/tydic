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
 from pu_model.TB_BIL_OWE_TAB_201711 a
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

 
 
 --销账前欠费
DROP TABLE TMP_OWE_XZQ1 PURGE;
create table TMP_OWE_XZQ1 parallel 8 nologging as
 Select A.SERV_ID,
				BILLING_CYCLE_ID,
				Sum(A.AMOUNT) AMOUNT,
				Sum(Case
							When A.STATE In ('5JD', '5JF') Then
							 A.AMOUNT
							Else
							 0
						End) XZQ_DH_AMONUT,
				Sum(Case
							When A.STATE = '5JC' Then
							 A.AMOUNT
							Else
							 0
						End) XZQ_ST_AMONUT,
				Sum(Case
							When A.STATE = '5JA' Then
							 A.AMOUNT
							Else
							 0
						End) XZQ_OWE_AMONTH,
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
				End FEE_MONTH
	 From PU_MODEL.TB_BIL_OWE_BEF_M_201711 A
	Where A.STATE In ('5JA', '5JD', '5JC', '5JF')
	Group By SERV_ID,
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
					 BILLING_CYCLE_ID ;
 
DROP TABLE TMP_OWE_XZQ PURGE;
create table TMP_OWE_XZQ  parallel 8 nologging as
Select A.*,
			 Case
				 When Nvl(B.DL_AMOUNT, 0) <> 0 Then
					1
				 Else
					0
			 End IS_DL_FLAG,
			 Case
				 When Nvl(B.DL_AMOUNT, 0) <> 0 And
							B.FEE_MONTH = '201710' Then
					1
				 Else
					0
			 End IS_M_DL_FLAG,
			 Case
				 When Nvl(B.DL_AMOUNT, 0) <> 0 Then
					Nvl(B.DL_AMOUNT, 0)
				 Else
					0
			 End XZQ_DL_AMOUNT1
	From TMP_OWE_XZQ1  A
	Left Join TMP_OWE_DL B
		On A.SERV_ID = B.SERV_ID
	 And A.BILLING_CYCLE_ID = B.BILLING_CYCLE_ID; 

Select sum(amount),Sum(XZQ_DH_AMONUT), Sum(XZQ_OWE_AMONTH),  Sum(XZQ_DL_AMOUNT1)
	From TMP_OWE_XZQ T
 Where /*T.IS_DL_FLAG = 0
	 And*/ FEE_MONTH >= 201211
	 And FEE_MONTH <= 201706;
   
   --184896351117	101111164101	83785187016	32039840019

create table pu_wt.TMP_wrm_OWE_XZQ parallel 8 nologging as
select * from wrm.TMP_OWE_XZQ@DL_EDW_YN ;

   
   -- 历史欠费
select /*+parallel(T1,8)*/  FEE_MONTH,
       Sum(Decode(AREA_NAME, '版纳', XZQ_AMOUNT_TDHDL, 0)),
       Sum(Decode(AREA_NAME, '保山', XZQ_AMOUNT_TDHDL, 0)),
       Sum(Decode(AREA_NAME, '楚雄', XZQ_AMOUNT_TDHDL, 0)),
       Sum(Decode(AREA_NAME, '大理', XZQ_AMOUNT_TDHDL, 0)),
       Sum(Decode(AREA_NAME, '德宏', XZQ_AMOUNT_TDHDL, 0)),
       Sum(Decode(AREA_NAME, '迪庆', XZQ_AMOUNT_TDHDL, 0)),
       Sum(Decode(AREA_NAME, '红河', XZQ_AMOUNT_TDHDL, 0)),
       Sum(Decode(AREA_NAME, '昆明', XZQ_AMOUNT_TDHDL, 0)),
       Sum(Decode(AREA_NAME, '省政企', XZQ_AMOUNT_TDHDL, 0)),
       Sum(Decode(AREA_NAME, '省商业客户部', XZQ_AMOUNT_TDHDL, 0)),
       Sum(Decode(AREA_NAME, '丽江', XZQ_AMOUNT_TDHDL, 0)),
       Sum(Decode(AREA_NAME, '临沧', XZQ_AMOUNT_TDHDL, 0)),
       Sum(Decode(AREA_NAME, '怒江', XZQ_AMOUNT_TDHDL, 0)),
       Sum(Decode(AREA_NAME, '曲靖', XZQ_AMOUNT_TDHDL, 0)),
       Sum(Decode(AREA_NAME, '普洱', XZQ_AMOUNT_TDHDL, 0)),
       Sum(Decode(AREA_NAME, '文山', XZQ_AMOUNT_TDHDL, 0)),
       Sum(Decode(AREA_NAME, '玉溪', XZQ_AMOUNT_TDHDL, 0)),
       Sum(Decode(AREA_NAME, '昭通', XZQ_AMOUNT_TDHDL, 0)),
       Sum(Decode(AREA_NAME, '号百', XZQ_AMOUNT_TDHDL, 0)),
       Sum(XZQ_AMOUNT_TDHDL)
  From (Select T1.FEE_MONTH, T2.AREA_CODE1 AREA_CODE, T2.AREA_NAME1 AREA_NAME, 
               Sum(T1.AMOUNT - T1.XZQ_DH_AMONUT-T1.XZQ_DL_AMOUNT1) / 100 XZQ_AMOUNT_TDHDL
        From LY.TMP_OWE_XZQ T1, 
             (select * 
               from PU_WT.WT_BIL_OWE_LIST_D_NEW@DL_NEWFX
               where date_no='20171210'
             ) T2
         Where T1.FEE_MONTH >= 201211
           And T1.SERV_ID = T2.SERV_ID(+)
         Group By T1.FEE_MONTH, T2.AREA_CODE1, T2.AREA_NAME1
       )
 Group By FEE_MONTH
 Order By FEE_MONTH;
