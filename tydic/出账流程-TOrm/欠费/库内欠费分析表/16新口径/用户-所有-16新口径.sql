
---Ƿ���û�

SELECT /*+parallel(a,4)*/
       b.order_no ���,
       A.AREA_CODE1 ����,
       B.area_name �ֹ�˾,
       --���û���
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN 1 ELSE 0 END),
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN 1 ELSE 0 END),       
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN 1 ELSE 0 END),
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN 1 ELSE 0 END),
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN 1 ELSE 0 END),
       --�����û���
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,       
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       --�����û���
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,       
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt
FROM TMP_OWE_KN_NEW03 a
LEFT JOIN pu_meta.latn_new_order b ON A.AREA_CODE1 = b.local_code
WHERE a.cust_group_TZ='����'
GROUP BY b.order_no,A.AREA_CODE1,B.area_name
ORDER BY b.order_no;

---Ƿ���û�

SELECT /*+parallel(a,4)*/
       b.order_no ���,
       A.AREA_CODE1 ����,
       B.area_name �ֹ�˾,
       --���û���
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN 1 ELSE 0 END),
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN 1 ELSE 0 END),       
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN 1 ELSE 0 END),
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN 1 ELSE 0 END),
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN 1 ELSE 0 END),
       --�����û���
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,       
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       --�����û���
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,       
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt
FROM TMP_OWE_KN_NEW03 a
LEFT JOIN pu_meta.latn_new_order b ON A.AREA_CODE1 = b.local_code
WHERE a.cust_group_TZ='����'
GROUP BY b.order_no,A.AREA_CODE1,B.area_name
ORDER BY b.order_no;


---Ƿ���û�

SELECT /*+parallel(a,4)*/
       b.order_no ���,
       A.AREA_CODE1 ����,
       B.area_name �ֹ�˾,
       --���û���
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN 1 ELSE 0 END),
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN 1 ELSE 0 END),       
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN 1 ELSE 0 END),
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN 1 ELSE 0 END),
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN 1 ELSE 0 END),
       --�����û���
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,       
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       --�����û���
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,       
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt
FROM TMP_OWE_KN_NEW03 a
LEFT JOIN pu_meta.latn_new_order b ON A.AREA_CODE1 = b.local_code
WHERE a.cust_group_TZ='����'
GROUP BY b.order_no,A.AREA_CODE1,B.area_name
ORDER BY b.order_no;


---ȫʡ



SELECT /*+parallel(a,4)*/
       --���û���
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN 1 ELSE 0 END),
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN 1 ELSE 0 END),       
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN 1 ELSE 0 END),
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN 1 ELSE 0 END),
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN 1 ELSE 0 END),
       --�����û���
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,       
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       --�����û���
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,       
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt
FROM TMP_OWE_KN_NEW03 a
WHERE a.cust_group_TZ='����';




SELECT /*+parallel(a,4)*/
       --���û���
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN 1 ELSE 0 END),
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN 1 ELSE 0 END),       
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN 1 ELSE 0 END),
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN 1 ELSE 0 END),
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN 1 ELSE 0 END),
       --�����û���
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,       
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       --�����û���
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,       
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt
FROM TMP_OWE_KN_NEW03 a
WHERE a.cust_group_TZ='����';




SELECT /*+parallel(a,4)*/
       --���û���
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN 1 ELSE 0 END),
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN 1 ELSE 0 END),       
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN 1 ELSE 0 END),
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN 1 ELSE 0 END),
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN 1 ELSE 0 END),
       --�����û���
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,       
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       --�����û���
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,       
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt
FROM TMP_OWE_KN_NEW03 a
WHERE a.cust_group_TZ='����';


--  �ϲ�
---Ƿ���û�

SELECT /*+parallel(a,4)*/
       b.order_no ���,
       A.AREA_CODE1 ����,
       B.area_name �ֹ�˾,
       --���û���
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN 1 ELSE 0 END),
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN 1 ELSE 0 END),       
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN 1 ELSE 0 END),
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN 1 ELSE 0 END),
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN 1 ELSE 0 END),
       --�����û���
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,       
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       --�����û���
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,       
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt
FROM TMP_OWE_KN_NEW03 a
LEFT JOIN pu_meta.latn_new_order b ON A.AREA_CODE1 = b.local_code
GROUP BY b.order_no,A.AREA_CODE1,B.area_name
ORDER BY b.order_no;

---�ϲ�  ȫʡ

SELECT /*+parallel(a,4)*/
       --���û���
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN 1 ELSE 0 END),
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN 1 ELSE 0 END),       
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN 1 ELSE 0 END),
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN 1 ELSE 0 END),
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN 1 ELSE 0 END),
       --�����û���
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,       
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date <= '20161231' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       --�����û���
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,       
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 1 THEN 1 ELSE 0 END) yff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt,
       SUM(CASE WHEN a.serv_create_date >= '20170101' AND a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' AND a.billing_mode_id = 2 THEN 1 ELSE 0 END) hff_cnt
FROM TMP_OWE_KN_NEW03 a;
