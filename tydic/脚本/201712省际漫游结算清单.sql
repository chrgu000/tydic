---201711漫游
From ZHJS_APP.TL_G_CDMA1X_LIST_201602@DL_ZHJS_YN T
 Where SWITCH_ID = 266
   And HOME_AREA_CODE = 870
   
   select * from ZHJS_APP.TL_G_CDMA1X_LIST_201712@DL_ZHJS_YN
   
   --PU_INTF.I_BILL_ACCT_ITEM_M  --分摊前
   --PU_MODEL.TB_BIL_FIN_INCM_MON_YYYYMM
   
select * from PU_MODEL.TB_BIL_FIN_INCM_MON_201712

--dsg.acct_item_type@dl_ods_89_yn 账目项


--------------------

drop table ly.tmp_roam_list_201712_1 purge;
create table ly.tmp_roam_list_201712_1 as
select * from 
(
select a.*,serv_id,
row_number() over(partition by a.calling_number order by b.create_date desc) rn
 from (select * from pu_list.p_roam_list_m  where month_no='201712') a,
tbas.wt_prod_serv_d_201712 b
where a.calling_number=b.acc_nbr
and ((prod_inst_state in ('2HX','2IX') and substr(b.create_date,0,4)!='3000')
or (prod_inst_state not in ('2HX','2IX')))
)
where rn=1;

select count(*) from ly.tmp_roam_list_201712_1  ----399608
select count(*) from ly.tmp_roam_list_201711_1  ---399011
select count(distinct imsi_number) from pu_list.p_cdmalx_list_m  where month_no='201712';  ---663842

select * from pu_list.p_cdmalx_list_m  where month_no='201608';
-----
drop table ly.tmp_roam_list_all purge;
create table ly.tmp_roam_list_all /* PARALLEL 6 */ as
select 
case when a.calling_area_name is not null then a.calling_area_name else b.home_area_name end std_area_name,
case when a.serv_id is not null then a.serv_id else b.serv_id end serv_id,
nvl(a.call_duration/60,0)  call_duration,  
nvl(b.total_data_flow,0)  total_data_flow,
nvl(a.sett_count,0) sett_count_yy,
nvl(b.sett_count,0) sett_count_ll,
nvl(a.sett_fee/100,0) sett_fee_yy,
nvl(b.sett_fee,0) sett_fee_ll
 from 
ly.tmp_roam_list_201712_1 a
FULL OUTER JOIN
(select home_area_name,serv_id,sum(total_data_flow) total_data_flow,sum(sett_count) sett_count,sum(sett_fee) sett_fee 
from pu_list.p_cdmalx_list_m  
where serv_id is not null 
and month_no='201712'
group by home_area_name,serv_id) b 
on a.serv_id=b.serv_id;


--------
drop table ly.tmp_roam_serv_list purge;
create table ly.tmp_roam_serv_list parallel 8 nologging as
select a.*,area_code,std_area_id,acc_nbr,create_date,zhu_offer_id,zhu_offer_name,
all_offer_name,product_id,prod_inst_state,b.dvlp_channel_id
 from ly.tmp_roam_list_all a,
tbas.WT_P_SERV_COLLECT_d partition(p20180114) b
where a.serv_id=b.serv_id;

select count(*) from ly.tmp_roam_serv_list
group by serv_id
having count(*)>1;  

select count(*) from tbas.WT_P_SERV_COLLECT_201711 where serv_id=703031044455

select a.* from ly.tmp_roam_list_all a,
ly.tmp_roam_serv_list b
where a.serv_id=b.serv_id(+)
and b.serv_id is null;

------

