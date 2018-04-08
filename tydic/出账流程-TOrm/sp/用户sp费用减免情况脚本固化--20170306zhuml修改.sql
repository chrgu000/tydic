-------------
DROP TABLE PU_WT.TMP_ACCT_ITEM_SP_M PURGE;
create table PU_WT.TMP_ACCT_ITEM_SP_M PARALLEL 8 NOLOGGING as
Select SERV_ID,
			 ACCT_ITEM_TYPE_ID,
			 OFFER_ID,
			 Sum(Case
						 When CHARGE < 0 Then
							CHARGE
						 Else
							0
					 End) SP_CHARGE,
			 Sum(Case
						 When CHARGE > 0 Then
							CHARGE
						 Else
							0
					 End) CHARGE
	From (Select SERV_ID, OFFER_ID, ACCT_ITEM_TYPE_ID, Sum(CHARGE) CHARGE
					From PU_INTF.I_ACCT_ITEM_M Partition(P201702)
				 Group By SERV_ID, OFFER_ID, ACCT_ITEM_TYPE_ID)
 Group By SERV_ID, ACCT_ITEM_TYPE_ID, OFFER_ID;         

Select * FROM TMP_ACCT_ITEM_SP_M ;

DROP TABLE PU_WT.TMP_ACCT_ITEM_SP_M_1 PURGE;
CREATE TABLE PU_WT.TMP_ACCT_ITEM_SP_M_1 PARALLEL 8 NOLOGGING AS
Select B.AREA_CODE,A.*,B.ACC_NBR,B.STATE,B.DVLP_CHANNEL_ID,B.DVLP_STAFF_ID,b.term_type_id
 FROM TMP_ACCT_ITEM_SP_M A,
PU_WT.F_1_SERV_D_JF B
Where A.Serv_Id = B.Serv_Id(+);
------------
drop table PU_WT.TMP_ACCT_ITEM_SP_M_ALL_1 purge;
CREATE TABLE PU_WT.TMP_ACCT_ITEM_SP_M_ALL_1 PARALLEL 8 NOLOGGING AS
Select A.AREA_CODE,A.DVLP_CHANNEL_ID,A.DVLP_STAFF_ID,
       a.serv_id,a.acc_nbr,a.offer_id,
       A.ACCT_ITEM_TYPE_ID,
       C.balance_type1,A.SP_CHARGE,a.state
  From PU_WT.TMP_ACCT_ITEM_SP_M_1 A,
       (Select Distinct SP_ITEM_ID,balance_type1 
       From PU_META.D_SP_ITEM_CODE T Where T.PRODUCT_ID Is Null and t.term_type_id is null) C
 Where A.ACCT_ITEM_TYPE_ID = C.SP_ITEM_ID
 AND A.SP_CHARGE<0; 
 
DROP TABLE PU_WT.TMP_ACCT_ITEM_SP_M_ALL_1_1 PURGE;
create table PU_WT.TMP_ACCT_ITEM_SP_M_ALL_1_1 as
SELECT A.SERV_ID,B.OFFER_ID,A.ACCT_ITEM_TYPE_ID,SUM(CHARGE) CHARGE 
FROM (select distinct SERV_ID,ACCT_ITEM_TYPE_ID from TMP_ACCT_ITEM_SP_M_ALL_1) A
LEFT JOIN PU_WT.TMP_ACCT_ITEM_SP_M B 
ON A.SERV_ID=B.SERV_ID and a.ACCT_ITEM_TYPE_ID=b.ACCT_ITEM_TYPE_ID
where CHARGE>0
group by A.SERV_ID,B.OFFER_ID,A.ACCT_ITEM_TYPE_ID;


DROP TABLE PU_WT.TMP_ACCT_ITEM_SP_M_ALL_1_11 PURGE;
CREATE TABLE PU_WT.TMP_ACCT_ITEM_SP_M_ALL_1_11 AS   
SELECT  SERV_ID,ACCT_ITEM_TYPE_ID,SUM(CHARGE) CHARGE FROM 
(SELECT SERV_ID,OFFER_ID,ACCT_ITEM_TYPE_ID,CHARGE,
row_number() over(partition by SERV_ID,ACCT_ITEM_TYPE_ID order by OFFER_ID) rn 
 FROM  PU_WT.TMP_ACCT_ITEM_SP_M_ALL_1_1) WHERE RN=1
 GROUP BY SERV_ID,ACCT_ITEM_TYPE_ID;
 
