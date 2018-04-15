---Ƿ������ͳ�� ������ �ֹ�
create table pu_intf.f_owe_month_dzj_m
(data_type number,
 month_no varchar2(6),
 area_code varchar2(30),
 area_name varchar2(30),
 owe_fee1 number,
 owe_fee2 number,
 owe_fee3 number,
 owe_fee4 number,
 owe_fee5 number,
 owe_fee6 number,
 owe_fee7 number
)
--������������201706��ʽ�仯
create table pu_intf.f_owe_month_dzj_m2  
(data_type number,
 month_no varchar2(6),
 area_code varchar2(30),
 area_name varchar2(30),
 owe_fee1 number,
 owe_fee2 number,
 owe_fee3 number,
 owe_fee4 number,
 owe_fee5 number,
 owe_fee6 number,
 owe_fee7 number,
 owe_fee8 number,
 owe_fee9 number,
 owe_fee10 number
)

---Ӫҵ������嵥�� �ֹ�
create table pu_intf.f_business_balance_m
( month_no varchar2(6),
  index_num number,
  area_code varchar2(30),
  area_name varchar2(30),
  end_balance number,
  ddwfx_balance number,
  other_balance number,
  checks varchar2(30),
  Remarks varchar2(30),
  end_balance_last number,
  end_balance_increase number,
  end_balance_hb number,
  ddwfx_balance_last number,
  ddwfx_balance_increase number,
  ddwfx_balance_hb number,
  begging_balance number,
  begging_balance_increase number,
  begging_balance_hb number 
)

---ʡ���� ʡ�̿;�Ӫ����ӿ�  ͨ��ҳ���ֹ�����
create table pu_intf.f_charge_jysr_m
(month_no varchar2(6),
 area_code varchar2(10),
 area_name varchar2(20),
 kpi_code  varchar2(10),
 kpi_name varchar2(50),
 kpi_value1 number,
 kpi_value2 number)

select * from pu_intf.f_charge_jysr_m where month_NO='201702' for update 

----��Ӫ����Űٻ�������������
pu_intf.f_charge_haobai_km 

----��Ȩ�� �ֹ�һ�굹һ��
CREATE TABLE pu_intf.f_Accounts_receiv_y
(year_no varchar2(4), 
 local_code varchar2(6),
 VALUE_NUM1  NUMBER,
 VALUE_NUM2  NUMBER,
 VALUE_NUM3  NUMBER,
 VALUE_NUM4  NUMBER,
 VALUE_NUM5  NUMBER,
 VALUE_NUM6  NUMBER,
 VALUE_NUM7  NUMBER,
 VALUE_NUM8  NUMBER,
 VALUE_NUM9  NUMBER,
 VALUE_NUM10  NUMBER,
 VALUE_NUM11  NUMBER,
 VALUE_NUM12  NUMBER) 

select * from  pu_intf.f_Accounts_receiv_y for update

---����׼��Ԥ��ֵ
create table pu_intf.f_Bad_debt_budget_y
(year_no varchar2(4),
area_code varchar2(10),
area_name varchar2(15),
budget_value number)

 

---ʡ�����̿ͷ�����
pu_busi_ind.bm_own_fee_age_m

---- ʡ���� ʡ�̿���ʷӦ���˿�û�Ƿ�ѣ���
create table pu_busi_ind.bm_own_fee_age_m2
(month_no	varchar2(6),
area_code	varchar2(6),
area_name	varchar2(16),
charge_type	varchar2(6),
id_value1	number,
id_value2	number,
id_value11	number
)
------------------------------------------------begin------------------------------------------------
---�����̣�
         
  --  1�����ֻ���Ƿ��(RULE_ID:300030049)
  --  ->���չܿ� ����Ƿ�����ݣ�pu_busi_ind.p_bm_Accounts_recv_m10 �ղ��� ÿ��7���� ETL(����Ƿ�Ѽ��û�������)
  --  ->ʡ�����̿�Ƿ������(���� pu_busi_ind.p_bm_own_fee_age_m)
       -- �����ֹ����ݵ�area_code
  --  2��alter table PU_INTF.INTF_DATA_M2 add partition p201707 values('201707'); ��������� -->ִ�д��PU_INTF.p_INTF_DATA_M2�� 11������ȡ�� ����
  --  ->���չܿ�Ӧ���˿�����(ETL--Ӧ���˿������)-->����ǰ̨����
--------------------------------------------------end-------------------------------------------------