------------
drop table ly.tmp_youhuo_offer_201712 purge;
create table ly.tmp_youhuo_offer_201712 as
select a.serv_id,a.offer_id,b.offer_name,count(*) cnt,sum(case when a.acct_item_type_id in
('4823','4848','4845','4846','4847','4909','4919','4908','4909','4910','4911','4912','4918','4920','4921','4922',
'4924','4925','4933','4934','4935','4936','4937','4938','4939','4940','4942','4953','4954','4955','4956','4957',
'4958','4959','4960','4961','4962','4963','4964','4965','4966','4967','4969','4970','4971','4972','4973','4986',
'5194','5290','5284','5285','5286','5287','5288','14731','14732','15193','15194','15195','14669','14736','14670',
'14671','14672','14673','14733','14739','14734','14735','14737','14738','14740','14837','14840','14844','14857',
'1931','1932','1933','1934','1935','20273','20274','20275','20255','20947')
then a.charge else 0 end)/100 roam_yh,
sum(case when a.acct_item_type_id in
('29387','29388','29389','29390','29391','20255','20947','20900','20901','20902','20903','20904','20354','20355',
'20356','20357','20358','15049','15050','15051','15052','15048','15352','15353','15354','15355','15356','15357',
'15358','15359','15360','15361','15443','15444','15445','15446','15447','15103','15105','15106','15107','15473',
'15474','15475','15476','15477','15494','15496','15497','15498','15519','15520','15521','15522','15523','20953',
'20957','20961','20964','20967','20971','20977','20980','20984','20988','20991','20994','20998','21004','21007',
'21011','21015','21018','21021','21025','21031','21034',
'21038','21042','21045','21048','21052','21058','21061','21065','21069','21072','21075','21079','21109','15318',
'21225','15495','15104')
then a.charge else 0 end)/100 cdma_yh,
sum(a.charge)/100 charge_yh,
sum(case when a.acct_item_type_id in ('107') 
then a.charge else 0 end)/100 base_charge
from PU_INTF.I_BILL_ACCT_ITEM_M a,
--dsg_crm.offer_spec@dl_ods_89_yn b
DSG.PRODUCT_offer@DL_ODS_89_YN b
where a.month_no='201712'
and a.charge<0
and a.offer_id=b.offer_id(+)
group by a.serv_id,a.offer_id,b.offer_name;

---
select * from ly.tmp_youhuo_offer  where serv_id=790100372264

select * from PU_INTF.I_BILL_ACCT_ITEM_M where serv_id=913018028020 and charge<0
and month_no='201712'

drop table ly.tmp_roam_serv_list_1 purge;
create table ly.tmp_roam_serv_list_1 as
select a.*,b.MBL_INNET_FLUX/1024/1024 MBL_INNET_FLUX,b.dur/60 dur from  ly.tmp_roam_serv_list a
left join  TBAS.EVT_PRD_BUSI_M_201712 b on a.serv_id=b.serv_id;


drop table ly.tmp_bill_acct_item_201712 purge;
create table ly.tmp_bill_acct_item_201712 as
select 
serv_id,
sum(case when b.acct_item_type_id in
('4823','4848','4845','4846','4847','4909','4919','4908','4909','4910','4911','4912','4918','4920','4921','4922',
'4924','4925','4933','4934','4935','4936','4937','4938','4939','4940','4942','4953','4954','4955','4956','4957',
'4958','4959','4960','4961','4962','4963','4964','4965','4966','4967','4969','4970','4971','4972','4973','4986',
'5194','5290','5284','5285','5286','5287','5288','14731','14732','15193','15194','15195','14669','14736','14670',
'14671','14672','14673','14733','14739','14734','14735','14737','14738','14740','14837','14840','14844','14857',
'1931','1932','1933','1934','1935','20273','20274','20275','20255','20947')
then b.charge else 0 end)/100 roam_income,
sum(case when b.acct_item_type_id in
('29387','29388','29389','29390','29391','20255','20947','20900','20901','20902','20903','20904','20354','20355',
'20356','20357','20358','15049','15050','15051','15052','15048','15352','15353','15354','15355','15356','15357',
'15358','15359','15360','15361','15443','15444','15445','15446','15447','15103','15105','15106','15107','15473',
'15474','15475','15476','15477','15494','15496','15497','15498','15519','15520','15521','15522','15523','20953',
'20957','20961','20964','20967','20971','20977','20980','20984','20988','20991','20994','20998','21004','21007',
'21011','21015','21018','21021','21025','21031','21034',
'21038','21042','21045','21048','21052','21058','21061','21065','21069','21072','21075','21079','21109','15318',
'21225','15495','15104')
then b.charge else 0 end)/100 cdma_income,
sum(case when b.acct_item_type_id in ('107') 
then b.charge else 0 end)/100 base_charge,
sum(charge)/100 charge
from PU_INTF.I_BILL_ACCT_ITEM_M b
where month_no='201712'
group by serv_id;

