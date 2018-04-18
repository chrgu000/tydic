drop table pu_wt.tmp_serv_black_1 purge;
create table pu_wt.tmp_serv_black_1 parallel 6 nologging as 
select 
  a.*,
  case when a.create_month='201711' and b.serv_id is not null then 1
       when a.create_month='201712' and c.serv_id is not null then 1
       when a.create_month='201801' and d.serv_id is not null then 1
         else 0 end is_bill6_flag
 from pu_wt.wt_half_serv_201803 a
 left join tbas.Wt_Bil_Chuzhang_201801_a@dl_edw_yn b on a.serv_id=b.serv_id
 left join tbas.Wt_Bil_Chuzhang_201802_a@dl_edw_yn c on a.serv_id=c.serv_id
 left join tbas.Wt_Bil_Chuzhang_201803_a@dl_edw_yn d on a.serv_id=d.serv_id
where a.term_type_id in(779)
----  and a.term_type_id in(779,833)   ---- 20170330  吴道义要求剔除数据卡
and a.is_dev_flag=1
and a.create_month in(201711,201712,201801);

drop table pu_wt.tmp_serv_black_2 purge;
create table pu_wt.tmp_serv_black_2 parallel 6 nologging as 
Select a.*,
       case when a.create_month='201711' and b.call_number>=5 and c.call_number>=5 and d.call_number>=5 then 1 
            when a.create_month='201712' and c.call_number>=5 and d.call_number>=5 and e.call_number>=5 then 1 
            when a.create_month='201801' and d.call_number>=5 and e.call_number>=5 and f.call_number>=5 then 1 
            else 0 end is_callday_flag,  
       case when a.is_livecard=1 then 1 else 0 end is_kxp_flag
 From  pu_wt.tmp_serv_black_1 a 
 left join pu_wt.wt_beh_m_201711 partition(p20171130) b on a.serv_id=b.serv_id
 left join pu_wt.wt_beh_m_201712 partition(p20171231) c on a.serv_id=c.serv_id
 left join pu_wt.wt_beh_m_201801 partition(p20180131) d on a.serv_id=d.serv_id
 left join pu_wt.wt_beh_m_201802 partition(p20180228) e on a.serv_id=e.serv_id
 left join pu_wt.wt_beh_m_201803 partition(p20180331) f on a.serv_id=f.serv_id;

drop table pu_wt.tmp_serv_black_3 purge;
create table pu_wt.tmp_serv_black_3 parallel 6 nologging as 
select 
    a.*,
    case when a.create_month='201711' and b.PROD_INST_state='2HA' then 1
         when a.create_month='201712' and c.PROD_INST_state='2HA' then 1
         when a.create_month='201801' and d.PROD_INST_state='2HA' then 1
         else 0 end is_state6_flag
    ,a.area_code1 area_code2
    ,a.area_name1 area_name2
    ,a.dvlp_channel_id dvlp_channel_id1
    ,cc.channel_name channel_name11
    ,case when bb.dvlp_channel_id is not null then '是' else '否' end is_out_flag 
    ,dd.staff_name          
 from pu_wt.tmp_serv_black_2 a
left join tbas.wt_prd_serv_mon_201801@dl_edw_yn b on a.serv_id=b.serv_id
left join tbas.wt_prd_serv_mon_201802@dl_edw_yn c on a.serv_id=c.serv_id
left join tbas.wt_prd_serv_mon_201803@dl_edw_yn d on a.serv_id=d.serv_id
left join pu_meta.D_CHANNEL_OUTCOUNTRY bb on a.dvlp_channel_id=bb.dvlp_channel_id
left join pu_meta.f_1_crm_channel cc on a.dvlp_channel_id=cc.channel_id
left join pu_meta.f_1_crm_staff dd on a.dvlp_staff_id=dd.staff_code;

