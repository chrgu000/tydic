create table pu_busi_Ind.bm_Accounts_recv_m8_1 as
select '201701' month_no,
       a.area_name,
       a.MONTH_AMOUNT_REAL,
       a.MONTH_AMOUNT_REAL - a.AMOUNT rec_amount,
       decode(a.MONTH_AMOUNT_REAL,
              0,
              0,
              (a.MONTH_AMOUNT_REAL - a.AMOUNT) / a.MONTH_AMOUNT_REAL) rec_pecent,
       b.MONTH_AMOUNT_REAL MONTH_AMOUNT_REAL2,
       b.MONTH_AMOUNT_REAL - b.AMOUNT rec_amount2,
       decode(b.MONTH_AMOUNT_REAL,
              0,
              0,
              (b.MONTH_AMOUNT_REAL - b.AMOUNT) / b.MONTH_AMOUNT_REAL) rec_pecent2,
       decode(a.MONTH_AMOUNT_REAL,
              0,
              0,
              (a.MONTH_AMOUNT_REAL - a.AMOUNT) / a.MONTH_AMOUNT_REAL) -
       decode(b.MONTH_AMOUNT_REAL,
              0,
              0,
              (b.MONTH_AMOUNT_REAL - b.AMOUNT) / b.MONTH_AMOUNT_REAL) rec_pecent_increase
  from (select area_name,
               sum(AMOUNT) AMOUNT,
               sum(MONTH_AMOUNT_REAL) MONTH_AMOUNT_REAL
          from PU_BUSI_IND.BM_BIL_OWE_REC_D_201701_NEW a
         where a.date_no = '20170131'
         group by area_name) a,
       (select area_name,
               sum(AMOUNT) AMOUNT,
               sum(MONTH_AMOUNT_REAL) MONTH_AMOUNT_REAL
          from PU_BUSI_IND.BM_BIL_OWE_REC_D_201612_NEW a
         where a.date_no = '20161231'
         group by area_name) b
 where a.area_name = b.area_name(+);
 
 
 
insert into pu_busi_Ind.bm_Accounts_recv_m8_2 
select '201701' month_no,
       a.area_name,
       a.amount,
       a.amount - a.month_amount_real,
       decode( a.amount,0,0,(a.amount - a.month_amount_real) / a.amount),
       b.amount,
       b.amount - b.month_amount_real,
       decode( b.amount,0,0,(b.amount - b.month_amount_real) / b.amount),
       decode( a.amount,0,0,(a.amount - a.month_amount_real) / a.amount)-
       decode( b.amount,0,0,(b.amount - b.month_amount_real) / b.amount)
  from (select area_name,
               sum(gz_amount + zq_amount + qt_amount) amount,
               sum(gz_month_amount_real + zq_month_amount_real +
                   qt_month_amount_real) month_amount_real
          from PU_BUSI_IND.BM_BIL_OWE_REC_D_201701_LZ_NEW a
         where a.date_no = '20170131'
         group by area_name) a,
       (select area_name,
               sum(gz_amount + zq_amount + qt_amount) amount,
               sum(gz_month_amount_real + zq_month_amount_real +
                   qt_month_amount_real) month_amount_real
          from PU_BUSI_IND.BM_BIL_OWE_REC_D_201612_LZ_NEW a
         where a.date_no = '20161231'
         group by area_name) b
 where a.area_name = b.area_name(+);
 commit;
 
 
