SELECT a.tablespace_name ��ռ���,
       total ��ռ��С,
       free ��ռ�ʣ���С,
       (total - free) ��ռ�ʹ�ô�С,
       ROUND((total - free) / total, 4) * 100 ʹ����
  FROM (SELECT tablespace_name, ROUND(SUM(bytes) / (1024 * 1024), 4) free
          FROM DBA_FREE_SPACE
         GROUP BY tablespace_name) a,
       (SELECT tablespace_name, ROUND(SUM(bytes) / (1024 * 1024), 4) total
          FROM DBA_DATA_FILES
         GROUP BY tablespace_name) b
 WHERE a.tablespace_name = b.tablespace_name
 
--TRUNCATE TABLE  system.Stat_Table;


