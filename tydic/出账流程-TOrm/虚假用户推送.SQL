--59库执行  
--同步上月虚假用户+6月无效用户    给营销管控支撑系统

DROP TABLE tmp_wt_serv_mon_201710 PURGE;
CREATE TABLE tmp_wt_serv_mon_201710 PARALLEL 4 NOLOGGING AS
Select '201710' MONTH_NO,
       AREA_CODE,
       SRC_ORG_ID,
       STD_AREA_ID,
       A.SERV_ID,
       BILLING_MODE_ID,
       CUST_ID,
       PROD_SPEC_ID,
       TERM_TYPE_ID,
       ACC_NBR,
       CERT_TYPE,
       CERT_NUMBER,
       USER_NAME,
       SERV_CREATE_DATE,
       SERV_LOST_DATE,
       SERV_MODI_DATE,
       IS_LIVECARD,
       STATE,
       STAFF_ID,
       CHANNEL_ID,
       VIP_SERV_GRADE,
       BRANCH_CODE,
       DVLP_STAFF_ID,
       CUST_ST_GROUP_ID,
       ADDRESS_ID,
       ADDRESS_NAME,
       STAT_ORG_ID,
       ACCT_ID,
       DVLP_CHANNEL_ID,
       CREATE_MONTH,
       BCD_CODE,
       IS_HUOYE_FALG,
       ALL_OFFER_NAME,
       ZHU_OFFER_NAME,
       ZHU_OFFER_ID,
       MARKET_TYPE1,
       MARKET_TYPE2,
       Decode(C.SERV_ID, Null, '否', '是') IS_WX,
       Decode(B.SERV_ID, Null, '否', '是') IS_XJ,
       DECODE(A.IS_BILLING_FLAG,1,'是','否') IS_BILLING_FLAG,
       a.call_number
  From (Select *
          From PU_WT.WT_HALF_SERV_201710 T
         Where TERM_TYPE_ID In (779, 833)
           And IS_DEV_FLAG = 1) A,
       (Select Distinct SERV_ID From PU_WT.WT_SERV_YSXJ_M_201710 Where IS_XJ_FLAG = 1) B,
       KG_INTF.WT_SERV_WX_201710@DL_239 C
 Where A.SERV_ID = B.SERV_ID(+)
   And A.SERV_ID = C.SERV_ID(+);
   
--239库执行
CREATE TABLE pu_wt.wt_serv_mon_201710 compress NOLOGGING AS    
Select * from pu_intf.tmp_wt_serv_mon_201710@Dl_Newfx;
select * from pu_wt.wt_serv_mon_201709                    
                                  
grant select on pu_wt.wt_serv_mon_201710 to kg_intf; 

 --59库执行
drop table pu_intf.tmp_wt_serv_mon_201710 purge;
