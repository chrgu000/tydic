---Ƿ������ͳ�� ������ �ֹ�
 pu_intf.f_owe_month_dzj_m 
---Ӫҵ������嵥�� �ֹ�
 pu_intf.f_business_balance_m 
---ʡ���� ʡ�̿;�Ӫ����ӿ�  ͨ��ҳ���ֹ�����
select * from  pu_intf.f_charge_jysr_m  where month_no='201701' 
 
----��Ӫ���� �Űٻ�������������
create table pu_intf.f_charge_haobai_km
(month_no varchar2(6),
charge_month number,
charge_year number)
 
01:��������ԭ�� 02:��������ԭ�� 03:�Űٻ�ԭ�� 04:�����������������Űٻ��� 05:PPM��ԭ�� 06:�����������������Ű١�PPM����


create table tmp_wrm_area
(order_id number,
area_name varchar2(10))

select * from tmp_wrm_area for update 

select a.*,b.local_code
 from tmp_wrm_area a,
pu_meta.d_cw_area_info2 b
where trim(a.area_name)=b.area_name(+)
order by a.order_id