drop table ly.tmp_bill_acct_item_ft_201712 purge;
create table ly.tmp_bill_acct_item_ft_201712 parallel 8 nologging as
select 
serv_id,
sum(case when b.acct_item_type_id in
('4823','4848','4845','4846','4847','4909','4919','4908','4909','4910','4911','4912','4918','4920','4921','4922',
'4924','4925','4933','4934','4935','4936','4937','4938','4939','4940','4942','4953','4954','4955','4956','4957',
'4958','4959','4960','4961','4962','4963','4964','4965','4966','4967','4969','4970','4971','4972','4973','4986',
'5194','5290','5284','5285','5286','5287','5288','14731','14732','15193','15194','15195','14669','14736','14670',
'14671','14672','14673','14733','14739','14734','14735','14737','14738','14740','14837','14840','14844','14857',
'1931','1932','1933','1934','1935','20273','20274','20275','20255','20947')
then b.charge else 0 end)/100 roam_income,
sum(case when b.acct_item_type_id in
('29387','29388','29389','29390','29391','20255','20947','20900','20901','20902','20903','20904','20354','20355',
'20356','20357','20358','15049','15050','15051','15052','15048','15352','15353','15354','15355','15356','15357',
'15358','15359','15360','15361','15443','15444','15445','15446','15447','15103','15105','15106','15107','15473',
'15474','15475','15476','15477','15494','15496','15497','15498','15519','15520','15521','15522','15523','20953',
'20957','20961','20964','20967','20971','20977','20980','20984','20988','20991','20994','20998','21004','21007',
'21011','21015','21018','21021','21025','21031','21034',
'21038','21042','21045','21048','21052','21058','21061','21065','21069','21072','21075','21079','21109','15318',
'21225','15495','15104')
then b.charge else 0 end)/100 cdma_income,
sum(charge)/100 charge
from PU_INTF.I_BILL_ACCT_ITEM_FT_M b
where month_no='201712'
group by serv_id;


drop table ly.tmp_roam_serv_list_2 purge;
create table ly.tmp_roam_serv_list_2 as
select a.*,b.roam_income,
--case when a.product_id='779' then b.cdma_income when a.product_id='833'
 -- then b.charge end cdma_income,
   b.cdma_income,
    b.charge,
    c.roam_income ft_roam_income,
case when a.product_id='779' then c.cdma_income when a.product_id='833'
  then c.charge end ft_cdma_income,c.charge ft_charge,
    d.roam_yh,
    case when a.product_id='779' then d.cdma_yh when 
      a.product_id='833' then d.charge_yh end cdma_yh,
      d.base_charge,
      b.base_charge base_charge_ftq
      from ly.tmp_roam_serv_list_1 a
left join ly.tmp_bill_acct_item_201712 b on a.serv_id=b.serv_id
left join ly.tmp_bill_acct_item_ft_201712 c on a.serv_id=c.serv_id
left join (select serv_id,sum(roam_yh) roam_yh,sum(cdma_yh) cdma_yh,sum(charge_yh) charge_yh,sum(base_charge) base_charge 
  from ly.tmp_youhuo_offer_201712
group by serv_id) d on a.serv_id=d.serv_id;

select count(serv_id),count(distinct serv_id) from ly.tmp_roam_serv_list_2


select a.*,
total_data_flow/1024/1024 total_data_flow_m,
(total_data_flow/1024/1024)*0.03 cdma_sett_fee
 from ly.tmp_roam_serv_list_2 a  
  where product_id='833'
 group by std_area_name
 
---------取套餐实例收入
select * from pu_intf.I_BILL_ACCT_ITEM_YS --1102423834
select * from dsg.product_offer_instance@dl_ods_89_yn 
--PRODUCT_OFFER_INSTANCE_ID;
select * from dsg.product_offer_instance_detail@dl_ods_89_yn where instaNCE_TYPE='10A'
--PRODUCT_OFFER_INSTANCE_ID

