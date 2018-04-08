


----按月虚假用户
select count(*),sum(c.is_xj_flag) from  PU_WT.wt_serv_ysxj_m_201801 c ; -- 23590115	19790880
select count(*),sum(c.is_xj_flag) from  PU_WT.wt_serv_ysxj_m_201802 c ; --24002387	19849895


--近3月虚假用户基础指标
select count(*), sum(c.is_xj_m), sum(c.is_xj_pre_m), sum(c.is_xj_pre_2m)
  from PU_BASE_IND.dm_serv_ysxj_201801 c; --2340405	1438083	1378152	1301277
  
select count(*), sum(c.is_xj_m), sum(c.is_xj_pre_m), sum(c.is_xj_pre_2m)
  from PU_BASE_IND.dm_serv_ysxj_201802 c; --2386505	1458966	1367778	1319744

  
---近3月虚假用户业务指标
select count(*),
       sum(c.dev_num),
       sum(c.xj_dy_num),
       sum(c.xj_2m_num),
       sum(c.xj_3m_num)
  from PU_busi_IND.bm_serv_ysxj_201801 c;--1719279	23676122	19791315	19139137	18762789

  
select count(*),
       sum(c.dev_num),
       sum(c.xj_dy_num),
       sum(c.xj_2m_num),
       sum(c.xj_3m_num)
  from PU_busi_IND.bm_serv_ysxj_201802 c;--1707038	23248918	19441194	18837052	18473266
  
 -----连续三个月虚假 
  select count(*), sum(is_xj_flag),sum(is_tszd_flag)
  from PU_WT.p_serv_mon_ysxj_third_201712 c ;  -- 1053301	411677	17443

select count(*), sum(is_xj_flag),sum(is_tszd_flag)
  from PU_WT.p_serv_mon_ysxj_third_201801 c ; --- 932690	365584	9085
  
select * from PU_WT.p_serv_mon_ysxj_third_201802 c 

select A.AREA_NAME1 ,
       sum(a.IS_DEV_FLAG) ,  --
       sum(a.IS_XJ_FLAG)
from PU_WT.p_serv_mon_ysxj_third_201802 A 
  where a.CREATE_MONTH='201802'
group by a.AREA_NAME1;

--select * from pu_busi_ind.bm_serv_third_ysxj_201801;

select b.AREA_NAME1,
       sum(b.DEV_NUM),
       sum(b.XJ_NUM),
       sum(b.DEV_PRE),
       sum(b.XJ_PRE),
      sum(b.DEV_PRE1),
       sum(b.XJ_PRE1),
        sum(b.DEV_PRE2),
       sum(b.XJ_PRE2)   
from pu_busi_ind.bm_serv_third_ysxj_201801 b
group by b.AREA_NAME1;


  

-----按月用户质量
select  sum(dev_cnt ),sum(acct_cnt ),sum(cm_cnt )
  from PU_BUSI_IND.BM_C_CL_SERV_M c  where month_no='201801'; -- 23203977	4615758	19349560
  
select  sum(dev_cnt ),sum(acct_cnt ),sum(cm_cnt )
  from PU_BUSI_IND.BM_C_CL_SERV_M c  where month_no='201802'; -- 48010000	10121848	39279334



--佣金数据抽取
 select count(*) from PU_INTF.I_PRD_SETTLE_ITEM_DETAIL_M  where month_no=201712 --9172507
 
select count(*) from PU_INTF.I_PRD_SETTLE_ITEM_DETAIL_M  where month_no='201801'; --8242660



-----实收表

select /*+parallel(a,8)*/ month_No,
 count(*), sum(amount), sum(amount_owe)
  from pu_wt.wt_serv_realrec_m_201802 a -- 	201711	22490720	33084173162	-21235631099
  group by month_No order by month_no desc;

select /*+parallel(a,8)*/ month_No, --     201712	 23280212	 39069388666	-20200525822
 count(*), sum(amount), sum(amount_owe)
  from pu_wt.wt_serv_realrec_m_201801 a
  group by month_No order by month_no desc;
  
---渠道效益评估月表

SELECT * FROM  pu_base_ind.dm_channel_evalution_m_201802
select * from  pu_busi_ind.bm_channel_evalution_m_201802

-- 无效用户统计 PU_BUSI_IND.P_BM_WX_USER_MON

select a.month_no,count(*) from PU_BUSI_IND.BM_WT_WX_USER_MON a group by  a.month_no order by a.month_no desc

-- 有效用户活跃及缴费 pu_busi_ind.P_BM_VALID_USER_BUSINESS_MON
select month_no,
 sum(dev_user ),sum(dev_user_zc ),sum(user_cm )
from  PU_BUSI_IND.BM_VALID_USER_BUSINESS_MON a 
group by month_no  order by a.month_no desc ;

--虚假用户推送
Select * from  pu_wt.wt_serv_mon_201802

--- 2017年12月分摊前后收入、欠费、欠费占收比

SELECT * FROM  pu_wt.rpt_owe_ftqh_201802 a order by a.area_name

--销帐前_欠费待列金额取待列表（报表）

 SELECT * FROM  TBAS.RPT_OWE_XZQ_DL@DL_EDW_YN a order by a.欠费账期 ;
