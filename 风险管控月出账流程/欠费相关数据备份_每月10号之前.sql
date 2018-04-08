
--月初10号之前备份
create table  pu_wt.Wt_Bil_Owe_List_d_New_20180131 as
Select * from pu_wt.Wt_Bil_Owe_List_d_New Partition(p20180131);

create table  pu_wt.Wt_Bil_Owe_List_d_Lz_New0131 as
Select * from pu_wt.Wt_Bil_Owe_List_d_Lz_New Partition(p20180131);

create table  pu_wt.Wt_Bil_Owe_St_List_d_20180131 as
Select * from pu_wt.Wt_Bil_Owe_St_List_d Partition(p20180131);


------
Select * from pu_wt.Wt_Bil_Owe_List_d_New  Partition(p20180228);
Select * from pu_wt.Wt_Bil_Owe_St_List_d Partition(p20180228);
Select * from pu_wt.Wt_Bil_Owe_List_d_Lz_New Partition(p20180228);

