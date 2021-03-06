

select * from pu_meta.etl_program_rule where rule_id='3010006';---规则表 

select * from pu_meta.etl_inter_rule where rule_id= 2010062;

select * from pu_meta.etl_program_rule a WHERE lower(a.tab_dest_name) like'%wt_serv%'; 
select * from pu_meta.etl_program_rule a WHERE upper(a.tab_dest_name) like'%WT_BIL_SERV_OWE_D%'; 




----6号欠费
 --------------用户划小关系对应-      
SELECT * FROM  ipd_in.i_in_kg_SERV_GRID_201802_ODS@dl_odl_89;---源表

select /*+parallel(a,8)*/    count(*) from  pu_intf.I_IN_KG_SERV_GRID partition(p201712) a;-- 58511715
select /*+parallel(a,8)*/    count(*) from  pu_intf.I_IN_KG_SERV_GRID partition(p201803) a;-- 60827928


select /*+parallel(a,8)*/ a.MONTH_NO,count(*) from  pu_intf.I_IN_KG_SERV_GRID a group by a.MONTH_NO order by a.month_no;   



 -------省政企用户清单 

  select /*+parallel(a,8)*/   count(*) from  pu_wt.wt_serv_shz_all_201802;   ---省政企用户清单  226721
  select /*+parallel(a,8)*/   count(*) from  pu_wt.wt_serv_shz_all_201803;   ---省政企用户清单  228308
 
  
--源表1：select * from  pu_intf.I_IN_KG_SERV_GRID partition(p201712) 

--源表2；SELECT * FROM pu_intf.I_IN_HX_ZD_ORG_BRANCH WHERE DATE_NO = TO_CHAR(SYSDATE-1,'YYYYMMDD')
 

 -----月欠费宽表(新版)  
 --WANGRM: etl调度是建表报错  导致后面流程会报错 

--- 建表语句  /home/yntbas/bin/SRCSQL/wt/PRE_WT_SERV_OWE_M.sql
 
select area_code,  --
       count(*),
       sum(xzh_amount_total), 
       sum(xzh_amount_real)
  from PU_INTF.WT_SERV_OWE_M_201802_ZML
 group by area_code;
 
 ---
 select area_code,  --
       count(*),
       sum(xzh_amount_total), 
       sum(xzh_amount_real)
  from PU_INTF.WT_SERV_OWE_M_201803_ZML
 group by area_code;
 
 
-----欠费区域排名前1000片段表(新版) 

select area_code,count(*),sum(x.amount_total),sum(x.serv_num)   --
from pu_wt.WT_P_OWE_ACCT_ORDER_201802_NEW x 
 group by x.area_code; 

select count(*),sum(x.amount_total),sum(x.serv_num) --  18006	58637236838	836232
from pu_wt.WT_P_OWE_ACCT_ORDER_201802_NEW x ; 


 

-----库内欠费月统计基础指标(新版)
select sum(x.is_i_flag),sum(x.is_zq_flag),sum(x.amount_total)  
from  PU_BASE_IND.DM_BIL_ITEM_OWE_201802_NEW x;  -- 1	583	129	373949784087

select sum(x.is_i_flag),sum(x.is_zq_flag),sum(x.amount_total)  
from  PU_BASE_IND.DM_BIL_ITEM_OWE_201801_NEW x;  -- 1	555	143	355497263988


----- --库内欠费月统计业务指标(新版)

select count(*) from  PU_BUSI_IND.BM_BIL_ITEM_OWE_201802_NEW ;--139262
select count(*) from PU_BUSI_IND.BM_BIL_ITEM_OWE_201801_NEW ;--138883
-----


--计提坏账抽取  （改账期运行脚本）
Select sum(jthz_amount) FROM PU_WT.wt_serv_jthz_201801;  ---1	31496554256 

Select sum(jthz_amount) FROM PU_WT.wt_serv_jthz_201802;  --21647896693  7251524567


 ---------------实际计提坏账准备用户清单+实际计提坏账准备月报  
 
 SELECT * FROM IPD_IN.I_IN_HX_SERV_CHANEL_201802@DL_ODL_89;  -- 依赖ods 数据
 


