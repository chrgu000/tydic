select * from pu_meta.etl_program_rule where rule_id='7001099'---规则表 
select * from pu_wt.p_serv_dev_d_201712;  -------用户发展质量原表
   1-10  上个月到今天发展用户
 11-月底  11以后截止到当天发展用户
select * from pu_wt.WT_SERV_C_D_201712; ---欠费相关表
Select * from pu_wt.Wt_Bil_Owe_List_d_New  Partition(p20171226); ---累计欠费    
Select * from pu_wt.Wt_Bil_Owe_List_d_Lz_New  Partition(p20171226);  ----零账欠费 
Select * from pu_wt.Wt_Bil_Owe_St_List_d  Partition(p20171226);  ---送托
select * from pu_meta.d_user_status  --状态表


select * from pu_wt.f_1_serv_d_jf where rownum<2;  --用户表

select * from pu_meta.latn_new --地州表

select * from comm.product@dl_jf219 where rownum<10; --产品表

select * from pu_wt.f_2_offer_serv_d where rownum<10; --销售品表

select * from pu_meta.offer_spec where rownum<10  --套餐表



----------  
create table zxy_text as   ---用户信息 
select b.*,l.area_name,s.acc_nbr,s.serv_create_date
        from pu_wt.f_1_serv_d_jf s         
        left join (
             select f.busi_obj_id,f.src_offer_id,o.name
             from pu_wt.f_2_offer_serv_d f,pu_meta.offer_spec o
               where  f.src_offer_id=o.offer_spec_id and 
             f.src_offer_id in ('1644205','1640581') and 
             (f.date_no between to_char(f.src_inst_eff_date,'YYYYMMDD') and to_char(f.src_inst_exp_date,'YYYYMMDD')) ) b 
        on s.serv_id=b.busi_obj_id 
        left join pu_meta.latn_new l on s.area_code=l.local_code
      where   b.busi_obj_id is not null and 
         s.term_type_id in (833,779) ;    
    
    select * from zxy_text;
 
-----   改后  
drop table zxy_test2;
create table zxy_test2 as  --分摊后税后信息
select  t.*,
       w.billing_arrive_flag,
       L2.charge_10,
       L2.charge_11
   from  zxy_text t   
     left join TBAS.WT_PRD_SERV_MON_201711@dl_edw_yn w on w.serv_id=t.busi_obj_id     
     left join (  
              select   l.prod_inst_id,
                       sum( decode(l.month_id,'201710',charge,0)) charge_10,
                       sum(decode(l.month_id,'201711',charge,0)) charge_11
                       from  PU_LIST.L_USER_FLHCHARGE_DETAIL_M@dl_edw_yn  l 
                       where l.month_id in ('201710','201711') 
                       group by l.prod_inst_id 
                   ) L2  on t.busi_obj_id=L2.prod_inst_id ;
                   
       -----
--[分公司,手机号码,入网时间,主套餐（1644205、1640581），是否出账用户，10月出账金额（分摊后税后），11月出账金额（分摊后税后）         
     select  t.area_name 分公司，
       t.acc_nbr 手机号码，
       t.serv_create_date 入网时间，
       t.name 主套餐，
       decode(t.billing_arrive_flag,'1','是','否') 是否出账用户,
       t.charge_10  十月出账金额,
       t.charge_11  十一月出账金额 
   from zxy_test2 t  
   
   
----------------------------------
   --- 查重
select busi_obj_id,count(*) from zxy_test2 group by busi_obj_id having count(*)>1;
select count(distinct(busi_obj_id))from zxy_test2;
select count(*) from zxy_test2;
select a.*, a.rowid from zxy_test2 a where busi_obj_id  in ( 700104373091 ,710110120543);



