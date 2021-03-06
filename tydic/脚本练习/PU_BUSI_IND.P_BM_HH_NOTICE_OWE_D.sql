CREATE OR REPLACE Procedure PU_BUSI_IND.P_BM_HH_NOTICE_OWE_D(V_DATE In Varchar2) Is

--- DESC: 公司欠费通报

  V_MONTH      Varchar2(6);
  V_LAST_MONTH Varchar2(6);
  V_LAST_DATE    Varchar2(8);
  --V_DAY        VARCHAR2(2);
  V_LAST_YEAR VARCHAR2(4);
  V_LAST_YEAR_M VARCHAR2(6);
  V_MONTH_M  VARCHAR2(6);
  V_DAY_M VARCHAR2(8);
Begin
  V_MONTH      := Substr(V_DATE, 1, 6);
  V_LAST_MONTH := TO_CHAR(ADD_MONTHS(TO_DATE(V_MONTH, 'YYYYMM'), -1), 'YYYYMM');
  V_LAST_DATE  := TO_CHAR(TO_DATE(V_DATE,'YYYYMMDD')-1,'YYYYMMDD');
  --V_DAY        := SUBSTR(V_DATE,-2);
  V_LAST_YEAR := substr(TO_CHAR(ADD_MONTHS(TO_DATE(V_MONTH, 'YYYYMM'), -12), 'YYYYMM'),1,4);
  V_LAST_YEAR_M := V_LAST_YEAR||'12';


