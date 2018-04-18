DROP TABLE TMP_20171009_A PURGE;
CREATE TABLE TMP_20171009_A NOLOGGING AS
 Select /*+PARALLEL(T1,16)*/
  T1.AREA_CODE,
  T1.SERV_ID,
  T1.TERM_TYPE_ID,
  Case
    When T4.BRANCH_CODE2 = '85344000000' Then
     '9004'
    When T3.SERV_ID Is Not Null Then
     '9000'
    When T4.BRANCH_CODE3 = '85301970000' Then
     '9003'
    Else
     T1.AREA_CODE
  End AREA_CODE1,
  Case
         When T1.TERM_TYPE_ID In (779, 835, 889, 833, 850) Then
          '移动'
         When T1.TERM_TYPE_ID In (2843, 352, 353, 2563, 354, 1721, 355, 1180) Then
          '有线宽带和宽带帐号'
         When T1.TERM_TYPE_ID In (381) Then
          '专线'
         When T1.TERM_TYPE_ID In (298,
                                  299,
                                  300,
                                  303,
                                  304,
                                  305,
                                  306,
                                  307,
                                  308,
                                  309,
                                  310,
                                  2123,
                                  361,
                                  362,
                                  323,
                                  614,
                                  673,
                                  655,
                                  603,
                                  312,
                                  654,
                                  321,
                                  645,
                                  1280,
                                  501,
                                  322,
                                  314,
                                  315,
                                  316,
                                  317,
                                  318,
                                  319,
                                  320,
                                  678,
                                  677) Then
          '固网'
         When T1.TERM_TYPE_ID In (333, 334, 335, 181, 336, 337, 338, 666) Then
          '基础数据和网元出租'
         When T1.TERM_TYPE_ID In (2903,358) Then
          'IPTV'
         Else
          'ICT及其他'
       End STD_TERM_TYPE
   From PU_WT.F_1_SERV_D_JF T1, 
   PU_INTF.I_IN_KG_SERV_GRID Partition(P201803) T5, --上月账期
   PU_META.D_HX_ZD_ORG_BRANCH_TREE T4,
   PU_WT.WT_SERV_SHZ_ALL_201803 T3    --上月账期
  Where T1.SERV_ID = T5.PROD_ID(+)
    And T5.SUM_BRANCH_CODE = T4.BRANCH_CODE(+)
    And T1.SERV_ID = T3.SERV_ID(+);

--基础数据和网元出租    固网    ICT及其他    移动    有线宽带和宽带帐号    专线  

----- 经分库
DROP TABLE ly.TB_BIL_FIN_INCM_MON_2017;
create table ly.TB_BIL_FIN_INCM_MON_2017 parallel 8 nologging as    
Select SERV_ID, Sum(CHARGE_FLH) CHARGE_FLH
          From (Select SERV_ID, Sum(CHARGE_FLH) / 100 CHARGE_FLH
                  From PU_MODEL.TB_BIL_FIN_INCM_MON_201801 T
                 Group By SERV_ID
                    Union All
                Select SERV_ID, Sum(CHARGE_FLH) / 100 CHARGE_FLH
                  From PU_MODEL.TB_BIL_FIN_INCM_MON_201802 T
                 Group By SERV_ID
            Union All
                Select SERV_ID, Sum(CHARGE_FLH) / 100 CHARGE_FLH
                  From PU_MODEL.TB_BIL_FIN_INCM_MON_201803 T
                 Group By SERV_ID
              /*
            Union All
                Select SERV_ID, Sum(CHARGE_FLH) / 100 CHARGE_FLH
                  From PU_MODEL.TB_BIL_FIN_INCM_MON_201804 T
                 Group By SERV_ID
            Union All
                Select SERV_ID, Sum(CHARGE_FLH) / 100 CHARGE_FLH
                  From PU_MODEL.TB_BIL_FIN_INCM_MON_201805 T
                 Group By SERV_ID
            Union All
                Select SERV_ID, Sum(CHARGE_FLH) / 100 CHARGE_FLH
                  From PU_MODEL.TB_BIL_FIN_INCM_MON_201806 T
                 Group By SERV_ID
                Union All
                Select SERV_ID, Sum(CHARGE_FLH) / 100 CHARGE_FLH
                  From PU_MODEL.TB_BIL_FIN_INCM_MON_201807 T
                 Group By SERV_ID
                   Union All
                Select SERV_ID, Sum(CHARGE_FLH) / 100 CHARGE_FLH
                  From PU_MODEL.TB_BIL_FIN_INCM_MON_201808 T
         Group By SERV_ID
              Union All
                Select SERV_ID, Sum(CHARGE_FLH) / 100 CHARGE_FLH
                  From PU_MODEL.TB_BIL_FIN_INCM_MON_201809 T
         Group By SERV_ID
             Union All
                Select SERV_ID, Sum(CHARGE_FLH) / 100 CHARGE_FLH
                  From PU_MODEL.TB_BIL_FIN_INCM_MON_201810 T
         Group By SERV_ID
            Union All
                Select SERV_ID, Sum(CHARGE_FLH) / 100 CHARGE_FLH
                  From PU_MODEL.TB_BIL_FIN_INCM_MON_201811 T
         Group By SERV_ID
                 Union All
                Select SERV_ID, Sum(CHARGE_FLH) / 100 CHARGE_FLH
                  From PU_MODEL.TB_BIL_FIN_INCM_MON_2018012 T     ---后面加上 上月每月的
         Group By SERV_ID*/) 
            Group By SERV_ID;                                             
