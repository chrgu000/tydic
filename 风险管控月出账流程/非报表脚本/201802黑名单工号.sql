---黑名单工号
--drop table pu_wt.tmp_serv_black_5 purge;
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
,sum(case when a.create_month='201707'    then 1 else 0 end) dev_num_mon1
,sum(case when a.create_month='201707' and  a.is_bill6_flag=0 then 1 else 0 end) lost_num_mon1
--,sum(case when a.create_month='201707' and  a.is_bill6_flag=0 then 1 else 0 end)/(sum(case when a.create_month='201707'  then 1 else 0 end)+0.000009) lost_rat_month1
,sum(case when a.create_month='201708' then 1 else 0 end) dev_num_mon2
,sum(case when a.create_month='201708' and  a.is_bill6_flag=0 then 1 else 0 end) lost_num_mon2
--,sum(case when a.create_month='201708' and  a.is_bill6_flag=0 then 1 else 0 end)/(sum(case when a.create_month='201708'  then 1 else 0 end)+0.000009) lost_rat_month2
,sum(case when a.create_month='201709' then 1 else 0 end) dev_num_mon3
,sum(case when a.create_month='201709' and  a.is_bill6_flag=0 then 1 else 0 end) lost_num_mon3
--,sum(case when a.create_month='201709' and  a.is_bill6_flag=0 then 1 else 0 end)/(sum(case when a.create_month='201709'  then 1 else 0 end)+0.000009) lost_rat_month3
--精确情况
,sum(case when a.is_kxp_flag=0 then 1 else 0 end) del_dev_num
,sum(case when a.is_kxp_flag=0 and a.is_state6_flag=0 and a.is_callday_flag=0 and a.is_bill6_flag=0 then 1 else 0 end ) del_lost_num
,sum(case when a.is_kxp_flag=0 and a.is_state6_flag=0 and a.is_callday_flag=0 and a.is_bill6_flag=0 then 1 else 0 end )/(sum(case when a.is_kxp_flag=0 then 1 else 0 end)+0.00009) del_lost_rat
,sum(case when a.create_month='201707' and a.is_kxp_flag=0    then 1 else 0 end) del_dev_num_mon1
,sum(case when a.create_month='201707' and a.is_kxp_flag=0 and a.is_state6_flag=0 and a.is_callday_flag=0 and a.is_bill6_flag=0 then 1 else 0 end) del_lost_num_mon1
--,sum(case when a.create_month='201707' and a.is_kxp_flag=0 and a.is_state6_flag=0 and a.is_callday_flag=0 and a.is_bill6_flag=0 then 1 else 0 end)/(sum(case when a.create_month='201707'  and a.is_kxp_flag=0   then 1 else 0 end)+0.000009) del_lost_rat_month1
,sum(case when a.create_month='201708' and a.is_kxp_flag=0    then 1 else 0 end) del_dev_num_mon2
,sum(case when a.create_month='201708' and a.is_kxp_flag=0 and a.is_state6_flag=0 and a.is_callday_flag=0 and a.is_bill6_flag=0 then 1 else 0 end) del_lost_num_mon2
--,sum(case when a.create_month='201708' and a.is_kxp_flag=0 and a.is_state6_flag=0 and a.is_callday_flag=0 and a.is_bill6_flag=0 then 1 else 0 end)/(sum(case when a.create_month='201708'  and a.is_kxp_flag=0   then 1 else 0 end)+0.000009) del_lost_rat_month2
,sum(case when a.create_month='201709' and a.is_kxp_flag=0    then 1 else 0 end) del_dev_num_mon3
,sum(case when a.create_month='201709' and a.is_kxp_flag=0 and a.is_state6_flag=0 and a.is_callday_flag=0 and a.is_bill6_flag=0 then 1 else 0 end) del_lost_num_mon3
--,sum(case when a.create_month='201709' and a.is_kxp_flag=0 and a.is_state6_flag=0 and a.is_callday_flag=0 and a.is_bill6_flag=0 then 1 else 0 end)/(sum(case when a.create_month='201709'  and a.is_kxp_flag=0   then 1 else 0 end)+0.000009) del_lost_rat_month3
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


--select * from pu_wt.wt_staff_black_FINal_201702 a;

--drop table pu_wt.wt_staff_black_FINal_201802;
create table pu_wt.wt_staff_black_FINal_201802 as
select *
  from pu_wt.tmp_serv_black_5 a
 where a.dvlp_channel_id1 is not null
   and a.dvlp_staff_id is not null
   and a.dev_num > 10
   and a.lost_rat >= 0.7
   and a.del_dev_num > 10
   and a.del_lost_rat >= 0.7;
--清单

--drop table  pu_wt.wt_staff_black_serv_201802 purge;
create table pu_wt.wt_staff_black_serv_201802 as 
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
 from  pu_wt.wt_staff_black_FINal_201802 a
left join pu_wt.tmp_serv_black_3 b 
on a.area_code2=b.area_code2
and a.dvlp_channel_id1=b.dvlp_channel_id1
and a.dvlp_staff_id=b.dvlp_staff_id;

/*

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
 from pu_wt.wt_staff_black_serv_201802 a;
 
 */
