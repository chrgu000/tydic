

/*
1、统计两版，一版是全量的，一版是剔除不计发展量的
2、低预存的指标小于 20元，小于50元两个标准
3、统计1-17号的入网用户

*/


/*
1、统计两版，一版是全量的，一版是剔除不计发展量的
2、用现有的机卡匹配标准
3、统计1-17号的入网用户

"*/	


select * from PU_WT.WT_SERV_C_D_201801
		
select * from PU_WT.tmp_SERV_C_D_20180117

select 	a.area_code,a.地市,a.date_no,a.用户创建时间,a.是否机卡匹配, a.入网预存金额,a.是否低预存,a.is_dev_flag 
     from PU_WT.tmp_SERV_C_D_20180117 a 
    



--------------
select a.地市,
       count( distinct a.设备号) 发展数, --发展数
       sum(decode(a.是否机卡匹配,'否',0,1)) 机卡匹配数, --机卡匹配数
       sum(decode(a.是否机卡匹配,'否',0,1))/count( distinct a.设备号) 匹配占比  --匹配占比
  from PU_WT.tmp_SERV_C_D_20180117 a 
  where （a.用户创建时间 between '20180101' and '20180117'） --
       --  and nvl( a.is_dev_flag,1)=1  --是否计发展  0 _否  1或空 _是
  group by a.地市 
  order by a.地市 
----------------  
  
  

PU_WT.P_WT_BIL_JTHZ_REC_D_LIST --line 253


select * from PU_WT.WT_BIL_JTHZ_REC_D_LIST Partition(P20180118)

 select * from PU_WT.WT_BIL_JTHZ_LIST_D Partition(P20180118)
 
 select * from TMP_BIL_JTHZ_REC_D4 A
 select * from  PU_WT.F_1_SERV_D_JF A1
 
 
  Select b.DATE_NO,
             b.AREA_CODE,
             b.AREA_NAME,
             b.BRANCH_NAME2,
             b.BRANCH_CODE3,
             b.BRANCH_NAME3,
             b.BRANCH_CODE4,
             b.BRANCH_NAME4,
             b.BRANCH_CODE5,
             b.BRANCH_NAME5,
             Decode(b.CUST_GROUP_TZ, '政企', '政企', '实体') CHANNEL_TYPE,
             A.SERV_ID,
             b.ACC_NBR,
             MONTH_AMOUNT_JTHZ / 100 MONTH_AMOUNT_JTHZ,
             DAY_AMOUNT_JTHZ / 100 DAY_AMOUNT_JTHZ,
             A1.ACCT_ID,  ---20170518wrm增加合同号id合同号名称两个字段
             A1.ACCT_NAME
        From TMP_BIL_JTHZ_REC_D4 A,
             PU_WT.F_1_SERV_D_JF A1， ---20170518wrm增加
            PU_WT.WT_BIL_JTHZ_LIST_D Partition(P20180118) B
       Where A.SERV_ID=A1.SERV_ID(+)
       AND A.SERV_ID = B.SERV_ID(+) and
         b.DATE_NO is null
           

  
  
  
  
  