/*****************    总欠费   *******************************/

  ----- 出账欠费  通报日欠费  本月已回收  回收率  当日回收欠费
  Begin
    Execute Immediate 'DROP TABLE PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_A PURGE';
  Exception
    When Others Then
      Null;
  End;
  EXECUTE IMMEDIATE'
  CREATE TABLE PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_A AS
  Select STD_AREA_ID,
         nvl(STD_AREA_NAME,''未知'') STD_AREA_NAME,
         Sum(MONTH_AMOUNT_REAL)*10000 MONTH_AMOUNT_REAL, --月欠费 
         Sum(AMOUNT_DAY)*10000 AMOUNT_DAY, --  --日欠费
         Sum(REC_M)*10000 REC_M, --月回收
         Decode(Sum(MONTH_AMOUNT_REAL), 0, 0, Sum(REC_M) / Sum(MONTH_AMOUNT_REAL)) REC_RATE_M, -- 月回收 /月欠费=月回收率
         Sum(AMOUNT_LAST - AMOUNT_day)*10000 REC_D  -- 上一天欠费-当天欠费=日回收
    From (Select T.STD_AREA_ID,
                 T.STD_AREA_NAME,
                 Sum(T.MONTH_AMOUNT_REAL) MONTH_AMOUNT_REAL,
                 Sum(T.AMOUNT) AMOUNT_DAY,
                 Sum(T.MONTH_AMOUNT_REAL - T.AMOUNT) REC_M,
                 0 AMOUNT_LAST
            From PU_BUSI_IND.BM_BIL_OWE_REC_D_'||V_MONTH||'_NEW Partition(P'||V_DATE||') T
           Where T.AREA_NAME = ''红河''
           Group By T.STD_AREA_ID, T.STD_AREA_NAME
          Union All
          Select T.STD_AREA_ID, T.STD_AREA_NAME, 0 MONTH_AMOUNT_REAL, 0 AMOUNT_DAY, 0 REC_M, Sum(T.AMOUNT) AMOUNT_LAST
            From PU_BUSI_IND.BM_BIL_OWE_REC_D_'||V_MONTH||'_NEW Partition(P'||V_LAST_DATE||') T
           Where T.AREA_NAME = ''红河''
           Group By T.STD_AREA_ID, T.STD_AREA_NAME)
   Group By STD_AREA_ID, nvl(STD_AREA_NAME,''未知'')';

  /*****************    总欠费  END *******************************/



  /*****************    零账龄欠费   *******************************/

  ----- 出账欠费  通报日欠费 回收率 当日回收欠费
  Begin
    Execute Immediate 'DROP TABLE PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_B PURGE';
  Exception
    When Others Then
      Null;
  End;
  EXECUTE IMMEDIATE'
  CREATE TABLE PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_B AS
  Select STD_AREA_ID,
         nvl(STD_AREA_NAME,''未知'') STD_AREA_NAME,
         Sum(MONTH_AMOUNT_REAL)*10000 MONTH_AMOUNT_REAL,
         Sum(AMOUNT_DAY)*10000 AMOUNT_DAY,
         Decode(Sum(MONTH_AMOUNT_REAL), 0, 0, Sum(REC_M) / Sum(MONTH_AMOUNT_REAL)) REC_RATE_M,
         Sum(AMOUNT_LAST - AMOUNT_day)*10000 REC_D
    From (Select T.STD_AREA_ID,
                 T.STD_AREA_NAME,
                 Sum(T.GZ_MONTH_AMOUNT_REAL+ZQ_MONTH_AMOUNT_REAL+QT_MONTH_AMOUNT_REAL) MONTH_AMOUNT_REAL,
                 Sum(T.GZ_AMOUNT+ZQ_AMOUNT+QT_AMOUNT) AMOUNT_DAY,
                 Sum(T.GZ_MONTH_AMOUNT_REAL+ZQ_MONTH_AMOUNT_REAL+QT_MONTH_AMOUNT_REAL - (GZ_AMOUNT+ZQ_AMOUNT+QT_AMOUNT)) REC_M,
                 0 AMOUNT_LAST
            From PU_BUSI_IND.BM_BIL_OWE_REC_D_'||V_MONTH||'_LZ_NEW Partition(P'||V_DATE||') T
           Where T.AREA_NAME = ''红河''
           Group By T.STD_AREA_ID, T.STD_AREA_NAME
          Union All
          Select T.STD_AREA_ID, T.STD_AREA_NAME, 0 MONTH_AMOUNT_REAL, 0 AMOUNT_DAY, 0 REC_M, Sum(GZ_AMOUNT+ZQ_AMOUNT+QT_AMOUNT) AMOUNT_LAST
            From PU_BUSI_IND.BM_BIL_OWE_REC_D_'||V_MONTH||'_LZ_NEW Partition(P'||V_LAST_DATE||') T
           Where T.AREA_NAME = ''红河''
           Group By T.STD_AREA_ID, T.STD_AREA_NAME)
   Group By STD_AREA_ID, nvl(STD_AREA_NAME,''未知'')';

  /*****************    零账龄欠费  END *******************************/

  /*****************   2017年新增欠费（V_LAST_YEAR||'12'-V_LAST_MONTH账期）   *******************************/

   --------   月欠费
   Begin
    Execute Immediate 'DROP TABLE PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_C_DL PURGE';
  Exception
    When Others Then
      Null;
  End;
  EXECUTE IMMEDIATE'
  CREATE TABLE PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_C_DL AS
  Select A.SERV_ID,
         Case
           When Substr(A.BILLING_CYCLE_ID, 1, 2) In (''10'', ''11'') And
                Substr(A.BILLING_CYCLE_ID, 4, 2) = ''13'' Then
            ''20'' || Substr(A.BILLING_CYCLE_ID, 2, 2) || ''12''
           When Substr(A.BILLING_CYCLE_ID, 1, 2) In (''10'', ''11'') Then
            ''20'' || Substr(A.BILLING_CYCLE_ID, 2, 4)
           When Substr(A.BILLING_CYCLE_ID, 4, 2) = ''13'' Then
            ''19'' || Substr(A.BILLING_CYCLE_ID, 2, 2) || ''12''
           Else
            ''19'' || Substr(A.BILLING_CYCLE_ID, 2, 4)
         End FEE_MONTH,
         Sum(A.TAB_AMOUNT) DL_AMOUNT,
         A.BILLING_CYCLE_ID
    From PU_MODEL.TB_BIL_OWE_TAB_'||V_LAST_MONTH||'@DL_EDW_YN A
   Where LATN_ID = ''0873''
     And A.TAB_AMOUNT > 0
     and nvl(QF_OR_HZ,''5JA'')<>''5JF''
   Group By A.SERV_ID,
            Case
              When Substr(A.BILLING_CYCLE_ID, 1, 2) In (''10'', ''11'') And
                   Substr(A.BILLING_CYCLE_ID, 4, 2) = ''13'' Then
               ''20'' || Substr(A.BILLING_CYCLE_ID, 2, 2) || ''12''
              When Substr(A.BILLING_CYCLE_ID, 1, 2) In (''10'', ''11'') Then
               ''20'' || Substr(A.BILLING_CYCLE_ID, 2, 4)
              When Substr(A.BILLING_CYCLE_ID, 4, 2) = ''13'' Then
               ''19'' || Substr(A.BILLING_CYCLE_ID, 2, 2) || ''12''
              Else
               ''19'' || Substr(A.BILLING_CYCLE_ID, 2, 4)
            End,
            A.BILLING_CYCLE_ID';
  /*
   Begin
    Execute Immediate 'DROP TABLE PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_C_XZH PURGE';
  Exception
    When Others Then
      Null;
  End;
  EXECUTE IMMEDIATE'
  CREATE TABLE PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_C_XZH AS
  Select A.*,
         Case
           When A.STATE In (''5JD'', ''5JF'') Then
            A.AMOUNT
           Else
            0
         End XZH_DH_AMONUT,
         Case
           When A.STATE = ''5JC'' Then
            A.AMOUNT
           Else
            0
         End XZH_ST_AMONUT,
         Case
           When A.STATE = ''5JA'' Then
            A.AMOUNT
           Else
            0
         End XZH_OWE_AMONTH,
         Case
           When Substr(A.BILLING_CYCLE_ID, 1, 2) In (''10'', ''11'') And
                Substr(A.BILLING_CYCLE_ID, 4, 2) = ''13'' Then
            ''20'' || Substr(A.BILLING_CYCLE_ID, 2, 2) || ''12''
           When Substr(A.BILLING_CYCLE_ID, 1, 2) In (''10'', ''11'') Then
            ''20'' || Substr(A.BILLING_CYCLE_ID, 2, 4)
           When Substr(A.BILLING_CYCLE_ID, 4, 2) = ''13'' Then
            ''19'' || Substr(A.BILLING_CYCLE_ID, 2, 2) || ''12''
           Else
            ''19'' || Substr(A.BILLING_CYCLE_ID, 2, 4)
         End FEE_MONTH,
         Case
           When Nvl(B.DL_AMOUNT, 0) <> 0 Then
            1
           Else
            0
         End IS_DL_FLAG
    From (Select * From PU_MODEL.TB_BIL_OWE_M_'||V_LAST_MONTH||'@DL_EDW_YN Where AREA_CODE = ''0873'') A
    Left Join PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_C_DL B
      On A.SERV_ID = B.SERV_ID
     And A.BILLING_CYCLE_ID = B.BILLING_CYCLE_ID
   Where A.STATE In (''5JA'', ''5JD'', ''5JC'', ''5JF'')';

   Begin
    Execute Immediate 'DROP TABLE PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_C_XZH1 PURGE';
  Exception
    When Others Then
      Null;
  End;
  EXECUTE IMMEDIATE'
  CREATE TABLE PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_C_XZH1 AS
  SELECT  A.SERV_ID,
          A.Fee_Month,
          MAX(A.IS_DL_FLAG) IS_DL_FLAG,
          SUM(A.AMOUNT) XZH_AMOUNT_TOTAL,
          SUM(CASE WHEN A.IS_DL_FLAG = 0 THEN A.XZH_DH_AMONUT ELSE 0 END ) XZH_AMOUNT_DX,
          SUM(CASE WHEN A.IS_DL_FLAG = 0 THEN A.XZH_ST_AMONUT ELSE 0 END ) XZH_AMOUNT_ST,
          SUM(CASE  WHEN A.IS_DL_FLAG=1 THEN A.AMOUNT ELSE 0 END) XZH_AMOUNT_DL,
          SUM(CASE WHEN A.IS_DL_FLAG=0 THEN A.AMOUNT-A.XZH_DH_AMONUT ELSE 0 END) XZH_AMOUNT_REAL,
          SUM(CASE WHEN A.FEE_MONTH = '''||V_LAST_MONTH||''' THEN  A.AMOUNT ELSE 0 END ) XZH_AMOUNT_TOTAL_AGE0,
          SUM(CASE WHEN A.IS_DL_FLAG = 0 AND A.FEE_MONTH = '''||V_LAST_MONTH||'''THEN A.XZH_DH_AMONUT ELSE 0 END ) XZH_AMOUNT_DX_AGE0,
          SUM(CASE WHEN A.IS_DL_FLAG = 0 AND A.FEE_MONTH = '''||V_LAST_MONTH||''' THEN A.XZH_ST_AMONUT ELSE 0 END ) XZH_AMOUNT_ST_AGE0,
          SUM(CASE  WHEN A.IS_DL_FLAG=1 AND A.FEE_MONTH= '''||V_LAST_MONTH||''' THEN A.AMOUNT ELSE 0 END) XZH_AMOUNT_DL_AGE0,
          SUM(CASE WHEN A.IS_DL_FLAG=0 AND A.FEE_MONTH='''||V_LAST_MONTH||''' THEN A.AMOUNT-A.XZH_DH_AMONUT ELSE 0 END) XZH_OWE_AGE0
     FROM PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_C_XZH A
  GROUP BY A.SERV_ID,A.Fee_Month';

   Begin
    Execute Immediate 'DROP TABLE PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_C_XZQ PURGE';
  Exception
    When Others Then
      Null;
  End;
  EXECUTE IMMEDIATE'
  CREATE TABLE PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_C_XZQ AS
  Select A.*,
         Case
           When A.STATE In (''5JD'', ''5JF'') Then
            A.AMOUNT
           Else
            0
         End XZQ_DH_AMONUT,
         Case
           When A.STATE = ''5JC'' Then
            A.AMOUNT
           Else
            0
         End XZQ_ST_AMONUT,
         Case
           When A.STATE = ''5JA'' Then
            A.AMOUNT
           Else
            0
         End XZQ_OWE_AMONTH,
         Case
           When Substr(A.BILLING_CYCLE_ID, 1, 2) In (''10'', ''11'') And
                Substr(A.BILLING_CYCLE_ID, 4, 2) = ''13'' Then
            ''20'' || Substr(A.BILLING_CYCLE_ID, 2, 2) || ''12''
           When Substr(A.BILLING_CYCLE_ID, 1, 2) In (''10'', ''11'') Then
            ''20'' || Substr(A.BILLING_CYCLE_ID, 2, 4)
           When Substr(A.BILLING_CYCLE_ID, 4, 2) = ''13'' Then
            ''19'' || Substr(A.BILLING_CYCLE_ID, 2, 2) || ''12''
           Else
            ''19'' || Substr(A.BILLING_CYCLE_ID, 2, 4)
         End FEE_MONTH,
         Case
           When Nvl(B.DL_AMOUNT, 0) <> 0 Then
            1
           Else
            0
         End IS_DL_FLAG
    From (Select * From PU_MODEL.TB_BIL_OWE_BEF_M_'||V_LAST_MONTH||'@DL_EDW_YN Where STD_AREA_ID = ''0873'') A
    Left Join PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_C_DL B
      On A.SERV_ID = B.SERV_ID
     And A.BILLING_CYCLE_ID = B.BILLING_CYCLE_ID
   Where A.STATE In (''5JA'', ''5JD'', ''5JC'', ''5JF'')';

   Begin
    Execute Immediate 'DROP TABLE PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_C_XZQ1 PURGE';
  Exception
    When Others Then
      Null;
  End;
  EXECUTE IMMEDIATE'
  CREATE TABLE PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_C_XZQ1  AS
  SELECT  A.SERV_ID,
          A.Fee_Month,
          SUM(A.AMOUNT) XZQ_AMOUNT_TOTAL,
          SUM(CASE WHEN A.IS_DL_FLAG = 0 THEN A.XZQ_DH_AMONUT ELSE 0 END ) XZQ_AMOUNT_DX,
          SUM(CASE WHEN A.IS_DL_FLAG = 0 THEN A.XZQ_ST_AMONUT ELSE 0 END ) XZQ_AMOUNT_ST,
          SUM(CASE  WHEN A.IS_DL_FLAG=1 THEN A.AMOUNT ELSE 0 END) XZQ_AMOUNT_DL,
          SUM(CASE WHEN A.IS_DL_FLAG=0 THEN A.AMOUNT-A.XZQ_DH_AMONUT  ELSE 0 END) XZQ_AMOUNT_REAL,
           SUM(CASE WHEN A.FEE_MONTH = '''||V_LAST_MONTH||''' THEN  A.AMOUNT ELSE 0 END ) XZQ_AMOUNT_TOTAL_AGE0,
          SUM(CASE WHEN A.IS_DL_FLAG = 0 AND A.FEE_MONTH = '''||V_LAST_MONTH||'''THEN A.XZQ_DH_AMONUT ELSE 0 END ) XZQ_AMOUNT_DX_AGE0,
          SUM(CASE WHEN A.IS_DL_FLAG = 0 AND A.FEE_MONTH = '''||V_LAST_MONTH||''' THEN A.XZQ_ST_AMONUT ELSE 0 END ) XZQ_AMOUNT_ST_AGE0,
          SUM(CASE  WHEN A.IS_DL_FLAG=1 AND A.FEE_MONTH= '''||V_LAST_MONTH||''' THEN A.AMOUNT ELSE 0 END) XZQ_AMOUNT_DL_AGE0,
          SUM(CASE WHEN A.IS_DL_FLAG=0 AND A.FEE_MONTH='''||V_LAST_MONTH||'''   THEN A.AMOUNT-A.XZQ_DH_AMONUT ELSE 0 END) XZQ_OWE_AGE0
     FROM PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_C_XZQ A
  GROUP BY A.SERV_ID,A.FEE_MONTH';

   Begin
    Execute Immediate 'DROP TABLE PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_C_USER PURGE';
  Exception
    When Others Then
      Null;
  End;
  EXECUTE IMMEDIATE'
  CREATE TABLE PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_C_USER  AS
  Select DISTINCT SERV_ID,FEE_MONTH FROM PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_C_XZQ1
  UNION
  Select DISTINCT TO_CHAR(SERV_ID),FEE_MONTH FROM PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_C_XZH1';

   Begin
    Execute Immediate 'DROP TABLE PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_C_OWE_M PURGE';
  Exception
    When Others Then
      Null;
  End;
  EXECUTE IMMEDIATE'
  CREATE TABLE PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_C_OWE_M  AS
  Select A.SERV_ID,
         A.FEE_MONTH,
         Sum(NVL(B.XZQ_AMOUNT_TOTAL,0) - NVL(B.XZQ_AMOUNT_TOTAL_AGE0,0) + NVL(C.XZH_AMOUNT_TOTAL_AGE0,0)) MONTH_AMOUNT_TOTAL,
         Sum(NVL(B.XZQ_AMOUNT_DX,0) - NVL(B.XZQ_AMOUNT_DX_AGE0,0) + NVL(C.XZH_AMOUNT_DX_AGE0,0)) MONTH_AMOUNT_DX,
         Sum(NVL(B.XZQ_AMOUNT_DL,0) - NVL(B.XZQ_AMOUNT_DL_AGE0,0) + NVL(C.XZH_AMOUNT_DL_AGE0,0)) MONTH_AMOUNT_DL,
         Sum(NVL(B.XZQ_AMOUNT_ST,0) - NVL(B.XZQ_AMOUNT_ST_AGE0,0) + NVL(C.XZH_AMOUNT_ST_AGE0,0)) MONTH_AMOUNT_ST,
         Sum(NVL(B.XZQ_AMOUNT_REAL,0) - NVL(B.XZQ_OWE_AGE0,0) + NVL(C.XZH_OWE_AGE0,0)) MONTH_AMOUNT_REAL
    From PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_C_USER A, PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_C_XZQ1 B, PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_C_XZH1 C
   Where A.SERV_ID = B.SERV_ID(+)
     AND A.FEE_MONTH =  B.FEE_MONTH(+)
     And A.SERV_ID = C.SERV_ID(+)
     AND A.FEE_MONTH =  C.FEE_MONTH(+)
  Group By A.SERV_ID,A.FEE_MONTH';
  */


  ------20170316 zhuml  modify   红河要求将新增欠费出账欠费调整为欠费账期当月出账时的零帐欠费
  Begin
    Execute Immediate 'DROP TABLE PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_C_OWE_M PURGE';
  Exception
    When Others Then
      Null;
  End;
  EXECUTE IMMEDIATE'
  CREATE TABLE PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_C_OWE_M  AS
    SELECT * FROM (
     Select '''||V_LAST_MONTH||''' MONTH_NO,
           T.SERV_ID,
           Sum(T.xzh_owe_age0)/100 MONTH_AMOUNT_REAL
      FROM PU_INTF.WT_SERV_OWE_M_'||V_LAST_MONTH||'_ZML PARTITION(P0873) T
     Group By T.SERV_ID
   )WHERE 1=2';


  FOR N IN 0..MONTHS_BETWEEN(TO_DATE(V_LAST_MONTH,'YYYYMM'),TO_DATE(V_LAST_YEAR_M,'YYYYMM')) LOOP

    V_MONTH_M := TO_CHAR(ADD_MONTHS(TO_DATE(V_LAST_YEAR_M,'YYYYMM'),N),'YYYYMM');

  /*  IF V_MONTH_M = V_MONTH THEN
       V_DAY_M :=  V_DATE;
     ELSE
       V_DAY_M := TO_CHAR(LAST_DAY(TO_DATE(V_MONTH_M,'YYYYMM')),'YYYYMMDD');
    END IF;*/

    EXECUTE IMMEDIATE'
    DELETE FROM PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_C_OWE_M  Where MONTH_NO = '''||V_MONTH_M||'''';
    COMMIT;

    EXECUTE IMMEDIATE'
    INSERT INTO PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_C_OWE_M
      Select '''||V_MONTH_M||''' MONTH_NO,
           T.SERV_ID,
           Sum(T.xzh_owe_age0)/100 MONTH_AMOUNT_REAL
      From PU_INTF.WT_SERV_OWE_M_'||V_MONTH_M||'_ZML PARTITION(P0873) T
     Group By T.SERV_ID';
    COMMIT;
  END LOOP;


  --------   日欠费
  ---  当日欠费
  Begin
    Execute Immediate 'DROP TABLE PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_C_OWE_D PURGE';
  Exception
    When Others Then
      Null;
  End;
  EXECUTE IMMEDIATE'
  CREATE TABLE PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_C_OWE_D AS
   Select A.SERV_ID,
          A.FEE_CYCLE_ID FEE_MONTH,
          Sum(A.AMOUNT) OWE_AMOUNT,
          Sum(Case
                When Nvl(B.DL_AMOUNT, 0) = 0 And
                     Substr(A.STATE_TR, -1) In (''D'', ''F'') Then
                 A.AMOUNT
                Else
                 0
              End) DH_AMOUNT,
          Sum(Case
                When Nvl(B.DL_AMOUNT, 0) <> 0 Then
                 A.AMOUNT
                Else
                 0
              End) DL_AMOUNT,
          Sum(Case
                When Nvl(B.DL_AMOUNT, 0) = 0 And
                     Substr(A.STATE_TR, -1) = ''C'' Then
                 A.AMOUNT
                Else
                 0
              End) ST_AMOUNT,
          Sum(Case
                When Nvl(B.DL_AMOUNT, 0) = 0 And
                     Substr(A.STATE_TR, -1) In (''A'', ''C'') Then
                 A.AMOUNT
                Else
                 0
              End) AMOUNT_REAL
     From (Select *
             From PU_MODEL.TB_BIL_SERV_OWE_TRACK_'||V_MONTH||'@DL_EDW_YN A
            Where DATE_NO = '''||V_DATE||'''
              And LOCAL_CODE = ''0873'') A
     Left Join PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_C_DL B
       On A.SERV_ID = B.SERV_ID
      And A.FEE_CYCLE_ID = B.FEE_MONTH
    Where A.IS_M_ETS_FLAG = 1
      And Substr(A.STATE_TR, -1) In (''A'', ''D'', ''C'', ''F'')
    Group By A.SERV_ID,A.FEE_CYCLE_ID';

