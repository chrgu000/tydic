select * from  pu_busi_ind.bm_Accounts_recv_m1
where month_no='201701'
and data_type='01'
order by INDEX_AREA;

select * from  pu_busi_ind.bm_Accounts_recv_m1
where month_no='201701'
and data_type='02'
order by INDEX_AREA;


select * from  pu_busi_ind.bm_Accounts_recv_m2
where month_no='201701'
and  area_index is not null
order by  area_index ;


select tab_type
,data_type
,month_no
,area_code
,area_index
,area_name
,value_num1
,value_num2
,value_num3
,value_num4
,value_num5
,value_num6
,value_num7
,value_num8
,value_num9
,value_num10
,value_num11
,value_num12
,value_num13
,value_num14
,value_num15
,value_num16
,value_num17
,value_num18
,value_num19 
,value_num23
,value_num24
,value_num25 
from pu_busi_ind.bm_Accounts_recv_m3
where month_no='201701'
and data_type='02'
and tab_type='01'
and area_index<>'99'
order by area_index;



select *
from pu_busi_ind.bm_Accounts_recv_m3
where month_no='201701'
and data_type='02'
and tab_type='02'
and area_index<>'99'
order by area_index;



select * from pu_busi_ind.bm_Accounts_recv_m4 t
where month_no='201701'
and data_type='02'
order by t.area_index; 

select * from pu_busi_ind.bm_Accounts_recv_m4 t
where month_no='201701'
and data_type='02'
and area_index<>99
order by t.area_index;


select * from pu_busi_ind.bm_Accounts_recv_m5 t
where month_no='201702'
order by area_index;


select * from pu_busi_ind.bm_Accounts_recv_m6 t
where month_no='201701'
and data_type='02'
order by INDEX_AREA;

