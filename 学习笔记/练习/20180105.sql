
select * from pu_meta.etl_program_rule where rule_id='7001099'---����� 

select * from pu_meta.etl_inter_rule where rule_id= 7001141; --ֱ�ӳ�ȡ�������ñ�

select * from pu_meta.etl_data_source a where a.data_source_id= 102; --����Դ���ñ�

select * from pu_meta.etl_program_rule a where a.rule_name like '%ҵ����%';--�����

--- ���չܿؿ�--���Ӿ��ֿ�---- @dl_edw_yn

select * from pu_wt.p_serv_dev_d_201712;  -------�û���չ����ԭ��--   1-10  �ϸ��µ����췢չ�û�  11-�µ�  11�Ժ��ֹ�����췢չ�û�

select * from pu_wt.WT_SERV_C_D_201712; ---Ƿ����ر�

Select * from pu_wt.Wt_Bil_Owe_List_d_New  Partition(p20171226); ---�ۼ�Ƿ��    

Select * from pu_wt.Wt_Bil_Owe_List_d_Lz_New  Partition(p20171226);  ----����Ƿ�� 

Select * from pu_wt.Wt_Bil_Owe_St_List_d  Partition(p20171226);  ---����

select * from pu_meta.d_user_status;  --״̬��

select * from pu_meta.latn_new@dl_fxgk_wt; --���ݱ�

select * from pu_wt.f_1_serv_d_jf where rownum<10;  --�û���

select * from comm.product@dl_jf219 where rownum<10; --��Ʒ��  1

select * from pu_wt.f_2_offer_serv_d where rownum<10; --����Ʒ��

select * from pu_meta.offer_spec where rownum<10  --�ײͱ�



------���ֿ�--- ���ӷ��չܿؿ�--  @dl_fxgk_wt 

select * s.src_ from tbas.wt_prod_serv_d_201801 s ;  --�û����ϱ�  1  ----dvlp_channel_id	 ��������id

select *  from tbas.wt_bs_offer_serv_d  s ; ---����Ʒ�� 1

select * from PU_MODEL.TB_PTY_CRM_CHANNEL; ---����ά�� 1

select * from TBAS.EVT_PRD_BUSI_M_201711  ---��ҵ������� (ȡ��������) 1
  
select * from pu_list.p_cdmalx_list_m   --ȡʡ����������  1

select * from TBAS.WT_PRD_SERV_MON_201712 where rownum<20;  ----���û���� BILLING_ARRIVE_FLAG ���˱�ʾ 1--�� 0--��

select * from PU_LIST.L_USER_FLHCHARGE_DETAIL_M@dl_edw_yn; ----������ܱ�
--------------------






----20180105 ����
--- �ֹ�˾	,serv_id,	�û�����	,�����ײͣ�1643217[2016.06]ȫʡ�����ײ�240Ԫ--���Ӱ���1643321[2016.06]ȫʡ�����ײ�180Ԫ--���Ӱ���,	����ʱ��	��������	��ǰ�û�״̬


---- �����ײ�('1643217','1643321')����Ч
create table zxy_test1 as 
         select    w.serv_id,   --�û�id
                   o.offer_spec_id, -- �ײ�id
                   o.name    -- �ײ�����
            from tbas.wt_bs_offer_serv_d w ,pu_meta.offer_spec o 
            where w.src_offer_id=o.offer_spec_id and 
                 w.src_offer_id in ('1643217','1643321')and
               ( '20180105' between to_char(w.src_inst_eff_date,'YYYYMMDD')and to_char(w.src_inst_exp_date,'YYYYMMDD') );

select count(*) from zxy_test1; --2117


--- �������ײ�����Ч���û���Ϣ
create table zxy_test2 as 
select t1.*, 
    l.area_name,--�ֹ�˾
    s.acc_nbr, --�û�����
    s.create_date, --����ʱ��   
    s.dvlp_channel_id,--��������id
    t.CHANNEL_NAME, -- ��������
    s.PROD_INST_STATE   --  �û�״̬
   from  tbas.wt_prod_serv_d_201801 s  
       join zxy_test1 t1 on s.serv_id=t1.serv_id
       left join pu_meta.latn_new@dl_fxgk_wt l on s.area_code=l.local_code
       left join PU_MODEL.TB_PTY_CRM_CHANNEL t on s.dvlp_channel_id =t.CHANNEL_ID ;
       
  select count(*) from zxy_test2;-- 2117
