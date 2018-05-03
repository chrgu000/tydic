create table ly.tmp_yd_serv parallel 8 nologging as
select a.latn_id,
a.src_offer_inst_id,
a.src_offer_id,
a.serv_id,
a.product_id,
a.serv_create_date,
a.src_crt_date,
a.src_inst_eff_date,
a.src_inst_exp_date
 from tbas.wt_bs_offer_serv_d a
 where substr(a.serv_create_date,1,6)='201708'
 and a.product_id in ('779','833') 
 and to_char(a.src_crt_date,'yyyymm')='201708'; --新装移动
 
 
 
 
 
 
create table ly.tmp_kd_serv parallel 8 nologging as
select a.src_offer_inst_id,
a.src_offer_id,
a.serv_id,
a.product_id,
a.serv_create_date,
a.src_crt_date,
a.src_inst_eff_date,
a.src_inst_exp_date
 from tbas.wt_bs_offer_serv_d a
 where substr(a.serv_create_date,1,6)='201708'
 and a.product_id in (352, 353, 354, 381, 1721, 2563)
  and to_char(a.src_crt_date,'yyyymm')='201708';  --新装宽带
  
  
create table ly.tmp_yd_serv_tx parallel 8 nologging as
select a.*,b.call_number call_number_10,
c.call_number call_number_11,
d.call_number call_number_12
 from ly.tmp_yd_serv a     --新装移动 各月通信次数
  left join (select * from pu_wt.wt_beh_m_201710@dl_fxgk_wt where date_no='20171031') b on a.serv_id=b.serv_id 
  left join (select * from pu_wt.wt_beh_m_201711@dl_fxgk_wt where date_no='20171130') c on a.serv_id=c.serv_id 
  left join (select * from pu_wt.wt_beh_m_201712@dl_fxgk_wt where date_no='20171231') d on a.serv_id=d.serv_id 
      

create table tmp_rh_serv parallel 8 nologging as  --融合套餐
select a.*,
b.kd_dev 
from (
select a.latn_id,
a.src_offer_inst_id,
a.src_offer_id,
count(*) yd_dev,       ---融合套餐中移动发张量
sum(case when CALL_NUMBER_10>=5 then 1 else 0 end) CALL_10_num,
sum(case when CALL_NUMBER_11>=5 then 1 else 0 end) CALL_11_num,
sum(case when CALL_NUMBER_12>=5 then 1 else 0 end) CALL_12_num
from ly.tmp_yd_serv_tx a
group by a.latn_id,
a.src_offer_inst_id,
a.src_offer_id) a,
(
select a.latn_id,
a.src_offer_inst_id,
a.src_offer_id,
count(*) kd_dev  --宽带发展量
from ly.tmp_kd_serv a
group by a.latn_id,
a.src_offer_inst_id,
a.src_offer_id) b
where a.src_offer_inst_id=b.src_offer_inst_id;  --融合


select b.area_name,
a.src_offer_id,
c.NAME,
count(distinct src_offer_inst_id) 
from tmp_rh_serv a,
pu_meta.latn_new b,
pu_meta.offer_spec c
where '0'||a.latn_id=b.local_code
and a.src_offer_id=c.OFFER_SPEC_ID(+)
and yd_dev>=2
group by b.area_name,a.src_offer_id,c.NAME
order by area_name;


select b.area_name,
a.src_offer_id,
c.NAME,
count(distinct src_offer_inst_id) 
from tmp_rh_serv a,
pu_meta.latn_new b,
pu_meta.offer_spec c
where '0'||a.latn_id=b.local_code
and a.src_offer_id=c.OFFER_SPEC_ID(+)
and yd_dev>=2
and CALL_12_NUM>=1
group by b.area_name,
a.src_offer_id,
c.NAME
order by area_name;


