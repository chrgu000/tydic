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
   PU_INTF.I_IN_KG_SERV_GRID Partition(P201711) T5, 
   PU_META.D_HX_ZD_ORG_BRANCH_TREE T4,
   PU_WT.WT_SERV_SHZ_ALL_201711 T3
  Where T1.SERV_ID = T5.PROD_ID(+)
    And T5.SUM_BRANCH_CODE = T4.BRANCH_CODE(+)
    And T1.SERV_ID = T3.SERV_ID(+);

--基础数据和网元出租    固网    ICT及其他    移动    有线宽带和宽带帐号    专线  

---20170510 增加临时表
create table pu_wt.tmp_wrm_B parallel 6  nologging as
 Select SERV_ID, Sum(CHARGE_FLH) CHARGE_FLH
          From (Select SERV_ID, Sum(CHARGE_FLH) / 100 CHARGE_FLH
                  From PU_MODEL.TB_BIL_FIN_INCM_MON_201701@DL_EDW_YN T
                 Group By SERV_ID
                Union All
                Select SERV_ID, Sum(CHARGE_FLH) / 100 CHARGE_FLH
                  From PU_MODEL.TB_BIL_FIN_INCM_MON_201702@DL_EDW_YN T
                 Group By SERV_ID
                Union All
                Select SERV_ID, Sum(CHARGE_FLH) / 100 CHARGE_FLH
                  From PU_MODEL.TB_BIL_FIN_INCM_MON_201703@DL_EDW_YN T
                 Group By SERV_ID
                Union All ---------   每个月增加当月收入
                Select SERV_ID, Sum(CHARGE_FLH) / 100 CHARGE_FLH  
                  From PU_MODEL.TB_BIL_FIN_INCM_MON_201704@DL_EDW_YN T
                 Group By SERV_ID
                Union All ---------   每个月增加当月收入
                Select SERV_ID, Sum(CHARGE_FLH) / 100 CHARGE_FLH  
                  From PU_MODEL.TB_BIL_FIN_INCM_MON_201705@DL_EDW_YN T
                 Group By SERV_ID)
                Union All ---------   每个月增加当月收入
                Select SERV_ID, Sum(CHARGE_FLH) / 100 CHARGE_FLH  
                  From PU_MODEL.TB_BIL_FIN_INCM_MON_201706@DL_EDW_YN T
                 Group By SERV_ID
         Group By SERV_ID ;
---
create table ly.TB_BIL_FIN_INCM_MON_2017 parallel 8 nologging as
Select SERV_ID, Sum(CHARGE_FLH) CHARGE_FLH
          From (Select SERV_ID, Sum(CHARGE_FLH) / 100 CHARGE_FLH
                  From PU_MODEL.TB_BIL_FIN_INCM_MON_201701 T
                 Group By SERV_ID
                    Union All
                Select SERV_ID, Sum(CHARGE_FLH) / 100 CHARGE_FLH
                  From PU_MODEL.TB_BIL_FIN_INCM_MON_201702 T
                 Group By SERV_ID
            Union All
                Select SERV_ID, Sum(CHARGE_FLH) / 100 CHARGE_FLH
                  From PU_MODEL.TB_BIL_FIN_INCM_MON_201703 T
                 Group By SERV_ID
            Union All
                Select SERV_ID, Sum(CHARGE_FLH) / 100 CHARGE_FLH
                  From PU_MODEL.TB_BIL_FIN_INCM_MON_201704 T
                 Group By SERV_ID
            Union All
                Select SERV_ID, Sum(CHARGE_FLH) / 100 CHARGE_FLH
                  From PU_MODEL.TB_BIL_FIN_INCM_MON_201705 T
                 Group By SERV_ID
            Union All
                Select SERV_ID, Sum(CHARGE_FLH) / 100 CHARGE_FLH
                  From PU_MODEL.TB_BIL_FIN_INCM_MON_201706 T
                 Group By SERV_ID
                Union All
                Select SERV_ID, Sum(CHARGE_FLH) / 100 CHARGE_FLH
                  From PU_MODEL.TB_BIL_FIN_INCM_MON_201707 T
                 Group By SERV_ID
                   Union All
                Select SERV_ID, Sum(CHARGE_FLH) / 100 CHARGE_FLH
                  From PU_MODEL.TB_BIL_FIN_INCM_MON_201708 T
         Group By SERV_ID
              Union All
                Select SERV_ID, Sum(CHARGE_FLH) / 100 CHARGE_FLH
                  From PU_MODEL.TB_BIL_FIN_INCM_MON_201709 T
         Group By SERV_ID
             Union All
                Select SERV_ID, Sum(CHARGE_FLH) / 100 CHARGE_FLH
                  From PU_MODEL.TB_BIL_FIN_INCM_MON_201710 T
         Group By SERV_ID
                 Union All
                Select SERV_ID, Sum(CHARGE_FLH) / 100 CHARGE_FLH
                  From PU_MODEL.TB_BIL_FIN_INCM_MON_201711 T
         Group By SERV_ID) 
            Group By SERV_ID;
--         
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
       SUM( NVL(B.CHARGE_FLH,0) )/10000 NUM_15,
       SUM( NVL(C.Month_Amount_Real,0) )/10000 NUM_16
  From TMP_20171009_A A,
      ly.TB_BIL_FIN_INCM_MON_2017@DL_EDW_YN B, 
       PU_WT.WT_BIL_OWE_LIST_D_NEW Partition(P20171210) C,
       PU_META.Latn_New D
 Where A.SERV_ID = B.SERV_ID(+)
   And A.SERV_ID = C.SERV_ID(+)
   AND A.Area_Code1 = D.Local_Code(+)
   Group By A.AREA_CODE1,D.AREA_NAME
   Order By D.AREA_NAME;

select * from pu_wt.TMP_20171009_B;   
   
--删除临时表
drop table pu_wt.tmp_wrm_B purge;
select * from TMP_20171009_B  Order By AREA_NAME
