----
�ֹ�˾  ����3��������Ӧ���˿�  ����Ӧ���˿��ܶ�  �����ۼ�����  ȥ��ͬ��3��������Ӧ���ʿ�  ȥ��ͬ��Ӧ���ʿ��ܶ�  ȥ��ͬ���ۼ�����  ͬ������  ͬ������  ����ռ�ձ�  ȥ��ͬ��ռ�ձ�  ռ�ձȱ仯  ����3��������Ӧ���˿�  ��������  ��������  ����ռ�ձ�  ռ�ձȻ��ȱ仯  ����ռӦ���˿��ܶ��  ȥ��ͬ��ռӦ���˿��ܶ��  �ܶ�ռ�ȱ仯  ����3��������Ӧ��ȫʡռ��  ȥ��ͬ��3��������Ӧ��ȫʡռ��  ռ�ȱ仯

create table PU_BUSI_IND.BM_ACCOUNTS_RECV_M3
(
  tab_type    VARCHAR2(6),
  data_type   VARCHAR2(6),
  month_no    VARCHAR2(6),
  area_code   VARCHAR2(6),
  area_index  NUMBER,
  area_name   VARCHAR2(16),
  value_num1  NUMBER,
  value_num2  NUMBER,
  value_num3  NUMBER,
  value_num4  NUMBER,
  value_num5  NUMBER,
  value_num6  NUMBER,
  value_num7  NUMBER,
  value_num8  NUMBER,
  value_num9  NUMBER,
  value_num10 NUMBER,
  value_num11 NUMBER,
  value_num12 NUMBER,
  value_num13 NUMBER,
  value_num14 NUMBER,
  value_num15 NUMBER,
  value_num16 NUMBER,
  value_num17 NUMBER,
  value_num18 NUMBER,
  value_num19 NUMBER,
  value_num20 NUMBER,
  value_num21 NUMBER,
  value_num22 NUMBER
) ;
-- Add comments to the columns 
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M3.tab_type
  is '01��Ӧ���˿�  02���û�Ƿ��';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M3.data_type
  is '01����Ӫ����  02������׼������';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M3.value_num1
  is '����3��������Ӧ���˿�';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M3.value_num2
  is '����Ӧ���˿��ܶ�';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M3.value_num3
  is '�����ۼ�����';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M3.value_num4
  is 'ȥ��ͬ��3��������Ӧ���ʿ�';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M3.value_num5
  is 'ȥ��ͬ��Ӧ���ʿ��ܶ�';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M3.value_num6
  is 'ȥ��ͬ���ۼ�����';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M3.value_num7
  is 'ͬ������';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M3.value_num8
  is 'ͬ������';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M3.value_num9
  is '����ռ�ձ�';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M3.value_num10
  is 'ȥ��ͬ��ռ�ձ�';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M3.value_num11
  is 'ռ�ձȱ仯';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M3.value_num12
  is '����3��������Ӧ���˿�';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M3.value_num13
  is '��������';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M3.value_num14
  is '��������';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M3.value_num15
  is '����ռ�ձ�';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M3.value_num16
  is 'ռ�ձȻ��ȱ仯';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M3.value_num17
  is '����ռӦ���˿��ܶ��';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M3.value_num18
  is 'ȥ��ͬ��ռӦ���˿��ܶ��';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M3.value_num19
  is '�ܶ�ռ�ȱ仯';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M3.value_num20
  is '����3��������Ӧ��ȫʡռ��';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M3.value_num21
  is 'ȥ��ͬ��3��������Ӧ��ȫʡռ��';
comment on column PU_BUSI_IND.BM_ACCOUNTS_RECV_M3.value_num22
  is 'ռ�ȱ仯';

---��ʱ�� ����Ӧ���˿�
truncate table pu_busi_ind.tmp1_Accounts_recv_m3;