------------------------------------����һ���������ñ�------------------------------------------
          -----���ñ�����Ӧ�ĳ����ű�----
  select t.*, rowid
  from META_SYS_MG.META_TAB_LEVL t
    where  TASK_NAME LIKE '%��Ӫ����%'
  order by TASK_ID, SHEET_ID;
 
 select t.*, rowid
  from META_SYS_MG.META_TAB_LEVL t
    where  TASK_NAME LIKE '%��Ӫ����%'
  order by TASK_ID, SHEET_ID;
 
 
 
------------------------------ �����ֹ����ݵ�area_code--------------------------------------------
-----���µ��б���
--�����������ű�PU_INTF.F_OWE_MONTH_DZJ_M  201705֮���ṹ�б� �����øñ�201705֮ǰ���ݵ�ʱ����PU_INTF.F_OWE_MONTH_DZJ_M��

----------- select * from PU_INTF.F_OWE_MONTH_DZJ_M2 a where a.month_no='201711' ;
update PU_INTF.F_OWE_MONTH_DZJ_M2 a
   set area_code =
         (select local_code
            from pu_meta.d_cw_area_info2 b
           where trim(decode(a.area_name,
                        '�Ű�',
                        '�Ű٣����²���',
                        '�ϼ�',
                        'ȫʡ',
                        a.area_name)) = trim(b.area_name)) 
    where a.month_no='201711' ;
    commit;

update PU_INTF.F_OWE_MONTH_DZJ_M2 
set area_name=trim(replace(replace(area_name,chr(13),''), chr(10),''))
where month_no='201711';
commit; 

----------------- select * from  pu_intf.f_business_balance_m  a where a.month_no='201711';
update pu_intf.f_business_balance_m  a
   set area_code =
         (select local_code
            from pu_meta.d_cw_area_info2 b
           where trim(decode(a.area_name,
                        '�Ű�',
                        '�Ű٣����²���',
                        'ȫʡ�����ܣ�',
                        'ȫʡ', 
                        a.area_name)) = trim(b.area_name))
    where a.month_no='201711';
    commit;
    
--�޸����ĵ����еĻس��������з�
update PU_INTF.F_BUSINESS_BALANCE_M 
set area_name=trim(replace(replace(area_name,chr(13),''), chr(10),''))
where month_no='201711';
commit;




--�������ݣ�
�ӿ�����
��Ӫ����ģ�壨���֣�
Ƿ�ѻ������ݣ����֣�300030049
pu_busi_ind.p_bm_Accounts_recv_m10(����pu_base_ind.DM_OWE_KN_NEW03) ����Ƿ������ �ղ��� --fxgk
ʡ�����̿�Ƿ������(����) 600010040
ʡ�����̿�Ƿ������(���չܿ�) pu_busi_ind.p_bm_own_fee_age_m  pu_busi_ind.bm_own_fee_age_m2 ������ʷ���ݵ�ʱ����Ҫ�����ܾ��ֵ�Ƿ�ѻ�������

pu_busi_ind.p_bm_Accounts_recv_m1 �����������������ɳ���� ���Ǻ���1��10������������� select * from PU_INTF.INTF_DATA_M2@DL_EDW_YN where month_no=201711 and ID_ZBCODE='CWYSMX1200_03';
pu_busi_ind.p_bm_Accounts_recv_m2 
pu_busi_ind.p_bm_Accounts_recv_m3  
pu_busi_ind.p_bm_Accounts_recv_m4 �����������3
pu_busi_ind.p_bm_Accounts_recv_m5 
pu_busi_ind.p_bm_Accounts_recv_m6 
pu_busi_ind.p_bm_Accounts_recv_m7 
pu_busi_Ind.p_bm_Accounts_recv_m8 

------------------  
  declare
  v_date varchar2(6);
  begin
  v_date :='201705'; -- ��������
  --Call the procedure
  pu_busi_ind.p_bm_Accounts_recv_m1(v_date);
  pu_busi_ind.p_bm_Accounts_recv_m2(v_date);
  pu_busi_ind.p_bm_Accounts_recv_m3(v_date);
  pu_busi_ind.p_bm_Accounts_recv_m4(v_date);
  pu_busi_ind.p_bm_Accounts_recv_m5(v_date);
  pu_busi_ind.p_bm_Accounts_recv_m6(v_date); 
  pu_busi_ind.p_bm_Accounts_recv_m7(v_date); 
  pu_busi_ind.p_bm_Accounts_recv_m8(v_date);  
  end;
  