---- 昨日欠费
Begin
  Execute Immediate 'DROP TABLE PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_OWE_D1 PURGE';
Exception
  When Others Then
    Null;
End;
EXECUTE IMMEDIATE'
CREATE TABLE PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_OWE_D1 AS
  Select A.SERV_ID,
        A.FEE_CYCLE_ID FEE_MONTH,
        Sum(A.AMOUNT) OWE_AMOUNT,
        Sum(Case
              When Nvl(B.DL_AMOUNT, 0) = 0 And
                   Substr(A.STATE_TR, -1) In (''D'', ''F'') Then
               A.AMOUNT
              Else
               0
            End) DH_AMOUNT,
        Sum(Case
              When Nvl(B.DL_AMOUNT, 0) <> 0 Then
               A.AMOUNT
              Else
               0
            End) DL_AMOUNT,
        Sum(Case
              When Nvl(B.DL_AMOUNT, 0) = 0 And
                   Substr(A.STATE_TR, -1) = ''C'' Then
               A.AMOUNT
              Else
               0
            End) ST_AMOUNT,
        Sum(Case
              When Nvl(B.DL_AMOUNT, 0) = 0 And
                   Substr(A.STATE_TR, -1) In (''A'', ''C'') Then
               A.AMOUNT
              Else
               0
            End) AMOUNT_REAL
   From (Select *
           From PU_MODEL.TB_BIL_SERV_OWE_TRACK_'||V_MONTH||'@DL_EDW_YN A
          Where DATE_NO = '''||V_LAST_DATE||'''
            And LOCAL_CODE = ''0873'') A
   Left Join PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_C_DL B
     On A.SERV_ID = B.SERV_ID
    And A.FEE_CYCLE_ID = B.FEE_MONTH
  Where A.IS_M_ETS_FLAG = 1
   And Substr(A.STATE_TR, -1) In (''A'', ''D'', ''C'', ''F'')
  Group By A.SERV_ID,A.FEE_CYCLE_ID';

