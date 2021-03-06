--59��ִ��
ALTER TABLE wt_channel_c_cl_m ADD PARTITION p201711 VALUES (201711);
ALTER TABLE wt_channel_c_cl_m TRUNCATE PARTITION p201711 ;
INSERT INTO wt_channel_c_cl_m
SELECT '201711',
       area_code,
       dvlp_channel_id,
       channel_name,
       COUNT(*) dev_num,
       SUM(case when substr(b.Serv_Create_Date,1,8) = substr(b.Serv_lost_Date,1,8) then  0
        when (substr(b.serv_lost_date,1,6)<=b.month_no or  
       ( substr(b.serv_lost_date,1,6)>b.month_no and b.rec_amount <= 0 and  b.state<>'2HA') or
       ( substr(b.serv_lost_date,1,6)>b.month_no and b.rec_amount > 0 and  b.state<>'2HA' and  b.count+b.voice_cnt+b.traffic=0  ) or
       ((b.state='2HA' or (substr(b.serv_lost_date,1,6)>b.month_no and b.rec_amount > 0 and  b.state<>'2HA' and  b.count+b.voice_cnt+b.traffic>0)) and  b.TOTAL_AMOUNT_TCDLZ > 0 and is_i_flag = 0) )
              then 1 else 0
       END) wx_num,
       SUM(
       case when substr(b.Serv_Create_Date,1,8) = substr(b.Serv_lost_Date,1,8) then  0
        when (substr(b.serv_lost_date,1,6)<=b.month_no or  
       ( substr(b.serv_lost_date,1,6)>b.month_no and b.rec_amount <= 0 and  b.state<>'2HA') or
       ( substr(b.serv_lost_date,1,6)>b.month_no and b.rec_amount > 0 and  b.state<>'2HA' and  b.count+b.voice_cnt+b.traffic=0  ) or
       ((b.state='2HA' or (substr(b.serv_lost_date,1,6)>b.month_no and b.rec_amount > 0 and  b.state<>'2HA' and  b.count+b.voice_cnt+b.traffic>0)) and  b.TOTAL_AMOUNT_TCDLZ > 0 and is_i_flag = 0) )
              then 1 else 0
       END)/COUNT(*)
FROM wt_serv_c_cl_201711 b
WHERE create_month BETWEEN to_char(add_months(to_date('201711','yyyymm'),-5),'yyyymm') AND to_char(add_months(to_date('201711','yyyymm'),-1),'yyyymm')
AND   substr(serv_create_date,1,8)<>substr(serv_lost_date,1,8)
GROUP BY area_code,dvlp_channel_id,channel_name;
commit;

--239��ִ��
DROP TABLE kg_intf.wt_serv_wx_201711 PURGE;
CREATE TABLE kg_intf.wt_serv_wx_201711 PARALLEL 4 NOLOGGING AS
SELECT month_no,
       serv_id
FROM pu_wt.wt_serv_c_cl_201711@dl_newfx b
WHERE case when (substr(b.serv_lost_date,1,6)<=b.month_no or  
       ( substr(b.serv_lost_date,1,6)>b.month_no and b.rec_amount <= 0 and  b.state<>'2HA') or
       ( substr(b.serv_lost_date,1,6)>b.month_no and b.rec_amount > 0 and  b.state<>'2HA' and  b.count+b.voice_cnt+b.traffic=0  ) or
       ((b.state='2HA' or (substr(b.serv_lost_date,1,6)>b.month_no and b.rec_amount > 0 and  b.state<>'2HA' and  b.count+b.voice_cnt+b.traffic>0)) and  b.TOTAL_AMOUNT_TCDLZ > 0 and is_i_flag = 0) )
              then 1 else 0
       END=1
 AND   substr(serv_create_date,1,8)<>substr(serv_lost_date,1,8);

