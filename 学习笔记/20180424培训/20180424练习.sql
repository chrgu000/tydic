--1,13398857945用户姓名、性别、生日、地址、客户类型、付费类型、 单融标识、主套餐、是否是合约套餐用户、如果是合约套餐名称、合约到期时间--

-- 用户基本信息
drop table tmp.tmp_zxy purge;
create table tmp.tmp_zxy as
SELECT  a.serv_id, -- 用户id 
        a.acct_id, -- 合同号
       a.cust_name 姓名, -- 姓名
       decode(a.gender,1,'男'，2，'女'） 性别，--性别
       a.birth_date 生日, --生日
       a.address_name 地址,--地址
       a.std_cust_type_cd, 
       b.lev3_cust_type_name 客户类型, -- 客户类型
       decode(a.payment_method_cd,1,'后付费'，'预付费') 付费方式--付费方式
    FROM tbas.wt_prod_serv_d_201805 a,PU_META.TPDIM_STD_CUST_TYPE_LEV b
    WHERE a.std_cust_type_cd=b.std_cust_type_cd(+)
       and a.prod_inst_state='2HA' --用户状态正常
       and a.product_id in('779','833') -- 移动
       and  a.acc_nbr='17787292926';   
        -- 手机号码
       
SELECT * FROM tmp.tmp_zxy; 
    
 --  单融标识、主套餐、是否是合约套餐用户、如果是合约套餐名称、合约到期时间--
 drop table tmp.tmp_zxy1 purge;
 create table tmp.tmp_zxy1 as
 select c.*,  -- 用户基本信息
         b.is_rh_flag 单融标识, -- 单融标识
         b.market_type2 产品类型,-- 产品类型
         b.zhu_offer_id,  -- 主套餐id
         b.zhu_offer_name 主套餐名称,  -- 主套餐名称
         decode(b.hy_offer_id,'','否','是') 合约标识,-- 合约标识
         b.hy_offer_id , -- 合约套餐id 
         a. PO_SPEC_NM 合约套餐名称, -- 合约套餐名称       
         b.hy_exp_date  合约到期时间 -- 合约到期时间
 from  PU_META.TPDIM_OFFER_CATALOG_NEW a, 
       TBAS.WT_P_OFFER_SERV_D_201805 b,
       tmp.tmp_zxy c
    WHERE  b.hy_offer_id=a.po_spec_cd(+)
           and c.serv_id=b.serv_id(+) ;
           
 SELECT * FROM tmp.tmp_zxy1;
 

   
--- 2，此号码合同号下的其他产品有哪些、状态、业务量组成

DROP TABLE tmp.tmp_zxy2 PURGE;
CREATE TABLE tmp.tmp_zxy2 AS 
SELECT
B.ACCT_ID, --合同号
A.SERV_ID, --用户id
a.acc_nbr, -- 手机号码
A.PRODUCT_ID, -- 产品id
A.STD_PRODUCT_ID,-- 产品id
A.PROD_INST_STATE -- 产品实例状态
FROM tbas.wt_prod_serv_d_201805 A,tmp.tmp_zxy B
WHERE B.acct_id=A.acct_id(+);
 -- 合同号

--SELECT * FROM tmp.tmp_zxy2;

-- 合同号下的产品，状态
drop table tmp.tmp_zxy3 purge;
CREATE TABLE tmp.tmp_zxy3 AS
SELECT
A.ACCT_ID, -- 合同号
A.SERV_ID,-- 用户id 
A.ACC_NBR, -- 接入号
A.PRODUCT_ID, --产品id
B.LEV3_PRODUCT_NAME,-- 产品名称
C.STATUS_CODE,-- 状态编码
C.STATUS_NAME --状态
FROM tmp.tmp_zxy2 A
     LEFT JOIN  PU_META.TPDIM_STD_PRODUCT_LEV B ON A.STD_PRODUCT_ID=B.PRODUCT_ID --取产品名称
     LEFT JOIN  pu_meta.d_user_status C ON A.PROD_INST_STATE=C.STATUS_CODE ; 
       -- 取产品状态
     
-- +业务量组成     
drop table TMP.TMP_ZXY4 purge;
create table TMP.TMP_ZXY4 as
SELECT 
a.serv_id 用户id,
a.acc_nbr 接入号,
a.product_id 产品id,
a.lev3_product_name 产品名称,
a.status_name 状态,
b.cnt 通话总次数,
round(b.dur/60,2) 通话总时长,
round(b.mbl_innet_flux/(1024*1024),2) 手机上网流量,
round(b.brd_data_flux/(1024*1024),2) 宽带流量,
b.mbl_mms_cnt 彩信条数,
b.mbl_sms_cnt 短信条数
FROM TMP.TMP_ZXY3 a,TBAS.EVT_PRD_BUSI_M_201804 b
WHERE a.serv_id=b.serv_id(+);

SELECT * FROM TMP.TMP_ZXY4 order by 用户id;
----- 
     
  
SELECT * FROM tmp.tmp_zxy3;

SELECT * FROM pu_meta.d_user_status;

--- 3、此号码合同号下所有产品的收入组成 

drop table tmp.zxy_tmp6 purge;
create table tmp.zxy_tmp6 as
SELECT  
a.serv_id,  --  用户id
a.product_id, -- 产品类型id
a.lev3_product_name product_name, -- 产品名称
c.name, -- 收入组成
sum(b.charge) charge, -- 分摊后收入
sum(b.tax) tax, -- 税金
sum(b.charge_flh)charge_flh -- 分摊后税后
FROM tmp.tmp_zxy3 A  
     left join   PU_MODEL.Tb_Bil_Fin_Incm_Mon_201804 B  on a.serv_id=b.serv_id
     left join  DSG.ACCT_ITEM_TYPE@DL_ODS_89_YN C on b.acct_item_type_id=c.acct_item_type_id
  WHERE a.status_code not in ('2HX','2IX') --剔除拆机 
  group by 
      a.serv_id,  --  用户id
      a.product_id, -- 产品类型id
      a.lev3_product_name, -- 产品名称
      c.name -- 收入组成    
     ;
SELECT * FROM tmp.zxy_tmp6 order by serv_id;



-- 4，此号码合同号下所有手机号码使用的终端串码、终端型号、终端类型、终端价格段

DROP TABLE TMP.TMP_ZXY5 PURGE;
CREATE TABLE TMP.TMP_ZXY5 AS
SELECT 
distinct
a.acct_id，-- 合同号
a.acc_nbr, --手机号
b.phone_type , --型号
b.phone_code, -- 串码
b.terminal_type, -- 类型
C.PRICE, --价格段
c.time_cd
FROM  tmp.tmp_zxy3 A 
   LEFT JOIN pu_intf.i_MAIL_SELFREG B ON A.ACC_NBR=B.PHONE_NUMBER  --取手机手机号使用的终端信息
   LEFT JOIN PU_INTF.I_MAIL_ALL C ON B.PHONE_TYPE=C.TERMINAL_NAME  -- 取终端价值段
 WHERE  a.product_id in ('779','833')  -- 移动
       and a.status_code not in ('2HX','2IX') -- 剔除拆机的    
       and b.time_cd=c.time_cd;    
 
SELECT  * FROM  TMP.TMP_ZXY5;




------------  业务量组成


  --- 语音话单
drop table tmp.tmp_zxy7;
create table tmp.tmp_zxy7 as
SELECT 
a.serv_id,
a.acc_nbr,
a.product_id,
a.lev3_product_name product_name,  
b.std_event_type_id,
c.std_event_type_name,
sum(b.cnt) cnt, -- 通话次数
round(sum(b.cdr_duration)/60,2) dur  -- 通话时长 分钟
FROM   tmp.tmp_zxy3 a 
       left join PU_MODEL.TB_EVT_CALLING_M_201804 b on a.serv_id=b.serv_id   -- 语音话单
        left join PU_META.TPDIM_STD_EVENT_TYPE c on b.std_event_type_id=c.std_event_type_cd
WHERE a.status_code not in ('2HX','2IX')
 group by   
a.serv_id,
a.acc_nbr,
a.product_id,
b.std_event_type_id,
c.std_event_type_name,
lev3_product_name
order by a.serv_id
 ;
 
 SELECT * FROM tmp.tmp_zxy7;
  ------   数据话单 
drop table tmp.tmp_zxy8;
create table tmp.tmp_zxy8 as
SELECT 
a.serv_id,
a.acc_nbr,
a.product_id,
a.lev3_product_name product_name,
b.std_event_type_id,
c.std_event_type_name,
round(sum(b.sum_amount/(1024*1024)),2) sum_amount--流量 M
FROM   tmp.tmp_zxy3 a 
       left join PU_MODEL.TB_EVT_DATA_M_201804 b on a.serv_id=b.serv_id  
        left join PU_META.TPDIM_STD_EVENT_TYPE c on b.std_event_type_id=c.std_event_type_cd
WHERE a.status_code not in ('2HX','2IX')
 group by   
a.serv_id,
a.acc_nbr,
a.product_id,
b.std_event_type_id,
c.std_event_type_name,
a.lev3_product_name
order by serv_id
 ;
 
 SELECT * FROM tmp.tmp_zxy8;
--SELECT a.serv_id,sum(a.sum_amount) FROM tmp.tmp_zxy8 a group by a.serv_id;

  ---- 增值话单
drop table tmp.tmp_zxy9;
create table tmp.tmp_zxy9 as
SELECT 
a.serv_id,
a.acc_nbr,
a.product_id,
a.lev3_product_name product_name,
b.std_event_type_id,
c.std_event_type_name,
sum(b.sum_amount) sum_amount-- 短彩信条数
FROM   tmp.tmp_zxy3 a 
       left join PU_MODEL.TB_EVT_SMS_M_201804 b on a.serv_id=b.serv_id  
        left join PU_META.TPDIM_STD_EVENT_TYPE c on b.std_event_type_id=c.std_event_type_cd
WHERE a.status_code not in ('2HX','2IX')
 group by   
a.serv_id,
a.acc_nbr,
a.product_id,
b.std_event_type_id,
c.std_event_type_name,
a.lev3_product_name
order by serv_id
 ;

SELECT * FROM  tmp.tmp_zxy9;

--SELECT * FROM  PU_MODEL.TB_EVT_SMS_M_201803;

 ---- 合并 业务量组成
SELECT * FROM (
SELECT  
a.serv_id,
a.acc_nbr,
a.product_id,
a.product_name,  
a.std_event_type_id,
a.std_event_type_name,
a.dur sum_amount  -- 通话时长
from tmp.tmp_zxy7 a
union all
SELECT * FROM tmp.tmp_zxy8
union all 
SELECT * FROM tmp.tmp_zxy9
)
WHERE std_event_type_id is not null
order by serv_id,std_event_type_name;
-----












