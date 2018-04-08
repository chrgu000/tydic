select * from TMP_DH_OWE


drop table ZXYTEST;

select  to_number('2022.55','99999.900')from dual;

select trim(replace('qw e 123','qw'))from dual;

SELECT F1(4,5,6) FROM DUAL;


 ---- 功能：求三个值中的最大值
CREATE OR REPLACE FUNCTION F1( A IN NUMBER ,B IN NUMBER,C IN NUMBER) RETURN NUMBER IS
    BEGIN
         BEGIN
            IF A>B 
              THEN
                IF A>C
                  THEN RETURN A;
                  ELSE RETURN C;
                END IF;
            ELSE IF B>C THEN RETURN B;
                    ELSE RETURN C;
                  END IF;
             END IF;
          END;  
        
    END F1;
 

SELECT F2(20181266) FROM DUAL;

----- 上月16号到本月15号
CREATE OR REPLACE FUNCTION F2(V_DATE IN VARCHAR2) RETURN VARCHAR2  IS 
   
   V_DAY  VARCHAR2(4);
   V_MONTH  VARCHAR2(8);
   BEGIN
    V_DAY:=SUBSTR(V_DATE,-2); --日期
     V_MONTH:=SUBSTR(V_DATE,1,6);--月   
     BEGIN
        IF TO_NUMBER(V_DAY) <=15 
          THEN RETURN V_MONTH;
         ELSE RETURN TO_CHAR(ADD_MONTHS(TO_DATE(V_MONTH,'YYYYMM'),1),'YYYYMM');
        END IF;      
     END;
 END;
--------------
 
 
 