insert into  pu_busi_ind.tmp1_Accounts_recv_m3  
select nvl(b.local_code, '9999') local_code,
       nvl(b.show_order2, 99) area_index,
       nvl(b.area_name, 'δ֪') area_name,
       case
         when id_zbcode in ('CWYSZL1118_04',
                            'CWYSZL1118_05',
                            'CWYSZL1118_06',
                            'CWYSZL1118_07',
                            'CWYSZL1118_18',
                            'CWYSZL1118_19',
                            'CWYSZL1118_20',
                            'CWYSZL1118_21') then
          '01'
         else
          '02'
       end tab_type,
       sum(case
             when id_zbcode in ('CWYSZL1118_18',
                                'CWYSZL1118_19',
                                'CWYSZL1118_20', 
                                'CWYSZL1101_18',
                                'CWYSZL1101_19',
                                'CWYSZL1101_20' ) then
              ID_VALUE
             else
              0
           end)/10000 ID_VALUE1, --����
           sum(case
             when id_zbcode in ( 'CWYSZL1118_21', 
                                'CWYSZL1101_21') then
              ID_VALUE
             else
              0
           end)/10000 ID_VALUE2, --�����ܶ�
       sum(case
             when id_zbcode in ('CWYSZL1118_04',
                                'CWYSZL1118_05',
                                'CWYSZL1118_06',
                                'CWYSZL1101_04',
                                'CWYSZL1101_05',
                                'CWYSZL1101_06') then
              ID_VALUE
             else
              0
           end) /10000 ID_VALUE11�� --ȥ��ͬ�� 
         sum(case
             when id_zbcode in ('CWYSZL1118_07',
                                'CWYSZL1101_07') then
              ID_VALUE
             else
              0
           end)/10000 ID_VALUE22 --ȥ��ͬ�� �ܶ�
  from PU_INTF.INTF_DATA_M@dl_edw_yn a, pu_meta.d_cw_area_info2 b
 where a.id_unitcode = b.jq_code(+)
   and a.month_no = '201701'
   and a.ID_UNITCODE<>'C0535500'---�˴���ȡʡ����
   and id_zbcode in ('CWYSZL1101_04',
                     'CWYSZL1101_05',
                     'CWYSZL1101_06',
                     'CWYSZL1101_07',
                     'CWYSZL1101_18',
                     'CWYSZL1101_19',
                     'CWYSZL1101_20',
                     'CWYSZL1101_21',
                     'CWYSZL1118_04',
                     'CWYSZL1118_05',
                     'CWYSZL1118_06',
                     'CWYSZL1118_07',
                     'CWYSZL1118_18',
                     'CWYSZL1118_19',
                     'CWYSZL1118_20' �� 'CWYSZL1118_21')
 group by nvl(b.local_code, '9999'),
          nvl(b.show_order2, 99),
          nvl(b.area_name, 'δ֪'),
          case
            when id_zbcode in ('CWYSZL1118_04',
                               'CWYSZL1118_05',
                               'CWYSZL1118_06',
                               'CWYSZL1118_07',
                               'CWYSZL1118_18',
                               'CWYSZL1118_19',
                               'CWYSZL1118_20',
                               'CWYSZL1118_21') then
             '01'
            else
             '02'
          end;
commit;

----ʡ����ʡ�̿ͷ�����Ӧ���˿���û�Ƿ��
insert into pu_busi_ind.tmp1_Accounts_recv_m3
select
  area_code,
  show_order2 area_index,
  area_name, 
  '01',
  sum(case when fee_type='01' 
           and MONTH_NO='201701' 
           AND FEE_MONTH<'201610' 
           THEN amount_real 
      ELSE 0 END )/10000  ,  
  sum(case when fee_type='01' 
           and MONTH_NO='201701'  
           AND FEE_MONTH<'201701'  
           THEN amount_real
       when fee_type='02' 
        and MONTH_NO='201701'  
        AND FEE_MONTH='201701'  
        THEN amount_real
      ELSE 0 END )/10000 this_month ,  
  sum(case when fee_type='01' 
           and MONTH_NO='201601' 
           AND FEE_MONTH<'201510' 
           THEN amount_real 
      ELSE 0 END )/10000 last_year,
  sum(case when fee_type='01' 
           and MONTH_NO='201601' 
           AND FEE_MONTH<'201601' 
           THEN amount_real
       when fee_type='02' 
        and MONTH_NO='201601' 
        AND FEE_MONTH='201601' 
        THEN amount_real
      ELSE 0 END )/10000 last_year
  from PU_BUSI_IND.BM_OWN_FEE_AGE_M a,
  pu_meta.d_cw_area_info2 b
  where a.area_code=b.local_code(+) 
  and a.month_no in('201701','201601')
