
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

select * from comm.product@dl_jf219 where rownum<10; --产品表  1

select * from pu_wt.f_2_offer_serv_d where rownum<10; --销售品表

select * from pu_meta.offer_spec where rownum<10  --套餐表



------经分库--- 链接风险管控库--  @dl_fxgk_wt 

select * s.src_ from tbas.wt_prod_serv_d_201801 s ;  --用户资料表  1  ----dvlp_channel_id	 揽收渠道id

select *  from tbas.wt_bs_offer_serv_d  s ; ---销售品表 1

select * from PU_MODEL.TB_PTY_CRM_CHANNEL; ---渠道维表 1

select * from TBAS.EVT_PRD_BUSI_M_201711  ---月业务量宽表 (取上网流量) 1
  
select * from pu_list.p_cdmalx_list_m   --取省际漫游流量  1

select * from TBAS.WT_PRD_SERV_MON_201712 where rownum<20;  ----月用户宽表 BILLING_ARRIVE_FLAG 出账标示 1--是 0--否

select * from PU_LIST.L_USER_FLHCHARGE_DETAIL_M@dl_edw_yn; ----收入汇总表
--------------------






----20180105 需求
--- 分公司	,serv_id,	用户号码	,包打套餐（1643217[2016.06]全省包打套餐240元--叠加包、1643321[2016.06]全省包打套餐180元--叠加包）,	入网时间	揽收渠道	当前用户状态


---- 订购套餐('1643217','1643321')且生效
create table zxy_test1 as 
         select    w.serv_id,   --用户id
                   o.offer_spec_id, -- 套餐id
                   o.name    -- 套餐名称
            from tbas.wt_bs_offer_serv_d w ,pu_meta.offer_spec o 
            where w.src_offer_id=o.offer_spec_id and 
                 w.src_offer_id in ('1643217','1643321')and
               ( '20180105' between to_char(w.src_inst_eff_date,'YYYYMMDD')and to_char(w.src_inst_exp_date,'YYYYMMDD') );

select count(*) from zxy_test1; --2117


--- 订购了套餐且生效的用户信息
create table zxy_test2 as 
select t1.*, 
    l.area_name,--分公司
    s.acc_nbr, --用户号码
    s.create_date, --入网时间   
    s.dvlp_channel_id,--揽收渠道id
    t.CHANNEL_NAME, -- 揽收渠道
    s.PROD_INST_STATE   --  用户状态
   from  tbas.wt_prod_serv_d_201801 s  
       join zxy_test1 t1 on s.serv_id=t1.serv_id
       left join pu_meta.latn_new@dl_fxgk_wt l on s.area_code=l.local_code
       left join PU_MODEL.TB_PTY_CRM_CHANNEL t on s.dvlp_channel_id =t.CHANNEL_ID ;
       
  select count(*) from zxy_test2;-- 2117
----相关用户的上网流量  
create table zxy_test3 as
select   t2.*,
        round (e7.DATA_FLUX/(1024*1024),2) DATA_FLUX_M7,
        round (e8.DATA_FLUX/(1024*1024),2) DATA_FLUX_M8, 
        round (e9.DATA_FLUX/(1024*1024),2) DATA_FLUX_M9,
        round (e10.DATA_FLUX/(1024*1024),2) DATA_FLUX_M10,
        round (e11.DATA_FLUX/(1024*1024),2) DATA_FLUX_M11,
        round (e12.DATA_FLUX/(1024*1024),2) DATA_FLUX_M12
       from zxy_test2 t2
       left join TBAS.EVT_PRD_BUSI_M_201707 e7  on e7.serv_id=t2.serv_id
       left join TBAS.EVT_PRD_BUSI_M_201708 e8  on e7.serv_id=e8.serv_id 
       left join TBAS.EVT_PRD_BUSI_M_201709 e9  on e7.serv_id=e9.serv_id 
       left join TBAS.EVT_PRD_BUSI_M_201710 e10 on e7.serv_id=e10.serv_id 
       left join TBAS.EVT_PRD_BUSI_M_201711 e11 on e7.serv_id=e11.serv_id 
       left join TBAS.EVT_PRD_BUSI_M_201712 e12 on e7.serv_id=e12.serv_id ;  
    select * from zxy_test3;   
---- 省际漫游流量
create table zxy_test4 as 
   select
       p.serv_id ,
       round(sum(decode(p.month_no,'201707',p.total_data_flow,0))/(1024*1024),2 ) total_data_flow_7,
       round(sum(decode(p.month_no,'201708',p.total_data_flow,0))/(1024*1024),2 ) total_data_flow_8,
       round(sum(decode(p.month_no,'201709',p.total_data_flow,0))/(1024*1024),2 ) total_data_flow_9,
       round(sum(decode(p.month_no,'201710',p.total_data_flow,0))/(1024*1024),2 ) total_data_flow_10,
       round(sum(decode(p.month_no,'201711',p.total_data_flow,0))/(1024*1024),2 ) total_data_flow_11,
       round(sum(decode(p.month_no,'201712',p.total_data_flow,0))/(1024*1024),2 ) total_data_flow_12
      from  pu_list.p_cdmalx_list_m p 
      group by p.serv_id;
--- 相关用户的 上网流量 ，省际漫游流量  
create table zxy_test5 as  --最终表
  select  t3.*,
         t4.total_data_flow_7,
         t4.total_data_flow_8,
         t4.total_data_flow_9,
         t4.total_data_flow_10,
         t4.total_data_flow_11,
         t4.total_data_flow_12
      from zxy_test3 t3 
      left join  zxy_test4 t4  on t3.serv_id=t4.serv_id;
      
---- 
select  t.area_name 分公司,
        t.serv_id 用户id,
        t.acc_nbr 用户号码,
        t.name 套餐名称,
        t.create_date 入网时间,
        t.dvlp_channel_id 揽收渠道id,
        t.CHANNEL_NAME 揽收渠道,
        d.status_name  用户状态,        
        t.DATA_FLUX_M7 上网7,
        t.DATA_FLUX_M8 上网8,
        t.DATA_FLUX_M9 上网9,
        t.DATA_FLUX_M10 上网10,
        t.DATA_FLUX_M11 上网11,
        t.DATA_FLUX_M12 上网12,
        t.total_data_flow_7 漫游7,
        t.total_data_flow_8 漫游8,
        t.total_data_flow_9 漫游9,
        t.total_data_flow_10 漫游10,
        t.total_data_flow_11 漫游11,
        t.total_data_flow_12 漫游12
     from zxy_test5 t 
      left join pu_meta.d_user_status d on t.prod_inst_state=d.status_code ;
       
       
