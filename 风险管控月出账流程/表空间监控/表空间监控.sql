SELECT a.tablespace_name 表空间名,
       total 表空间大小,
       free 表空间剩余大小,
       (total - free) 表空间使用大小,
       ROUND((total - free) / total, 4) * 100 使用率
  FROM (SELECT tablespace_name, ROUND(SUM(bytes) / (1024 * 1024), 4) free
          FROM DBA_FREE_SPACE
         GROUP BY tablespace_name) a,
       (SELECT tablespace_name, ROUND(SUM(bytes) / (1024 * 1024), 4) total
          FROM DBA_DATA_FILES
         GROUP BY tablespace_name) b
 WHERE a.tablespace_name = b.tablespace_name
 
--TRUNCATE TABLE  system.Stat_Table;