group by area_code,
  show_order2 ,
  area_name
union all
select
  area_code,
  show_order2 area_index,
  area_name, 
  '02',
  sum(case when fee_type='01' 
           and MONTH_NO='201701' 
           AND FEE_MONTH<'201610' 
           THEN amount_real 
      ELSE 0 END )/10000  ,  
  sum(case when fee_type='01' 
           and MONTH_NO='201701'  
           AND FEE_MONTH<'201701'  
           THEN amount_real
       when fee_type='02' 
        and MONTH_NO='201701'  
        AND FEE_MONTH='201701'  
        THEN amount_real
      ELSE 0 END )/10000 this_month ,  
  sum(case when fee_type='01' 
           and MONTH_NO='201601' 
           AND FEE_MONTH<'201510' 
           THEN amount_real 
      ELSE 0 END )/10000 last_year,
  sum(case when fee_type='01' 
           and MONTH_NO='201601' 
           AND FEE_MONTH<'201601' 
           THEN amount_real
       when fee_type='02' 
        and MONTH_NO='201601' 
        AND FEE_MONTH='201601' 
        THEN amount_real
      ELSE 0 END )/10000 last_year
  from PU_BUSI_IND.BM_OWN_FEE_AGE_M a,
  pu_meta.d_cw_area_info2 b
  where a.area_code=b.local_code(+) 
  and a.month_no in('201701','201601')
group by area_code,
  show_order2 ,
  area_name;
commit;

 
----����
insert into pu_busi_ind.tmp1_Accounts_recv_m3
select '9011',
21,
'���У�����',
'01',
sum(case when local_code ='0871' then id_value1 else -id_value1 end),
sum(case when local_code ='0871' then id_value1 else -id_value2 end),
sum(case when local_code ='0871' then id_value1 else -id_value11 end),
sum(case when local_code ='0871' then id_value1 else -id_value22 end) 
from pu_busi_ind.tmp1_Accounts_recv_m3
where local_code in('0871','9008','9010')
union all
select '9011',
21,
'���У�����',
'02',
sum(case when local_code ='0871' then id_value1 else -id_value1 end),
sum(case when local_code ='0871' then id_value1 else -id_value2 end),
sum(case when local_code ='0871' then id_value1 else -id_value11 end),
sum(case when local_code ='0871' then id_value1 else -id_value22 end) 
from pu_busi_ind.tmp1_Accounts_recv_m3
where local_code in('0871','9008','9010');
commit;