----����û�����������  
create table zxy_test3 as
select   t2.*,
        round (e7.DATA_FLUX/(1024*1024),2) DATA_FLUX_M7,
        round (e8.DATA_FLUX/(1024*1024),2) DATA_FLUX_M8, 
        round (e9.DATA_FLUX/(1024*1024),2) DATA_FLUX_M9,
        round (e10.DATA_FLUX/(1024*1024),2) DATA_FLUX_M10,
        round (e11.DATA_FLUX/(1024*1024),2) DATA_FLUX_M11,
        round (e12.DATA_FLUX/(1024*1024),2) DATA_FLUX_M12
       from zxy_test2 t2
       left join TBAS.EVT_PRD_BUSI_M_201707 e7  on e7.serv_id=t2.serv_id
       left join TBAS.EVT_PRD_BUSI_M_201708 e8  on e7.serv_id=e8.serv_id 
       left join TBAS.EVT_PRD_BUSI_M_201709 e9  on e7.serv_id=e9.serv_id 
       left join TBAS.EVT_PRD_BUSI_M_201710 e10 on e7.serv_id=e10.serv_id 
       left join TBAS.EVT_PRD_BUSI_M_201711 e11 on e7.serv_id=e11.serv_id 
       left join TBAS.EVT_PRD_BUSI_M_201712 e12 on e7.serv_id=e12.serv_id ;  
    select * from zxy_test3;   
---- ʡ����������
create table zxy_test4 as 
   select
       p.serv_id ,
       round(sum(decode(p.month_no,'201707',p.total_data_flow,0))/(1024*1024),2 ) total_data_flow_7,
       round(sum(decode(p.month_no,'201708',p.total_data_flow,0))/(1024*1024),2 ) total_data_flow_8,
       round(sum(decode(p.month_no,'201709',p.total_data_flow,0))/(1024*1024),2 ) total_data_flow_9,
       round(sum(decode(p.month_no,'201710',p.total_data_flow,0))/(1024*1024),2 ) total_data_flow_10,
       round(sum(decode(p.month_no,'201711',p.total_data_flow,0))/(1024*1024),2 ) total_data_flow_11,
       round(sum(decode(p.month_no,'201712',p.total_data_flow,0))/(1024*1024),2 ) total_data_flow_12
      from  pu_list.p_cdmalx_list_m p 
      group by p.serv_id;
--- ����û��� �������� ��ʡ����������  
create table zxy_test5 as  --���ձ�
  select  t3.*,
         t4.total_data_flow_7,
         t4.total_data_flow_8,
         t4.total_data_flow_9,
         t4.total_data_flow_10,
         t4.total_data_flow_11,
         t4.total_data_flow_12
      from zxy_test3 t3 
      left join  zxy_test4 t4  on t3.serv_id=t4.serv_id;
      
---- 
select  t.area_name �ֹ�˾,
        t.serv_id �û�id,
        t.acc_nbr �û�����,
        t.name �ײ�����,
        t.create_date ����ʱ��,
        t.dvlp_channel_id ��������id,
        t.CHANNEL_NAME ��������,
        d.status_name  �û�״̬,        
        t.DATA_FLUX_M7 ����7,
        t.DATA_FLUX_M8 ����8,
        t.DATA_FLUX_M9 ����9,
        t.DATA_FLUX_M10 ����10,
        t.DATA_FLUX_M11 ����11,
        t.DATA_FLUX_M12 ����12,
        t.total_data_flow_7 ����7,
        t.total_data_flow_8 ����8,
        t.total_data_flow_9 ����9,
        t.total_data_flow_10 ����10,
        t.total_data_flow_11 ����11,
        t.total_data_flow_12 ����12
     from zxy_test5 t 
      left join pu_meta.d_user_status d on t.prod_inst_state=d.status_code ;
       
       
