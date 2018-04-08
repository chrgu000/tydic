--生成欠费计提清单   ods在121库
DROP TABLE TMP_DH_OWE PURGE;
CREATE TABLE TMP_DH_OWE  NOLOGGING AS
Select A.SERV_ID,
			 Sum(Case
						 When (MONTHS_BETWEEN(TO_DATE(STAT_MONTH, 'yyyymm'), TO_DATE(OWE_MONTH2, 'yyyymm')) <= 0) Then
							AMOUNT
						 Else
							0
					 End) QY_AMOUNT,
			 Sum(Case
						 When (MONTHS_BETWEEN(TO_DATE(STAT_MONTH, 'yyyymm'), TO_DATE(OWE_MONTH2, 'yyyymm')) = 1) Then
							AMOUNT
						 Else
							0
					 End) AMOUNT1,
			 Sum(Case
						 When (MONTHS_BETWEEN(TO_DATE(STAT_MONTH, 'yyyymm'), TO_DATE(OWE_MONTH2, 'yyyymm')) = 2) Then
							AMOUNT
						 Else
							0
					 End) AMOUNT2,
			 Sum(Case
						 When (MONTHS_BETWEEN(TO_DATE(STAT_MONTH, 'yyyymm'), TO_DATE(OWE_MONTH2, 'yyyymm')) Between 3 And 3) Then
							AMOUNT
						 Else
							0
					 End) AMOUNT3,
			 Sum(Case
						 When (MONTHS_BETWEEN(TO_DATE(STAT_MONTH, 'yyyymm'), TO_DATE(OWE_MONTH2, 'yyyymm')) Between 13 And 36) Then
							AMOUNT
						 Else
							0
					 End) AMOUNT13_36,
			 Sum(Case
						 When (MONTHS_BETWEEN(TO_DATE(STAT_MONTH, 'yyyymm'), TO_DATE(OWE_MONTH2, 'yyyymm')) > 36) Then
							AMOUNT
						 Else
							0
					 End) AMOUNT37,
			 Sum(Case
						 When (MONTHS_BETWEEN(TO_DATE(STAT_MONTH, 'yyyymm'), TO_DATE(OWE_MONTH2, 'yyyymm')) = 4) Then
							AMOUNT
						 Else
							0
					 End) AMOUNT4,
			 Sum(Case
						 When (MONTHS_BETWEEN(TO_DATE(STAT_MONTH, 'yyyymm'), TO_DATE(OWE_MONTH2, 'yyyymm')) = 5) Then
							AMOUNT
						 Else
							0
					 End) AMOUNT5,
			 Sum(Case
						 When (MONTHS_BETWEEN(TO_DATE(STAT_MONTH, 'yyyymm'), TO_DATE(OWE_MONTH2, 'yyyymm')) = 6) Then
							AMOUNT
						 Else
							0
					 End) AMOUNT6,
			 Sum(Case
						 When (MONTHS_BETWEEN(TO_DATE(STAT_MONTH, 'yyyymm'), TO_DATE(OWE_MONTH2, 'yyyymm')) = 7) Then
							AMOUNT
						 Else
							0
					 End) AMOUNT7,
			 Sum(Case
						 When (MONTHS_BETWEEN(TO_DATE(STAT_MONTH, 'yyyymm'), TO_DATE(OWE_MONTH2, 'yyyymm')) = 8) Then
							AMOUNT
						 Else
							0
					 End) AMOUNT8,
			 Sum(Case
						 When (MONTHS_BETWEEN(TO_DATE(STAT_MONTH, 'yyyymm'), TO_DATE(OWE_MONTH2, 'yyyymm')) = 9) Then
							AMOUNT
						 Else
							0
					 End) AMOUNT9,
			 Sum(Case
						 When (MONTHS_BETWEEN(TO_DATE(STAT_MONTH, 'yyyymm'), TO_DATE(OWE_MONTH2, 'yyyymm')) = 10) Then
							AMOUNT
						 Else
							0
					 End) AMOUNT10,
			 Sum(Case
						 When (MONTHS_BETWEEN(TO_DATE(STAT_MONTH, 'yyyymm'), TO_DATE(OWE_MONTH2, 'yyyymm')) = 11) Then
							AMOUNT
						 Else
							0
					 End) AMOUNT11,
			 Sum(Case
						 When (MONTHS_BETWEEN(TO_DATE(STAT_MONTH, 'yyyymm'), TO_DATE(OWE_MONTH2, 'yyyymm')) = 12) Then
							AMOUNT
						 Else
							0
					 End) AMOUNT12
	From (Select *
					From IPD_IN.I_IN_B_750_DHZ_201711@DL_ODL_89 A
				 Where A.STAT_MONTH = '201711'
					 And ((Nvl(DZJ_FLAG, 0) <> '1' And Nvl(GLF_FLAG, 0) <> '1' And Nvl(HYQ_FLAG, 0) = 0 And Nvl(PPM_AMOUNT, 0) = 0) Or
							 (Nvl(DZJ_FLAG, 0) <> '1' And Nvl(GLF_FLAG, 0) <> '1' And HYQ_FLAG = 1))
					 And STATE = '5JA'
				Union All
				---超过1年的
				Select *
					From IPD_IN.I_IN_B_750_DHZ_201711@DL_ODL_89 A
				 Where A.STAT_MONTH = '201711'
					 And ((Nvl(DZJ_FLAG, 0) = '1' And MONTHS_BETWEEN(TO_DATE(STAT_MONTH, 'yyyymm'), TO_DATE(OWE_MONTH2, 'yyyymm')) > 12 And STATE = '5JA') Or
							 (Nvl(DZJ_FLAG, 0) <> 1 And Nvl(GLF_FLAG, 0) = 1 And MONTHS_BETWEEN(TO_DATE(STAT_MONTH, 'yyyymm'), TO_DATE(OWE_MONTH2, 'yyyymm')) > 12) And
							 STATE = '5JA')
				
				Union All
				---收回
				Select *
					From IPD_IN.I_IN_B_750_DHZ_201711@DL_ODL_89 A
				 Where A.STAT_MONTH = '201711'
					 And STATE = '5JG'
					 And (Nvl(DZJ_FLAG, 0) = 0 And Nvl(GLF_FLAG, 0) = 0 And Nvl(PPM_AMOUNT, 0) = 0 And Nvl(HYQ_FLAG, 0) = 0)) A
 Where Substr(A.OWE_MONTH2, -2) <= 12
	 And STATE = '5JA'
 Group By A.SERV_ID; 
 
 
 