truncate table pu_busi_ind.tmp2_Accounts_recv_m3 ;
insert into pu_busi_ind.tmp2_Accounts_recv_m3 
select 
a.tab_type,	--01��Ӧ���˿�  02���û�Ƿ��
b.data_type	  ,--01����Ӫ����  02������׼������
'201701' month_no	  ,
a.local_code	  ,
a.area_index	,
a.area_name	  ,
ID_VALUE1 value_num1	,--����3��������Ӧ���˿�
ID_VALUE2 value_num2	,--����Ӧ���˿��ܶ�
b.charge_year3 value_num3	,--�����ۼ�����
ID_VALUE11 value_num4	,--ȥ��ͬ��3��������Ӧ���ʿ�
ID_VALUE22 value_num5	,--ȥ��ͬ��Ӧ���ʿ��ܶ�
b.charge_year31 value_num6	,--ȥ��ͬ���ۼ�����
ID_VALUE1-ID_VALUE11 value_num7	,--ͬ������
decode(ID_VALUE11,0,0,ID_VALUE1/ID_VALUE11) value_num8	,--ͬ������
decode(b.charge_year3,0,0,ID_VALUE1/b.charge_year3)*(1/12) value_num9	,--����ռ�ձ�
decode(b.charge_year31,0,0,ID_VALUE11/b.charge_year31)*(1/12) value_num10	,--ȥ��ͬ��ռ�ձ�
decode(b.charge_year3,0,0,ID_VALUE1/b.charge_year3)*(1/12)-
decode(b.charge_year31,0,0,ID_VALUE11/b.charge_year31)*(1/12) value_num11--ռ�ձȱ仯
from pu_busi_ind.tmp1_Accounts_recv_m3 a,
pu_busi_ind.bm_charge_all_m b
where a.local_code=b.area_code(+)
and b.month_no(+)='201701';
commit;

truncate table pu_busi_ind.tmp3_Accounts_recv_m3;
insert into pu_busi_ind.tmp3_Accounts_recv_m3  
select a.*,
       b.value_num1 value_num12, --����3��������Ӧ���˿�
       a.value_num1 - b.value_num1 value_num13, --��������
       decode(b.value_num1, 0, 0, a.value_num1 / b.value_num1 - 1) value_num14, --��������
       b.value_num9 value_num15, --����ռ�ձ�
       a.value_num9 - b.value_num9 value_num16, --ռ�ձȻ��ȱ仯
       decode(a.value_num2, 0, 0, a.value_num1 / a.value_num2) value_num17, --����ռӦ���˿��ܶ��
       decode(a.value_num5, 0, 0, a.value_num4 / a.value_num5) value_num18, --ȥ��ͬ��ռӦ���˿��ܶ��
       decode(a.value_num2, 0, 0, a.value_num1 / a.value_num2) -
       decode(a.value_num5, 0, 0, a.value_num4 / a.value_num5) value_num19, --�ܶ�ռ�ȱ仯
       decode(c.value_num2, 0, 0, a.value_num1 / c.value_num2) value_num20, --����3��������Ӧ��ȫʡռ��
       decode(c.value_num5, 0, 0, a.value_num4 / c.value_num5) value_num21, --ȥ��ͬ��3��������Ӧ��ȫʡռ��
       decode(a.value_num5, 0, 0, a.value_num4 / a.value_num5) -
       decode(c.value_num2, 0, 0, a.value_num1 / c.value_num2) value_num22 --ռ�ȱ仯
  from pu_busi_ind.tmp2_Accounts_recv_m3 a
  left join PU_BUSI_IND.BM_ACCOUNTS_RECV_M3 b
    on a.tab_type = b.tab_type
   and a.data_type = b.data_type
   and a.local_code=b.area_code
   and b.month_no = '201612'
  left join pu_busi_ind.tmp2_Accounts_recv_m3 c
    on a.tab_type = c.tab_type
   and a.data_type = c.data_type
   and c.local_code = '9998';
commit;
 
   
delete from PU_BUSI_IND.BM_ACCOUNTS_RECV_M3 where month_no='201701';
commit;
insert into PU_BUSI_IND.BM_ACCOUNTS_RECV_M3
select * 
from pu_busi_ind.tmp3_Accounts_recv_m3;
commit;



select * from PU_BUSI_IND.BM_ACCOUNTS_RECV_M3
where month_no='201701'
and tab_type='01'
and data_type='01'


 select * from PU_INTF.INTF_DATA_M@DL_EDW_YN 
where month_no='201701'
and id_zbcode like'%CWYSZL1118%'
and id_unitcode='530103757190184'

create table 
 
 