----  出账总欠费 通报日欠费 累计回收  回收率 当日回收金额
Begin
  Execute Immediate 'DROP TABLE PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_C PURGE';
Exception
  When Others Then
    Null;
End;
/*EXECUTE IMMEDIATE'
CREATE TABLE PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_C AS
Select A.BRANCH_CODE3 STD_AREA_ID,
       Nvl(A.BRANCH_NAME3, ''未知'') STD_AREA_NAME,
       Sum(Nvl(B.MONTH_AMOUNT_REAL, 0))/100 MONTH_AMOUNT_REAL,
       Sum(Nvl(C.AMOUNT_REAL, 0))/100 AMOUNT_DAY,
       (Sum(Nvl(B.MONTH_AMOUNT_REAL, 0)) - Sum(Nvl(C.AMOUNT_REAL, 0)))/100 REC_M,
       Decode(Sum(Nvl(B.MONTH_AMOUNT_REAL, 0)),
              0,
              0,
              (Sum(Nvl(B.MONTH_AMOUNT_REAL, 0)) - Sum(Nvl(C.AMOUNT_REAL, 0))) / Sum(Nvl(B.MONTH_AMOUNT_REAL, 0))) REC_RATE_M,
       (Sum(Nvl(D.AMOUNT_REAL, 0)) - Sum(Nvl(C.AMOUNT_REAL, 0)))/100 REC_D
  From PU_WT.WT_BIL_OWE_LIST_D_NEW Subpartition(P'||V_DATE||'_0873) A,
       (Select SERV_ID, Sum(MONTH_AMOUNT_REAL) MONTH_AMOUNT_REAL
          From PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_C_OWE_M T
         Where T.FEE_MONTH Between '''||V_LAST_YEAR_M||''' And '''||V_LAST_MONTH||'''
         Group By SERV_ID) B,
       (Select SERV_ID, Sum(AMOUNT_REAL) AMOUNT_REAL From PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_C_OWE_D T Where T.FEE_MONTH Between '''||V_LAST_YEAR_M||''' And '''||V_LAST_MONTH||''' Group By SERV_ID) C,
       (Select SERV_ID, Sum(AMOUNT_REAL) AMOUNT_REAL From PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_OWE_D1 T Where T.FEE_MONTH Between '''||V_LAST_YEAR_M||''' And '''||V_LAST_MONTH||''' Group By SERV_ID) D
 Where A.SERV_ID = B.SERV_ID(+)
   And A.SERV_ID = C.SERV_ID(+)
   And A.SERV_ID = D.SERV_ID(+)
 Group By A.BRANCH_CODE3, Nvl(A.BRANCH_NAME3, ''未知'')';*/

 EXECUTE IMMEDIATE'
