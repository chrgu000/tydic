
DROP TABLE TMP_20170128_AA PURGE;
CREATE TABLE TMP_20170128_AA AS
Select A.SERV_ID,
       C.BRANCH_CODE2,
       C.BRANCH_NAME2,
       C.BRANCH_CODE3,
       C.BRANCH_NAME3,
       C.BRANCH_CODE4,
       C.BRANCH_NAME4,
       C.BRANCH_CODE5,
       C.BRANCH_NAME5,
       Case
         When D.SERV_ID Is Not Null Then
          '9000'
         When C.BRANCH_CODE2 = '85344000000' Then
          '9004'
         When C.BRANCH_CODE2 = '85301000850' Then
          '9005'
         When C.BRANCH_CODE3 = '85301970000' Then
          '9003'
         When C.BRANCH_CODE2 = '85301000439' Or
              C.BRANCH_CODE2 = '85301000860' Or
              C.BRANCH_CODE2 = '85301000421' Then
          '9006'
         Else
          A.AREA_CODE
       End AREA_CODE1,
       Case
         When D.SERV_ID Is Not Null Then
          '省政企'
         When C.BRANCH_CODE2 = '85344000000' Then
          '号百'
         When C.BRANCH_CODE2 = '85301000850' Then
          '信产公司'
         When C.BRANCH_CODE3 = '85301970000' Then
          '省商业客户部'
         When C.BRANCH_CODE2 = '85301000439' Or
              C.BRANCH_CODE2 = '85301000860' Or
              C.BRANCH_CODE2 = '85301000421' Then
          '省本部'
         Else
          F.AREA_NAME
       End AREA_NAME1,
       Case
         When D.SERV_ID Is Not Null Then
          '省政企'
         When C.BRANCH_CODE2 = '85344000000' Then
          '号百'
         When C.BRANCH_CODE2 = '85301000850' Then
          '信产公司'
         When C.BRANCH_CODE3 = '85301970000' Then
          '省商业客户部'
         When C.BRANCH_CODE2 = '85301000439' then '市场部'
         When C.BRANCH_CODE2 = '85301000860' THEN '省利润中心'
         When C.BRANCH_CODE2 = '85301000421' THEN '电子渠道运营中心' 
         Else
          F.AREA_NAME
       End AREA_NAME2,
       E.CLASS_TYPE,
       E.CLASS_TYPE2
  From PU_WT.F_1_SERV_D_JF A, PU_INTF.I_IN_KG_SERV_GRID Partition(P201711) B, PU_META.D_HX_ZD_ORG_BRANCH_TREE C, PU_WT.WT_SERV_SHZ_ALL_201711 D,
       IPD_IN.I_IN_HX_SERV_CHANEL_201711@DL_ODL_89 E,
       PU_META.Latn_New F
 Where A.SERV_ID = B.PROD_ID(+)
   And B.SUM_BRANCH_CODE = C.BRANCH_CODE(+)
   And A.SERV_ID = D.SERV_ID(+)
   AND A.SERV_ID  = E.PROD_ID(+)
   AND A.Area_Code =  F.Local_Code(+); 

 
---  统计
政企  其中行业  其中商客  其中校园  实体  ICT及其他

DROP TABLE TMP_20170128_AB PURGE;
CREATE TABLE TMP_20170128_AB AS
Select T.*,
       Case
         When T.CLASS_TYPE In ('政企', '商客') Or
              T.AREA_NAME1 Like '%信产%' Then
          '政企'
         When T.CLASS_TYPE In ('实体', '未分配') Or
              (T.CLASS_TYPE = '其他' And T.AREA_NAME1 NOT IN ('信产公司','号百', '省本部')) Then
          '实体'
         When  T.CLASS_TYPE = '其他' And
              T.AREA_NAME1 in ('号百', '省本部')  Then
          '其他'
       End CLASS_TYPE_SR,  ---- 收入大类
       Case
         When (T.CLASS_TYPE = '政企' And T.CLASS_TYPE2 = '政企行业') Or
              T.AREA_NAME1 Like '%信产%' Then
          '行业'
         When T.CLASS_TYPE = '商客' Then
          '商客'
         When T.CLASS_TYPE = '政企' And
              T.CLASS_TYPE2 In ('校园专属渠道', '政企校园', '校园支局') Then
          '校园'
       End CLASS_TYPE2_SR ---- 收入小类
  From TMP_20170128_AA T;
  
 
