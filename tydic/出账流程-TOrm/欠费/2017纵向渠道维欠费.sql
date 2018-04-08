
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
          'ʡ����'
         When C.BRANCH_CODE2 = '85344000000' Then
          '�Ű�'
         When C.BRANCH_CODE2 = '85301000850' Then
          '�Ų���˾'
         When C.BRANCH_CODE3 = '85301970000' Then
          'ʡ��ҵ�ͻ���'
         When C.BRANCH_CODE2 = '85301000439' Or
              C.BRANCH_CODE2 = '85301000860' Or
              C.BRANCH_CODE2 = '85301000421' Then
          'ʡ����'
         Else
          F.AREA_NAME
       End AREA_NAME1,
       Case
         When D.SERV_ID Is Not Null Then
          'ʡ����'
         When C.BRANCH_CODE2 = '85344000000' Then
          '�Ű�'
         When C.BRANCH_CODE2 = '85301000850' Then
          '�Ų���˾'
         When C.BRANCH_CODE3 = '85301970000' Then
          'ʡ��ҵ�ͻ���'
         When C.BRANCH_CODE2 = '85301000439' then '�г���'
         When C.BRANCH_CODE2 = '85301000860' THEN 'ʡ��������'
         When C.BRANCH_CODE2 = '85301000421' THEN '����������Ӫ����' 
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

 
---  ͳ��
����  ������ҵ  �����̿�  ����У԰  ʵ��  ICT������

DROP TABLE TMP_20170128_AB PURGE;
CREATE TABLE TMP_20170128_AB AS
Select T.*,
       Case
         When T.CLASS_TYPE In ('����', '�̿�') Or
              T.AREA_NAME1 Like '%�Ų�%' Then
          '����'
         When T.CLASS_TYPE In ('ʵ��', 'δ����') Or
              (T.CLASS_TYPE = '����' And T.AREA_NAME1 NOT IN ('�Ų���˾','�Ű�', 'ʡ����')) Then
          'ʵ��'
         When  T.CLASS_TYPE = '����' And
              T.AREA_NAME1 in ('�Ű�', 'ʡ����')  Then
          '����'
       End CLASS_TYPE_SR,  ---- �������
       Case
         When (T.CLASS_TYPE = '����' And T.CLASS_TYPE2 = '������ҵ') Or
              T.AREA_NAME1 Like '%�Ų�%' Then
          '��ҵ'
         When T.CLASS_TYPE = '�̿�' Then
          '�̿�'
         When T.CLASS_TYPE = '����' And
              T.CLASS_TYPE2 In ('У԰ר������', '����У԰', 'У԰֧��') Then
          'У԰'
       End CLASS_TYPE2_SR ---- ����С��
  From TMP_20170128_AA T;
  
 
