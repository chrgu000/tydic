select * from PU_INTF.INTF_DATA_M 
where month_no='201701'
and id_zbcode like'%BMX60000000%'
and id_unitcode='530103757190184'

分公司  2017年预算  当月累计  去年同期	同比增加	同比增幅	当期累计收入	去年同期累计收入	当期占收比	"去年同期占收比"	占收比同比变化	上月累计	环比增加	环比增幅	上月占收比	占收比环比变化 	当期超预算额度（时序）	预算完成率（时序）	超预算进度（时序）	预算完成率 当期超预算进度
 
create table pu_busi_ind.bm_Accounts_recv_m6
(month_no   varchar2(6),
data_type   varchar2(2),
index_area  number,
area_code   varchar2(10),   
area_name   varchar2(10), 
target_value  number,
value_num1  number,
value_num2   number,
value_num3  number, 
value_num4  number, 
value_num5  number,
value_num6  number,
value_num7  number, 
value_num8  number,
value_num9  number, 
value_num10  number,
value_num11  number, 
value_num12  number, 
value_num13  number, 
value_num14  number, 
value_num15  number, 
value_num16  number, 
value_num17  number,
value_num18  number,
value_num19  number  
) 
 
drop table pu_busi_ind.tmp1_Accounts_recv_m6;
create table pu_busi_ind.tmp1_Accounts_recv_m6 as
select '201701' month_no, 
b.show_order2 index_area,
a.area_code ,
a.area_name,
a.budget_value target_value ,--2017年预算
sum(case when c.id_zbcode ='BMX60000000_3' then ID_VALUE else 0 end)/100  value_num1 , --当月累计
sum(case when c.id_zbcode ='BMX60000000_1' then ID_VALUE else 0 end)/100  value_num2 , --去年同期
sum(case when c.id_zbcode ='BMX60000000_3' then ID_VALUE else 0 end)/100 -
sum(case when c.id_zbcode ='BMX60000000_1' then ID_VALUE else 0 end)/100 value_num3 , --同比增加
decode(sum(case when c.id_zbcode ='BMX60000000_1' then ID_VALUE else 0 end),0,0,  
sum(case when c.id_zbcode ='BMX60000000_3' then ID_VALUE else 0 end)/
sum(case when c.id_zbcode ='BMX60000000_1' then ID_VALUE else 0 end)-1) value_num4 --比增幅
 from pu_intf.f_Bad_debt_budget_y a,
  pu_meta.d_cw_area_info2 b,
  PU_INTF.INTF_DATA_M@DL_EDW_YN c
where  a.area_code=b.local_code
and b.jq_code=c.id_unitcode 
and year_No='2017'
and c.id_zbcode in ('BMX60000000_1','BMX60000000_3') 
and c.month_no='201701'
group by b.show_order2,
a.area_code ,
a.area_name,
a.budget_value;

drop table pu_busi_ind.tmp2_Accounts_recv_m6;
create table pu_busi_ind.tmp2_Accounts_recv_m6 as
select a.month_no,
b.data_type,
a.index_area,
a.area_code,
a.area_name,
a.target_value,
a.value_num1,
a.value_num2,
a.value_num3,
a.value_num4, 
b.charge_year3 value_num5 , --当期累计收入
b.charge_year31 value_num6 , --去年同期累计收入
decode(b.charge_year3,0,0,a.value_num1/b.charge_year3) value_num7 , --当期占收比
decode(b.charge_year31,0,0,a.value_num2/b.charge_year31) value_num8 , --去年同期占收比
decode(b.charge_year3,0,0,a.value_num1/b.charge_year3)-
decode(b.charge_year31,0,0,a.value_num2/b.charge_year31) value_num9  --占收比同比变化 
from  pu_busi_ind.tmp1_Accounts_recv_m6 a, 
pu_busi_ind.bm_charge_all_m b
where a.area_code=b.area_code
and b.month_no='201701';

delete from pu_busi_ind.bm_Accounts_recv_m6  where month_no='201701';
commit;
insert into pu_busi_ind.p_bm_Accounts_recv_m6
  select a.*,
         b.value_num1 value_num10, --上月累计              
         a.value_num1 - b.value_num1 value_num11, --环比增加              
         decode(b.value_num1, 0, 0, a.value_num1 / b.value_num1 - 1) value_num12, --环比增幅              
         b.value_num7 value_num13, --上月占收比            
         a.value_num7 - b.value_num7 value_num14, --占收比环比变化        
         a.value_num1 - (a.target_value / 12) * 1 value_num15, --当期超预算额度（时序）
         decode(a.target_value,
                0,
                0,
                a.value_num1 / ((a.target_value / 12) * 1)) value_num16, --预算完成率（时序）    
         decode(a.target_value,
                0,
                0,
                (a.value_num1 - (a.target_value / 12) * 1) /
                ((a.target_value / 12) * 1)) value_num17, --超预算进度（时序）    
         decode(a.target_value, 0, 0, a.value_num1 / a.target_value) value_num18, --预算完成率            
         decode(a.target_value, 0, 0, a.value_num1 / a.target_value) -
         decode(a.target_value,
                0,
                0,
                a.target_value / 12 * 1 / a.target_value) value_num19 --当期超预算进度  
    from pu_busi_ind.tmp2_Accounts_recv_m6 a
    left join pu_busi_ind.bm_Accounts_recv_m6 b
      on a.data_type = b.data_type
     and a.area_code = b.area_code
     and b.month_No = '201612';
commit;


select *
  from pu_busi_ind.bm_Accounts_recv_m6
 where month_no = '201701'
   and data_type = '01'