Select A.Area_Code1,A.Area_Name1, 
      SUM(CASE WHEN A.Class_Type_Sr = '政企' then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN A.Class_Type_Sr = '政企' and a.Class_Type2_Sr ='行业' then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN A.Class_Type_Sr = '政企' and a.Class_Type2_Sr ='商客' then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN A.Class_Type_Sr = '政企' and a.Class_Type2_Sr ='校园' then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN A.Class_Type_Sr = '实体' then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN A.Class_Type_Sr = '其他' then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(NVL(B.Month_Amount_Real,0))
 FROM TMP_20170128_AB A,
PU_WT.WT_BIL_OWE_LIST_D_NEW PARTITION(P20171208) B
Where A.SERV_ID(+)  =  B.SERV_ID
Group By A.Area_Code1,A.Area_Name1;


---   新架构分产品类型
/*Select A.Area_Code1,A.Area_Name1,
      SUM(NVL(B.Month_Amount_Real,0)),
      SUM(CASE WHEN b.Std_Term_Type = '有线宽带和宽带帐号' and A.Class_Type_Sr = '实体'  then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = '有线宽带和宽带帐号' and A.Class_Type_Sr = '政企' then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = '有线宽带和宽带帐号' and A.Class_Type_Sr = '其他' then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = '基础数据和网元出租' and A.Class_Type_Sr = '实体'  then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = '基础数据和网元出租' and A.Class_Type_Sr = '政企' then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = '基础数据和网元出租' and A.Class_Type_Sr = '其他' then NVL(B.Month_Amount_Real,0) else 0 end ), 
       SUM(CASE WHEN b.Std_Term_Type = '专线' and A.Class_Type_Sr = '实体'  then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = '专线' and A.Class_Type_Sr = '政企' then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = '专线' and A.Class_Type_Sr = '其他' then NVL(B.Month_Amount_Real,0) else 0 end ), 
      SUM(CASE WHEN b.Std_Term_Type = '固网' and A.Class_Type_Sr = '实体'  then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = '固网' and A.Class_Type_Sr = '政企' then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = '固网' and A.Class_Type_Sr = '其他' then NVL(B.Month_Amount_Real,0) else 0 end ),
       SUM(CASE WHEN b.Std_Term_Type = 'ICT及其他' and A.Class_Type_Sr = '实体'  then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = 'ICT及其他' and A.Class_Type_Sr = '政企' then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = 'ICT及其他' and A.Class_Type_Sr = '其他' then NVL(B.Month_Amount_Real,0) else 0 end ),  
       SUM(CASE WHEN b.Std_Term_Type = '移动' and A.Class_Type_Sr = '实体'  then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = '移动' and A.Class_Type_Sr = '政企' then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = '移动' and A.Class_Type_Sr = '其他' then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = 'IPTV' and A.Class_Type_Sr = '实体'  then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = 'IPTV' and A.Class_Type_Sr = '政企' then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = 'IPTV' and A.Class_Type_Sr = '其他' then NVL(B.Month_Amount_Real,0) else 0 end )         
 FROM TMP_20170128_AB A,
PU_WT.WT_BIL_OWE_LIST_D_NEW PARTITION(P20170308) B
Where A.SERV_ID(+)  =  B.SERV_ID
Group By A.Area_Code1,A.Area_Name1;*/


Select A.Area_Code1,A.Area_Name1,
      SUM(NVL(B.Month_Amount_Real,0)),
      SUM(CASE WHEN b.Std_Term_Type = '有线宽带和宽带帐号' and A.Class_Type_Sr = '实体'  then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = '有线宽带和宽带帐号' and A.Class_Type_Sr = '政企' then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = '有线宽带和宽带帐号' and A.Class_Type_Sr = '其他' then NVL(B.Month_Amount_Real,0) else 0 end ), 
       SUM(CASE WHEN b.Std_Term_Type = '专线' and A.Class_Type_Sr = '实体'  then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = '专线' and A.Class_Type_Sr = '政企' then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = '专线' and A.Class_Type_Sr = '其他' then NVL(B.Month_Amount_Real,0) else 0 end ), 
       SUM(CASE WHEN b.Std_Term_Type = '基础数据和网元出租' and A.Class_Type_Sr = '实体'  then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = '基础数据和网元出租' and A.Class_Type_Sr = '政企' then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = '基础数据和网元出租' and A.Class_Type_Sr = '其他' then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = '固网' and A.Class_Type_Sr = '实体'  then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = '固网' and A.Class_Type_Sr = '政企' then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = '固网' and A.Class_Type_Sr = '其他' then NVL(B.Month_Amount_Real,0) else 0 end ),
       SUM(CASE WHEN b.Std_Term_Type = 'ICT及其他' and A.Class_Type_Sr = '实体'  then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = 'ICT及其他' and A.Class_Type_Sr = '政企' then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = 'ICT及其他' and A.Class_Type_Sr = '其他' then NVL(B.Month_Amount_Real,0) else 0 end ),  
       SUM(CASE WHEN b.Std_Term_Type = '移动' and A.Class_Type_Sr = '实体'  then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = '移动' and A.Class_Type_Sr = '政企' then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = '移动' and A.Class_Type_Sr = '其他' then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = 'IPTV' and A.Class_Type_Sr = '实体'  then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = 'IPTV' and A.Class_Type_Sr = '政企' then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = 'IPTV' and A.Class_Type_Sr = '其他' then NVL(B.Month_Amount_Real,0) else 0 end )      
 FROM TMP_20170128_AB A,
      (Select A.SERV_ID,
       Sum(A.XZQ_AMOUNT_REAL - A.XZQ_OWE_AGE0 + A.XZH_OWE_AGE0)/100 MONTH_AMOUNT_REAL,
       Case
         When A1.TERM_TYPE_ID In (779, 835, 889, 833, 850) Then
          '移动'
         When A1.TERM_TYPE_ID In (2843, 352, 353, 2563, 354, 1721, 355, 1180) Then
          '有线宽带和宽带帐号'
         When A1.TERM_TYPE_ID In (381) Then
          '专线'
         When A1.TERM_TYPE_ID In (298,
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
         When A1.TERM_TYPE_ID In (333, 334, 335, 181, 336, 337, 338, 666) Then
          '基础数据和网元出租'
          when A1.term_type_id in (358,2903) then
           'IPTV'
         Else
          'ICT及其他'
       End STD_TERM_TYPE
  From PU_INTF.WT_SERV_OWE_M_201711_ZML A, F_1_SERV_D_JF A1
 Where A.SERV_ID = A1.SERV_ID(+)
 Group By A.SERV_ID,
          Case
         When A1.TERM_TYPE_ID In (779, 835, 889, 833, 850) Then
          '移动'
         When A1.TERM_TYPE_ID In (2843, 352, 353, 2563, 354, 1721, 355, 1180) Then
          '有线宽带和宽带帐号'
         When A1.TERM_TYPE_ID In (381) Then
          '专线'
         When A1.TERM_TYPE_ID In (298,
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
         When A1.TERM_TYPE_ID In (333, 334, 335, 181, 336, 337, 338, 666) Then
          '基础数据和网元出租'
           when A1.term_type_id in (358,2903) then
           'IPTV'
         Else
          'ICT及其他'
       End) B
Where A.SERV_ID(+)  =  B.SERV_ID
Group By A.Area_Code1,A.Area_Name1;
