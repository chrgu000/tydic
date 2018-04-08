
-----1
select
   A.AREA_NAME 分公司,   
   SUM(A.DEV_NUM) 发展数, --发展数
  
   SUM(A.XJ_2018_NUM)/  SUM(A.DEV_NUM) 疑似虚假占比,   --虚假占比   
     
    SUM(A.JKPP_NUM)/  SUM(A.DEV_NUM) 机卡匹配占比, --机卡匹配占比 
    
    sum (A.NO_BLANCE_NUM)/SUM(A.DEV_NUM) 无预存占比  --无预存占比
    
  from pu_busi_ind.bm_serv_dev_d_new  A      
       GROUP BY A.AREA_NAME;
       
------2
select
   a.AREA_NAME 分公司,   
   SUM(A.DEV_NUM) 发展数, --发展数     
   
   SUM(A.XJ_2018_NUM)/  SUM(A.DEV_NUM) 疑似虚假占比,   --虚假占比   
     
   SUM(A.JKPP_NUM)/  SUM(A.DEV_NUM) 机卡匹配占比, --机卡匹配占比 
    
   SUM(A.LJ_DEV_NUM)累计发展   --累计发展  
    
 from pu_busi_ind.bm_serv_dev_d_new  A    
     WHERE A.IS_ZL=1    --战狼
    GROUP BY A.AREA_NAME ;
 

--------3
select
   A.AREA_NAME 分公司,  
   A.STD_AREA_NAME 区县,--区县
   A.BRANCH_NAME4 支局,--支局
   A.DVLP_STAFF_ID 揽收工号, --揽收工号
   A.DVLP_STAFF_NAME 揽收人, --揽收人      
   SUM(A.DEV_NUM) 发展数, --发展数        
   SUM(A.XJ_2018_NUM)/ SUM(A.DEV_NUM) 疑似虚假占比,   --虚假占比     
   SUM(A.LJ_DEV_NUM)累计发展   --累计发展 
 from pu_busi_ind.bm_serv_dev_d_new  A    
    WHERE A.IS_ZL=1    --战狼
      AND A.AREA_NAME<>'全省'
      GROUP BY A.AREA_NAME,
       A.STD_AREA_NAME,--区县
       A.BRANCH_NAME4 ,--支局
       A.DVLP_STAFF_ID, --揽收工号
       A.DVLP_STAFF_NAME  --揽收人  
    HAVING 
     SUM(A.DEV_NUM)>10  --月发展超过10
     AND SUM(A.XJ_2018_NUM)/ SUM(A.DEV_NUM)>0.5     --疑似虚假占比超过50%
   ORDER BY A.AREA_NAME; 