DROP TABLE TMP1_DH_OWE PURGE;
CREATE TABLE pu_wt.TMP1_DH_OWE PARALLEL 6 NOLOGGING AS
Select B.AREA_CODE,
			 B.AREA_CODE AREA_CODE1,
			 D.BRANCH_NAME3,
			 D.BRANCH_CODE,
			 D.BRANCH_NAME,
			 B.DVLP_STAFF_ID,
			 F.STAFF_NAME,
			 B.DVLP_CHANNEL_ID,
			 E.CHANNEL_NAME,
			 E.CHANNEL_TYPE_CLASS,
			 A.SERV_ID,
			 B.ACC_NBR,
			 B.ACCT_ID,
			 B.CUST_ID,
			 G.CUST_NAME,
			 Decode(Substr(G.CUST_GROUP_ID, 1, 1), 1, '政企', '公众') CUST_GROUP,
			 Decode(B.BILLING_MODE_ID, 1, '预付费', '后付费') BILLING_MODE,
			 B.ADDRESS_NAME,
			 B.USER_NAME,
			 H.PRODUCT_NAME,
			 I.STATUS_NAME,
			 A.QY_AMOUNT,
			 A.AMOUNT1,
			 A.AMOUNT2,
			 A.AMOUNT3,
			 A.AMOUNT4,
			 A.AMOUNT5,
			 A.AMOUNT6,
			 A.AMOUNT7,
			 A.AMOUNT8,
			 A.AMOUNT9,
			 A.AMOUNT10,
			 A.AMOUNT11,
			 A.AMOUNT12,
			 A.AMOUNT13_36,
			 A.AMOUNT37,
			 J.PRODUCT_ID,
			 J.PRODUCT_NAME PRODUCT_NAME1,
			 J.LEV2_PRODUCT_NAME,
			 J.LEV3_PRODUCT_NAME,
			 J.LEV4_PRODUCT_NAME,
			 J.LEV5_PRODUCT_NAME,
			 J.LEV6_PRODUCT_NAME
	From PU_WT.TMP_DH_OWE A
	Left Join PU_WT.F_1_SERV_D_JF B
		On A.SERV_ID = B.SERV_ID
	Left Join PU_INTF.I_IN_KG_SERV_GRID Partition(P201711) C
		On A.SERV_ID = C.PROD_ID
	Left Join PU_META.D_HX_ZD_ORG_BRANCH_TREE D
		On C.SUM_BRANCH_CODE = D.BRANCH_CODE
	Left Join PU_META.F_1_CRM_CHANNEL E
		On B.DVLP_CHANNEL_ID = E.CHANNEL_ID
	Left Join PU_META.F_1_CRM_STAFF F
		On B.DVLP_STAFF_ID = F.STAFF_CODE
	Left Join PU_WT.WT_CUST_INFO G
		On B.CUST_ID = G.CUST_ID
	Left Join PU_META.D_PRODUCT H
		On B.TERM_TYPE_ID = H.PRODUCT_ID
	Left Join PU_META.D_USER_STATUS I
		On B.STATE = I.STATUS_CODE
	Left Join PU_META.TPDIM_STD_PRODUCT_LEV J
		On B.PROD_SPEC_ID = J.PRODUCT_ID
  Where  b.serv_id is not null;
  /*

201969674.7 
  
    
Select  
			 sum(AMOUNT4 + AMOUNT5 + AMOUNT6 + AMOUNT7 + AMOUNT8 + AMOUNT9 + AMOUNT10 + AMOUNT11 + AMOUNT12 + AMOUNT13_36) JTHZ_AMOUNT
	From TMP1_DH_OWE A    
*/