drop table ly.tmp_offer_inset_id_charge purge;
create table ly.tmp_offer_inset_id_charge parallel 20 nologging as
select offer_inst_id,sum(charge)/100 charge
 from pu_intf.I_BILL_ACCT_ITEM_YS where month_no='201712'
and acct_item_type_id='107' group by offer_inst_id;

drop table ly.tmp_offer_inset_id_charge_yh purge;
create table ly.tmp_offer_inset_id_charge_yh parallel 20 nologging as
select offer_inst_id,sum(charge)/100 charge
 from pu_intf.I_BILL_ACCT_ITEM_YS where month_no='201712'
and acct_item_type_id='107'
and charge<0 group by offer_inst_id;

----ODS库跑，数据量很大
create table IPD_IN.ly_tmp_roam_serv_list_1 as
select * from ly.tmp_roam_serv_list@ ; ----经分链路

create table IPD_IN.tmp_ly_offer_detail  parallel 10 nologging as
select a.serv_id,b.PRODUCT_OFFER_INSTANCE_ID,
to_char(b.eff_date,'yyyymm') eff_date,
to_char(b.exp_date,'yyyymm') exp_date 
from  IPD_IN.ly_tmp_roam_serv_list_1 a,
dsg.product_offer_instance_detail b
where a.serv_id=b.instance_id;

drop table ly.tmp_ly_offer_detail purge;
create table ly.tmp_ly_offer_detail as 
SELECT *  FROM IPD_IN.tmp_ly_offer_detail@DL_ODS_89_YN a
 WHERE a.eff_date <= '201712' and a.exp_date >= '201712'; 
 
select * from IPD_IN.tmp_ly_offer_detail2@DL_ODS_89_YN
select * from IPD_IN.tmp_ly_offer_detail2_ly@DL_ODS_89_YN
----
drop table ly.tmp_ly_offer_detail purge;
create table ly.tmp_ly_offer_detail as
select * from 
--ly.tmp_ly_offer_detail2
IPD_IN.tmp_ly_offer_detail2@DL_ODS_89_YN;

----
drop table ly.tmp_product_offer_instance_id purge;
create table ly.tmp_product_offer_instance_id parallel 20 nologging as
select a.serv_id,sum(c.charge) charge from  
ly.tmp_roam_serv_list_2 a,
ly.tmp_ly_offer_detail  b,
ly.tmp_offer_inset_id_charge c
where a.serv_id=b.serv_id
and b.PRODUCT_OFFER_INSTANCE_ID=c.offer_inst_id
group by a.serv_id;


drop table ly.tmp_product_offer_inst_id_yh purge;
create table ly.tmp_product_offer_inst_id_yh parallel 20 nologging as
select a.serv_id,sum(c.charge) charge from  ly.tmp_roam_serv_list_2 a,
ly.tmp_ly_offer_detail  b,
ly.tmp_offer_inset_id_charge_yh c
where a.serv_id=b.serv_id
and b.PRODUCT_OFFER_INSTANCE_ID=c.offer_inst_id
group by a.serv_id;



select * from ly.tmp_product_offer_instance_id

-------增加包打标示
------添加包打标示---------
drop table  ly.TMP_ROAM_LIST_F purge;  
create table ly.TMP_ROAM_LIST_F AS
select serv_id,lev_6090 from (
 select a.serv_id,a.lev_6090,row_number() over(partition by a.serv_id order by date_no desc) rn 
 from PU_LIST.P_SUB_PRD_SERV_BD_D a where lev_6090_rh is null)
 where rn=1


 
