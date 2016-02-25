declare
  v_jwdcode varchar2(30):='0801';    --机务段代码
  v_dblink varchar2(50):='dblink_localhost'; ---连接
begin
  --清除日计划表
  delete from DATEPLAN_PRI t where t.JWDCODE=v_jwdcode;
  commit;

  --清除DICT_FIRSTUNIT---
  delete from DICT_FIRSTUNIT t where t.JWDCODE=v_jwdcode;
  commit;

  --清除DICT_PROTEAM---
  delete from DICT_PROTEAM t where t.JWDCODE=v_jwdcode;

  --清除DICT_SECUNIT---
  delete from DICT_SECUNIT t where t.JWDCODE=v_jwdcode;
  commit;

  --清除JC_EXPERIMENT_ITEM---
  delete from JC_EXPERIMENT_ITEM t where t.JWDCODE=v_jwdcode;
  commit;

  --清除JC_EXP_REC---
  delete from JC_EXP_REC t where t.JWDCODE=v_jwdcode;
  commit;

  --清除JC_FIXITEM---
  delete from JC_FIXITEM t where t.JWDCODE=v_jwdcode;
  commit;

  --清除JC_FIXREC---
  delete from JC_FIXREC t where t.JWDCODE=v_jwdcode;
  commit;

  --清除JC_FLOWREC---
  delete from JC_FLOWREC t where t.JWDCODE=v_jwdcode;
  commit;

  --清除JC_QZ_FIXREC---
  delete from JC_QZ_FIXREC t where t.JWDCODE=v_jwdcode;
  commit;

  --清除JC_QZ_ITEMS---
  delete from JC_QZ_ITEMS t where t.JWDCODE=v_jwdcode;
  commit;

  --清除JC_ZX_FIXITEM---
  delete from JC_ZX_FIXITEM t where t.JWDCODE=v_jwdcode;
  commit;

  --清除JC_ZX_FIXREC---
  delete from JC_ZX_FIXREC t where t.JWDCODE=v_jwdcode;
  commit;

  --清除JG_PLAN_CONTENT---
  delete from JG_PLAN_CONTENT t where t.JWDCODE=v_jwdcode;

  --清除JT_PREDICT---
  delete from JT_PREDICT t where t.JWDCODE=v_jwdcode;
  commit;

  --清除JT_RUNKILOREC---
  delete from DICT_PROTEAM t where t.JWDCODE=v_jwdcode;

  --清除MAINPLAN---
  delete from MAINPLAN t where t.JWDCODE=v_jwdcode;
  commit;

  --清除MAINPLANDETAIL---
  delete from MAINPLANDETAIL t where t.JWDCODE=v_jwdcode;
  commit;

  --清除OIL_ASSAY_DETAILRECORER---
  delete from OIL_ASSAY_DETAILRECORER t where t.JWDCODE=v_jwdcode;
  commit;

  --清除OIL_ASSAY_PRIRECORDER---
  delete from OIL_ASSAY_PRIRECORDER t where t.JWDCODE=v_jwdcode;
  commit;

  --清除OIL_ASSAY_ITEM---
  delete from OIL_ASSAY_ITEM t where t.JWDCODE=v_jwdcode;
  commit;

  --清除OIL_ASSAY_SUBITEM---
  delete from OIL_ASSAY_SUBITEM t where t.JWDCODE=v_jwdcode;
  commit;

  --清除PJ_DYNAMICINFO---
  delete from PJ_DYNAMICINFO t where t.JWDCODE=v_jwdcode;
  commit;

  --清除PJ_FIXFLOWRECORD---
  delete from PJ_FIXFLOWRECORD t where t.JWDCODE=v_jwdcode;
  commit;

  --清除PJ_FIXITEM---
  delete from PJ_FIXITEM t where t.JWDCODE=v_jwdcode;
  commit;

  --清除PJ_FIXRECORD---
  delete from PJ_FIXRECORD t where t.JWDCODE=v_jwdcode;
  commit;

  --清除PJ_STATICINFO---
  delete from PJ_STATICINFO t where t.JWDCODE=v_jwdcode;
  commit;

  --清除YSJC_ITEM---
  delete from YSJC_ITEM t where t.JWDCODE=v_jwdcode;
  commit;

  --清除YSJC_REC---
  delete from YSJC_REC t where t.JWDCODE=v_jwdcode;
  commit;
end;

  