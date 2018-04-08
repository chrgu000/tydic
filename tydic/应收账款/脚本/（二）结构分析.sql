 select * from PU_INTF.INTF_DATA_M @DL_EDW_YN 
where month_no='201701'
and id_zbcode in('YNCWYSMX0100','YNCWYSMX0102','YNCWYSMX0111','YNCWYSMX0112','YNCWYSMX0114','YNCWYSMX0113','YNCWYSMX1101','YNCWYSMX0108','YNCWYSM04612','YNCWYSMX0109','YNCWYSMX0900') 
and id_unitcode='530103757190184'

 
create table pu_busi_ind.bm_Accounts_recv_m2 
(month_no varchar2(6),
area_code varchar2(6),
area_index number,
area_name varchar2(10),
value_nums1 number, 
value_nums2  number,
value_nums3  number,
value_nums4 number, 
value_nums5 number, 
value_nums6 number, 
value_nums7 number, 
value_nums8 number, 
value_nums9 number, 
value_nums10 number, 
value_nums11 number, 
value_nums12 number, 
value_nums13 number, 
value_nums14 number, 
value_nums15 number  
)

  用户欠费
	集团内结算款其他
	集团外结算款网间结算款
	集团外结算款应收电路及其他网元服务费
	集团外结算款结算
	集团外结算款其他
	系统集成款
	代办单位营业款
	应收号百业务款
	应收账款.其他
	营业款结算


truncate table pu_busi_ind.tmp1_Accounts_recv_m2;
---临时表
insert into pu_busi_ind.tmp1_Accounts_recv_m2  
select 
nvl(decode(c.local_code,'9003','3009',c.local_code),'0000') local_code, ----信产单独  大昆明
sum(case when id_zbcode='YNCWYSMX0100' then id_value else 0 end) value_nums1 , 
sum(b.ddwfx_balance) value_nums2  ,
sum(case when id_zbcode='YNCWYSMX0102' then id_value else 0 end) value_nums3  ,
sum(case when id_zbcode='YNCWYSMX0111' then id_value else 0 end) value_nums4 , 
sum(case when id_zbcode='YNCWYSMX0112' then id_value else 0 end) value_nums5 , 
sum(case when id_zbcode='YNCWYSMX0114' then id_value else 0 end) value_nums6 , 
sum(case when id_zbcode='YNCWYSMX0113' then id_value else 0 end) value_nums7 , 
sum(case when id_zbcode='YNCWYSMX1101' then id_value else 0 end) value_nums8 , 
sum(case when id_zbcode='YNCWYSMX0108' then id_value else 0 end) value_nums9 , 
sum(case when id_zbcode='YNCWYSM04612' then id_value else 0 end) value_nums10 , 
sum(case when id_zbcode='YNCWYSMX0109' then id_value else 0 end) value_nums11 , 
sum(case when id_zbcode='YNCWYSMX0900' then id_value else 0 end) value_nums12 , 
sum(id_value ) value_nums13 , 
sum(case when id_zbcode<>'YNCWYSMX0100' then id_value else 0 end) value_nums14 , 
sum(case when id_zbcode not in('YNCWYSMX0100','YNCWYSMX0900') then id_value else 0 end) value_nums15  
from PU_INTF.INTF_DATA_M@DL_EDW_YN a,
pu_intf.f_business_balance_m b,
pu_meta.d_cw_area_info2 c
where a.ID_UNITCODE=c.jq_code 
and b.area_code=c.local_code
and a.month_no='201702'
and a.id_zbcode in('YNCWYSMX0100','YNCWYSMX0102','YNCWYSMX0111','YNCWYSMX0112','YNCWYSMX0114','YNCWYSMX0113','YNCWYSMX1101','YNCWYSMX0108','YNCWYSM04612','YNCWYSMX0109','YNCWYSMX0900') 
and b.month_no='201701'
group by nvl(decode(c.local_code,'9003','3009',c.local_code),'0000');
commit;

---政企 商客
insert into pu_busi_ind.tmp1_Accounts_recv_m2
(local_code,
 value_nums1
 )
select area_code,
       sum(case
             when fee_type = '01' AND FEE_MONTH < '201702' THEN
              amount_real
             when fee_type = '02' AND FEE_MONTH = '201702' THEN
              amount_real
             ELSE
              0
           END) / 10000 this_month
  from PU_BUSI_IND.BM_OWN_FEE_AGE_M a
 where month_no = '201702'
 group by area_code;
 commit;
 