CREATE TABLE PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_C AS
 Select STD_AREA_ID,
        STD_AREA_NAME,
        Sum(MONTH_AMOUNT_REAL)  MONTH_AMOUNT_REAL,
        Sum(AMOUNT_DAY) AMOUNT_DAY,
        Sum(MONTH_AMOUNT_REAL)  - Sum(AMOUNT_DAY) REC_M,
        Decode(Sum(MONTH_AMOUNT_REAL), 0, 0, (Sum(MONTH_AMOUNT_REAL)  - Sum(AMOUNT_DAY)) / Sum(MONTH_AMOUNT_REAL)) REC_RATE_M,
        Sum(REC_D) REC_D
   From (Select A.BRANCH_CODE3 STD_AREA_ID,
                Nvl(A.BRANCH_NAME3, ''未知'') STD_AREA_NAME,
                Sum(Nvl(C.AMOUNT_REAL, 0)) / 100 AMOUNT_DAY,
                (Sum(Nvl(D.AMOUNT_REAL, 0)) - Sum(Nvl(C.AMOUNT_REAL, 0))) / 100 REC_D,
                0 MONTH_AMOUNT_REAL
           From PU_WT.WT_BIL_OWE_LIST_D_NEW Subpartition(P'||V_DATE||'_0873) A,
                (Select SERV_ID, Sum(AMOUNT_REAL) AMOUNT_REAL
                   From PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_C_OWE_D T
                  Where T.FEE_MONTH Between '''||V_LAST_YEAR_M||''' And '''||V_LAST_MONTH||'''
                  Group By SERV_ID) C,
                (Select SERV_ID, Sum(AMOUNT_REAL) AMOUNT_REAL
                   From PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_OWE_D1 T
                  Where T.FEE_MONTH Between '''||V_LAST_YEAR_M||''' And '''||V_LAST_MONTH||'''
                  Group By SERV_ID) D
          Where A.SERV_ID = C.SERV_ID(+)
            And A.SERV_ID = D.SERV_ID(+)
          Group By A.BRANCH_CODE3, Nvl(A.BRANCH_NAME3, ''未知'')

         Union All

         Select c.branch_code3 STD_AREA_ID, Nvl(c.branch_name3, ''未知'') STD_AREA_NAME, 0 AMOUNT_DAY, 0 REC_D, Sum(MONTH_AMOUNT_REAL) MONTH_AMOUNT_REAL
           From (select serv_id,sum(month_amount_real) month_amount_real
                    from  PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_C_OWE_M
                   group by serv_id) a,
                 PU_INTF.I_IN_KG_SERV_GRID Subpartition(P'||V_LAST_MONTH||'_0873) B,
                 PU_META.D_HX_ZD_ORG_BRANCH_TREE C
           WHERE A.SERV_ID  = B.PROD_ID(+)
             AND B.SUM_BRANCH_CODE = C.BRANCH_CODE(+)
          Group By c.branch_code3, Nvl(c.branch_name3, ''未知'') )
  Group By STD_AREA_ID, STD_AREA_NAME';

