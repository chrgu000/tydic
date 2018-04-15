
SELECT * FROM  PU_WT.WT_SERV_JTHZ_201801

select * from pu_meta.etl_program_rule where rule_id='700020016';---规则表 

TBAS.P_RPT_OWE_XZQ_DL
select * from pu_meta.etl_inter_rule where rule_id= 2010012;
/*
   查询临时表空间

*/
   PU_WT.P_WT_YSDB_SERV_DEV_M
   
    PU_WT.WT_SERV_YSXJ_M_201712
   
   
   
select ts#, name FROM v$tablespace; ---查表空间id    

   SELECT a.tablespace_name,
           a.BYTES / (1024 * 1024) "total(M)",
           a.bytes / (1024 * 1024) - nvl(b.bytes / (1024 * 1024), 0) "free(M)",
           round(b.bytes / a.BYTES * 100, 2) "使用率",
           b.bytes / (1024 * 1024) "使用量(M)"
      FROM (SELECT tablespace_name, SUM(bytes) bytes
              FROM dba_temp_files
             GROUP BY tablespace_name) a,
           (SELECT tablespace_name, SUM(bytes_cached) bytes
              FROM v$temp_extent_pool
             GROUP BY tablespace_name) b
     WHERE a.tablespace_name = b.tablespace_name(+);
     
alter session set events 'immediate trace name DROP_SEGMENTS level 17'; -- USER_TEMP1
alter session set events 'immediate trace name DROP_SEGMENTS level 18'; -- WT_TEMP

