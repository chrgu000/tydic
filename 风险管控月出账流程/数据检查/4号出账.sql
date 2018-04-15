PU_WT.p_WT_BIL_OWE_SP_4PRE

select * from pu_meta.etl_program_rule where rule_id='7001138';---规则表 
select * from pu_meta.etl_inter_rule where rule_id= 2010012;

---VIP账户接口表

SELECT /*+parallel(a.8)*/ count(*) FROM PU_INTF.I_PRD_VIP_ACCT a WHERE a.month_no='201802';



--用户支局关系月表 (只看月上月账期数据)

select count(*) from IPD_IN.I_IN_WG_BRANCH_GRID_SR_201802@dl_odl_89; ---源表

selectcount(*) from pu_intf.I_IN_WG_BRANCH_GRID_SR_M
where month_no='201802'

-- 51712403
                        
SELECT * FROM pu_intf.I_IN_WG_BRANCH_GRID_SR_M  where month_no='201803';


----月账单抽取 
select /*+parallel(a,8)*/    count(*) from  pu_intf.i_acct_item_m partition(p201802) a; -- 37189248

select /*+parallel(a,8)*/    count(*) from  pu_intf.i_acct_item_m partition(p201801) a;  --38190240


---分摊后账单抽取

 SELECT /*+parallel(a,16)*/count(*) FROM  PU_INTF.I_ACCT_ITEM_FT_M  partition (p201801) a ; --85850539
 
  SELECT/*+parallel(a,16)*/ count(*) FROM  PU_INTF.I_ACCT_ITEM_FT_M partition (p201802) a;-- 87408133
  
  
  



