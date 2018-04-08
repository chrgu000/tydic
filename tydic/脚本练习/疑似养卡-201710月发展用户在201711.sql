
----   201710 入网用户
CREATE TABLE TMP_20171225_USER_201710 AS
Select *
  From PU_WT.P_SERV_DEV_D_201711 Partition(P20171110) T
 Where T.SERV_CREATE_DATE Like '201710%'
   And T.TERM_TYPE_ID = '779'
   And T.DVLP_CHANNEL_ID In (Select T.DVLP_CHANNEL_ID
                               From PU_WT.P_SERV_DEV_D_201711 Partition(P20171110) T
                              Where T.SERV_CREATE_DATE Like '201710%'
                                And T.TERM_TYPE_ID = '779'
                              Group By T.DVLP_CHANNEL_ID
                             Having Count(*) >= 30);


Select * from TMP_20171225_USER_201710 t;

---- 201710入网用户在201711话单  经分库
DROP TABLE TMP_YY_20171225_USER_1704_3_1 PURGE;
CREATE TABLE TMP_YY_20171225_USER_1704_3_1 NOLOGGING AS
Select * From TMP.TMP_XL_201710_USER_3@DL_YNDATA_58 T Where DURATION Is Not Null;


---被叫号码集中
DROP TABLE TMP_20171225_CALL1_1 PURGE;
CREATE TABLE TMP_20171225_CALL1_1 AS
Select DVLP_CHANNEL_ID, CALLED_NBR,COUNT(*) CALLING_CNT
  From (Select Distinct CALLING_NBR, CALLED_NBR, T2.DVLP_CHANNEL_ID
          From ZML.TMP_YY_20171225_USER_1704_3_1@DL_EDW_YN T1, TMP_20171225_USER_201710_201710_201710 T2
         Where LENGTH(T1.CALLED_NBR) > 5
           And T1.CALLING_NBR = T2.ACC_NBR)
 Group By DVLP_CHANNEL_ID, CALLED_NBR
Having Count(*) >= 10;

DROP TABLE TMP_20171225_CALL1_2 PURGE;
CREATE TABLE TMP_20171225_CALL1_2 AS
Select *
  From (Select A.*, CALLING_CNT / ALL_CNT ZB
          From (Select DVLP_CHANNEL_ID, Sum(CALLING_CNT) CALLING_CNT From TMP_20171225_CALL1_1 Group By DVLP_CHANNEL_ID) A,
               (Select T2.DVLP_CHANNEL_ID, Count(*) ALL_CNT
                  From ZML.TMP_YY_20171225_USER_1704_3_1@DL_EDW_YN T1, TMP_20171225_USER_201710_201710_201710 T2
                 Where T1.SERV_ID = T2.SERV_ID
                 Group By T2.DVLP_CHANNEL_ID) B
         Where A.DVLP_CHANNEL_ID = B.DVLP_CHANNEL_ID);
 --Where ZB >= 0.5;  
 
  
DROP TABLE TMP_20171225_CALL1_3 PURGE;
CREATE TABLE TMP_20171225_CALL1_3 AS
Select A.*
  From (Select Distinct CALLING_NBR, CALLED_NBR, T2.DVLP_CHANNEL_ID,T2.Serv_Id
          From ZML.TMP_YY_20171225_USER_1704_3_1@DL_EDW_YN T1, TMP_20171225_USER_201710_201710_201710 T2
         Where LENGTH(T1.CALLED_NBR) > 5
           And T1.CALLING_NBR = T2.ACC_NBR) A,
       TMP_20171225_CALL1_1 B,
       TMP_20171225_CALL1_2 C
 Where A.CALLED_NBR = B.CALLED_NBR
   And A.DVLP_CHANNEL_ID = B.DVLP_CHANNEL_ID
   AND A.DVLP_CHANNEL_ID  = C.Dvlp_Channel_Id;
   
DROP TABLE TMP_20171225_CALL1 PURGE;
CREATE TABLE TMP_20171225_CALL1 AS
Select DISTINCT SERV_ID,DVLP_CHANNEL_ID FROM TMP_20171225_CALL1_3 T ;