Select A.Area_Code1,A.Area_Name1, 
      SUM(CASE WHEN A.Class_Type_Sr = '����' then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN A.Class_Type_Sr = '����' and a.Class_Type2_Sr ='��ҵ' then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN A.Class_Type_Sr = '����' and a.Class_Type2_Sr ='�̿�' then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN A.Class_Type_Sr = '����' and a.Class_Type2_Sr ='У԰' then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN A.Class_Type_Sr = 'ʵ��' then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN A.Class_Type_Sr = '����' then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(NVL(B.Month_Amount_Real,0))
 FROM TMP_20170128_AB A,
PU_WT.WT_BIL_OWE_LIST_D_NEW PARTITION(P20171208) B
Where A.SERV_ID(+)  =  B.SERV_ID
Group By A.Area_Code1,A.Area_Name1;


---   �¼ܹ��ֲ�Ʒ����
/*Select A.Area_Code1,A.Area_Name1,
      SUM(NVL(B.Month_Amount_Real,0)),
      SUM(CASE WHEN b.Std_Term_Type = '���߿���Ϳ���ʺ�' and A.Class_Type_Sr = 'ʵ��'  then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = '���߿���Ϳ���ʺ�' and A.Class_Type_Sr = '����' then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = '���߿���Ϳ���ʺ�' and A.Class_Type_Sr = '����' then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = '�������ݺ���Ԫ����' and A.Class_Type_Sr = 'ʵ��'  then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = '�������ݺ���Ԫ����' and A.Class_Type_Sr = '����' then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = '�������ݺ���Ԫ����' and A.Class_Type_Sr = '����' then NVL(B.Month_Amount_Real,0) else 0 end ), 
       SUM(CASE WHEN b.Std_Term_Type = 'ר��' and A.Class_Type_Sr = 'ʵ��'  then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = 'ר��' and A.Class_Type_Sr = '����' then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = 'ר��' and A.Class_Type_Sr = '����' then NVL(B.Month_Amount_Real,0) else 0 end ), 
      SUM(CASE WHEN b.Std_Term_Type = '����' and A.Class_Type_Sr = 'ʵ��'  then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = '����' and A.Class_Type_Sr = '����' then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = '����' and A.Class_Type_Sr = '����' then NVL(B.Month_Amount_Real,0) else 0 end ),
       SUM(CASE WHEN b.Std_Term_Type = 'ICT������' and A.Class_Type_Sr = 'ʵ��'  then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = 'ICT������' and A.Class_Type_Sr = '����' then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = 'ICT������' and A.Class_Type_Sr = '����' then NVL(B.Month_Amount_Real,0) else 0 end ),  
       SUM(CASE WHEN b.Std_Term_Type = '�ƶ�' and A.Class_Type_Sr = 'ʵ��'  then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = '�ƶ�' and A.Class_Type_Sr = '����' then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = '�ƶ�' and A.Class_Type_Sr = '����' then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = 'IPTV' and A.Class_Type_Sr = 'ʵ��'  then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = 'IPTV' and A.Class_Type_Sr = '����' then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = 'IPTV' and A.Class_Type_Sr = '����' then NVL(B.Month_Amount_Real,0) else 0 end )         
 FROM TMP_20170128_AB A,
PU_WT.WT_BIL_OWE_LIST_D_NEW PARTITION(P20170308) B
Where A.SERV_ID(+)  =  B.SERV_ID
Group By A.Area_Code1,A.Area_Name1;*/


Select A.Area_Code1,A.Area_Name1,
      SUM(NVL(B.Month_Amount_Real,0)),
      SUM(CASE WHEN b.Std_Term_Type = '���߿���Ϳ���ʺ�' and A.Class_Type_Sr = 'ʵ��'  then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = '���߿���Ϳ���ʺ�' and A.Class_Type_Sr = '����' then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = '���߿���Ϳ���ʺ�' and A.Class_Type_Sr = '����' then NVL(B.Month_Amount_Real,0) else 0 end ), 
       SUM(CASE WHEN b.Std_Term_Type = 'ר��' and A.Class_Type_Sr = 'ʵ��'  then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = 'ר��' and A.Class_Type_Sr = '����' then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = 'ר��' and A.Class_Type_Sr = '����' then NVL(B.Month_Amount_Real,0) else 0 end ), 
       SUM(CASE WHEN b.Std_Term_Type = '�������ݺ���Ԫ����' and A.Class_Type_Sr = 'ʵ��'  then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = '�������ݺ���Ԫ����' and A.Class_Type_Sr = '����' then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = '�������ݺ���Ԫ����' and A.Class_Type_Sr = '����' then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = '����' and A.Class_Type_Sr = 'ʵ��'  then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = '����' and A.Class_Type_Sr = '����' then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = '����' and A.Class_Type_Sr = '����' then NVL(B.Month_Amount_Real,0) else 0 end ),
       SUM(CASE WHEN b.Std_Term_Type = 'ICT������' and A.Class_Type_Sr = 'ʵ��'  then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = 'ICT������' and A.Class_Type_Sr = '����' then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = 'ICT������' and A.Class_Type_Sr = '����' then NVL(B.Month_Amount_Real,0) else 0 end ),  
       SUM(CASE WHEN b.Std_Term_Type = '�ƶ�' and A.Class_Type_Sr = 'ʵ��'  then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = '�ƶ�' and A.Class_Type_Sr = '����' then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = '�ƶ�' and A.Class_Type_Sr = '����' then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = 'IPTV' and A.Class_Type_Sr = 'ʵ��'  then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = 'IPTV' and A.Class_Type_Sr = '����' then NVL(B.Month_Amount_Real,0) else 0 end ),
      SUM(CASE WHEN b.Std_Term_Type = 'IPTV' and A.Class_Type_Sr = '����' then NVL(B.Month_Amount_Real,0) else 0 end )      
 FROM TMP_20170128_AB A,
      (Select A.SERV_ID,
       Sum(A.XZQ_AMOUNT_REAL - A.XZQ_OWE_AGE0 + A.XZH_OWE_AGE0)/100 MONTH_AMOUNT_REAL,
       Case
         When A1.TERM_TYPE_ID In (779, 835, 889, 833, 850) Then
          '�ƶ�'
         When A1.TERM_TYPE_ID In (2843, 352, 353, 2563, 354, 1721, 355, 1180) Then
          '���߿���Ϳ���ʺ�'
         When A1.TERM_TYPE_ID In (381) Then
          'ר��'
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
          '����'
         When A1.TERM_TYPE_ID In (333, 334, 335, 181, 336, 337, 338, 666) Then
          '�������ݺ���Ԫ����'
          when A1.term_type_id in (358,2903) then
           'IPTV'
         Else
          'ICT������'
       End STD_TERM_TYPE
  From PU_INTF.WT_SERV_OWE_M_201711_ZML A, F_1_SERV_D_JF A1
 Where A.SERV_ID = A1.SERV_ID(+)
 Group By A.SERV_ID,
          Case
         When A1.TERM_TYPE_ID In (779, 835, 889, 833, 850) Then
          '�ƶ�'
         When A1.TERM_TYPE_ID In (2843, 352, 353, 2563, 354, 1721, 355, 1180) Then
          '���߿���Ϳ���ʺ�'
         When A1.TERM_TYPE_ID In (381) Then
          'ר��'
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
          '����'
         When A1.TERM_TYPE_ID In (333, 334, 335, 181, 336, 337, 338, 666) Then
          '�������ݺ���Ԫ����'
           when A1.term_type_id in (358,2903) then
           'IPTV'
         Else
          'ICT������'
       End) B
Where A.SERV_ID(+)  =  B.SERV_ID
Group By A.Area_Code1,A.Area_Name1;