drop table pu_wt.tmp_serv_black_4 purge;
create table pu_wt.tmp_serv_black_4 parallel 6 nologging as 
select 
a.area_code2 area_code2
,a.area_name2 area_name2
,a.dvlp_channel_id1 dvlp_channel_id1
,a.channel_name11 
,a.channel_type_class
,a.is_out_flag
,count(1) dev_num
,sum(case when a.is_bill6_flag=0 then 1 else 0 end ) lost_num
,sum(case when a.is_bill6_flag=0 then 1 else 0 end )/count(1) lost_rat
,sum(case when a.create_month='201711' then 1 else 0 end) dev_num_mon1
,sum(case when a.create_month='201711' and  a.is_bill6_flag=0 then 1 else 0 end) lost_num_mon1
,sum(case when a.create_month='201712' then 1 else 0 end) dev_num_mon2
,sum(case when a.create_month='201712' and  a.is_bill6_flag=0 then 1 else 0 end) lost_num_mon2
,sum(case when a.create_month='201801' then 1 else 0 end) dev_num_mon3
,sum(case when a.create_month='201801' and  a.is_bill6_flag=0 then 1 else 0 end) lost_num_mon3
--精确情况
,sum(case when a.is_kxp_flag=0 then 1 else 0 end) del_dev_num
,sum(case when a.is_kxp_flag=0 and a.is_state6_flag=0 and a.is_callday_flag=0 and a.is_bill6_flag=0 then 1 else 0 end ) del_lost_num
,sum(case when a.is_kxp_flag=0 and a.is_state6_flag=0 and a.is_callday_flag=0 and a.is_bill6_flag=0 then 1 else 0 end )/(sum(case when a.is_kxp_flag=0 then 1 else 0 end)+0.00009) del_lost_rat
,sum(case when a.create_month='201711' and a.is_kxp_flag=0 then 1 else 0 end) del_dev_num_mon1
,sum(case when a.create_month='201711' and a.is_kxp_flag=0 and a.is_state6_flag=0 and a.is_callday_flag=0 and a.is_bill6_flag=0 then 1 else 0 end) del_lost_num_mon1
,sum(case when a.create_month='201712' and a.is_kxp_flag=0 then 1 else 0 end) del_dev_num_mon2
,sum(case when a.create_month='201712' and a.is_kxp_flag=0 and a.is_state6_flag=0 and a.is_callday_flag=0 and a.is_bill6_flag=0 then 1 else 0 end) del_lost_num_mon2
,sum(case when a.create_month='201801' and a.is_kxp_flag=0 then 1 else 0 end) del_dev_num_mon3
,sum(case when a.create_month='201801' and a.is_kxp_flag=0 and a.is_state6_flag=0 and a.is_callday_flag=0 and a.is_bill6_flag=0 then 1 else 0 end) del_lost_num_mon3
 from
 pu_wt.tmp_serv_black_3 a
 group by 
 a.area_code2 
,a.area_name2 
,a.dvlp_channel_id1 
,a.channel_name11 
,a.is_out_flag 
,a.channel_type_class;

DROP TABLE pu_wt.wt_channel_black_FINal_201803 PURGE;
create table pu_wt.wt_channel_black_FINal_201803 as
select *
  from pu_wt.tmp_serv_black_4 a
 where a.dvlp_channel_id1 is not null
   and a.dev_num > 10
   and a.lost_rat >= 0.7
   and a.del_dev_num > 10
   and a.del_lost_rat >= 0.7;
--清单

drop table pu_wt.wt_channel_black_serv_201803 purge;
create table pu_wt.wt_channel_black_serv_201803 as 
select 
    b.area_name2 area_name1,
    b.area_code2 area_code1,
    b.dvlp_channel_id1  dvlp_channel_id,
    b.channel_name11 channel_name,
    b.serv_id ,
    b.acc_nbr ,
    b.channel_type_class,
    b.zhu_offer_name ,
    b.zhu_offer_id ,
    b.is_livecard   ,
    b.IS_KXP_FLAG , 
    b.is_callday_flag is_rw_beh_flag ,
    b.is_state6_flag ,
    b.is_bill6_flag is_billing_flag  ,
    b.is_out_flag
 from  pu_wt.wt_channel_black_FINal_201803 a
left join pu_wt.tmp_serv_black_3 b 
on a.area_code2=b.area_code2
and a.dvlp_channel_id1=b.dvlp_channel_id1;

select 
    a.area_name1 "分公司",
    a.area_code1 "区号",
    a.dvlp_channel_id "渠道ID",
    a.channel_name "渠道",
    a.serv_id "设备号",
    a.acc_nbr "接入号码",
    a.channel_type_class  渠道分类属性,
    a.is_out_flag "是否境外渠道",
    a.zhu_offer_name 主套餐,
    a.zhu_offer_id 主套餐ID,
    case when a.is_livecard=1 then '是' else '否' end "是否活卡",
    case when a.IS_KXP_FLAG=1 then '是' else '否' end "是否快销品", 
    case when a.is_rw_beh_flag=1 then '是' else '否' end "是否入网三月通信天数大于等于5",
    case when a.is_state6_flag=1 then '是' else '否' end "是否入网第6月状态正常",
    case when a.is_billing_flag=0 then '是' else '否' end "是否离网"
 from pu_wt.wt_channel_black_serv_201803 a;



