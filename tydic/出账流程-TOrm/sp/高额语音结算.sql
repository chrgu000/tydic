calling_attach_code 是归属地
area_code 漫游地
calling_number  号码

月份  serv_id IMSI号码  MDN号码 号码归属地 客户名称  用户状态  付费方式  
产品  套餐  漫游地区号 漫游地省名称  漫游地名称 漫游流量_G  调整前结算金额_元 需调整结算金额_元 调整后结算金额_元 分摊前收入


drop table TMP_ROAM_CALL_JS_1 purge;
create table TMP_ROAM_CALL_JS_1 AS
Select SERVED_IMSI, CALLING_NUMBER, CALLING_ATTACH_CODE AREA_CODE, AREA_CODE AREA_CODE_ROAM, Sum(CALL_DURATION) CALL_DURATION, Sum(SETT_FEE) / 100 SETT_FEE
	From ZHJS_APP.TL_Y_ROAM_LIST_201702@Dl_Zhjs_Yn
 Where SOURCE_ID = 262
	 And CALLING_ATTACH_CODE <> AREA_CODE
	 And Substr(START_DATETIME, 1, 8) Between '20170201' And '20170228'
 Group By SERVED_IMSI, CALLING_NUMBER, CALLING_ATTACH_CODE, AREA_CODE; 

--DROP TABLE PU_WT.WT_ROAM_CALL_JS_MON PURGE;
delete from  pu_wt.wt_roam_call_js_mon t Where month_no = 201702;
commit;
Insert
/*+append*/
Into PU_WT.WT_ROAM_CALL_JS_MON
	Select '201702' MONTH_NO,
				 B.SERV_ID,
				 A.SERVED_IMSI,
				 A.CALLING_NUMBER,
				 A.AREA_CODE, --  结算话单用户归属地市
				 B.AREA_CODE AREA_CODE_SERV, --用户资料用户归属地市
				 B.USER_NAME,
				 C.STATUS_NAME,
				 Decode(B.BILLING_MODE_ID, 1, '预付费', '后付费') BILLING_MODE,
				 D.PRODUCT_NAME,
				 E.ZHU_OFFER_ID,
				 E.ZHU_OFFER_NAME,
				 A.AREA_CODE_ROAM AREA_CODE_ROAM,
				 F.PROV_NAME PROV_NAME,
				 F.AREA_NAME,
				 A.CALL_DURATION  ,
				 A.SETT_FEE,
				 Nvl(G.CHARGE, 0) CHARGE,
				 B.DVLP_CHANNEL_ID,
				 H.CHANNEL_NAME,
				 SUBSTR(B.SERV_CREATE_DATE,1,8)
		From zml.TMP_ROAM_CALL_JS_1@Dl_Edw_Yn A,
				 (Select *
						From (Select T.*, ROW_NUMBER() OVER(Partition By ACC_NBR Order By STATE Asc, SERV_CREATE_DATE Desc, SERV_LOST_DATE Desc) RN
										From F_1_SERV_D_JF T)
					 Where RN = 1) B,
				 PU_META.D_USER_STATUS C,
				 REPORT.PRODUCT@DL_BILL D,
				 tbas.wt_P_OFFER_SERV_D_201702@Dl_Edw_Yn E,
				 PU_META.TPDIM_WHOLE_COUNTRY_AREA_CODE@DL_EDW_YN F,
				 (Select SERV_ID, Sum(CHARGE) CHARGE From PU_INTF.I_ACCT_ITEM_M Partition(P201702) Group By SERV_ID) G,
				 PU_META.F_1_CRM_CHANNEL H
	 Where A.CALLING_NUMBER = B.ACC_NBR(+)
		 And B.STATE = C.STATUS_CODE(+)
		 And B.TERM_TYPE_ID = D.PRODUCT_ID(+)
		 And B.SERV_ID = E.SERV_ID(+)
		 And A.AREA_CODE_ROAM = '0' || F.AREA_CODE(+)
		 And B.SERV_ID = G.SERV_ID(+)
		 And B.DVLP_CHANNEL_ID = H.CHANNEL_ID(+);
Commit; 

    
 Select * FROM pu_wt.wt_roam_call_js_mon t Where t.Month_No = 201702 and t.SETT_FEE <-100;
 
 Select Count(*)
	 From TMP_ROAM_CALL_JS_1 T
	Where T.SETT_FEE > 100
		 Or T.SETT_FEE < -100;

