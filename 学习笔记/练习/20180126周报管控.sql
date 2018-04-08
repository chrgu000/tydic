select * from PU_WT.WT_SERV_C_D_201801 partition(p20180119)

--------  1
SELECT 
     NVL(A.地市,'全省'),    
     
    COUNT(DISTINCT A.设备号) 发展量, --发展量
     
    SUM( DECODE( A.是否虚假2018,'是',1,0))/ COUNT(DISTINCT A.设备号)虚假占比, --虚假占比
     
    SUM(DECODE( A.是否机卡匹配,'是',1,0))/ COUNT(DISTINCT A.设备号) 机卡匹配占比, --机卡匹配占比
       
    SUM(DECODE(NVL(A.入网预存金额,0),0,1,0))/ COUNT(DISTINCT A.设备号) 无预存占比  --无预存占比
   
    FROM PU_WT.WT_SERV_C_D_201801 partition(p20180119) A
    
  WHERE A.用户创建时间 BETWEEN '20180101' AND '20180113'
     GROUP BY ROLLUP(A.地市)
  
------2
  SELECT 
     NVL(A.地市,'全省'),      
     A.消费市场,  
     
   COUNT(DISTINCT A.设备号) 发展量, --发展量
     
    SUM( DECODE( A.是否虚假2018,'是',1,0)) 虚假数, --虚假
     
    SUM(DECODE( A.是否机卡匹配,'是',1,0)) 机卡匹配数, --机卡匹配
       
    SUM(DECODE(NVL(A.入网预存金额,0),0,1,0)) 无预存数  --无预存
   
    FROM PU_WT.WT_SERV_C_D_201801 partition(p20180119) A
    
  WHERE A.用户创建时间 BETWEEN '20180101' AND '20180113'
     GROUP BY ROLLUP(A.地市),
      A.消费市场  
  ORDER BY A.地市,A.消费市场  
  
----3
  
   SELECT 
    NVL(A.地市,'全省'),       
   A.政策标示,     
   COUNT(DISTINCT A.设备号) 发展量, --发展量
     
    SUM( DECODE( A.是否虚假2018,'是',1,0)) 虚假数, --虚假
     
    SUM(DECODE( A.是否机卡匹配,'是',1,0)) 机卡匹配数, --机卡匹配
       
    SUM(DECODE(NVL(A.入网预存金额,0),0,1,0)) 无预存数  --无预存
   
    FROM PU_WT.WT_SERV_C_D_201801 partition(p20180119) A
    
  WHERE A.用户创建时间 BETWEEN '20180101' AND '20180113'
       AND A.政策标示 IS NOT NULL
     GROUP BY ROLLUP(A.地市),
            A.政策标示
  ORDER BY A.地市, A.政策标示
  
