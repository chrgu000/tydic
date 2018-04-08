---欠费收入

SELECT /*+parallel(a,4)*/
       b.order_no 序号,
       A.AREA_CODE1 区号,
       B.area_name 分公司,
      --总欠费
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') = '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM')THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') <= '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       --存量
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM')THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'THEN a.AMOUNT_REAL ELSE 0 END)/SUM(a.AMOUNT_REAL),
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'AND a.billing_mode_id = 1 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 yff_amount,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'AND a.billing_mode_id = 2 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 hff_amount,
       --增量
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/SUM(a.AMOUNT_REAL),
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 1 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 yff_amount,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 2 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 hff_amount,
       --正常
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       --单停
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --双停
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --拆机
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --活卡 
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       --挂失
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --I类
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000                  
FROM TMP_OWE_KN_NEW03 a
LEFT JOIN pu_meta.latn_new_order b ON A.AREA_CODE1 = b.local_code
WHERE a.cust_group_TZ='政企'
GROUP BY b.order_no,A.AREA_CODE1,B.area_name
ORDER BY b.order_no;


SELECT /*+parallel(a,4)*/
       b.order_no 序号,
       A.AREA_CODE1 区号,
       B.area_name 分公司,
      --总欠费
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') = '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM')THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') <= '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       --存量
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM')THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'THEN a.AMOUNT_REAL ELSE 0 END)/SUM(a.AMOUNT_REAL),
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'AND a.billing_mode_id = 1 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 yff_amount,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'AND a.billing_mode_id = 2 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 hff_amount,
       --增量
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/SUM(a.AMOUNT_REAL),
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 1 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 yff_amount,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 2 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 hff_amount,
       --正常
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       --单停
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --双停
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --拆机
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --活卡 
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       --挂失
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --I类
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000                  
FROM TMP_OWE_KN_NEW03 a
LEFT JOIN pu_meta.latn_new_order b ON A.AREA_CODE1 = b.local_code
WHERE a.cust_group_TZ='公众'
GROUP BY b.order_no,A.AREA_CODE1,B.area_name
ORDER BY b.order_no;


SELECT /*+parallel(a,4)*/
       b.order_no 序号,
       A.AREA_CODE1 区号,
       B.area_name 分公司,
      --总欠费
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') = '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM')THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') <= '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       --存量
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM')THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'THEN a.AMOUNT_REAL ELSE 0 END)/SUM(a.AMOUNT_REAL),
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'AND a.billing_mode_id = 1 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 yff_amount,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'AND a.billing_mode_id = 2 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 hff_amount,
       --增量
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/SUM(a.AMOUNT_REAL),
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 1 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 yff_amount,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 2 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 hff_amount,
       --正常
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       --单停
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --双停
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --拆机
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --活卡 
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       --挂失
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --I类
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000                  
FROM TMP_OWE_KN_NEW03 a
LEFT JOIN pu_meta.latn_new_order b ON A.AREA_CODE1 = b.local_code
WHERE a.cust_group_TZ='其他'
GROUP BY b.order_no,A.AREA_CODE1,B.area_name
ORDER BY b.order_no;

---全省


SELECT /*+parallel(a,4)*/
      --总欠费
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') = '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM')THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') <= '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       --存量
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM')THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'THEN a.AMOUNT_REAL ELSE 0 END)/SUM(a.AMOUNT_REAL),
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'AND a.billing_mode_id = 1 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 yff_amount,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'AND a.billing_mode_id = 2 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 hff_amount,
       --增量
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/SUM(a.AMOUNT_REAL),
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 1 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 yff_amount,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 2 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 hff_amount,
       --正常
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       --单停
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --双停
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --拆机
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --活卡 
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       --挂失
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --I类
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000                  
FROM TMP_OWE_KN_NEW03 a
WHERE a.cust_group_TZ='政企';



SELECT /*+parallel(a,4)*/
      --总欠费
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') = '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM')THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') <= '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       --存量
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM')THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'THEN a.AMOUNT_REAL ELSE 0 END)/SUM(a.AMOUNT_REAL),
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'AND a.billing_mode_id = 1 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 yff_amount,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'AND a.billing_mode_id = 2 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 hff_amount,
       --增量
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/SUM(a.AMOUNT_REAL),
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 1 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 yff_amount,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 2 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 hff_amount,
       --正常
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       --单停
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --双停
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --拆机
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --活卡 
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       --挂失
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --I类
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000                  
FROM TMP_OWE_KN_NEW03 a
WHERE a.cust_group_TZ='公众';


SELECT /*+parallel(a,4)*/
      --总欠费
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') = '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM')THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') <= '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       --存量
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM')THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'THEN a.AMOUNT_REAL ELSE 0 END)/SUM(a.AMOUNT_REAL),
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'AND a.billing_mode_id = 1 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 yff_amount,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'AND a.billing_mode_id = 2 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 hff_amount,
       --增量
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/SUM(a.AMOUNT_REAL),
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 1 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 yff_amount,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 2 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 hff_amount,
       --正常
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       --单停
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --双停
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --拆机
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --活卡 
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       --挂失
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --I类
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000                  
FROM TMP_OWE_KN_NEW03 a
WHERE a.cust_group_TZ='其他';


---合并
---欠费收入

SELECT /*+parallel(a,4)*/
       b.order_no 序号,
       A.AREA_CODE1 区号,
       B.area_name 分公司,
      --总欠费
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') = '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM')THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') <= '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       --存量
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM')THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'THEN a.AMOUNT_REAL ELSE 0 END)/SUM(a.AMOUNT_REAL),
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'AND a.billing_mode_id = 1 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 yff_amount,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'AND a.billing_mode_id = 2 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 hff_amount,
       --增量
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/SUM(a.AMOUNT_REAL),
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 1 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 yff_amount,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 2 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 hff_amount,
       --正常
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       --单停
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --双停
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --拆机
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --活卡 
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       --挂失
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --I类
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000                  
FROM TMP_OWE_KN_NEW03 a
LEFT JOIN pu_meta.latn_new_order b ON A.AREA_CODE1 = b.local_code
GROUP BY b.order_no,A.AREA_CODE1,B.area_name
ORDER BY b.order_no;


--合并  全省
---欠费收入

SELECT /*+parallel(a,4)*/
      --总欠费
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') = '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM')THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') <= '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       --存量
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM')THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'THEN a.AMOUNT_REAL ELSE 0 END)/SUM(a.AMOUNT_REAL),
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'AND a.billing_mode_id = 1 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 yff_amount,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'AND a.billing_mode_id = 2 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 hff_amount,
       --增量
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/SUM(a.AMOUNT_REAL),
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 1 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 yff_amount,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 2 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 hff_amount,
       --正常
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       --单停
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --双停
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --拆机
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --活卡 
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       --挂失
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --I类
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000                  
FROM TMP_OWE_KN_NEW03 a;