Select COUNT(*),COUNT(DISTINCT SERV_ID) FROM TMP_20171225_CALL1;

--Select * FROM TMP_20171225_CALL1 Where CALLING_NBR = '15368346686';
--Select * FROM TMP_20171225_USER_201710_201710_201710 Where ACC_NBR = '15368346686';

-----通话时长集中
DROP TABLE TMP_20171225_CALL5_1 PURGE;
CREATE TABLE TMP_20171225_CALL5_1 AS
Select  T1.SERV_ID, DUR_LEV, T2.DVLP_CHANNEL_ID,COUNT(*) CALL_CNT
  From (Select T.*,
               Case
                 When Nvl(T.DURATION, 0) <= 10 Then
                  '0--10'
                 When Nvl(T.DURATION, 0) > 10 And
                      Nvl(T.DURATION, 0) <= 20 Then
                  '10--20' 
                 When Nvl(T.DURATION, 0) > 20 And
                      Nvl(T.DURATION, 0) <= 30 Then
                  '20--30'
                 When Nvl(T.DURATION, 0) > 30 And
                      Nvl(T.DURATION, 0) <= 40 Then
                  '30--40'
                 When Nvl(T.DURATION, 0) > 40 And
                      Nvl(T.DURATION, 0) <= 50 Then
                  '40--50'
                 When Nvl(T.DURATION, 0) > 50 And
                      Nvl(T.DURATION, 0) <= 60 Then
                  '50--60'
                 When Nvl(T.DURATION, 0) > 60 And
                      Nvl(T.DURATION, 0) <= 70 Then
                  '60--70'
                  When Nvl(T.DURATION, 0) > 70 And
                      Nvl(T.DURATION, 0) <= 80 Then
                  '70--80'
                  When Nvl(T.DURATION, 0) > 80 And
                      Nvl(T.DURATION, 0) <= 90 Then
                  '80--90'
                  When Nvl(T.DURATION, 0) > 90 And
                      Nvl(T.DURATION, 0) <= 100 Then
                  '90--100'
                  When Nvl(T.DURATION, 0) > 100 And
                      Nvl(T.DURATION, 0) <= 110 Then
                  '100--110'
                  When Nvl(T.DURATION, 0) > 110 And
                      Nvl(T.DURATION, 0) <= 120 Then
                  '110--120'
                 When Nvl(T.DURATION, 0) > 120 Then
                  '120以上'
               End DUR_LEV
          From ZML.TMP_YY_20171225_USER_1704_3_1@DL_EDW_YN T) T1,
       TMP_20171225_USER_201710_201710_201710 T2
 Where T1.SERV_ID = T2.SERV_ID
 Group By  T1.SERV_ID, DUR_LEV, T2.DVLP_CHANNEL_ID; 

DROP TABLE TMP_20171225_CALL5_2 PURGE;
CREATE TABLE TMP_20171225_CALL5_2 AS
Select *
  From (Select A.*, ROW_NUMBER() OVER(Partition By DVLP_CHANNEL_ID Order By CALL_CNT Desc) RN
          From (Select T.DVLP_CHANNEL_ID, T.DUR_LEV, Sum(T.CALL_CNT) CALL_CNT From TMP_20171225_CALL5_1 T Group By T.DVLP_CHANNEL_ID, T.DUR_LEV) A)
 Where RN <= 5; 
         
          
DROP TABLE TMP_20171225_CALL5_3 PURGE;
CREATE TABLE TMP_20171225_CALL5_3 AS
Select *
  From (Select A.DVLP_CHANNEL_ID, A.CALL_CNT / B.CALL_CNT ZB
          From (Select T.DVLP_CHANNEL_ID, Sum(T.CALL_CNT) CALL_CNT From TMP_20171225_CALL5_2 T Group By T.DVLP_CHANNEL_ID) A,
               (Select T.DVLP_CHANNEL_ID, Sum(T.CALL_CNT) CALL_CNT From TMP_20171225_CALL5_1 T Group By T.DVLP_CHANNEL_ID) B
         Where A.DVLP_CHANNEL_ID = B.DVLP_CHANNEL_ID)
 Where ZB >= 0.5; 