drop table ly.tmp_roam_serv_list_all_201712 purge;
create table  ly.tmp_roam_serv_list_all_201712 as
select a.std_area_name,a.serv_id,a.acc_nbr,a.create_date,
a.dvlp_channel_id,f.channel_name dvlp_channel_name,
a.zhu_offer_id,
a.zhu_offer_name,
a.all_offer_name,a.product_id,
a.dur 语音话务量,mbl_innet_flux 流量,
a.cdma_income 分摊前省际漫游流量账目项收入,
a.roam_income 分摊前省际漫游语音账目项收入,
a.charge 分摊前总收入,
a.ft_cdma_income 分摊后省际漫游流量账目项收入,
a.ft_roam_income 分摊后省际漫游语音账目项收入,
a.ft_charge 分摊后总收入,
a.total_data_flow/1024/1024 省际结算流量,
a.call_duration 省际结算语音,
(a.total_data_flow/1024/1024)*0.003 省际流量结算支出费用,
a.sett_fee_yy 省际语音漫游支出,
a.cdma_yh 优惠省际漫游流量费用,
a.roam_yh 优惠省际漫游语音费用,
d.charge 优惠套餐月基本费,
nvl(c.charge,0) 分摊前套餐月基本费收入,
e.lev_6090 包打标示
 from ly.tmp_roam_serv_list_2 a, 
 ly.tmp_product_offer_instance_id c,
 ly.tmp_product_offer_inst_id_yh d,
 ly.TMP_ROAM_LIST_F e,
  PU_MODEL.TB_PTY_CRM_CHANNEL f
 where a.serv_id=c.serv_id(+)
 and a.serv_id=d.serv_id(+)
 and a.serv_id=e.serv_id(+)
 and a.dvlp_channel_id=f.channel_id(+);
 
 select sum(省际流量结算支出费用) from ly.tmp_roam_serv_list_all_201712; --1463462.29635036
  select sum(省际流量结算支出费用) from ly.tmp_roam_serv_list_all_201711;---8562629.02603506


 select count(*) from ly.tmp_roam_serv_list_all_201711   ----524512

 
  select * from ly.tmp_roam_serv_list_all where acc_nbr='18087728860'

  select * from ly.tmp_roam_serv_list_2 where  dur is null

--------主套餐处理
drop table ly.tmp_bs_offer_serv_d purge;
create table ly.tmp_bs_offer_serv_d parallel 8 nologging as
select a.* from 
tbas.wt_bs_offer_serv_d a,
(select serv_id from ly.tmp_roam_serv_list_all_201712 where zhu_offer_name like '%基础%') b
where a.serv_id=b.serv_id;

drop table ly.TMP_WT_PDB_OFFER_SERV_1 purge;
create table ly.TMP_WT_PDB_OFFER_SERV_1  nologging as
 select a.*,
        case when b.offer_id is not null and substr(a.serv_lost_date,1,8)>=20171230 and nvl(b.main_lev,6)>8 then 4
             when b.offer_id is not null and substr(a.serv_lost_date,1,8) <20171230 and nvl(b.main_lev,6)>8 then 3   
             when b.offer_id is not null and 20171230 between to_char(a.offer_mbr_eff_dt,'yyyymmdd') and to_char(a.offer_mbr_exp_dt,'yyyymmdd')   then 0 
             when b.offer_id is not null and 20171230 < to_char(a.offer_mbr_eff_dt,'yyyymmdd') then 1
             when b.offer_id is not null and 20171230 > to_char(a.offer_mbr_exp_dt,'yyyymmdd') then 2 
             else 5 end is_state_value,/**当前生效主套餐**/     
        case when nvl(b.is_rh_flag,0)=1 then -1 
             when b.offer_id is not null then to_number(nvl(b.main_lev,10)) else 11 end is_offer_type,
        case when b.offer_id is not null then 1 else 0 end is_zhu_flag,
        case when   d.offer_spec_id is not null and a.OFFER_MBR_SIGN_FLAG=1 then 1 else 0 end is_hey_new_flag,
        c.name,
        row_number() over(partition by a.serv_id order by a.offer_mbr_exp_dt desc) rn
    from ly.tmp_bs_offer_serv_d a
    left join(select * from PU_META.TPDIM_OFFER_TYPE_LEV  b 
    where offer_name not like '%基础%') b on  to_char(a.src_offer_id)=to_char(b.offer_id)
    left join pu_meta.offer_spec c on a.src_offer_id=c.offer_spec_id
    left join pu_meta.offer_sepc_plan d on a.src_offer_id=d.offer_spec_id
    where to_char(a.offer_mbr_eff_dt,'yyyymm')<='201712'
    and to_char(a.offer_mbr_exp_dt,'yyyymm')>='201712';