select * from PU_WT.TMP_ACCT_ITEM_SP_M_ALL_1_1 where offer_id=0;
select serv_id,acct_item_type_id,count(*) from PU_WT.TMP_ACCT_ITEM_SP_M_ALL_1_1 
where serv_id not in(select distinct serv_id 
from PU_WT.TMP_ACCT_ITEM_SP_M_ALL_1_1 where offer_id=0)
group by serv_id,acct_item_type_id
having count(*)>1;
 
 
drop table PU_WT.TMP_ACCT_ITEM_SP_M_ALL_1_2 purge;
CREATE TABLE PU_WT.TMP_ACCT_ITEM_SP_M_ALL_1_2  PARALLEL 8 NOLOGGING AS
Select a.*,b.CHARGE
 FROM PU_WT.TMP_ACCT_ITEM_SP_M_ALL_1 A
 LEFT JOIN PU_WT.TMP_ACCT_ITEM_SP_M_ALL_1_11 B ON A.Serv_Id=B.Serv_Id
and a.ACCT_ITEM_TYPE_ID=b.ACCT_ITEM_TYPE_ID;
 
------------- 
drop table PU_WT.TMP_ACCT_ITEM_SP_M_ALL_2 purge;
create table PU_WT.TMP_ACCT_ITEM_SP_M_ALL_2 PARALLEL 8 NOLOGGING as
  Select A.AREA_CODE,A.DVLP_CHANNEL_ID,A.DVLP_STAFF_ID,
       a.serv_id,a.acc_nbr,a.offer_id,
       A.ACCT_ITEM_TYPE_ID,A.SP_CHARGE,a.state
    From PU_WT.TMP_ACCT_ITEM_SP_M_1 A,
         (Select Distinct product_id,
         SP_ITEM_ID 
         From PU_META.D_SP_ITEM_CODE T Where T.PRODUCT_ID Is Not Null AND SP_ITEM_ID!=107
         and term_type_id is null ) C
   Where A.ACCT_ITEM_TYPE_ID = C.SP_ITEM_ID
   AND A.SP_CHARGE<0
    And A.OFFER_ID = C.PRODUCT_ID;
   
DROP TABLE PU_WT.TMP_ACCT_ITEM_SP_M_ALL_2_1 PURGE;
create table PU_WT.TMP_ACCT_ITEM_SP_M_ALL_2_1 PARALLEL 8 NOLOGGING as
SELECT A.SERV_ID,A.ACCT_ITEM_TYPE_ID,b.balance_type1,SUM(CHARGE) CHARGE 
FROM PU_WT.TMP_ACCT_ITEM_SP_M A
LEFT JOIN 
(Select Distinct product_id,SP_ITEM_ID,balance_type1 
From PU_META.D_SP_ITEM_CODE T Where T.PRODUCT_ID Is Not Null AND SP_ITEM_ID!=107) B
ON a.ACCT_ITEM_TYPE_ID=b.SP_ITEM_ID AND A.OFFER_ID=B.PRODUCT_ID
WHERE B.SP_ITEM_ID IS NOT NULL
 group by A.SERV_ID,A.ACCT_ITEM_TYPE_ID,b.balance_type1;


drop table PU_WT.TMP_ACCT_ITEM_SP_M_ALL_2_2 purge;
CREATE TABLE PU_WT.TMP_ACCT_ITEM_SP_M_ALL_2_2  PARALLEL 8 NOLOGGING AS
Select A.AREA_CODE,A.DVLP_CHANNEL_ID,A.DVLP_STAFF_ID,
       a.serv_id,a.acc_nbr,a.offer_id,
       A.ACCT_ITEM_TYPE_ID,b.balance_type1,A.SP_CHARGE,a.state,b.CHARGE
 FROM PU_WT.TMP_ACCT_ITEM_SP_M_ALL_2 A
 LEFT JOIN PU_WT.TMP_ACCT_ITEM_SP_M_ALL_2_1 B ON A.Serv_Id=B.Serv_Id
and a.ACCT_ITEM_TYPE_ID=b.ACCT_ITEM_TYPE_ID
where b.serv_id is not null;



----------- 
SELECT SERV_ID,COUNT(*) FROM  TMP_ACCT_ITEM_SP_M_ALL_2_1 GROUP BY SERV_ID HAVING COUNT(*)>0;