Select * FROM TMP_20171225_CALL5_3;

DROP TABLE TMP_20171225_CALL5 PURGE;
CREATE TABLE TMP_20171225_CALL5 AS
Select Distinct A.Serv_Id
  From TMP_20171225_CALL5_1 A,(Select T1.* FROM  TMP_20171225_CALL5_2 T1,TMP_20171225_CALL5_3 T2 Where T1.Dvlp_Channel_Id = T2.Dvlp_Channel_Id) B
 Where A.DUR_LEV = B.DUR_LEV
   And A.DVLP_CHANNEL_ID = B.DVLP_CHANNEL_ID;
    
----使用位置集中
DROP TABLE TMP_20171225_CALL2_1 PURGE;
CREATE TABLE TMP_20171225_CALL2_1 AS
Select DVLP_CHANNEL_ID, CELL_ID, Count(*) NUM_CNT
  From (Select Distinct T1.SERV_ID, T1.CELL_ID, T2.DVLP_CHANNEL_ID
          From ZML.TMP_YY_20171225_USER_1704_3_1@DL_EDW_YN T1, TMP_20171225_USER_201710_201710_201710 T2
         Where T1.SERV_ID = T2.SERV_ID)
 Group By DVLP_CHANNEL_ID, CELL_ID;
 
Select * FROM TMP_20171225_CALL2_1 T Order By NUM_CNT desc;

DROP TABLE TMP_20171225_CALL2_2 PURGE;
CREATE TABLE TMP_20171225_CALL2_2 AS
Select *
  From (Select A.DVLP_CHANNEL_ID, CELL_ID, A.NUM_CNT / B.USER_CNT ZB
          From TMP_20171225_CALL2_1 A, (Select DVLP_CHANNEL_ID, Count(Distinct SERV_ID) USER_CNT From TMP_20171225_USER_201710_201710_201710 Group By DVLP_CHANNEL_ID) B
         Where A.DVLP_CHANNEL_ID = B.DVLP_CHANNEL_ID)
 Where ZB >= 0.5;

 
DROP TABLE TMP_20171225_CALL2 PURGE;
CREATE TABLE TMP_20171225_CALL2 AS
Select Distinct A.SERV_ID
  From (Select Distinct T1.SERV_ID, T1.CELL_ID, T2.DVLP_CHANNEL_ID
          From ZML.TMP_YY_20171225_USER_1704_3_1@DL_EDW_YN T1, TMP_20171225_USER_201710_201710_201710 T2
         Where T1.SERV_ID = T2.SERV_ID) A,
       TMP_20171225_CALL2_2 B
 Where A.CELL_ID = B.CELL_ID
 AND A.Dvlp_Channel_Id = B.Dvlp_Channel_Id;
 
Select COUNT(*),COUNT(DISTINCT SERV_ID) FROM TMP_20171225_CALL2;

 
---- 集中省外身份证开卡
DROP TABLE TMP_20171225_CALL6_1 PURGE;
CREATE TABLE TMP_20171225_CALL6_1 AS
Select A.DVLP_CHANNEL_ID, A.SERV_ID, B.CERT_NBR ,b.cert_type From TMP_20171225_USER_201710_201710 A, TBAS.DAPM_CUST_INFO_201711@DL_EDW_YN B Where A.CUST_ID = B.CUST_ID(+);


DROP TABLE TMP_20171225_CALL6_2 PURGE;
CREATE TABLE TMP_20171225_CALL6_2 AS
Select *
  From (Select DVLP_CHANNEL_ID,
               Count(Distinct Case
                       When CERT_NBR Not Like '53%' Then
                        SERV_ID
                       Else
                        Null
                     End) / Count(Distinct SERV_ID) ZB
          From TMP_20171225_CALL6_1 T
          Where cert_type=1
         Group By DVLP_CHANNEL_ID)
 Where ZB >= 0.5; 
 
 
 DROP TABLE TMP_20171225_CALL6 PURGE;