--        
drop table  pu_wt.TMP_20171009_B;
create table pu_wt.TMP_20171009_B PARALLEL 8 NOLOGGING AS         
Select A.AREA_CODE1,
       D.Area_Name,
       SUM(CASE WHEN A.Std_Term_Type = '基础数据和网元出租' THEN NVL(B.CHARGE_FLH,0) ELSE 0 END )/10000 NUM_1,
       SUM(CASE WHEN A.Std_Term_Type = '基础数据和网元出租' THEN NVL(C.Month_Amount_Real,0) ELSE 0 END )/10000 NUM_2,
       SUM(CASE WHEN A.Std_Term_Type = '固网' THEN NVL(B.CHARGE_FLH,0) ELSE 0 END )/10000 NUM_3,
       SUM(CASE WHEN A.Std_Term_Type = '固网' THEN NVL(C.Month_Amount_Real,0) ELSE 0 END )/10000 NUM_4, 
       SUM(CASE WHEN A.Std_Term_Type = 'ICT及其他' THEN NVL(B.CHARGE_FLH,0) ELSE 0 END )/10000 NUM_5,
       SUM(CASE WHEN A.Std_Term_Type = 'ICT及其他' THEN NVL(C.Month_Amount_Real,0) ELSE 0 END )/10000 NUM_6,
       SUM(CASE WHEN A.Std_Term_Type = '移动' THEN NVL(B.CHARGE_FLH,0) ELSE 0 END )/10000 NUM_7,
       SUM(CASE WHEN A.Std_Term_Type = '移动' THEN NVL(C.Month_Amount_Real,0) ELSE 0 END )/10000 NUM_8,
       SUM(CASE WHEN A.Std_Term_Type = '有线宽带和宽带帐号' THEN NVL(B.CHARGE_FLH,0) ELSE 0 END )/10000 NUM_9,
       SUM(CASE WHEN A.Std_Term_Type = '有线宽带和宽带帐号' THEN NVL(C.Month_Amount_Real,0) ELSE 0 END )/10000 NUM_10,
       SUM(CASE WHEN A.Std_Term_Type = '专线' THEN NVL(B.CHARGE_FLH,0) ELSE 0 END )/10000 NUM_11,
       SUM(CASE WHEN A.Std_Term_Type = '专线' THEN NVL(C.Month_Amount_Real,0) ELSE 0 END )/10000 NUM_12,
       SUM(CASE WHEN A.Std_Term_Type = 'IPTV' THEN NVL(B.CHARGE_FLH,0) ELSE 0 END )/10000 NUM_13,
       SUM(CASE WHEN A.Std_Term_Type = 'IPTV' THEN NVL(C.Month_Amount_Real,0) ELSE 0 END )/10000 NUM_14,
       SUM( NVL(B.,0) )/1000CHARGE_FLH0 NUM_15,
       SUM( NVL(C.Month_Amount_Real,0) )/10000 NUM_16
  From TMP_20171009_A A,
      ly.TB_BIL_FIN_INCM_MON_2017@DL_EDW_YN B, 
       PU_WT.WT_BIL_OWE_LIST_D_NEW Partition(P20180408) C, --当月10号  (s)
       PU_META.Latn_New D
 Where A.SERV_ID = B.SERV_ID(+)
   And A.SERV_ID = C.SERV_ID(+)
   AND A.Area_Code1 = D.Local_Code(+)
   Group By A.AREA_CODE1,D.AREA_NAME
   Order By D.AREA_NAME;

--select * from pu_wt.TMP_20171009_B;   

select * from TMP_20171009_B  Order By AREA_NAME
--删除临时表