DROP TABLE PU_WT.TMP_ACCT_ITEM_SP_M_ALL_3 PURGE; 
create table PU_WT.TMP_ACCT_ITEM_SP_M_ALL_3 PARALLEL 8 NOLOGGING as
  Select A.AREA_CODE,A.DVLP_CHANNEL_ID,A.DVLP_STAFF_ID,
       a.serv_id,a.acc_nbr,a.offer_id,
       A.ACCT_ITEM_TYPE_ID,
       C.balance_type1,A.SP_CHARGE,a.state
    From PU_WT.TMP_ACCT_ITEM_SP_M_1 A,
         (Select Distinct term_type_id,SP_ITEM_ID,balance_type1 From PU_META.D_SP_ITEM_CODE T Where T.term_type_id Is Not Null
         ) C
   Where A.ACCT_ITEM_TYPE_ID=C.SP_ITEM_ID
     And a.term_type_id=c.term_type_id
      AND A.SP_CHARGE<0;
     
DROP TABLE PU_WT.TMP_ACCT_ITEM_SP_M_ALL_3_1 PURGE;
create table PU_WT.TMP_ACCT_ITEM_SP_M_ALL_3_1 as
SELECT A.SERV_ID,A.ACCT_ITEM_TYPE_ID,SUM(CHARGE) CHARGE 
FROM (select distinct SERV_ID,ACCT_ITEM_TYPE_ID from TMP_ACCT_ITEM_SP_M_ALL_3) A
LEFT JOIN PU_WT.TMP_ACCT_ITEM_SP_M B 
ON A.SERV_ID=B.SERV_ID and a.ACCT_ITEM_TYPE_ID=b.ACCT_ITEM_TYPE_ID
group by A.SERV_ID,A.ACCT_ITEM_TYPE_ID;
 
 
drop table PU_WT.TMP_ACCT_ITEM_SP_M_ALL_3_2 purge;
CREATE TABLE PU_WT.TMP_ACCT_ITEM_SP_M_ALL_3_2  PARALLEL 8 NOLOGGING AS
Select a.*,b.CHARGE
 FROM PU_WT.TMP_ACCT_ITEM_SP_M_ALL_3 A
 LEFT JOIN PU_WT.TMP_ACCT_ITEM_SP_M_ALL_3_1 B ON A.Serv_Id=B.Serv_Id
and a.ACCT_ITEM_TYPE_ID=b.ACCT_ITEM_TYPE_ID;

--select count(*) from TMP_ACCT_ITEM_SP_M_ALL_3_1
--select count(*) from TMP_ACCT_ITEM_SP_M_ALL_3_2

--------汇总
drop table PU_WT.TMP_ACCT_ITEM_SP_M_ALL purge;
create table PU_WT.TMP_ACCT_ITEM_SP_M_ALL PARALLEL 8 NOLOGGING as
select * from PU_WT.TMP_ACCT_ITEM_SP_M_ALL_1_2
union all
select * from PU_WT.TMP_ACCT_ITEM_SP_M_ALL_2_2
union all
select * from PU_WT.TMP_ACCT_ITEM_SP_M_ALL_3_2;
 
--------
Select * FROM TMP_SERV_ACCT_ITEM_SP_M_201702;

drop table PU_WT.TMP_SERV_ACCT_ITEM_SP_M_201702 purge;
CREATE TABLE PU_WT.TMP_SERV_ACCT_ITEM_SP_M_201702 PARALLEL 8 NOLOGGING AS
select b.std_area_name,
a.DVLP_CHANNEL_ID,
e.channel_name,
a.DVLP_STAFF_ID,
f.staff_name,
a.serv_id,
a.acc_nbr,
'201702' month_no,
a.offer_id,
d.offer_name,
d.offer_description,
a.acct_item_type_id,a.balance_type1,
a.charge/100 charge,
a.sp_charge/100 sp_charge,
c.status_name 
from PU_WT.TMP_ACCT_ITEM_SP_M_ALL a
left join (SELECT * FROM PU_META.TPDIM_STD_AREA where up_std_area_id=1) b on a.area_code=b.area_order
left join pu_meta.D_USER_STATUS c on a.state=c.status_code
left join comm.product_offer@dl_jf219 d on a.offer_id=d.offer_id
LEFT JOIN pu_meta.f_1_crm_channel e ON a.DVLP_CHANNEL_ID = e.channel_id
LEFT JOIN pu_meta.f_1_crm_staff f ON a.DVLP_STAFF_ID = f.staff_code;

---------剔除发生费为0的
delete from PU_WT.TMP_SERV_ACCT_ITEM_SP_M_201702 where charge is null;
COMMIT;

-----  从201702账期开始， 注意稽核 term_type_id 是2903的  ，201701有重复，且发生费没取进去