CREATE TABLE TMP_20171225_CALL6 AS
Select DISTINCT A.Serv_Id
  From TMP_20171225_CALL6_1 A, (Select Distinct DVLP_CHANNEL_ID From TMP_20171225_CALL6_2) B
 Where A.DVLP_CHANNEL_ID = B.DVLP_CHANNEL_ID
   And A.CERT_NBR Not Like '53%'
   AND cert_type=1; 
   


---- 201710入网用户在201711 DPI清单 经分库
DROP TABLE TMP_DPI_20171225_USER_1704 PURGE;
CREATE TABLE TMP_DPI_20171225_USER_1704 NOLOGGING AS
Select * From Tmp.tmp_xl_201710_user_dpi@DL_YNDATA_58 T;

Select * FROM TMP_DPI_20171225_USER_1704;

---- 201710入网用户在201711 DPI终端轨迹 经分库
DROP TABLE TMP_DPI_YY_20171225_USER_1704 PURGE;
CREATE TABLE TMP_DPI_YY_20171225_USER_1704 NOLOGGING AS
Select * From Tmp.Tmp_xl_201710_USER_2@DL_YNDATA_58 T;

Select * FROM TMP_DPI_YY_20171225_USER_1704;



/***************  DPI  ****************/
---机型集中
DROP TABLE TMP_20171225_CALL3_1 PURGE;
CREATE TABLE TMP_20171225_CALL3_1 AS
Select DVLP_CHANNEL_ID, PHONE_TYPE, Count(*) NUM_CNT
  From (Select Distinct T1.SERV_ID, PHONE_TYPE, T2.DVLP_CHANNEL_ID
          From ZML.TMP_DPI_YY_20171225_USER_1704@DL_EDW_YN T1, TMP_20171225_USER_201710 T2
         Where T1.SERV_ID = T2.SERV_ID)
 Group By DVLP_CHANNEL_ID, PHONE_TYPE;
 
 
DROP TABLE TMP_20171225_CALL3_2 PURGE;
CREATE TABLE TMP_20171225_CALL3_2 AS
Select *
  From (Select T.*, ROW_NUMBER() OVER(Partition By DVLP_CHANNEL_ID Order By NUM_CNT Desc) RN From TMP_20171225_CALL3_1 T Where T.PHONE_TYPE Is Not Null)
 Where RN <= 2; 

DROP TABLE TMP_20171225_CALL3_3 PURGE;
CREATE TABLE TMP_20171225_CALL3_3 AS
Select *
  From (Select A.DVLP_CHANNEL_ID, A.Phone_Type, A.NUM_CNT / B.USER_CNT ZB
          From TMP_20171225_CALL3_2 A, (Select DVLP_CHANNEL_ID, Count(Distinct SERV_ID) USER_CNT From TMP_20171225_USER_201710 Group By DVLP_CHANNEL_ID) B
         Where A.DVLP_CHANNEL_ID = B.DVLP_CHANNEL_ID)
 Where ZB >= 0.8;

Select * FROM TMP_20171225_CALL3_3;

DROP TABLE TMP_20171225_CALL3 PURGE;
CREATE TABLE TMP_20171225_CALL3 AS
Select Distinct A.SERV_ID
  From (Select Distinct T1.SERV_ID, PHONE_TYPE, T2.DVLP_CHANNEL_ID
          From ZML.TMP_DPI_YY_20171225_USER_1704@DL_EDW_YN T1, TMP_20171225_USER_201710 T2
         Where T1.SERV_ID = T2.SERV_ID) A,
       TMP_20171225_CALL3_3 B
 Where A.DVLP_CHANNEL_ID = B.DVLP_CHANNEL_ID
   And A.PHONE_TYPE = B.PHONE_TYPE;     