--------------------------------------------------------



--月质量的已经跑完

-------6号质量   

---当月养卡 
select count(*),
   sum(c.keep_flag),   ---当月养卡 	56997	101010	325	0
   sum(c.cert_keep_flag),
    sum(c.term_keep_flag)
  from PU_WT.WT_SUSPECT_KEEP_CUR_M PARTITION(P201802) c 
  
  select count(*),
   sum(c.keep_flag),   ---当月养卡 	102456	180594	66	0

   sum(c.cert_keep_flag),
    sum(c.term_keep_flag)
  from PU_WT.WT_SUSPECT_KEEP_CUR_M PARTITION(P201803) c 
  

  
  ------ 次月养卡

select count(*),sum(c.keep_flag),sum(c.cert_keep_flag),-- 69468	100286	15	6715
sum(c.term_keep_flag)
  from PU_WT.WT_SUSPECT_KEEP_LAST_M PARTITION (P201802) c ;
  --
select count(*),sum(c.keep_flag),sum(c.cert_keep_flag),-- 56174	82370	296	4341
sum(c.term_keep_flag)
  from PU_WT.WT_SUSPECT_KEEP_LAST_M PARTITION(P201803) c;



---- 月报处理
----
select/*+parallel(a,8)*/ count(*),sum(pay_amount ),sum(charge ),sum(pay_csh_amount ) from pu_wt.wt_half_serv_201802 a;  
--	37790215	97645794448005	52314100314	97573034449480    
select/*+parallel(a,8)*/ count(*),sum(dev_num),sum(ycyh_num) from pu_busi_ind.bm_serv_c_cl_ycyh_201802 a;    
  --75865	453418	92652
select/*+parallel(c,8)*/ count(*),sum(c.dev_num),sum(c.dev_num),sum(c.hey_num),sum(c.fhey_num) from  pu_busi_ind.bm_c_cl_serv_201802 c;

---
select /*+parallel(a,8)*/count(*),sum(pay_amount ),sum(charge ),sum(pay_csh_amount ) from pu_wt.wt_half_serv_201801 a;    
 --1	37259254	115320913938980	51053676536	115284357611193
select /*+parallel(a,8)*/count(*),sum(dev_num),sum(ycyh_num) from pu_busi_ind.bm_serv_c_cl_ycyh_201801 a;      --1	80628	493024	89164
select /*+parallel(a,8)*/count(*),sum(c.dev_num),sum(c.dev_num),sum(c.hey_num),sum(c.fhey_num) from  pu_busi_ind.bm_c_cl_serv_201801 a; --1	1398077	47351120	47351120	4624426	42726694


--- 当月养卡基础指标
select month_no,count(*),sum(keep_flag ),sum(cnt)from PU_BASE_IND.DM_SUSPECT_KEEP_CUR_M 
group by month_no order by month_no desc;   -- 1	201712	12101	1687	417894


--当月养卡业务指标
select month_no,count(*),sum(total_cnt ),sum(keep_cnt )from PU_BUSI_IND.BM_SUSPECT_KEEP_CUR_M
group by month_no order by month_no desc; --   1	201712	21183	835788	102400



---连续两个月养卡宽表   --出到 上两个月的数据 

 select month_no,count(*) from pu_wt.WT_SUSPECT_KEEP_CON_M group by  month_no  order by month_no desc;        
 
 select  *  from  pu_wt.wt_suspect_keep_con_m  order by  month_no desc;  
 

---连续两个月养卡基础指标  

select  month_no,sum(cnt ),sum(con_keep_flag ) from  PU_BASE_IND.DM_SUSPECT_KEEP_CON_M group by month_no order by month_no desc;

----连续两个月养卡业务指标 
select month_no,sum(total_cnt ),sum(keep_cnt ) from  PU_BUSI_IND.BM_SUSPECT_KEEP_CON_M
group by month_no order by  month_no desc;  --






