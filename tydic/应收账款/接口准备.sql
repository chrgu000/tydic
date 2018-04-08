数据源和接口准备：

select * from PU_INTF.INTF_DATA_M 
where month_no='201701'
and id_zbcode like'%CWYSMX0100%'
and id_unitcode='530103757190184'

select * from pu_meta.D_CW_AREA_INFO

select * from all_tables where table_name like'%AREA%'AND OWNER='PU_META'


(一）总体情况（按累计主营收入）
select * from PU_INTF.INTF_DATA_M 
where month_no='201701'
and id_zbcode like'%CWYSMX0100%'
and id_unitcode='530103757190184'

省政企部只管客户欠费账龄表+省商客欠费账龄表

经营分析模板（收入完成率）