---- 自注册无数据
DROP TABLE TMP_20171225_CALL4_1 PURGE;
CREATE TABLE TMP_20171225_CALL4_1 AS
Select A.SERV_ID
  From (Select Distinct T1.SERV_ID,T2.Acc_Nbr From ZML.TMP_DPI_YY_20171225_USER_1704@DL_EDW_YN T1, TMP_20171225_USER_201710 T2 Where T1.SERV_ID = T2.SERV_ID) A,
       (Select Distinct T.ACC_NBR
          From PU_INTF.I_PRD_PHONE_TERMINAL_A T
         Where TO_CHAR(TO_DATE(Substr(CREATE_DATE, 1, 10), 'YYYY-MM-DD'), 'YYYYMMDD') >= '20171001') B
 Where A.ACC_NBR = B.ACC_NBR(+)
   And B.ACC_NBR Is Null;

DROP TABLE TMP_20171225_CALL4_2 PURGE;
CREATE TABLE TMP_20171225_CALL4_2 AS
Select *
  From (Select A.DVLP_CHANNEL_ID,
               Count(Distinct Case
                       When B.SERV_ID Is Not Null Then
                        B.SERV_ID
                       Else
                        Null
                     End) / Count(Distinct A.SERV_ID) ZB
          From TMP_20171225_USER_201710 A, TMP_20171225_CALL4_1 B
         Where A.SERV_ID = B.SERV_ID(+)
         Group By A.DVLP_CHANNEL_ID)
Where ZB>=0.5;
         
DROP TABLE TMP_20171225_CALL4 PURGE;
CREATE TABLE TMP_20171225_CALL4 AS
Select Distinct A.SERV_ID
  From TMP_20171225_USER_201710 A, TMP_20171225_CALL4_1 B, TMP_20171225_CALL4_2 C
 Where A.SERV_ID = B.SERV_ID
   And A.DVLP_CHANNEL_ID = C.DVLP_CHANNEL_ID;  
      
Select * FROM TMP_20171225_CALL4;   
 
------   初步汇总  用户清单
DROP TABLE TMP_20171225_RESULT_1704_1 PURGE;
CREATE TABLE TMP_20171225_RESULT_1704_1 AS
Select AA.*, T3.td_class_type,
       DECODE(T1.Serv_Id,NULL,0,1) IS_YY_YSYK, 
       Decode(T4.SERV_ID, Null, 0, 1) IS_PHONE_JZ, 
       Decode(T5.SERV_ID, Null, 0, 1) IS_NO_SELF,
       Decode(T6.SERV_ID, Null, 0, 1) IS_CERT_JZ,
       CASE WHEN T2.cert_type=1 AND T2.CERT_NBR Not Like '53%' THEN 1 ELSE 0 END  IS_SWJZ
  From TMP_20171225_USER_201710 AA,
       (Select A.*
          From TMP_20171225_USER_201710 A, TMP_20171225_CALL1 B, TMP_20171225_CALL5 C, TMP_20171225_CALL2 D
         Where A.SERV_ID = B.SERV_ID
           And A.SERV_ID = C.SERV_ID
           And A.SERV_ID = D.SERV_ID) T1, 
       TMP_20171225_CALL6_1 T2,
       TBAS.WT_PROD_SERV_D_201711@Dl_Edw_Yn T3,
       TMP_20171225_CALL3 T4, 
       TMP_20171225_CALL4 T5,
       TMP_20171225_CALL6 T6
 Where AA.SERV_ID  =  T1.SERV_ID(+) 
   And AA.SERV_ID = T2.SERV_ID(+)
   AND AA.SERV_ID = T3.SERV_ID(+)
   AND AA.SERV_ID = T4.SERV_ID(+) 
   AND AA.SERV_ID = T5.SERV_ID(+) 
   And AA.SERV_ID = T6.SERV_ID(+);  

Select * FROM TMP_20171225_RESULT_1704_1 T;
Select T.Is_Yy_Ysyk,COUNT(*) FROM TMP_20171225_RESULT_1704_1 T Group By T.Is_Yy_Ysyk;

