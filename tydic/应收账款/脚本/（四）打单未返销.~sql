分公司  201712  201711  201710  201709  201708  201707  201706  201705  201704  201703  201702  201701  2017年初  环比增加  环比增幅  较年初增加  较年初增幅


create table PU_BUSI_IND.BM_ACCOUNTS_RECV_M5
(month_no varchar2(6),
 area_code  varchar2(6),
 area_name  varchar2(16), 
 value_num1 number,
 value_num2 number,
 value_num3 number,
 value_num4 number,
 value_num5 number,
 value_num6 number,
 value_num7 number,
 value_num8 number,
 value_num9 number,
 value_num10 number,
 value_num11 number,
 value_num12 number,
 value_num13 number,
 value_num14 number,
 value_num15 number,
 value_num16 number,
 value_num17 number 
)

delete from PU_BUSI_IND.BM_ACCOUNTS_RECV_M5 where month_no='201701';
commit;
insert into PU_BUSI_IND.BM_ACCOUNTS_RECV_M5
select '201701',
area_code,
area_name,
sum(case when month_No='201712' then ddwfx_balance else 0 end)/10000 ,
sum(case when month_No='201711' then ddwfx_balance else 0 end)/10000 ,
sum(case when month_No='201710' then ddwfx_balance else 0 end)/10000 ,
sum(case when month_No='201709' then ddwfx_balance else 0 end)/10000 ,
sum(case when month_No='201708' then ddwfx_balance else 0 end)/10000 ,
sum(case when month_No='201707' then ddwfx_balance else 0 end)/10000 ,
sum(case when month_No='201706' then ddwfx_balance else 0 end)/10000 ,
sum(case when month_No='201705' then ddwfx_balance else 0 end)/10000 ,
sum(case when month_No='201704' then ddwfx_balance else 0 end)/10000 ,
sum(case when month_No='201703' then ddwfx_balance else 0 end)/10000 ,
sum(case when month_No='201702' then ddwfx_balance else 0 end)/10000 ,
sum(case when month_No='201701' then ddwfx_balance else 0 end)/10000 ,
sum(case when month_No='201701' then begging_balance else 0 end)/10000, --年初   
sum(case when month_No='201701' then ddwfx_balance_increase  else 0 end)/10000, --环比增加
sum(case when month_No='201701' then ddwfx_balance_hb  else 0 end) ,--环比增幅
sum(case when month_No='201701' then begging_balance_increase  else 0 end)/10000, --较年初增加
sum(case when month_No='201701' then begging_balance_hb else 0 end) --较年初增幅  实际不存在聚合 故直接sum环比值
from PU_INTF.F_BUSINESS_BALANCE_M t
where month_no between '201701' and '201712'
and area_code not in ('9005','9004','9003')
group by area_code,
area_name;
commit;

select * from PU_BUSI_IND.BM_ACCOUNTS_RECV_M5