select * from PU_META.TPDIM_OFFER_TYPE_LEV  where offer_name not like '%基础%' 
    
--主套餐获取
drop table ly.TMP_WT_PDB_OFFER_SERV_2 purge;
create table ly.TMP_WT_PDB_OFFER_SERV_2  nologging as
select * from (
select a.*,
       row_number() over(partition by a.serv_id order by a.is_state_value,a.is_offer_type,months_between(to_date('20171230','yyyymmdd'),a.offer_mbr_exp_dt),
       a.offer_mbr_eff_dt asc) rm
 from ly.TMP_WT_PDB_OFFER_SERV_1 a
 where name not like '%基础%'
and name not like '%向流量包%'  
and name not like '%预存%' 
and name not like '%彩铃%' 
 ) a 
 where rm=1;
 
 ------
  select a.*,b.src_offer_id,b.name from ly.tmp_roam_serv_list_all_201711 a,
  ly.TMP_WT_PDB_OFFER_SERV_2 b
   where a.zhu_offer_name like '%基础%'
   and a.serv_id=b.serv_id
   
   select * from   TMP.TMP_WT_PDB_OFFER_SERV_2 where serv_id='180568424'
   
   select * from ly.tmp_roam_serv_list_all_201711
      where zhu_offer_name like '%基础%'
      and all_offer_name like '%(13360194)【原联通】（VPN）新时空世界风电信集团员工卡194%' 
      
      
        select * from ly.tmp_roam_serv_list_all
      where zhu_offer_name like '%基础%'
      and all_offer_name like '%电信%' 
     and all_offer_name not like '%(1622885)【原联通】新时空－世界风－电信集团员工卡  826476%'
     and all_offer_name not like '%(13360194)【原联通】（VPN）新时空世界风电信集团员工卡194%' 

drop table ly.tmp_roam_serv_list_all_10_bak purge; 
create table ly.tmp_roam_serv_list_all_10_bak as 
select * from ly.tmp_roam_serv_list_all_201712;

update ly.tmp_roam_serv_list_all_201712 set zhu_offer_id='1622885',
 zhu_offer_name='(1622885)【原联通】新时空－世界风－电信集团员工卡  826476' 
where serv_id in (
select serv_id from ly.tmp_roam_serv_list_all_10_bak
   where zhu_offer_name like '%基础%'
      and all_offer_name like '%(1622885)【原联通】新时空－世界风－电信集团员工卡  826476%')
and zhu_offer_name like '%基础%';

update ly.tmp_roam_serv_list_all_201712 set zhu_offer_id='13360194',
 zhu_offer_name='(13360194)【原联通】（VPN）新时空世界风电信集团员工卡194' 
where serv_id in (
select serv_id from ly.tmp_roam_serv_list_all_10_bak
   where zhu_offer_name like '%基础%'
      and all_offer_name not like '%(1622885)【原联通】新时空－世界风－电信集团员工卡  826476%'
      and all_offer_name like '%(13360194)【原联通】（VPN）新时空世界风电信集团员工卡194%')
and zhu_offer_name like '%基础%';


update ly.tmp_roam_serv_list_all_201712 a set(zhu_offer_id,zhu_offer_name)=
(select src_offer_id,name from ly.TMP_WT_PDB_OFFER_SERV_2 b where a.serv_id=b.serv_id)
where a.zhu_offer_name like '%基础%'
and a.serv_id in (select serv_id from ly.TMP_WT_PDB_OFFER_SERV_2);



update ly.tmp_roam_serv_list_all_201712 a set(zhu_offer_id,zhu_offer_name)=
(select src_offer_id,name from TMP.TMP_WT_PDB_OFFER_SERV_2 b where a.serv_id=b.serv_id)
where  a.serv_id in (select serv_id from ly.tmp_roam_serv_list_all_10_bak where zhu_offer_name like '%基础%') 
 and a.serv_id in (select serv_id from ly.TMP_WT_PDB_OFFER_SERV_2)
 and zhu_offer_name like '%预存%';
 
 update ly.tmp_roam_serv_list_all_201712 a set(zhu_offer_id,zhu_offer_name)=