/*****************   2017年新增欠费（201612-201701账期） END  *******************************/

/*****************    合同号欠费≥2000元欠费     *******************************/

--- 出账欠费  通报日欠费 回收率 当日回收欠费
Begin
  Execute Immediate 'DROP TABLE PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_D PURGE';
Exception
  When Others Then
    Null;
End;
EXECUTE IMMEDIATE'
CREATE TABLE PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_D AS
Select STD_AREA_ID,
       STD_AREA_NAME,
       Sum(MONTH_AMOUNT_REAL) MONTH_AMOUNT_REAL,
       Sum(AMOUNT_DAY) AMOUNT_DAY,
       Decode(Sum(MONTH_AMOUNT_REAL), 0, 0, (Sum(MONTH_AMOUNT_REAL) - Sum(AMOUNT_DAY)) / Sum(MONTH_AMOUNT_REAL)) REC_RATE_M,
       Sum(AMOUNT_LAST) - Sum(AMOUNT_DAY) REC_D
  From (Select BRANCH_CODE3 STD_AREA_ID,
                Nvl(BRANCH_NAME3, ''未知'') STD_AREA_NAME,
                Sum(MONTH_AMOUNT_REAL) MONTH_AMOUNT_REAL,
                Sum(AMOUNT) AMOUNT_DAY ,
                0 AMOUNT_LAST
          From PU_WT.WT_BIL_OWE_LIST_D_NEW Subpartition(P'||V_DATE||'_0873)
         Where ACCT_ID In (Select T.ACCT_ID
                             From PU_WT.WT_BIL_OWE_LIST_D_NEW Subpartition(P'||V_DATE||'_0873) T
                            Group By T.ACCT_ID
                           Having Sum(T.MONTH_AMOUNT_REAL) >= 2000)
         Group By BRANCH_CODE3, Nvl(BRANCH_NAME3, ''未知'')

        Union All

        Select BRANCH_CODE3 STD_AREA_ID, Nvl(BRANCH_NAME3, ''未知'') STD_AREA_NAME, 0 MONTH_AMOUNT_REAL, 0 AMOUNT_DAY, Sum(AMOUNT) AMOUNT_LAST
          From PU_WT.WT_BIL_OWE_LIST_D_NEW Subpartition(P'||V_LAST_DATE||'_0873)
         Where ACCT_ID In (Select T.ACCT_ID
                             From PU_WT.WT_BIL_OWE_LIST_D_NEW Subpartition(P'||V_DATE||'_0873) T
                            Group By T.ACCT_ID
                           Having Sum(T.MONTH_AMOUNT_REAL) >= 2000)
         Group By BRANCH_CODE3, Nvl(BRANCH_NAME3, ''未知''))
 Group By STD_AREA_ID, STD_AREA_NAME';


 /*****************    合同号欠费≥2000元欠费   END    *******************************/

----   汇总