---黑名单工号
drop table pu_wt.tmp_serv_black_5 purge;
create table pu_wt.tmp_serv_black_5 parallel 6 nologging as 
select 
a.area_code2 area_code2
,a.area_name2 area_name2
,a.dvlp_channel_id1 dvlp_channel_id1
,a.channel_name11 
,a.dvlp_staff_id
,a.staff_name
,a.channel_type_class
,a.is_out_flag
,count(1) dev_num
,sum(case when a.is_bill6_flag=0 then 1 else 0 end ) lost_num
,sum(case when a.is_bill6_flag=0 then 1 else 0 end )/count(1) lost_rat
,sum(case when a.create_month='201711' then 1 else 0 end) dev_num_mon1
,sum(case when a.create_month='201711' and  a.is_bill6_flag=0 then 1 else 0 end) lost_num_mon1
,sum(case when a.create_month='201712' then 1 else 0 end) dev_num_mon2
,sum(case when a.create_month='201712' and  a.is_bill6_flag=0 then 1 else 0 end) lost_num_mon2
,sum(case when a.create_month='201801' then 1 else 0 end) dev_num_mon3
,sum(case when a.create_month='201801' and  a.is_bill6_flag=0 then 1 else 0 end) lost_num_mon3
--精确情况
,sum(case when a.is_kxp_flag=0 then 1 else 0 end) del_dev_num
,sum(case when a.is_kxp_flag=0 and a.is_state6_flag=0 and a.is_callday_flag=0 and a.is_bill6_flag=0 then 1 else 0 end ) del_lost_num
,sum(case when a.is_kxp_flag=0 and a.is_state6_flag=0 and a.is_callday_flag=0 and a.is_bill6_flag=0 then 1 else 0 end )/(sum(case when a.is_kxp_flag=0 then 1 else 0 end)+0.00009) del_lost_rat
,sum(case when a.create_month='201711' and a.is_kxp_flag=0 then 1 else 0 end) del_dev_num_mon1
,sum(case when a.create_month='201711' and a.is_kxp_flag=0 and a.is_state6_flag=0 and a.is_callday_flag=0 and a.is_bill6_flag=0 then 1 else 0 end) del_lost_num_mon1
,sum(case when a.create_month='201712' and a.is_kxp_flag=0 then 1 else 0 end) del_dev_num_mon2
,sum(case when a.create_month='201712' and a.is_kxp_flag=0 and a.is_state6_flag=0 and a.is_callday_flag=0 and a.is_bill6_flag=0 then 1 else 0 end) del_lost_num_mon2
,sum(case when a.create_month='201801' and a.is_kxp_flag=0 then 1 else 0 end) del_dev_num_mon3
,sum(case when a.create_month='201801' and a.is_kxp_flag=0 and a.is_state6_flag=0 and a.is_callday_flag=0 and a.is_bill6_flag=0 then 1 else 0 end) del_lost_num_mon3
 from
 pu_wt.tmp_serv_black_3 a
 group by 
 a.area_code2 
,a.area_name2 
,a.dvlp_channel_id1 
,a.channel_name11 
,a.dvlp_staff_id
,a.staff_name
,a.is_out_flag 
,a.channel_type_class;

drop table pu_wt.wt_staff_black_FINal_201803;
create table pu_wt.wt_staff_black_FINal_201803 as
select *
  from pu_wt.tmp_serv_black_5 a
 where a.dvlp_channel_id1 is not null
   and a.dvlp_staff_id is not null
   and a.dev_num > 10
   and a.lost_rat >= 0.7
   and a.del_dev_num > 10
   and a.del_lost_rat >= 0.7;
--清单

drop table  pu_wt.wt_staff_black_serv_201803 purge;
create table pu_wt.wt_staff_black_serv_201803 as 
select 
    b.area_name2 area_name1,
    b.area_code2 area_code1,
    b.dvlp_channel_id1  dvlp_channel_id,
    b.channel_name11 channel_name,
    b.dvlp_staff_id,
    b.staff_name,
    b.serv_id ,
    b.acc_nbr ,
    b.channel_type_class,
    b.zhu_offer_name ,
    b.zhu_offer_id ,
    b.is_livecard   ,
    b.IS_KXP_FLAG , 
    b.is_callday_flag is_rw_beh_flag ,
    b.is_state6_flag ,
    b.is_bill6_flag is_billing_flag  ,
    b.is_out_flag
 from  pu_wt.wt_staff_black_FINal_201803 a
left join pu_wt.tmp_serv_black_3 b 
on a.area_code2=b.area_code2
and a.dvlp_channel_id1=b.dvlp_channel_id1
and a.dvlp_staff_id=b.dvlp_staff_id;

select 
    a.area_name1 "分公司",
    a.area_code1 "区号",
    a.dvlp_channel_id "渠道ID",
    a.channel_name "渠道",
    a.dvlp_channel_id "揽收工号",
    a.staff_name "揽收人",
    a.serv_id "设备号",
    a.acc_nbr "接入号码",
    a.channel_type_class  渠道分类属性,
    a.is_out_flag "是否境外渠道",
    a.zhu_offer_name 主套餐,
    a.zhu_offer_id 主套餐ID,
    case when a.is_livecard=1 then '是' else '否' end "是否活卡",
    case when a.IS_KXP_FLAG=1 then '是' else '否' end "是否快销品", 
    case when a.is_rw_beh_flag=1 then '是' else '否' end "是否入网三月通信天数大于等于5",
    case when a.is_state6_flag=1 then '是' else '否' end "是否入网第6月状态正常",
    case when a.is_billing_flag=0 then '是' else '否' end "是否离网"
 from pu_wt.wt_staff_black_serv_201708 a;
