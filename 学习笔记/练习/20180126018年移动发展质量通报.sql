
-----1
select
   A.AREA_NAME �ֹ�˾,   
   SUM(A.DEV_NUM) ��չ��, --��չ��
  
   SUM(A.XJ_2018_NUM)/  SUM(A.DEV_NUM) �������ռ��,   --���ռ��   
     
    SUM(A.JKPP_NUM)/  SUM(A.DEV_NUM) ����ƥ��ռ��, --����ƥ��ռ�� 
    
    sum (A.NO_BLANCE_NUM)/SUM(A.DEV_NUM) ��Ԥ��ռ��  --��Ԥ��ռ��
    
  from pu_busi_ind.bm_serv_dev_d_new  A      
       GROUP BY A.AREA_NAME;
       
------2
select
   a.AREA_NAME �ֹ�˾,   
   SUM(A.DEV_NUM) ��չ��, --��չ��     
   
   SUM(A.XJ_2018_NUM)/  SUM(A.DEV_NUM) �������ռ��,   --���ռ��   
     
   SUM(A.JKPP_NUM)/  SUM(A.DEV_NUM) ����ƥ��ռ��, --����ƥ��ռ�� 
    
   SUM(A.LJ_DEV_NUM)�ۼƷ�չ   --�ۼƷ�չ  
    
 from pu_busi_ind.bm_serv_dev_d_new  A    
     WHERE A.IS_ZL=1    --ս��
    GROUP BY A.AREA_NAME ;
 

--------3
select
   A.AREA_NAME �ֹ�˾,  
   A.STD_AREA_NAME ����,--����
   A.BRANCH_NAME4 ֧��,--֧��
   A.DVLP_STAFF_ID ���չ���, --���չ���
   A.DVLP_STAFF_NAME ������, --������      
   SUM(A.DEV_NUM) ��չ��, --��չ��        
   SUM(A.XJ_2018_NUM)/ SUM(A.DEV_NUM) �������ռ��,   --���ռ��     
   SUM(A.LJ_DEV_NUM)�ۼƷ�չ   --�ۼƷ�չ 
 from pu_busi_ind.bm_serv_dev_d_new  A    
    WHERE A.IS_ZL=1    --ս��
      AND A.AREA_NAME<>'ȫʡ'
      GROUP BY A.AREA_NAME,
       A.STD_AREA_NAME,--����
       A.BRANCH_NAME4 ,--֧��
       A.DVLP_STAFF_ID, --���չ���
       A.DVLP_STAFF_NAME  --������  
    HAVING 
     SUM(A.DEV_NUM)>10  --�·�չ����10
     AND SUM(A.XJ_2018_NUM)/ SUM(A.DEV_NUM)>0.5     --�������ռ�ȳ���50%
   ORDER BY A.AREA_NAME; 
