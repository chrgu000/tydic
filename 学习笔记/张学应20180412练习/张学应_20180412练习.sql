select * from tbas.wt_prod_serv_d_201804 --�����ϱ�
select * from pu_meta.tpdim_std_product_lev;--���ֲ�Ʒ���ͱ�
select * from pu_meta.tprel_product where std_product_id in (55,56,57,10)--��Ʒ����ӳ���
select * from pu_meta.tpdim_std_area where up_std_area_id='1'--����
select * from tbas.wt_prd_serv_mon_201803--�����ϱ�
select * from all_tables where table_name like '%SERV%' AND OWNER='TBAS';--�����Ʊ���
SELECT * FROM pu_meta.etl_program_rule where rule_name like '%ҵ����%'--ETL���ñ�

-- ==================

--- ��� ����
 select product_id from pu_meta.tprel_product where std_product_id in(
select a.product_id from pu_meta.tpdim_std_product_lev a   WHERE a.lev6_product_name like '%����%' and a.lev4_product_name like'%����������%')    
 --- �̻�����
 select product_id from pu_meta.tprel_product where std_product_id in(
select a.product_id from pu_meta.tpdim_std_product_lev a   WHERE a.lev6_product_name like '%����%' and a.lev4_product_name like'%��������%')  
 
--- �ƶ�����
 
  select product_id from pu_meta.tprel_product where std_product_id in(
select a.product_id from pu_meta.tpdim_std_product_lev a   WHERE a.lev6_product_name like '%�ƶ�%')


--- 1��4��9���ƶ���������̻� ��չ�û������ֵ��� 
drop table temp_zxy;
create table temp_zxy as
select
 b.local_code,
 b.area_name,
 sum(  case when a.product_id in( '835','779','850','833','889') 
     then 1 else 0 end
    ) yd_dev��   -- �ƶ���չչ��
   sum(  case when a.product_id in 
   (  '2563','350','351','381','352','353','354','669','356','355','1721','4302','2843') 
     then 1 else 0 end
    ) kd_dev �� -- ��� 
    
  sum(case when a.product_id in (    select product_id from pu_meta.tprel_product where std_product_id in(
      select a.product_id from pu_meta.tpdim_std_product_lev a  
       WHERE a.lev6_product_name like '%����%' and a.lev4_product_name like'%��������%')   
       )  then 1 else 0 end 
       ) gh_dev -- �̻�    
from  tbas.wt_prod_serv_d_201804 a
        join pu_meta.latn_new b on a.area_code=b.local_code
        join pu_meta.d_user_status c on a.prod_inst_state= c.status_code          
 where c.status_name not like'%���%' 
 and  substr(a.create_date,1,8)='20180409'
 group by b.local_code,b.area_name;
 
 SELECT * FROM temp_zxy order by area_name;
 
      
 
  ---2 ��  3�¡�2�³���/�Ʒ��û������ֵ���  
  drop table temp_zxy1;    
create table temp_zxy1 as
select * 
from(
select '201802' month_no,   
   b.local_code,
   b.area_name,
   count(distinct a.serv_id) bil_num    -- 2�³����û�
from TBAS.WT_PRD_SERV_MON_201802 a,pu_meta.latn_new b
  where a.area_code=b.local_code
  and a.billing_arrive_flag='1'
    group by b.local_code,
      b.area_name
      
     union all
     
   select '201803' month_no,  
   b.local_code,
   b.area_name,
  count(distinct a.serv_id) bil_num  --3�³���
from TBAS.WT_PRD_SERV_MON_201803 a,pu_meta.latn_new b
  where a.area_code=b.local_code
  and a.billing_arrive_flag='1'
    group by b.local_code,
      b.area_name  
       )  
  -- ��ѯ     
select  
  t1.local_code,
  t1.area_name,
  sum(decode(t1.month_no,'201802',t1.bil_num,0)  ) bil_num2,--2�³����û���
  sum(decode(t1.month_no,'201803',t1.bil_num,0)  ) bil_num3  -- 3�³����û���
  from temp_zxy1 t1
  group by   
  t1.local_code,
  t1.area_name
  order by t1.local_code
   
  
  
 ----  
   --3�� 3�·ֵ����ƶ��������ʧ�û��� 
drop table temp_zxy2;
create table temp_zxy2 as
SELECT
 '201803' month_no, 
 c.local_code,
 c.area_name,
  sum(  case when b.product_id in( '835','779','850','833','889') 
     then 1 else 0 end
    ) yd_ls,--�ƶ���ʧ�û���
    sum(  case when b.product_id in (  '2563','350','351','381','352','353','354','669','356','355','1721','4302','2843') 
     then 1 else 0 end
    )  kd_ls --�����ʧ�û���
 FROM 
(
select a.serv_id
from 
   TBAS.WT_PRD_SERV_MON_201802 a
   WHERE a.billing_arrive_flag='1') a1   -- 2�³���
  left join  TBAS.WT_PRD_SERV_MON_201803 b on a1.serv_id=b.serv_id
  left join pu_meta.latn_new c on b.area_code=c.local_code  
  where b.billing_arrive_flag='0'  -- 3 �²�����
  group by  c.local_code,
 c.area_name;
  
 select * from temp_zxy2;
------   3.2   ������ʧ��ʾ ͳ����ʧ�û�---------------------------
drop table temp_zxy2;
create table temp_zxy2 as
SELECT
 '201803' month_no, 
 c.local_code,
 c.area_name,
  sum(  case when b.product_id in( '835','779','850','833','889') 
     then 1 else 0 end
    ) yd_ls,--�ƶ���ʧ�û���
    sum(  case when b.product_id in (  '2563','350','351','381','352','353','354','669','356','355','1721','4302','2843') 
     then 1 else 0 end
    )  kd_ls --�����ʧ�û���

from    TBAS.WT_PRD_SERV_MON_201803 b 
  left join pu_meta.latn_new c on b.area_code=c.local_code  
  where b.loss_user_flag='1'  -- 3 ����ʧ��ʶ
  group by  c.local_code,
 c.area_name;
   
 -------------------------------  

-- 4,  3���ƶ���Ĭ�ǲ���û����ֵ���4,

drop table temp_zxy3;
create table temp_zxy3 as
SELECT 
'201803 'month_no,
b.local_code,
b.area_name,
count(distinct a.serv_id) silent_num  --��Ĭ�û���
 FROM 
  TBAS.WT_PRD_SERV_MON_201803 a,pu_meta.latn_new b,pu_meta.d_user_status c
  where a.area_code=b.local_code 
   and  a.prod_inst_state=c.status_code
   and a.product_id in( '835','779','850','833','889') -- �ƶ�
   and c.status_name not like '%���%'  --�ǲ��
   and a.silent_flag='1'  --��Ĭ�û�
   group by  b.local_code,b.area_name ; 
    
 SELECT * FROM temp_zxy3 order by local_code;
   
   
   