drop table   PU_WT.TMP_DH_BAL purge; 
CREATE TABLE PU_WT.TMP_DH_BAL PARALLEL 4 NOLOGGING AS
Select ACCT_ID, Sum(A.BALANCE) BAL
	From PU_INTF.I_ACCT_BALANCE A
 Where Exists (Select 'x' From PU_WT.TMP1_DH_OWE B Where A.ACCT_ID = B.ACCT_ID)
	 And A.BALANCE_TYPE_ID <> '159'
 Group By ACCT_ID;
 
 
--drop table wt_serv_jthz_201711 purge;
CREATE TABLE PU_WT.wt_serv_jthz_201711
PARTITION BY LIST (area_code)
(
   partition P0000 values ('0000') tablespace TBAS_DW,
  partition P0691 values ('0691') tablespace TBAS_DW,
  partition P0692 values ('0692') tablespace TBAS_DW,
  partition P0870 values ('0870') tablespace TBAS_DW, 
  partition P0871 values ('0871') tablespace TBAS_DW, 
  partition P0872 values ('0872') tablespace TBAS_DW, 
  partition P0873 values ('0873') tablespace TBAS_DW,
  partition P0874 values ('0874') tablespace TBAS_DW,
  partition P0875 values ('0875') tablespace TBAS_DW,
  partition P0876 values ('0876') tablespace TBAS_DW, 
  partition P0877 values ('0877') tablespace TBAS_DW,
  partition P0878 values ('0878') tablespace TBAS_DW,
  partition P0879 values ('0879') tablespace TBAS_DW, 
  partition P0883 values ('0883') tablespace TBAS_DW, 
  partition P0886 values ('0886') tablespace TBAS_DW, 
  partition P0887 values ('0887') tablespace TBAS_DW,
  partition P0888 values ('0888') tablespace TBAS_DW
)  NOLOGGING AS
Select A.*,
			 Nvl(B.BAL, 0) BAL,
			 Decode(D.ACCT_ID, Null, 0, 1) IS_VIP_FLAG,
			 AMOUNT4 + AMOUNT5 + AMOUNT6 + AMOUNT7 + AMOUNT8 + AMOUNT9 + AMOUNT10 + AMOUNT11 + AMOUNT12 + AMOUNT13_36 JTHZ_AMOUNT
	From PU_WT.TMP1_DH_OWE A
	Left Join PU_WT.TMP_DH_BAL B
		On A.ACCT_ID = B.ACCT_ID
	Left Join PU_INTF.I_PRD_VIP_ACCT Partition(P201711) D
		On A.ACCT_ID = D.ACCT_ID
	 And TO_CHAR(D.EXP_DATE, 'YYYYMM') > '201711';
   
Select sum(jthz_amount) FROM PU_WT.wt_serv_jthz_201711;  ---31496554256 31806556396 29252245575 26816081179 22828875264