---昆电
insert into pu_busi_ind.tmp1_Accounts_recv_m2
select '9011',
sum(case when local_code='0871' then value_nums1 else -value_nums1 end ), 
sum(case when local_code='0871' then value_nums2 else -value_nums2 end ),
sum(case when local_code='0871' then value_nums3 else -value_nums3 end ),
sum(case when local_code='0871' then value_nums4 else -value_nums4 end ),
sum(case when local_code='0871' then value_nums5 else -value_nums5 end ),
sum(case when local_code='0871' then value_nums6 else -value_nums6 end ),
sum(case when local_code='0871' then value_nums7 else -value_nums7 end ),
sum(case when local_code='0871' then value_nums8 else -value_nums8 end ),
sum(case when local_code='0871' then value_nums9 else -value_nums9 end ),
sum(case when local_code='0871' then value_nums10 else -value_nums10 end ),
sum(case when local_code='0871' then value_nums11 else -value_nums11 end ),
sum(case when local_code='0871' then value_nums12 else -value_nums12 end ),
sum(case when local_code='0871' then value_nums13 else -value_nums13 end ),
sum(case when local_code='0871' then value_nums14 else -value_nums14 end ),
sum(case when local_code='0871' then value_nums15 else -value_nums15 end )
from pu_busi_ind.tmp1_Accounts_recv_m2
where local_code in ('0871','9008','9010');
COMMIT;

---差额   (从应收账款明细表取差额)
insert into pu_busi_ind.tmp1_Accounts_recv_m2
select  
'9006' local_code,
sum(case when id_zbcode='CWYSMX0100_03' then id_value else 0 end) value_nums1 , 
sum(c.ddwfx_balance) value_nums2  ,
sum(case when id_zbcode='CWYSMX0102_03' then id_value else 0 end) value_nums3  ,
sum(case when id_zbcode='CWYSMX0111_03' then id_value else 0 end) value_nums4 , 
sum(case when id_zbcode='CWYSMX0112_03' then id_value else 0 end) value_nums5 , 
sum(case when id_zbcode='CWYSMX0114_03' then id_value else 0 end) value_nums6 , 
sum(case when id_zbcode='CWYSMX0113_03' then id_value else 0 end) value_nums7 , 
sum(case when id_zbcode='CWYSMX1101_03' then id_value else 0 end) value_nums8 , 
sum(case when id_zbcode='CWYSMX0108_03' then id_value else 0 end) value_nums9 , 
sum(case when id_zbcode='CWYSM04612_03' then id_value else 0 end) value_nums10 , 
sum(case when id_zbcode='CWYSMX0109_03' then id_value else 0 end) value_nums11 , 
sum(case when id_zbcode='CWYSMX0900_03' then id_value else 0 end) value_nums12 , 
sum(id_value ) value_nums13 , 
sum(case when id_zbcode<>'CWYSMX0100_03' then id_value else 0 end) value_nums14 , 
sum(case when id_zbcode not in('CWYSMX0100_03','CWYSMX0900_03') then id_value else 0 end) value_nums15  
  from PU_INTF.INTF_DATA_M@DL_EDW_YN a， 
pu_intf.f_business_balance_m c
where decode(a.ID_UNITCODE,'533528999999999','9006')=c.area_code
and a.month_no='201701'
and ID_UNITCODE='533528999999999'--差额 
and a.id_zbcode in ('CWYSMX0100_03','CWYSMX0102_03','CWYSMX0111_03','CWYSMX0112_03','CWYSMX0114_03','CWYSMX0113_03','CWYSMX1101_03','CWYSMX0108_03','CWYSM04612_03','CWYSMX0109_03','CWYSMX0900_03');
commit;
 
-- 信产+差额 
insert into pu_busi_ind.tmp1_Accounts_recv_m2
select '9003'local_code,
sum(value_nums1),
sum(value_nums2),
sum(value_nums3),
sum(value_nums4),
sum(value_nums5),
sum(value_nums6),
sum(value_nums7),
sum(value_nums8),
sum(value_nums9),
sum(value_nums10),
sum(value_nums11),
sum(value_nums12),
sum(value_nums13),
sum(value_nums14),
sum(value_nums15) 
from pu_busi_ind.tmp1_Accounts_recv_m2
where local_code in('9006','3009');
commit;

 
delete from pu_busi_ind.bm_Accounts_recv_m2  where month_no='201702';
commit;
insert into pu_busi_ind.bm_Accounts_recv_m2 
select '201702',
nvl(b.local_code,'0000'),
case when a.local_code='3009' then 24 else b.show_order3 end,
case when a.local_code='3009' then '信产(不含差额)' else b.area_name end,
value_nums1,
value_nums2,
value_nums3,
value_nums4,
value_nums5,
value_nums6,
value_nums7,
value_nums8,
value_nums9,
value_nums10,
value_nums11,
value_nums12,
value_nums13,
value_nums14,
value_nums15 
from pu_busi_ind.tmp1_Accounts_recv_m2 a,
pu_meta.d_cw_area_info2 b
where a.local_code=b.local_code(+);
commit;
 


select * from pu_meta.d_cw_area_info2