---   二次汇总  
DROP TABLE TMP_20171225_RESULT_1704_2 PURGE;
CREATE TABLE TMP_20171225_RESULT_1704_2 AS
Select A.AREA_CODE,
       B.AREA_NAME,
       A.BRANCH_CODE3,
       A.BRANCH_NAME3,
       A.DVLP_CHANNEL_ID,
       A.CHANNEL_NAME,
       A.TD_CLASS_TYPE,
       A.CHANNEL_TYPE_CLASS,
       C.CREATE_DT,
       Count(Distinct SERV_ID) DEV_NUM,
       Sum(IS_YY_YSYK) YY_YSYK_NUM,
       Sum(A.IS_PHONE_JZ) PHONE_JZ_NUM,
       Sum(A.IS_CERT_JZ) CERT_JZ_NUM,
       Count(Distinct Case
               When A.IS_YY_YSYK = 1 Or
                    A.IS_PHONE_JZ = 1 Or
                    A.IS_NO_SELF = 1 Then
                A.SERV_ID
               Else
                Null
             End) YSYK_NUM,
       Decode(Count(Distinct SERV_ID), 0, 0, Sum(IS_YY_YSYK) / Count(Distinct SERV_ID)) YY_YSYK_ZB,
       Sum(A.IS_SWJZ) SWZJ_NUM,
       Decode(Count(Distinct SERV_ID), 0, 0, Sum(A.IS_SWJZ) / Count(Distinct SERV_ID)) SWZJ_ZB,
       Nvl(D.CALLING_CNT, 0) CALLING_CNT,
       Nvl(E.ZB, 0) DUR_ZB,
       Nvl(F.ZB, 0) CELL_ZB
  From TMP_20171225_RESULT_1704_1 A,
       PU_META.LATN_NEW B,
       PU_META.F_1_CRM_CHANNEL C,
       (Select *
          From (Select T.*, ROW_NUMBER() OVER(Partition By DVLP_CHANNEL_ID Order By CALLING_CNT Desc) RN From TMP_20171225_CALL1_1 T)
         Where RN = 1) D,
       (Select A.DVLP_CHANNEL_ID, A.CALL_CNT / B.CALL_CNT ZB
          From (Select T.DVLP_CHANNEL_ID, Sum(T.CALL_CNT) CALL_CNT From TMP_20171225_CALL5_2 T Group By T.DVLP_CHANNEL_ID) A,
               (Select T.DVLP_CHANNEL_ID, Sum(T.CALL_CNT) CALL_CNT From TMP_20171225_CALL5_1 T Group By T.DVLP_CHANNEL_ID) B
         Where A.DVLP_CHANNEL_ID = B.DVLP_CHANNEL_ID) E,
       (Select *
          From (Select T.*, ROW_NUMBER() OVER(Partition By DVLP_CHANNEL_ID Order By ZB Desc) RN
                  From (Select A.DVLP_CHANNEL_ID, CELL_ID, A.NUM_CNT / B.USER_CNT ZB
                          From TMP_20171225_CALL2_1 A,
                               (Select DVLP_CHANNEL_ID, Count(Distinct SERV_ID) USER_CNT From TMP_20171225_USER_201710 Group By DVLP_CHANNEL_ID) B
                         Where A.DVLP_CHANNEL_ID = B.DVLP_CHANNEL_ID) T)
         Where RN = 1) F
 Where A.AREA_CODE = B.LOCAL_CODE(+)
   And A.DVLP_CHANNEL_ID = C.CHANNEL_ID(+)
   And A.DVLP_CHANNEL_ID = D.DVLP_CHANNEL_ID(+)
   And A.DVLP_CHANNEL_ID = E.DVLP_CHANNEL_ID(+)
   And A.DVLP_CHANNEL_ID = F.DVLP_CHANNEL_ID(+)
 Group By A.AREA_CODE,
          B.AREA_NAME,
          A.BRANCH_CODE3,
          A.BRANCH_NAME3,
          A.DVLP_CHANNEL_ID,
          A.CHANNEL_NAME,
          A.TD_CLASS_TYPE,
          A.CHANNEL_TYPE_CLASS,
          C.CREATE_DT,
          Nvl(D.CALLING_CNT, 0),
          Nvl(E.ZB, 0),
          Nvl(F.ZB, 0);          
          
Select * FROM TMP_20171225_RESULT_1704_2 T;    
