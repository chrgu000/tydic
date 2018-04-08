---欠费账龄统计 党政军 手工
 pu_intf.f_owe_month_dzj_m 
---营业款结算清单表 手工
 pu_intf.f_business_balance_m 
---省政企 省商客经营收入接口  通过页面手工输入
select * from  pu_intf.f_charge_jysr_m  where month_no='201701' 
 
----经营收入 号百划入昆明的数据
create table pu_intf.f_charge_haobai_km
(month_no varchar2(6),
charge_month number,
charge_year number)
 
01:党政军还原后 02:关联方还原后 03:号百还原后 04:党政军、关联方、号百汇总 05:PPM还原后 06:党政军、关联方、号百、PPM汇总


create table tmp_wrm_area
(order_id number,
area_name varchar2(10))

select * from tmp_wrm_area for update 

select a.*,b.local_code
 from tmp_wrm_area a,
pu_meta.d_cw_area_info2 b
where trim(a.area_name)=b.area_name(+)
order by a.order_id
