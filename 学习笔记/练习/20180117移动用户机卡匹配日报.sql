

/*
1��ͳ�����棬һ����ȫ���ģ�һ�����޳����Ʒ�չ����
2����Ԥ���ָ��С�� 20Ԫ��С��50Ԫ������׼
3��ͳ��1-17�ŵ������û�

*/


/*
1��ͳ�����棬һ����ȫ���ģ�һ�����޳����Ʒ�չ����
2�������еĻ���ƥ���׼
3��ͳ��1-17�ŵ������û�

"*/	


select * from PU_WT.WT_SERV_C_D_201801
		
select * from PU_WT.tmp_SERV_C_D_20180117

select 	a.area_code,a.����,a.date_no,a.�û�����ʱ��,a.�Ƿ����ƥ��, a.����Ԥ����,a.�Ƿ��Ԥ��,a.is_dev_flag 
     from PU_WT.tmp_SERV_C_D_20180117 a 
    



--------------
select a.����,
       count( distinct a.�豸��) ��չ��, --��չ��
       sum(decode(a.�Ƿ����ƥ��,'��',0,1)) ����ƥ����, --����ƥ����
       sum(decode(a.�Ƿ����ƥ��,'��',0,1))/count( distinct a.�豸��) ƥ��ռ��  --ƥ��ռ��
  from PU_WT.tmp_SERV_C_D_20180117 a 
  where ��a.�û�����ʱ�� between '20180101' and '20180117'�� --
       --  and nvl( a.is_dev_flag,1)=1  --�Ƿ�Ʒ�չ  0 _��  1��� _��
  group by a.���� 
  order by a.���� 
----------------  
  
  

PU_WT.P_WT_BIL_JTHZ_REC_D_LIST --line 253


select * from PU_WT.WT_BIL_JTHZ_REC_D_LIST Partition(P20180118)

 select * from PU_WT.WT_BIL_JTHZ_LIST_D Partition(P20180118)
 
 select * from TMP_BIL_JTHZ_REC_D4 A
 select * from  PU_WT.F_1_SERV_D_JF A1
 
 
  Select b.DATE_NO,
             b.AREA_CODE,
             b.AREA_NAME,
             b.BRANCH_NAME2,
             b.BRANCH_CODE3,
             b.BRANCH_NAME3,
             b.BRANCH_CODE4,
             b.BRANCH_NAME4,
             b.BRANCH_CODE5,
             b.BRANCH_NAME5,
             Decode(b.CUST_GROUP_TZ, '����', '����', 'ʵ��') CHANNEL_TYPE,
             A.SERV_ID,
             b.ACC_NBR,
             MONTH_AMOUNT_JTHZ / 100 MONTH_AMOUNT_JTHZ,
             DAY_AMOUNT_JTHZ / 100 DAY_AMOUNT_JTHZ,
             A1.ACCT_ID,  ---20170518wrm���Ӻ�ͬ��id��ͬ�����������ֶ�
             A1.ACCT_NAME
        From TMP_BIL_JTHZ_REC_D4 A,
             PU_WT.F_1_SERV_D_JF A1�� ---20170518wrm����
            PU_WT.WT_BIL_JTHZ_LIST_D Partition(P20180118) B
       Where A.SERV_ID=A1.SERV_ID(+)
       AND A.SERV_ID = B.SERV_ID(+) and
         b.DATE_NO is null
           

  
  
  
  
  
