---Ƿ������

SELECT /*+parallel(a,4)*/
       b.order_no ���,
       A.AREA_CODE1 ����,
       B.area_name �ֹ�˾,
      --��Ƿ��
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') = '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM')THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') <= '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       --����
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM')THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'THEN a.AMOUNT_REAL ELSE 0 END)/SUM(a.AMOUNT_REAL),
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'AND a.billing_mode_id = 1 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 yff_amount,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'AND a.billing_mode_id = 2 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 hff_amount,
       --����
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/SUM(a.AMOUNT_REAL),
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 1 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 yff_amount,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 2 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 hff_amount,
       --����
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       --��ͣ
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --˫ͣ
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --���
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --� 
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       --��ʧ
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --I��
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000                  
FROM TMP_OWE_KN_NEW03 a
LEFT JOIN pu_meta.latn_new_order b ON A.AREA_CODE1 = b.local_code
WHERE a.cust_group_TZ='����'
GROUP BY b.order_no,A.AREA_CODE1,B.area_name
ORDER BY b.order_no;


SELECT /*+parallel(a,4)*/
       b.order_no ���,
       A.AREA_CODE1 ����,
       B.area_name �ֹ�˾,
      --��Ƿ��
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') = '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM')THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') <= '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       --����
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM')THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'THEN a.AMOUNT_REAL ELSE 0 END)/SUM(a.AMOUNT_REAL),
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'AND a.billing_mode_id = 1 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 yff_amount,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'AND a.billing_mode_id = 2 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 hff_amount,
       --����
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/SUM(a.AMOUNT_REAL),
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 1 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 yff_amount,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 2 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 hff_amount,
       --����
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       --��ͣ
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --˫ͣ
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --���
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --� 
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       --��ʧ
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --I��
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000                  
FROM TMP_OWE_KN_NEW03 a
LEFT JOIN pu_meta.latn_new_order b ON A.AREA_CODE1 = b.local_code
WHERE a.cust_group_TZ='����'
GROUP BY b.order_no,A.AREA_CODE1,B.area_name
ORDER BY b.order_no;


SELECT /*+parallel(a,4)*/
       b.order_no ���,
       A.AREA_CODE1 ����,
       B.area_name �ֹ�˾,
      --��Ƿ��
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') = '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM')THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') <= '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       --����
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM')THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'THEN a.AMOUNT_REAL ELSE 0 END)/SUM(a.AMOUNT_REAL),
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'AND a.billing_mode_id = 1 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 yff_amount,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'AND a.billing_mode_id = 2 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 hff_amount,
       --����
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/SUM(a.AMOUNT_REAL),
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 1 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 yff_amount,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 2 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 hff_amount,
       --����
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       --��ͣ
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --˫ͣ
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --���
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --� 
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       --��ʧ
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --I��
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000                  
FROM TMP_OWE_KN_NEW03 a
LEFT JOIN pu_meta.latn_new_order b ON A.AREA_CODE1 = b.local_code
WHERE a.cust_group_TZ='����'
GROUP BY b.order_no,A.AREA_CODE1,B.area_name
ORDER BY b.order_no;

---ȫʡ


SELECT /*+parallel(a,4)*/
      --��Ƿ��
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') = '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM')THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') <= '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       --����
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM')THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'THEN a.AMOUNT_REAL ELSE 0 END)/SUM(a.AMOUNT_REAL),
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'AND a.billing_mode_id = 1 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 yff_amount,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'AND a.billing_mode_id = 2 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 hff_amount,
       --����
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/SUM(a.AMOUNT_REAL),
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 1 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 yff_amount,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 2 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 hff_amount,
       --����
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       --��ͣ
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --˫ͣ
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --���
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --� 
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       --��ʧ
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --I��
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000                  
FROM TMP_OWE_KN_NEW03 a
WHERE a.cust_group_TZ='����';



SELECT /*+parallel(a,4)*/
      --��Ƿ��
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') = '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM')THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') <= '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       --����
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM')THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'THEN a.AMOUNT_REAL ELSE 0 END)/SUM(a.AMOUNT_REAL),
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'AND a.billing_mode_id = 1 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 yff_amount,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'AND a.billing_mode_id = 2 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 hff_amount,
       --����
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/SUM(a.AMOUNT_REAL),
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 1 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 yff_amount,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 2 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 hff_amount,
       --����
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       --��ͣ
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --˫ͣ
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --���
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --� 
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       --��ʧ
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --I��
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000                  
FROM TMP_OWE_KN_NEW03 a
WHERE a.cust_group_TZ='����';


SELECT /*+parallel(a,4)*/
      --��Ƿ��
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') = '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM')THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') <= '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       --����
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM')THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'THEN a.AMOUNT_REAL ELSE 0 END)/SUM(a.AMOUNT_REAL),
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'AND a.billing_mode_id = 1 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 yff_amount,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'AND a.billing_mode_id = 2 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 hff_amount,
       --����
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/SUM(a.AMOUNT_REAL),
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 1 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 yff_amount,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 2 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 hff_amount,
       --����
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       --��ͣ
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --˫ͣ
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --���
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --� 
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       --��ʧ
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --I��
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000                  
FROM TMP_OWE_KN_NEW03 a
WHERE a.cust_group_TZ='����';


---�ϲ�
---Ƿ������

SELECT /*+parallel(a,4)*/
       b.order_no ���,
       A.AREA_CODE1 ����,
       B.area_name �ֹ�˾,
      --��Ƿ��
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') = '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM')THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') <= '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       --����
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM')THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'THEN a.AMOUNT_REAL ELSE 0 END)/SUM(a.AMOUNT_REAL),
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'AND a.billing_mode_id = 1 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 yff_amount,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'AND a.billing_mode_id = 2 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 hff_amount,
       --����
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/SUM(a.AMOUNT_REAL),
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 1 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 yff_amount,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 2 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 hff_amount,
       --����
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       --��ͣ
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --˫ͣ
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --���
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --� 
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       --��ʧ
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --I��
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000                  
FROM TMP_OWE_KN_NEW03 a
LEFT JOIN pu_meta.latn_new_order b ON A.AREA_CODE1 = b.local_code
GROUP BY b.order_no,A.AREA_CODE1,B.area_name
ORDER BY b.order_no;


--�ϲ�  ȫʡ
---Ƿ������

SELECT /*+parallel(a,4)*/
      --��Ƿ��
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') = '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM')THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN NVL(a.MIN_OWE_MONTH,'999999') <= '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       --����
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM')THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'THEN a.AMOUNT_REAL ELSE 0 END)/SUM(a.AMOUNT_REAL),
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'AND a.billing_mode_id = 1 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 yff_amount,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702'AND a.billing_mode_id = 2 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 hff_amount,
       --����
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702'THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/SUM(a.AMOUNT_REAL),
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 1 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 yff_amount,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 2 THEN a.AMOUNT_REAL ELSE 0 END)/100/10000 hff_amount,
       --����
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HA' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       --��ͣ
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state IN ('2IS','2HC','2HS') AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --˫ͣ
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state IN ('2HH','2ID','2HD','2HE') AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --���
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state IN ('2HK','2HX','2IX','2PX','2SX','2HB','2HF') AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --� 
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state='2HO' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       --��ʧ
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.state='2HJ' AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       --I��
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                   
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN a.AMOUNT_REAL ELSE 0 END)/100/10000,                  
       SUM(CASE WHEN a.is_i_flag=1 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN a.AMOUNT_REAL ELSE 0 END)/100/10000                  
FROM TMP_OWE_KN_NEW03 a;

