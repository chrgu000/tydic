CREATE OR REPLACE Procedure P_BM_HH_NOTICE_OWE_D_2017(V_DATE In Varchar2) Is

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
 ---  
 Begin
    Execute Immediate 'DROP TABLE  PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_C_DL_1 PURGE';
  Exception
    When Others Then
      Null;
  End;
  EXECUTE IMMEDIATE'
  CREATE TABLE PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_C_DL_1 AS    
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
  


  ------20170316 zhuml  modify   红河要求将新增欠费出账欠费调整为欠费账期当月出账时的零帐欠费
  Begin
    Execute Immediate 'DROP TABLE PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_C_M_1 PURGE';
  Exception
    When Others Then
      Null;
  End;
  EXECUTE IMMEDIATE'
  CREATE TABLE  PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_C_M_1  AS
    SELECT * FROM (
     Select '''||V_LAST_MONTH||''' MONTH_NO,
           T.SERV_ID,
           Sum(T.xzh_owe_age0)/100 MONTH_AMOUNT_REAL
      FROM PU_INTF.WT_SERV_OWE_M_'||V_LAST_MONTH||'_ZML PARTITION(P0873) T
     Group By T.SERV_ID
   )WHERE 1=2';


  FOR N IN 0..MONTHS_BETWEEN(TO_DATE(201712,'YYYYMM'),TO_DATE(201612,'YYYYMM')) LOOP  

    V_MONTH_M := TO_CHAR(ADD_MONTHS(TO_DATE(201612,'YYYYMM'),N),'YYYYMM');

    EXECUTE IMMEDIATE'
    DELETE FROM  PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_C_M_1  Where MONTH_NO = '''||V_MONTH_M||'''';
    COMMIT;

    EXECUTE IMMEDIATE'
    INSERT INTO PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_C_M_1
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
    Execute Immediate 'DROP TABLE  PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_C_D_1 PURGE';
  Exception
    When Others Then
      Null;
  End;
  EXECUTE IMMEDIATE'
  CREATE TABLE PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_C_D_1 AS
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
     Left Join PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_C_DL_1 B
       On A.SERV_ID = B.SERV_ID
      And A.FEE_CYCLE_ID = B.FEE_MONTH
    Where A.IS_M_ETS_FLAG = 1
      And Substr(A.STATE_TR, -1) In (''A'', ''D'', ''C'', ''F'')
    Group By A.SERV_ID,A.FEE_CYCLE_ID';

---- 昨日欠费
Begin
  Execute Immediate 'DROP TABLE PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_D1_1 PURGE';
Exception
  When Others Then
    Null;
End;
EXECUTE IMMEDIATE'
CREATE TABLE PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_D1_1 AS
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
   Left Join  PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_C_DL_1 B
     On A.SERV_ID = B.SERV_ID
    And A.FEE_CYCLE_ID = B.FEE_MONTH
  Where A.IS_M_ETS_FLAG = 1
   And Substr(A.STATE_TR, -1) In (''A'', ''D'', ''C'', ''F'')
  Group By A.SERV_ID,A.FEE_CYCLE_ID';

----  出账总欠费 通报日欠费 累计回收  回收率 当日回收金额
Begin
  Execute Immediate 'DROP TABLE PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_C_1 PURGE';
Exception
  When Others Then
    Null;
End;


 EXECUTE IMMEDIATE'
CREATE TABLE PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_C_1 AS
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
                   From  PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_C_D_1 T
                  Where T.FEE_MONTH Between ''201612'' And ''201712''
                  Group By SERV_ID) C,
                (Select SERV_ID, Sum(AMOUNT_REAL) AMOUNT_REAL
                   From PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_D1_1 T
                  Where T.FEE_MONTH Between  ''201612'' And ''201712''
                  Group By SERV_ID) D
          Where A.SERV_ID = C.SERV_ID(+)
            And A.SERV_ID = D.SERV_ID(+)
          Group By A.BRANCH_CODE3, Nvl(A.BRANCH_NAME3, ''未知'')

         Union All

         Select c.branch_code3 STD_AREA_ID, Nvl(c.branch_name3, ''未知'') STD_AREA_NAME, 0 AMOUNT_DAY, 0 REC_D, Sum(MONTH_AMOUNT_REAL) MONTH_AMOUNT_REAL
           From (select serv_id,sum(month_amount_real) month_amount_real
                    from  PU_BUSI_IND.TMP_BM_HH_NOTICE_OWE_D_C_M_1
                   group by serv_id) a,
                 PU_INTF.I_IN_KG_SERV_GRID Subpartition(P'||V_LAST_MONTH||'_0873) B,
                 PU_META.D_HX_ZD_ORG_BRANCH_TREE C
           WHERE A.SERV_ID  = B.PROD_ID(+)
             AND B.SUM_BRANCH_CODE = C.BRANCH_CODE(+)
          Group By c.branch_code3, Nvl(c.branch_name3, ''未知'') )
  Group By STD_AREA_ID, STD_AREA_NAME';
 end;