(select src_offer_id,name from TMP.TMP_WT_PDB_OFFER_SERV_2 b where a.serv_id=b.serv_id)
where  a.serv_id in (select serv_id from ly.tmp_roam_serv_list_all_10_bak where zhu_offer_name like '%基础%') 
 and a.serv_id in (select serv_id from ly.TMP_WT_PDB_OFFER_SERV_2)
 and zhu_offer_name like '%向流量包%';
 
   update ly.tmp_roam_serv_list_all_201712 a set(zhu_offer_id,zhu_offer_name)=
(select src_offer_id,name from TMP.TMP_WT_PDB_OFFER_SERV_2 b where a.serv_id=b.serv_id)
where  a.serv_id in (select serv_id from ly.tmp_roam_serv_list_all_10_bak where zhu_offer_name like '%基础%') 
 and a.serv_id in (select serv_id from ly.TMP_WT_PDB_OFFER_SERV_2)
 and zhu_offer_name like '%彩铃%';
 
 select * from ly.tmp_roam_serv_list_all_201712 
 where serv_id in (select serv_id from ly.tmp_roam_serv_list_all_10_bak where zhu_offer_name like '%基础%')
 and zhu_offer_name like '%基础%';
 
 select * from TMP.TMP_WT_PDB_OFFER_SERV_1 b
where serv_id in (select serv_id from ly.tmp_roam_serv_list_all_201711 where zhu_offer_name like '%基础%')

select * from ly.TMP_WT_PDB_OFFER_SERV_1 where serv_id=740105718913

--------------备份表
ly.tmp_roam_serv_list_all_bak

create table ly.tmp_roam_serv_list_all_bak1 as
select * from ly.tmp_roam_serv_list_all;

create table ly.tmp_roam_serv_list_al1_201712 parallel 8 nologging as
select a.*,b.dvlp_channel_id,c.channel_name dvlp_channel_name from ly.tmp_roam_serv_list_all_201712 a,
tbas.wt_prod_serv_d_201712 b,
 PU_MODEL.TB_PTY_CRM_CHANNEL c
where a.serv_id=b.serv_id(+)
and b.dvlp_channel_id=c.channel_id(+);

select * from 
-----------加身份证、缴费、状态------------
drop table ly.tmp_roam_serv_list_all_201712a purge;
create table ly.tmp_roam_serv_list_all_201712a parallel 8 nologging as
select a.*,b.prod_inst_state,c.status_name,d.amount,e.CERT_NBR,e.cert_type
 from ly.tmp_roam_serv_list_all_201712 a,
tbas.wt_prod_serv_d_201712 b,
pu_meta.d_user_status c,
ly.tmp_pay_20180116 d,
tBAS.DAPM_CUST_INFO_201712 e
where a.serv_id=b.serv_id(+)
and b.prod_inst_state=c.status_code(+)
and a.serv_id=d.serv_id(+)
and b.cust_id=e.cust_id(+);

select * from ly.tmp_roam_serv_list_all_201712a

Select T.ACCT_ID, Count(*) PAY_NUM
From PU_INTF.I_BIL_PAYMENT T              --------每天全量
Where T.MONTH_NO In ('201711')
And STATE = 'C0C'
And AMOUNT <> 0
And STAFF_ID <> '71986' --剔除赠送  （剔除赠送即为现金缴费）
Group By T.ACCT_ID ;

drop table ly.tmp_pay_20180116 purge;
create table ly.tmp_pay_20180116 as
select a.serv_id,sum(amount)/100 amount
from PU_INTF.I_BIL_PAYMENT_M a,
ly.tmp_roam_serv_list_all_201712 b
where a.MONTH_NO In ('201712')
And STATE = 'C0C'
And AMOUNT <> 0
and a.serv_id=b.serv_id
Group By a.serv_id ;
--------------
