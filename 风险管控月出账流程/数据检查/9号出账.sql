
select * from pu_meta.etl_program_rule where rule_id='3003186';---����� 

---����Ƿ�Ѽ��û�������   pu_busi_ind.p_bm_accounts_recv_m10

-- Դ��----------
SELECT * FROM  PU_INTF.WT_SERV_OWE_M_201802_ZML 
SELECT * FROM  PU_INTF.I_IN_KG_SERV_GRID Partition(P201802) 

SELECT * FROM  PU_INTF.I_IN_HX_ZD_ORG_BRANCH Where DATE_NO ='20180307'

SELECT * FROM PU_WT.WT_SERV_SHZ_ALL_201802

SELECT * FROM  PU_WT.WT_BRANCH_TYPE_TZ_LIST

--------Ŀ���
SELECT * FROM  PU_busi_IND.bm_OWE_KN_NEW03 PARTITION (P201802)
----------------

---ʡ�̿�Ƿ������� ������
SELECT * FROM  pu_wt.rpt_owe_ssk_xzq;  --����ǰ

SELECT * FROM  pu_wt.rpt_owe_ssk_xzh;  --���˺�
 
---ʡ����ͻ���ֱ�ܿͻ�Ƿ������� ������

SELECT * FROM  pu_wt.rpt_owe_szq_xzq_201802; --����ǰ

SELECT * FROM  pu_wt.rpt_owe_szq_xzh_201802;  --���˺�


----Ƿ��ͳ��-I��ͻ�(16�¿ھ�)������
SELECT * FROM  pu_wt.tmp_owe_age_count2  Order By AREA_NAME;

 ------  ������Ƿ�ѣ�16�¿ھ��������� (���ֿ�)
 SELECT * FROM  ly.rpt_owe_flh_201802 
 
 

 
 
 
