
select * from pu_meta.etl_program_rule where rule_id='7001099'---规则表 

select * from pu_meta.etl_inter_rule where rule_id= 7001141; --直接抽取数据配置表

select * from pu_meta.etl_data_source a where a.data_source_id= 102; --数据源配置表

select * from pu_meta.etl_program_rule a where a.rule_name like '%业务量%';--规则表

--- 风险管控库--链接经分库---- @dl_edw_yn

select * from pu_wt.p_serv_dev_d_201712;  -------用户发展质量原表--   1-10  上个月到今天发展用户  11-月底  11以后截止到当天发展用户

select * from pu_wt.WT_SERV_C_D_201712; ---欠费相关表

Select * from pu_wt.Wt_Bil_Owe_List_d_New  Partition(p20171226); ---累计欠费    

Select * from pu_wt.Wt_Bil_Owe_List_d_Lz_New  Partition(p20171226);  ----零账欠费 

Select * from pu_wt.Wt_Bil_Owe_St_List_d  Partition(p20171226);  ---送托

select * from pu_meta.d_user_status;  --状态表

select * from pu_meta.latn_new@dl_fxgk_wt; --地州表

select * from pu_wt.f_1_serv_d_jf where rownum<10;  --用户表

select * from comm.product@dl_jf219 where rownum<10; --产品表

select * from pu_wt.f_2_offer_serv_d where rownum<10; --销售品表

select * from pu_meta.offer_spec where rownum<10  --套餐表

select * from PU_INTF.I_BIL_PAYMENT --按月缴费记录

------经分库--- 链接风险管控库--  @dl_fxgk_wt 

select * from tbas.wt_prod_serv_d_201801 s ;  --用户资料表   ----dvlp_channel_id   揽收渠道id

select *  from tbas.wt_bs_offer_serv_d  s ; ---销售品表

select * from PU_MODEL.TB_PTY_CRM_CHANNEL; ---渠道维表

select * from TBAS.EVT_PRD_BUSI_M_201711  ---月业务量宽表 (取上网流量)
  
select * from pu_list.p_cdmalx_list_m   --取省际漫游流量

select * from TBAS.WT_PRD_SERV_MON_201712 where rownum<20;  ----月用户宽表 BILLING_ARRIVE_FLAG 出账标示 1--是 0--否

select * from PU_LIST.L_USER_FLHCHARGE_DETAIL_M@dl_edw_yn; ----收入汇总表