DELETE FROM PU_BUSI_IND.BM_HH_NOTICE_OWE_D T Where DATE_NO = V_DATE;
COMMIT;
EXECUTE IMMEDIATE'
INSERT INTO  PU_BUSI_IND.BM_HH_NOTICE_OWE_D
Select '''||V_MONTH||''' MONTH_NO,
       '''||V_DATE||''' DATE_NO,
       STD_AREA_ID,
       STD_AREA_NAME,
       Sum(MONTH_AMOUNT_REAL_ALL) MONTH_AMOUNT_REAL_ALL,
       Sum(AMOUNT_DAY_ALL) AMOUNT_DAY_ALL,
       Sum(REC_M_ALL) REC_M_ALL,
       Sum(REC_RATE_M_ALL) REC_RATE_M_ALL,
       Sum(REC_D_ALL) REC_D_ALL,
       Sum(MONTH_AMOUNT_REAL_LZ) MONTH_AMOUNT_REAL_LZ,
       Sum(AMOUNT_DAY_LZ) AMOUNT_DAY_LZ,
       Sum(REC_RATE_M_LZ) REC_RATE_M_LZ,
       Sum(REC_D_LZ) REC_D_LZ,
       Sum(MONTH_AMOUNT_REAL_NEW) MONTH_AMOUNT_REAL_NEW,
       Sum(AMOUNT_DAY_NEW) AMOUNT_DAY_NEW,
       Sum(REC_M_NEW) REC_M_NEW,
       Sum(REC_RATE_M_NEW) REC_RATE_M_NEW,
       Sum(REC_D_NEW) REC_D_NEW,
       Sum(MONTH_AMOUNT_REAL_2K) MONTH_AMOUNT_REAL_2K,
       Sum(AMOUNT_DAY_2K) AMOUNT_DAY_2K,
       Sum(REC_RATE_M_2K) REC_RATE_M_2K,
       Sum(REC_D_2K) REC_D_2K,
       ''红河''
  From (Select STD_AREA_ID,
               STD_AREA_NAME,
               MONTH_AMOUNT_REAL MONTH_AMOUNT_REAL_ALL,
               AMOUNT_DAY        AMOUNT_DAY_ALL,
               REC_M             REC_M_ALL,
               REC_RATE_M        REC_RATE_M_ALL,
               REC_D             REC_D_ALL,
               0                 MONTH_AMOUNT_REAL_LZ,
               0                 AMOUNT_DAY_LZ,
               0                 REC_RATE_M_LZ,
               0                 REC_D_LZ,
               0                 MONTH_AMOUNT_REAL_NEW,
               0                 AMOUNT_DAY_NEW,
               0                 REC_M_NEW,
               0                 REC_RATE_M_NEW,
               0                 REC_D_NEW,
               0                 MONTH_AMOUNT_REAL_2K,
               0                 AMOUNT_DAY_2K,
               0                 REC_RATE_M_2K,
               0                 REC_D_2K
          From TMP_BM_HH_NOTICE_OWE_D_A
        Union All
        Select STD_AREA_ID,
               STD_AREA_NAME,
               0                 MONTH_AMOUNT_REAL_ALL,
               0                 AMOUNT_DAY_ALL,
               0                 REC_M_ALL,
               0                 REC_RATE_M_ALL,
               0                 REC_D_ALL,
               MONTH_AMOUNT_REAL MONTH_AMOUNT_REAL_LZ,
               AMOUNT_DAY        AMOUNT_DAY_LZ,
               REC_RATE_M        REC_RATE_M_LZ,
               REC_D             REC_D_LZ,
               0                 MONTH_AMOUNT_REAL_NEW,
               0                 AMOUNT_DAY_NEW,
               0                 REC_M_NEW,
               0                 REC_RATE_M_NEW,
               0                 REC_D_NEW,
               0                 MONTH_AMOUNT_REAL_2K,
               0                 AMOUNT_DAY_2K,
               0                 REC_RATE_M_2K,
               0                 REC_D_2K
          From TMP_BM_HH_NOTICE_OWE_D_B
        Union All
        Select STD_AREA_ID,
               STD_AREA_NAME,
               0                 MONTH_AMOUNT_REAL_ALL,
               0                 AMOUNT_DAY_ALL,
               0                 REC_M_ALL,
               0                 REC_RATE_M_ALL,
               0                 REC_D_ALL,
               0                 MONTH_AMOUNT_REAL_LZ,
               0                 AMOUNT_DAY_LZ,
               0                 REC_RATE_M_LZ,
               0                 REC_D_LZ,
               MONTH_AMOUNT_REAL MONTH_AMOUNT_REAL_NEW,
               AMOUNT_DAY        AMOUNT_DAY_NEW,
               REC_M             REC_M_NEW,
               REC_RATE_M        REC_RATE_M_NEW,
               REC_D             REC_D_NEW,
               0                 MONTH_AMOUNT_REAL_2K,
               0                 AMOUNT_DAY_2K,
               0                 REC_RATE_M_2K,
               0                 REC_D_2K
          From TMP_BM_HH_NOTICE_OWE_D_C
        Union All
        Select STD_AREA_ID,
               STD_AREA_NAME,
               0                 MONTH_AMOUNT_REAL_ALL,
               0                 AMOUNT_DAY_ALL,
               0                 REC_M_ALL,
               0                 REC_RATE_M_ALL,
               0                 REC_D_ALL,
               0                 MONTH_AMOUNT_REAL_LZ,
               0                 AMOUNT_DAY_LZ,
               0                 REC_RATE_M_LZ,
               0                 REC_D_LZ,
               0                 MONTH_AMOUNT_REAL_NEW,
               0                 AMOUNT_DAY_NEW,
               0                 REC_M_NEW,
               0                 REC_RATE_M_NEW,
               0                 REC_D_NEW,
               MONTH_AMOUNT_REAL MONTH_AMOUNT_REAL_2K,
               AMOUNT_DAY        AMOUNT_DAY_2K,
               REC_RATE_M        REC_RATE_M_2K,
               REC_D             REC_D_2K
          From TMP_BM_HH_NOTICE_OWE_D_D)
 Group By STD_AREA_ID, STD_AREA_NAME';
COMMIT;

