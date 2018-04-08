
---欠费用户

SELECT /*+parallel(a,4)*/
       b.order_no 序号,
       A.AREA_CODE1 区号,
       B.area_name 分公司,
       --总用户数
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN 1 ELSE 0 END),
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN 1 ELSE 0 END),       
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN 1 ELSE 0 END),
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN 1 ELSE 0 END),
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN 1 ELSE 0 END),
       --存量用户数
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
       --增量用户数
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
WHERE a.cust_group_TZ='政企'
GROUP BY b.order_no,A.AREA_CODE1,B.area_name
ORDER BY b.order_no;

---欠费用户

SELECT /*+parallel(a,4)*/
       b.order_no 序号,
       A.AREA_CODE1 区号,
       B.area_name 分公司,
       --总用户数
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN 1 ELSE 0 END),
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN 1 ELSE 0 END),       
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN 1 ELSE 0 END),
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN 1 ELSE 0 END),
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN 1 ELSE 0 END),
       --存量用户数
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
       --增量用户数
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
WHERE a.cust_group_TZ='公众'
GROUP BY b.order_no,A.AREA_CODE1,B.area_name
ORDER BY b.order_no;


---欠费用户

SELECT /*+parallel(a,4)*/
       b.order_no 序号,
       A.AREA_CODE1 区号,
       B.area_name 分公司,
       --总用户数
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN 1 ELSE 0 END),
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN 1 ELSE 0 END),       
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN 1 ELSE 0 END),
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN 1 ELSE 0 END),
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN 1 ELSE 0 END),
       --存量用户数
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
       --增量用户数
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
WHERE a.cust_group_TZ='其他'
GROUP BY b.order_no,A.AREA_CODE1,B.area_name
ORDER BY b.order_no;


---全省



SELECT /*+parallel(a,4)*/
       --总用户数
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN 1 ELSE 0 END),
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN 1 ELSE 0 END),       
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN 1 ELSE 0 END),
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN 1 ELSE 0 END),
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN 1 ELSE 0 END),
       --存量用户数
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
       --增量用户数
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
WHERE a.cust_group_TZ='政企';




SELECT /*+parallel(a,4)*/
       --总用户数
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN 1 ELSE 0 END),
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN 1 ELSE 0 END),       
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN 1 ELSE 0 END),
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN 1 ELSE 0 END),
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN 1 ELSE 0 END),
       --存量用户数
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
       --增量用户数
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
WHERE a.cust_group_TZ='公众';




SELECT /*+parallel(a,4)*/
       --总用户数
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN 1 ELSE 0 END),
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN 1 ELSE 0 END),       
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN 1 ELSE 0 END),
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN 1 ELSE 0 END),
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN 1 ELSE 0 END),
       --存量用户数
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
       --增量用户数
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
WHERE a.cust_group_TZ='其他';


--  合并
---欠费用户

SELECT /*+parallel(a,4)*/
       b.order_no 序号,
       A.AREA_CODE1 区号,
       B.area_name 分公司,
       --总用户数
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN 1 ELSE 0 END),
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN 1 ELSE 0 END),       
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN 1 ELSE 0 END),
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN 1 ELSE 0 END),
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN 1 ELSE 0 END),
       --存量用户数
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
       --增量用户数
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

---合并  全省

SELECT /*+parallel(a,4)*/
       --总用户数
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') = '201702' THEN 1 ELSE 0 END),
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-3),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-1),'YYYYMM') THEN 1 ELSE 0 END),       
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') BETWEEN to_char(add_months(to_date(201702,'YYYYMM'),-12),'YYYYMM') AND to_char(add_months(to_date(201702,'YYYYMM'),-4),'YYYYMM') THEN 1 ELSE 0 END),
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= to_char(add_months(to_date(201702,'YYYYMM'),-13),'YYYYMM') THEN 1 ELSE 0 END),
       SUM(CASE WHEN a.AMOUNT_REAL <> 0 AND NVL(a.MIN_OWE_MONTH,'999999') <= '201702' THEN 1 ELSE 0 END),
       --存量用户数
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
       --增量用户数
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
