select * from PU_WT.WT_SERV_C_D_201801 partition(p20180119)

--------  1
SELECT 
     NVL(A.����,'ȫʡ'),    
     
    COUNT(DISTINCT A.�豸��) ��չ��, --��չ��
     
    SUM( DECODE( A.�Ƿ����2018,'��',1,0))/ COUNT(DISTINCT A.�豸��)���ռ��, --���ռ��
     
    SUM(DECODE( A.�Ƿ����ƥ��,'��',1,0))/ COUNT(DISTINCT A.�豸��) ����ƥ��ռ��, --����ƥ��ռ��
       
    SUM(DECODE(NVL(A.����Ԥ����,0),0,1,0))/ COUNT(DISTINCT A.�豸��) ��Ԥ��ռ��  --��Ԥ��ռ��
   
    FROM PU_WT.WT_SERV_C_D_201801 partition(p20180119) A
    
  WHERE A.�û�����ʱ�� BETWEEN '20180101' AND '20180113'
     GROUP BY ROLLUP(A.����)
  
------2
  SELECT 
     NVL(A.����,'ȫʡ'),      
     A.�����г�,  
     
   COUNT(DISTINCT A.�豸��) ��չ��, --��չ��
     
    SUM( DECODE( A.�Ƿ����2018,'��',1,0)) �����, --���
     
    SUM(DECODE( A.�Ƿ����ƥ��,'��',1,0)) ����ƥ����, --����ƥ��
       
    SUM(DECODE(NVL(A.����Ԥ����,0),0,1,0)) ��Ԥ����  --��Ԥ��
   
    FROM PU_WT.WT_SERV_C_D_201801 partition(p20180119) A
    
  WHERE A.�û�����ʱ�� BETWEEN '20180101' AND '20180113'
     GROUP BY ROLLUP(A.����),
      A.�����г�  
  ORDER BY A.����,A.�����г�  
  
----3
  
   SELECT 
    NVL(A.����,'ȫʡ'),       
   A.���߱�ʾ,     
   COUNT(DISTINCT A.�豸��) ��չ��, --��չ��
     
    SUM( DECODE( A.�Ƿ����2018,'��',1,0)) �����, --���
     
    SUM(DECODE( A.�Ƿ����ƥ��,'��',1,0)) ����ƥ����, --����ƥ��
       
    SUM(DECODE(NVL(A.����Ԥ����,0),0,1,0)) ��Ԥ����  --��Ԥ��
   
    FROM PU_WT.WT_SERV_C_D_201801 partition(p20180119) A
    
  WHERE A.�û�����ʱ�� BETWEEN '20180101' AND '20180113'
       AND A.���߱�ʾ IS NOT NULL
     GROUP BY ROLLUP(A.����),
            A.���߱�ʾ
  ORDER BY A.����, A.���߱�ʾ
  