EXECUTE IMMEDIATE'
INSERT INTO  PU_BUSI_IND.BM_HH_NOTICE_OWE_D
Select '''||V_MONTH||''' MONTH_NO,
       '''||V_DATE||''' DATE_NO,
       ''9999'' STD_AREA_ID,
       ''合计'' STD_AREA_NAME,
       Sum(MONTH_AMOUNT_REAL_ALL) MONTH_AMOUNT_REAL_ALL,
       Sum(AMOUNT_DAY_ALL) AMOUNT_DAY_ALL,
       Sum(REC_M_ALL) REC_M_ALL,
       decode(Sum(MONTH_AMOUNT_REAL_ALL),0,0,Sum(REC_M_ALL)/Sum(MONTH_AMOUNT_REAL_ALL)) REC_RATE_M_ALL,
       Sum(REC_D_ALL) REC_D_ALL,
       Sum(MONTH_AMOUNT_REAL_LZ) MONTH_AMOUNT_REAL_LZ,
       Sum(AMOUNT_DAY_LZ) AMOUNT_DAY_LZ,
       Decode(Sum(MONTH_AMOUNT_REAL_LZ), 0, 0, (Sum(MONTH_AMOUNT_REAL_LZ)-Sum(AMOUNT_DAY_LZ)) / Sum(MONTH_AMOUNT_REAL_LZ)) REC_RATE_M_LZ,
       Sum(REC_D_LZ) REC_D_LZ,
       Sum(MONTH_AMOUNT_REAL_NEW) MONTH_AMOUNT_REAL_NEW,
       Sum(AMOUNT_DAY_NEW) AMOUNT_DAY_NEW,
       Sum(REC_M_NEW) REC_M_NEW,
       decode(Sum(MONTH_AMOUNT_REAL_NEW),0,0,Sum(REC_M_NEW)/Sum(MONTH_AMOUNT_REAL_NEW)) REC_RATE_M_NEW,
       Sum(REC_D_NEW) REC_D_NEW,
       Sum(MONTH_AMOUNT_REAL_2K) MONTH_AMOUNT_REAL_2K,
       Sum(AMOUNT_DAY_2K) AMOUNT_DAY_2K,
       decode(Sum(MONTH_AMOUNT_REAL_2K),0,0,(Sum(MONTH_AMOUNT_REAL_2K)-sum(AMOUNT_DAY_2K))/Sum(MONTH_AMOUNT_REAL_2K)) REC_RATE_M_2K,
       Sum(REC_D_2K) REC_D_2K,
       ''红河''
  From (Select STD_AREA_ID,
               STD_AREA_NAME,
               MONTH_AMOUNT_REAL MONTH_AMOUNT_REAL_ALL,
               AMOUNT_DAY        AMOUNT_DAY_ALL,
               REC_M             REC_M_ALL,
               REC_RATE_M        REC_RATE_M_ALL,
               REC_D             REC_D_ALL,
               0                 MONTH_AMOUNT_REAL_LZ,
               0                 AMOUNT_DAY_LZ,
               0                 REC_RATE_M_LZ,
               0                 REC_D_LZ,
               0                 MONTH_AMOUNT_REAL_NEW,
               0                 AMOUNT_DAY_NEW,
               0                 REC_M_NEW,
               0                 REC_RATE_M_NEW,
               0                 REC_D_NEW,
               0                 MONTH_AMOUNT_REAL_2K,
               0                 AMOUNT_DAY_2K,
               0                 REC_RATE_M_2K,
               0                 REC_D_2K
          From TMP_BM_HH_NOTICE_OWE_D_A
        Union All
        Select STD_AREA_ID,
               STD_AREA_NAME,
               0                 MONTH_AMOUNT_REAL_ALL,
               0                 AMOUNT_DAY_ALL,
               0                 REC_M_ALL,
               0                 REC_RATE_M_ALL,
               0                 REC_D_ALL,
               MONTH_AMOUNT_REAL MONTH_AMOUNT_REAL_LZ,
               AMOUNT_DAY        AMOUNT_DAY_LZ,
               REC_RATE_M        REC_RATE_M_LZ,
               REC_D             REC_D_LZ,
               0                 MONTH_AMOUNT_REAL_NEW,
               0                 AMOUNT_DAY_NEW,
               0                 REC_M_NEW,
               0                 REC_RATE_M_NEW,
               0                 REC_D_NEW,
               0                 MONTH_AMOUNT_REAL_2K,
               0                 AMOUNT_DAY_2K,
               0                 REC_RATE_M_2K,
               0                 REC_D_2K
          From TMP_BM_HH_NOTICE_OWE_D_B
        Union All
        Select STD_AREA_ID,
               STD_AREA_NAME,
               0                 MONTH_AMOUNT_REAL_ALL,
               0                 AMOUNT_DAY_ALL,
               0                 REC_M_ALL,
               0                 REC_RATE_M_ALL,
               0                 REC_D_ALL,
               0                 MONTH_AMOUNT_REAL_LZ,
               0                 AMOUNT_DAY_LZ,
               0                 REC_RATE_M_LZ,
               0                 REC_D_LZ,
               MONTH_AMOUNT_REAL MONTH_AMOUNT_REAL_NEW,
               AMOUNT_DAY        AMOUNT_DAY_NEW,
               REC_M             REC_M_NEW,
               REC_RATE_M        REC_RATE_M_NEW,
               REC_D             REC_D_NEW,
               0                 MONTH_AMOUNT_REAL_2K,
               0                 AMOUNT_DAY_2K,
               0                 REC_RATE_M_2K,
               0                 REC_D_2K
          From TMP_BM_HH_NOTICE_OWE_D_C
        Union All
        Select STD_AREA_ID,
               STD_AREA_NAME,
               0                 MONTH_AMOUNT_REAL_ALL,
               0                 AMOUNT_DAY_ALL,
               0                 REC_M_ALL,
               0                 REC_RATE_M_ALL,
               0                 REC_D_ALL,
               0                 MONTH_AMOUNT_REAL_LZ,
               0                 AMOUNT_DAY_LZ,
               0                 REC_RATE_M_LZ,
               0                 REC_D_LZ,
               0                 MONTH_AMOUNT_REAL_NEW,
               0                 AMOUNT_DAY_NEW,
               0                 REC_M_NEW,
               0                 REC_RATE_M_NEW,
               0                 REC_D_NEW,
               MONTH_AMOUNT_REAL MONTH_AMOUNT_REAL_2K,
               AMOUNT_DAY        AMOUNT_DAY_2K,
               REC_RATE_M        REC_RATE_M_2K,
               REC_D             REC_D_2K
          From TMP_BM_HH_NOTICE_OWE_D_D)';
COMMIT;

END;
