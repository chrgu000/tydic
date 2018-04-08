
/**
DROP TABLE pu_wt.tmp1_chrw_stream_info PURGE;
CREATE TABLE pu_wt.tmp1_chrw_stream_info AS
SELECT A.SERV_ID FROM 
  (SELECT * FROM pu_wt.tmp_chrw_stream_info WHERE STATE = \'2HX\') A,
    (Select 
			 SERV_ID
				From PU_MODEL.TB_BIL_SERV_OWE_TRACK_{Month_No}@DL_EDW_YN T
			 Where DATE_NO = TO_CHAR(LAST_DAY(TO_DATE(\'{Month_No}\',\'YYYYMM\')),\'YYYYMMDD\')
				 And IS_M_ETS_FLAG = 1
				 And Substr(STATE_TR, -1) In (\'A\', \'D\', \'C\', \'F\')
				GROUP BY SERV_ID )B
			WHERE A.SERV_ID = B.SERV_ID(+)
			AND B.SERV_ID IS NULL;
			**/






CREATE TABLE pu_wt.tmp2_chrw_stream_info   --从经风上抽取数据
PARTITION BY LIST (LOCAL_CODE)
(
  partition P0691 values (\'0691\') tablespace TBAS_DW,
  partition P0692 values (\'0692\') tablespace TBAS_DW,
  partition P0870 values (\'0870\') tablespace TBAS_DW, 
  partition P0871 values (\'0871\') tablespace TBAS_DW, 
  partition P0872 values (\'0872\') tablespace TBAS_DW, 
  partition P0873 values (\'0873\') tablespace TBAS_DW,
  partition P0874 values (\'0874\') tablespace TBAS_DW,
  partition P0875 values (\'0875\') tablespace TBAS_DW,
  partition P0876 values (\'0876\') tablespace TBAS_DW, 
  partition P0877 values (\'0877\') tablespace TBAS_DW,
  partition P0878 values (\'0878\') tablespace TBAS_DW,
  partition P0879 values (\'0879\') tablespace TBAS_DW, 
  partition P0883 values (\'0883\') tablespace TBAS_DW, 
  partition P0886 values (\'0886\') tablespace TBAS_DW, 
  partition P0887 values (\'0887\') tablespace TBAS_DW,
  partition P0888 values (\'0888\') tablespace TBAS_DW
)  NOLOGGING AS 

Select /*+parallel(t,8)*/
        T.SERV_ID,
        T.LOCAL_CODE
        From PU_MODEL.TB_BIL_SERV_OWE_TRACK_{Month_No}@DL_EDW_YN T
       Where DATE_NO = TO_CHAR(LAST_DAY(TO_DATE(\'{Month_No}\',\'YYYYMM\')),\'YYYYMMDD\')--上月最后一天
         And IS_M_ETS_FLAG = 1
         And Substr(STATE_TR, -1) In (\'A\', \'D\', \'C\', \'F\') ;

---
CREATE TABLE pu_wt.tmp1_chrw_stream_info AS

SELECT A.SERV_ID FROM 
  (SELECT SERV_ID FROM pu_wt.tmp_chrw_stream_info WHERE STATE = \'2HX\') A, pu_wt.tmp2_chrw_stream_info PARTITION (P0691) B         
      WHERE A.SERV_ID = B.SERV_ID(+)
      AND B.SERV_ID IS NULL 
      
       UNION ALL      
  
SELECT A.SERV_ID FROM 
  (SELECT SERV_ID FROM pu_wt.tmp_chrw_stream_info WHERE STATE = \'2HX\') A, pu_wt.tmp2_chrw_stream_info PARTITION (P0692) B         
      WHERE A.SERV_ID = B.SERV_ID(+)
      AND B.SERV_ID IS NULL 
          UNION ALL      
  
SELECT A.SERV_ID FROM 
  (SELECT SERV_ID FROM pu_wt.tmp_chrw_stream_info WHERE STATE = \'2HX\') A, pu_wt.tmp2_chrw_stream_info PARTITION (P0870) B         
      WHERE A.SERV_ID = B.SERV_ID(+)
      AND B.SERV_ID IS NULL 
       
           UNION ALL      
  
SELECT A.SERV_ID FROM 
  (SELECT SERV_ID FROM pu_wt.tmp_chrw_stream_info WHERE STATE = \'2HX\') A, pu_wt.tmp2_chrw_stream_info PARTITION (P0871) B         
      WHERE A.SERV_ID = B.SERV_ID(+)
      AND B.SERV_ID IS NULL 
           UNION ALL      
  
SELECT A.SERV_ID FROM 
  (SELECT SERV_ID FROM pu_wt.tmp_chrw_stream_info WHERE STATE = \'2HX\') A, pu_wt.tmp2_chrw_stream_info PARTITION (P0872) B         
      WHERE A.SERV_ID = B.SERV_ID(+)
      AND B.SERV_ID IS NULL 
           UNION ALL      
  
SELECT A.SERV_ID FROM 
  (SELECT SERV_ID FROM pu_wt.tmp_chrw_stream_info WHERE STATE = \'2HX\') A, pu_wt.tmp2_chrw_stream_info PARTITION (P0873) B         
      WHERE A.SERV_ID = B.SERV_ID(+)
      AND B.SERV_ID IS NULL 
           UNION ALL      
  
SELECT A.SERV_ID FROM 
  (SELECT SERV_ID FROM pu_wt.tmp_chrw_stream_info WHERE STATE = \'2HX\') A, pu_wt.tmp2_chrw_stream_info PARTITION (P0874) B         
      WHERE A.SERV_ID = B.SERV_ID(+)
      AND B.SERV_ID IS NULL 
           UNION ALL      
  
SELECT A.SERV_ID FROM 
  (SELECT SERV_ID FROM pu_wt.tmp_chrw_stream_info WHERE STATE = \'2HX\') A, pu_wt.tmp2_chrw_stream_info PARTITION (P0875) B         
      WHERE A.SERV_ID = B.SERV_ID(+)
      AND B.SERV_ID IS NULL 
          UNION ALL      
  
SELECT A.SERV_ID FROM 
  (SELECT SERV_ID FROM pu_wt.tmp_chrw_stream_info WHERE STATE = \'2HX\') A, pu_wt.tmp2_chrw_stream_info PARTITION (P0876) B         
      WHERE A.SERV_ID = B.SERV_ID(+)
      AND B.SERV_ID IS NULL 
      
          UNION ALL      
  
SELECT A.SERV_ID FROM 
  (SELECT SERV_ID FROM pu_wt.tmp_chrw_stream_info WHERE STATE = \'2HX\') A, pu_wt.tmp2_chrw_stream_info PARTITION (P0877) B         
      WHERE A.SERV_ID = B.SERV_ID(+)
      AND B.SERV_ID IS NULL 
      
          UNION ALL      
  
SELECT A.SERV_ID FROM 
  (SELECT SERV_ID FROM pu_wt.tmp_chrw_stream_info WHERE STATE = \'2HX\') A, pu_wt.tmp2_chrw_stream_info PARTITION (P0878) B         
      WHERE A.SERV_ID = B.SERV_ID(+)
      AND B.SERV_ID IS NULL 
      
          UNION ALL      
  
SELECT A.SERV_ID FROM 
  (SELECT SERV_ID FROM pu_wt.tmp_chrw_stream_info WHERE STATE = \'2HX\') A, pu_wt.tmp2_chrw_stream_info PARTITION (P0879) B         
      WHERE A.SERV_ID = B.SERV_ID(+)
      AND B.SERV_ID IS NULL 
          UNION ALL      
  
SELECT A.SERV_ID FROM 
  (SELECT SERV_ID FROM pu_wt.tmp_chrw_stream_info WHERE STATE = \'2HX\') A, pu_wt.tmp2_chrw_stream_info PARTITION (P0883) B         
      WHERE A.SERV_ID = B.SERV_ID(+)
      AND B.SERV_ID IS NULL 
      
          UNION ALL      
  
SELECT A.SERV_ID FROM 
  (SELECT SERV_ID FROM pu_wt.tmp_chrw_stream_info WHERE STATE = \'2HX\') A, pu_wt.tmp2_chrw_stream_info PARTITION (P0886) B      
      WHERE A.SERV_ID = B.SERV_ID(+)
      AND B.SERV_ID IS NULL 
      
        UNION ALL      
  
SELECT A.SERV_ID FROM 
  (SELECT SERV_ID FROM pu_wt.tmp_chrw_stream_info WHERE STATE = \'2HX\') A, pu_wt.tmp2_chrw_stream_info PARTITION (P0887) B     
      WHERE A.SERV_ID = B.SERV_ID(+)
      AND B.SERV_ID IS NULL 
         UNION ALL      
  
SELECT A.SERV_ID FROM 
  (SELECT SERV_ID FROM pu_wt.tmp_chrw_stream_info WHERE STATE = \'2HX\') A, pu_wt.tmp2_chrw_stream_info PARTITION (P0888) B      
      WHERE A.SERV_ID = B.SERV_ID(+)
      AND B.SERV_ID IS NULL;  
      
      

   
  
  
  
  
  
  
 
