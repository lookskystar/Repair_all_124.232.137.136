declare
  v_jwdcode varchar2(30):='08052';    --机务段代码
  v_dblink varchar2(50):='dblink_CHANGSHA'; ---连接
begin
  --初始化日计划表
  delete from DATEPLAN_PRI t where t.JWDCODE=v_jwdcode;
  commit;
  execute immediate 'insert into DATEPLAN_PRI('||
      'RJHMID,JCTYPE,JCNUM,FIXFREQUE,'||
      'KCSJ,JHQJSJ,JHJCSJ,ZHIJIAN,'||
      'GONGZHANG,PLANSTATUE,GDH,TWH,'||
      'ZDR,ZDSJ,NODEID,YANSHOU,'||
      'JISHU,PROJECTTYPE,BANZU,SJQJSJ,'||
      'SJJCSJ,COMMENTS,WORKTEAM,JWDCODE)'||
  ' select '||
      'RJHMID,JCTYPE,JCNUM,FIXFREQUE,'||
      'KCSJ,JHQJSJ,JHJCSJ,ZHIJIAN,'||
      'GONGZHANG,PLANSTATUE,GDH,TWH,'||
      'ZDR,ZDSJ,NODEID,YANSHOU,'||
      'JISHU,PROJECTTYPE,BANZU,SJQJSJ,'||
      'SJJCSJ,COMMENTS,WORKTEAM,'''||v_jwdcode||''''||
  ' from DATEPLAN_PRI@'||v_dblink;
  commit;

  --初始化DICT_FIRSTUNIT---
  delete from DICT_FIRSTUNIT t where t.JWDCODE=v_jwdcode;
  commit;
  execute immediate 'insert into DICT_FIRSTUNIT('||
          'FIRSTUNITID,FIRSTUNITNAME,PY,JCSTYPEVALUE,'||
          'URL,JWDCODE)'||
      ' select '|| 
          'FIRSTUNITID,FIRSTUNITNAME,PY,JCSTYPEVALUE,'||
          'URL,'''||v_jwdcode||'''
  from DICT_FIRSTUNIT@'||v_dblink;
  commit;

  --初始化DICT_PROTEAM---
  delete from DICT_PROTEAM t where t.JWDCODE=v_jwdcode;
  commit;
  execute immediate 'insert into DICT_PROTEAM('||
          'PROTEAMID,PROTEAMNAME,PY,PROID,'||
          'JCTYPE,WORKFLAG,ZXFLAG,JWDCODE)'||
      ' select '|| 
          'PROTEAMID,PROTEAMNAME,PY,PROID,'||
          'JCTYPE,WORKFLAG,ZXFLAG,'''||v_jwdcode||''''||
  ' from DICT_PROTEAM@'||v_dblink;
  commit;

  --初始化DICT_SECUNIT---
  delete from DICT_SECUNIT t where t.JWDCODE=v_jwdcode;
  commit;
  execute immediate 'insert into DICT_SECUNIT('||
          'SECUNITID,FIRSTUNITID,SECUNITNAME,PY,'||
          'URL,JCSTYPEVALUE,JWDCODE)'||
      ' select '||
          'SECUNITID,FIRSTUNITID,SECUNITNAME,PY,'||
          'URL,JCSTYPEVALUE,'''||v_jwdcode||''''||
      ' from DICT_SECUNIT@'||v_dblink;
  commit;

  --初始化JC_EXPERIMENT_ITEM---
  delete from JC_EXPERIMENT_ITEM t where t.JWDCODE=v_jwdcode;
  commit;
  execute immediate 'insert into JC_EXPERIMENT_ITEM('||
          'JCEIID,JWDCODE,NODEID,ITEMNAE,'||
          'ITEMSN,PARENTID,CONDITION,TECHSTANDARD,'||
          'FILLDEFAVAL,EIMIN,EIMAX,UNIT,'||
          'ITEMPY,ITEMCTRLLEAD,ITEMCTRLCOMLD,ITEMCTRLQI,'||
          'ITEMCTRLTECH,ITEMCTRLACCE,JCSTYPE,XCXC,'||
          'JC,PROTEAM,YSID)'||
      ' select '|| 
          'JCEIID,'''||v_jwdcode||''',NODEID,ITEMNAE,'||
          'ITEMSN,PARENTID,CONDITION,TECHSTANDARD,'||
          'FILLDEFAVAL,EIMIN,EIMAX,UNIT,'||
          'ITEMPY,ITEMCTRLLEAD,ITEMCTRLCOMLD,ITEMCTRLQI,'||
          'ITEMCTRLTECH,ITEMCTRLACCE,JCSTYPE,XCXC,'||
          'JC,PROTEAM,YSID'||
     ' from JC_EXPERIMENT_ITEM@'||v_dblink;
  commit;

  --初始化JC_EXP_REC---
  delete from JC_EXP_REC t where t.JWDCODE=v_jwdcode;
  commit;
  execute immediate 'insert into JC_EXP_REC('||
          'JCERID,JWDCODE,JCNUM,DYPRECID,'||
          'XC,DOPJBARCODE,DOWNPJNUM,UPPJBARCODE,'||
          'UPPJNUM,ITEMID,ITEMNAME,EXPSTATUS,'||
          'UNIT,FIXEMPID,FIXEMP,EMPAFFIRMTIME,'||
          'LEADID,LEADER,LDAFFIRMTIME,TEACHID,'||
          'TEACHNAME,TEACHFITIME,QIID,QI,'||
          'QIAFFITIME,COMMITLEADID,COMMITLEAD,COMLDAFFITIME,'||
          'ACCEPTERID,ACCEPTER,ACCEAFFITIME,RECSTAS,'||
          'FIXSIGNEEID,FIXSIGNEE,EXPTYPE)'||
      ' select '|| 
          'JCERID,'''||v_jwdcode||''',JCNUM,DYPRECID,'||
          'XC,DOPJBARCODE,DOWNPJNUM,UPPJBARCODE,'||
          'UPPJNUM,ITEMID,ITEMNAME,EXPSTATUS,'||
          'UNIT,FIXEMPID,FIXEMP,EMPAFFIRMTIME,'||
          'LEADID,LEADER,LDAFFIRMTIME,TEACHID,'||
          'TEACHNAME,TEACHFITIME,QIID,QI,'||
          'QIAFFITIME,COMMITLEADID,COMMITLEAD,COMLDAFFITIME,'||
          'ACCEPTERID,ACCEPTER,ACCEAFFITIME,RECSTAS,'||
          'FIXSIGNEEID,FIXSIGNEE,EXPTYPE'||
     ' from JC_EXP_REC@'||v_dblink;
  commit;

  --初始化JC_FIXITEM---
  delete from JC_FIXITEM t where t.JWDCODE=v_jwdcode;
  commit;
  execute immediate 'insert into JC_FIXITEM('||
          'THIRDUNITID,JWDCODE,NODEID,FIRSTUNITID,'||
          'UNITNUM,UNITNAME,SECUNITID,SECUNITNUM,'||
          'SECUNITNAME,POSINUM,POSINAME,ITEMNAME,'||
          'ITEMORDER,TECHSTANDARD,FILLDEFAVAL,CHECKTIMES,'||
          'ISUSED,QUERYSHW,ITEMPY,UNITIPY,'||
          'SECUNITPY,ITEMCTRLLEAD,ITEMCTRLCOMLD,ITEMCTRLQI,'||
          'ITEMCTRLTECH,ITEMCTRLACCE,MIN1,MAX1,'||
          'PROTEAM,XIUCI,JCSTYPEVALUE,BZID,JC,'||
          'PROSETID,UNIT,DURATION)'||
      ' select '|| 
          'THIRDUNITID,'''||v_jwdcode||''',NODEID,FIRSTUNITID,'||
          'UNITNUM,UNITNAME,SECUNITID,SECUNITNUM,'||
          'SECUNITNAME,POSINUM,POSINAME,ITEMNAME,'||
          'ITEMORDER,TECHSTANDARD,FILLDEFAVAL,CHECKTIMES,'||
          'ISUSED,QUERYSHW,ITEMPY,UNITIPY,'||
          'SECUNITPY,ITEMCTRLLEAD,ITEMCTRLCOMLD,ITEMCTRLQI,'||
          'ITEMCTRLTECH,ITEMCTRLACCE,MIN1,MAX1,'||
          'PROTEAM,XIUCI,JCSTYPEVALUE,BZID,JC,'||
          'PROSETID,UNIT,DURATION'||
     ' from JC_FIXITEM@'||v_dblink;
  commit;

  --初始化JC_FIXREC---
  delete from JC_FIXREC t where t.JWDCODE=v_jwdcode;
  commit;
  execute immediate 'insert into JC_FIXREC('||
          'JCRECID,JWDCODE,JCID,DYPRECID,'||
          'DOPJBARCODE,DOWNPJNUM,UPPJBARCODE,UPPJNUM,'||
          'THIRDUNITID,ITEMNAME,PJSID,PJNAME,'||
          'LEFTMARGIN,RIGHTMARGIN,FIXSITUATION,FIXEMP,'||
          'EMPAFFIRMTIME,LEAD,LDAFFIRMTIME,COMMITLEAD,'||
          'COMLDAFFITIME,QI,QIAFFITIME,ACCEPTER,'||
          'ACCEAFFITIME,RECSTAS,PROFESSION,POSINAME,'||
          'SECUNITNAME,ITEMORDER,FILLDEFAVAL,TECHSTANDARD,'||
          'JCRECMID,BZID,MOREN,JCNUM,'||
          'JCTYPE,UNIT,PROTEAM,JHTIME,'||
          'FIXEMPID,ITEMTYPE,TECHAFFITIME,TECH,'||
          'WEKPRECID,DURATION,UNITNAME,ITEMCTRLLEAD,'||
          'ITEMCTRLCOMLD,ITEMCTRLQI,ITEMCTRLTECH,ITEMCTRLACCE,'||
          'FIRSTUNITID)'||
      ' select '|| 
          'JCRECID,'''||v_jwdcode||''',JCID,DYPRECID,'||
          'DOPJBARCODE,DOWNPJNUM,UPPJBARCODE,UPPJNUM,'||
          'THIRDUNITID,ITEMNAME,PJSID,PJNAME,'||
          'LEFTMARGIN,RIGHTMARGIN,FIXSITUATION,FIXEMP,'||
          'EMPAFFIRMTIME,LEAD,LDAFFIRMTIME,COMMITLEAD,'||
          'COMLDAFFITIME,QI,QIAFFITIME,ACCEPTER,'||
          'ACCEAFFITIME,RECSTAS,PROFESSION,POSINAME,'||
          'SECUNITNAME,ITEMORDER,FILLDEFAVAL,TECHSTANDARD,'||
          'JCRECMID,BZID,MOREN,JCNUM,'||
          'JCTYPE,UNIT,PROTEAM,JHTIME,'||
          'FIXEMPID,ITEMTYPE,TECHAFFITIME,TECH,'||
          'WEKPRECID,DURATION,UNITNAME,ITEMCTRLLEAD,'||
          'ITEMCTRLCOMLD,ITEMCTRLQI,ITEMCTRLTECH,ITEMCTRLACCE,'||
          'FIRSTUNITID'||
     ' from JC_FIXREC@'||v_dblink;
  commit;

  --初始化JC_FLOWREC---
  delete from JC_FLOWREC t where t.JWDCODE=v_jwdcode;
  commit;
  execute immediate 'insert into JC_FLOWREC('||
          'JCFLOWRECID,JCFLOWID,BZID,FINISHSTATUS,'||
          'FINISHTIME,DYPRECID,JWDCODE)'||
      ' select '|| 
          'JCFLOWRECID,JCFLOWID,BZID,FINISHSTATUS,'||
          'FINISHTIME,DYPRECID,'''||v_jwdcode||''''||
     ' from JC_FLOWREC@'||v_dblink;
  commit;

  --初始化JC_QZ_FIXREC---
  delete from JC_QZ_FIXREC t where t.JWDCODE=v_jwdcode;
  commit;
  execute immediate 'insert into JC_QZ_FIXREC('||
          'JCRECID,WEKPRECID,PJSID,JCID,'||
          'DOPJBARCODE,DOWNPJNUM,UPPJBARCODE,'||
          'UPPJNUM,THIRDUNITID,ITEMNAME,PJNAME,LEFTMARGIN,'||
          'RIGHTMARGIN,FIXSITUATION,FIXEMP,EMPAFFIRMTIME,LEAD,'||
          'LDAFFIRMTIME,COMMITLEAD,COMLDAFFITIME,QI,QIAFFITIME,'||
          'ACCEPTER,ACCEAFFITIME,RECSTAS,JCRECMID,BZID,'||
          'MOREN,BBRW,BBRWAFFITIME,JXZR,JXZRAFFITIME,'||
          'ZJKZ,ZJKZAFFITIME,JSKZ,JSKZAFFITIME,DLD,'||
          'DLDAFFITIME,LEADNAME,WORKERNAME,WORKERID,ITEMTYPE,'||
          'TECHAFFITIME,TECH,JWDCODE)'||
      ' select '|| 
          'JCRECID,WEKPRECID,PJSID,JCID,'||
          'DOPJBARCODE,DOWNPJNUM,UPPJBARCODE,'||
          'UPPJNUM,THIRDUNITID,ITEMNAME,PJNAME,LEFTMARGIN,'||
          'RIGHTMARGIN,FIXSITUATION,FIXEMP,EMPAFFIRMTIME,LEAD,'||
          'LDAFFIRMTIME,COMMITLEAD,COMLDAFFITIME,QI,QIAFFITIME,'||
          'ACCEPTER,ACCEAFFITIME,RECSTAS,JCRECMID,BZID,'||
          'MOREN,BBRW,BBRWAFFITIME,JXZR,JXZRAFFITIME,'||
          'ZJKZ,ZJKZAFFITIME,JSKZ,JSKZAFFITIME,DLD,'||
          'DLDAFFITIME,LEADNAME,WORKERNAME,WORKERID,ITEMTYPE,'||
          'TECHAFFITIME,TECH,'''||v_jwdcode||''''||
     ' from JC_QZ_FIXREC@'||v_dblink;
  commit;

  --初始化JC_QZ_ITEMS---
  delete from JC_QZ_ITEMS t where t.JWDCODE=v_jwdcode;
  commit;
  execute immediate 'insert into JC_QZ_ITEMS('||
          'ID,FIRSTUNITID,UNITNUM,UNITNAME,'||
          'XH,ITEMNAME,TECHSTANDARD,'||
          'FILLDEFAVAL,MIN1,MAX1,XIUCI,JCSTYPE,'||
          'BZID,JWDCODE)'||
      ' select '|| 
          'ID,FIRSTUNITID,UNITNUM,UNITNAME,'||
          'XH,ITEMNAME,TECHSTANDARD,'||
          'FILLDEFAVAL,MIN1,MAX1,XIUCI,JCSTYPE,'||
          'BZID,'''||v_jwdcode||''''||
     ' from JC_QZ_ITEMS@'||v_dblink;
  commit;

  --初始化JC_ZX_FIXITEM---
  delete from JC_ZX_FIXITEM t where t.JWDCODE=v_jwdcode;
  commit;
  execute immediate 'insert into JC_ZX_FIXITEM('||
          'ID,NODEID,ITEMNAME,ITEMSN,'||
          'PARENTID,TIMENUM,TECHSTANDARD,'||
          'FILLDEFAVAL,MIN,MAX,UNIT,ITEMPY,'||
          'ITEMCTRLLEAD,ITEMCTRLCOMLD,ITEMCTRLQI,ITEMCTRLTECH,ITEMCTRLACCE,'||
          'JCSTYPE,XCXC,JC,PROTEAM,YSID,'||
          'BZID,ITEMRELATION,UNITNAME,POSINAME,FIRSTUNITID,'||
          'DURATION,AMOUNT,STDPJID,ITEMCTRLREPT,JWDCODE)'||
      ' select '|| 
          'ID,NODEID,ITEMNAME,ITEMSN,'||
          'PARENTID,TIMENUM,TECHSTANDARD,'||
          'FILLDEFAVAL,MIN,MAX,UNIT,ITEMPY,'||
          'ITEMCTRLLEAD,ITEMCTRLCOMLD,ITEMCTRLQI,ITEMCTRLTECH,ITEMCTRLACCE,'||
          'JCSTYPE,XCXC,JC,PROTEAM,YSID,'||
          'BZID,ITEMRELATION,UNITNAME,POSINAME,FIRSTUNITID,'||
          'DURATION,AMOUNT,STDPJID,ITEMCTRLREPT,'''||v_jwdcode||''''||
     ' from JC_ZX_FIXITEM@'||v_dblink;
  commit;

  --初始化JC_ZX_FIXREC---
  delete from JC_ZX_FIXREC t where t.JWDCODE=v_jwdcode;
  commit;
  execute immediate 'insert into JC_ZX_FIXREC('||
          'ID,JWDCODE,JCTYPE,DYPRECID,'||
          'DOWNPJBARCODE,DOWNPJNUM,UPPJBARCODE,UPPJNUM,'||
          'ITEMID,ITEMNAME,FIXSITUATION,UNIT,'||
          'FIXEMPID,FIXEMP,EMPAFFIRMTIME,LEADID,'||
          'LEAD,LDAFFIRMTIME,TEACHID,TEACHNAME,'||
          'TEALDAFFITIME,QIID,QI,QIAFFITIME,'||
          'COMMITLEADID,COMMITLEAD,COMLDAFFITIME,ACCEPTERID,'||
          'ACCEPTER,ACCEAFFITIME,RECSTAS,ITEMTYPE,'||
          'JCNUM,JHTIME,BZID,NODEID,'||
          'DURATION,REPTID,REPT,REPTAFFIRMTIME,'||
          'DEALSITUATION,ITEMCTRLREPT,POSINAME,UNITNAME,'||
          'ITEMCTRLLEAD,ITEMCTRLCOMLD,ITEMCTRLQI,ITEMCTRLTECH,'||
          'ITEMCTRLACCE,FIRSTUNITID)'||
      ' select '|| 
          'ID,'''||v_jwdcode||''',JCTYPE,DYPRECID,'||
          'DOWNPJBARCODE,DOWNPJNUM,UPPJBARCODE,UPPJNUM,'||
          'ITEMID,ITEMNAME,FIXSITUATION,UNIT,'||
          'FIXEMPID,FIXEMP,EMPAFFIRMTIME,LEADID,'||
          'LEAD,LDAFFIRMTIME,TEACHID,TEACHNAME,'||
          'TEALDAFFITIME,QIID,QI,QIAFFITIME,'||
          'COMMITLEADID,COMMITLEAD,COMLDAFFITIME,ACCEPTERID,'||
          'ACCEPTER,ACCEAFFITIME,RECSTAS,ITEMTYPE,'||
          'JCNUM,JHTIME,BZID,NODEID,'||
          'DURATION,REPTID,REPT,REPTAFFIRMTIME,'||
          'DEALSITUATION,ITEMCTRLREPT,POSINAME,UNITNAME,'||
          'ITEMCTRLLEAD,ITEMCTRLCOMLD,ITEMCTRLQI,ITEMCTRLTECH,'||
          'ITEMCTRLACCE,FIRSTUNITID'||
     ' from JC_ZX_FIXREC@'||v_dblink;
  commit;

  --初始化JG_PLAN_CONTENT---
  delete from JG_PLAN_CONTENT t where t.JWDCODE=v_jwdcode;
  commit;
  execute immediate 'insert into JG_PLAN_CONTENT('||
          'ID,JG_CONTENT,PLAN_NUM,JC_TYPE,'||
          'JWDCODE)'||
      ' select '|| 
          'ID,JG_CONTENT,PLAN_NUM,JC_TYPE,'||
          ''''||v_jwdcode||''''||
  ' from JG_PLAN_CONTENT@'||v_dblink;
  commit;

  --初始化JT_PREDICT---
  delete from JT_PREDICT t where t.JWDCODE=v_jwdcode;
  commit;
  execute immediate 'insert into JT_PREDICT('||
          'PREDICTID,JWDCODE,REPTIME,JCTYPE,'||
          'JCNUM,REPPOSI,REPSITUATION,FAILNUM,'||
          'FAILNOTE,REPEMPNO,REPEMP,VERIFYTIME,'||
          'VERYFIER,RECEIPTPEO,RECETIME,FIXEMP,'||
          'DEALSITUATION,FIXENDTIME,LEAD,LDAFFIRMTIME,'||
          'COMMITLD,COMLDAFFITIME,QI,QIAFFITIME,'||
          'ACCEPTER,ACCETIME,TECHNICIAN,TECHAFFITIME,'||
          'AFFIRMGRADE,TYPE,ZEROKILORECID,RECSTAS,'||
          'REPDATE,THIRDUNITID,CLQK,FIXEMPID,'||
          'LEADID,COMMITLDID,QIID,ACCEPTERID,'||
          'TECHNICIANID,IMGURL,PROTEAMID,ITEMCTRLCOMLD,'||
          'ITEMCTRQI,ITEMCTRLTECH,ITEMCTRLACCE,DATEPLANPRI,'||
          'DEALFIXEMP,FIXEMPIDS,FIXEMPS,ASSIGNEDIDS,'||
          'ASSIGNEDNAMES,FIXEMDTIME,JCRECMID,BZID,'||
          'BZNAME,DIVISIONID,SMPREDICTID,UPPJNUM,'||
          'SCORE)'||
      ' select '|| 
          'PREDICTID,'''||v_jwdcode||''',REPTIME,JCTYPE,'||
          'JCNUM,REPPOSI,REPSITUATION,FAILNUM,'||
          'FAILNOTE,REPEMPNO,REPEMP,VERIFYTIME,'||
          'VERYFIER,RECEIPTPEO,RECETIME,FIXEMP,'||
          'DEALSITUATION,FIXENDTIME,LEAD,LDAFFIRMTIME,'||
          'COMMITLD,COMLDAFFITIME,QI,QIAFFITIME,'||
          'ACCEPTER,ACCETIME,TECHNICIAN,TECHAFFITIME,'||
          'AFFIRMGRADE,TYPE,ZEROKILORECID,RECSTAS,'||
          'REPDATE,THIRDUNITID,CLQK,FIXEMPID,'||
          'LEADID,COMMITLDID,QIID,ACCEPTERID,'||
          'TECHNICIANID,IMGURL,PROTEAMID,ITEMCTRLCOMLD,'||
          'ITEMCTRQI,ITEMCTRLTECH,ITEMCTRLACCE,DATEPLANPRI,'||
          'DEALFIXEMP,FIXEMPIDS,FIXEMPS,ASSIGNEDIDS,'||
          'ASSIGNEDNAMES,FIXEMDTIME,JCRECMID,BZID,'||
          'BZNAME,DIVISIONID,SMPREDICTID,UPPJNUM,'||
          'SCORE'||
     ' from JT_PREDICT@'||v_dblink;
  commit;

  --初始化JT_RUNKILOREC---
  delete from JT_RUNKILOREC t where t.JWDCODE=v_jwdcode;
  commit;
  execute immediate 'insert into JT_RUNKILOREC('||
          'RUNID,JWDCODE,NOWDATE,JCTYPE,'||
          'JCNUM,DAYRUNKILO,MINORRUNKILO,SMARUNKILO,'||
          'MIDRUNKILO,LARRUNKILO,TOTALRUNKILO,REGISTRANT,'||
          'REGISTTIME,VARY)'||
      ' select '|| 
          'RUNID,'''||v_jwdcode||''',NOWDATE,JCTYPE,'||
          'JCNUM,DAYRUNKILO,MINORRUNKILO,SMARUNKILO,'||
          'MIDRUNKILO,LARRUNKILO,TOTALRUNKILO,REGISTRANT,'||
          'REGISTTIME,VARY'||
  ' from JT_RUNKILOREC@'||v_dblink;
  commit;  

  --初始化MAINPLAN---
  delete from MAINPLAN t where t.JWDCODE=v_jwdcode;
  commit;
  execute immediate 'insert into MAINPLAN('||
          'ID,STARTTIME,ENDTIME,TITLE,MAKEPEOPLE,'||
          'MAKETIME,COMMENTS,STATUS,JWDCODE)'||
      ' select '|| 
          'ID,STARTTIME,ENDTIME,TITLE,MAKEPEOPLE,'||
          'MAKETIME,COMMENTS,STATUS,'''||v_jwdcode||''''||
     ' from MAINPLAN@'||v_dblink;
  commit;

  --初始化MAINPLANDETAIL---
  delete from MAINPLANDETAIL t where t.JWDCODE=v_jwdcode;
  commit;
  execute immediate 'insert into MAINPLANDETAIL('||
          'ID,MAINPLANID,PLANTIME,PLANWEEK,'||
          'NUM,JCTYPE,JCNUM,XCXC,'||
          'KILOMETRE,KCAREA,COMMENTS,ISCASH,'||
          'CASHREASON,REALKILOMETRE,RJHMID,JWDCODE)'||
      ' select '|| 
          'ID,MAINPLANID,PLANTIME,PLANWEEK,'||
          'NUM,JCTYPE,JCNUM,XCXC,'||
          'KILOMETRE,KCAREA,COMMENTS,ISCASH,'||
          'CASHREASON,REALKILOMETRE,RJHMID,'''||v_jwdcode||''''||
     ' from MAINPLANDETAIL@'||v_dblink;
  commit;

  --初始化OIL_ASSAY_DETAILRECORER---
  delete from OIL_ASSAY_DETAILRECORER t where t.JWDCODE=v_jwdcode;
  commit;
  execute immediate 'insert into OIL_ASSAY_DETAILRECORER('||
          'RECDETAILID,RECPRIID,SUBITEMID,SUBITEMTITLE,RECEIPTPEO,'||
          'FINTIME,REALDETEVAL,QUAGRADE,JWDCODE)'||
      ' select '|| 
          'RECDETAILID,RECPRIID,SUBITEMID,SUBITEMTITLE,RECEIPTPEO,'||
          'FINTIME,REALDETEVAL,QUAGRADE,'''||v_jwdcode||''''||
     ' from OIL_ASSAY_DETAILRECORER@'||v_dblink;
  commit;

  --初始化OIL_ASSAY_PRIRECORDER---
  delete from OIL_ASSAY_PRIRECORDER t where t.JWDCODE=v_jwdcode;
  commit;
  execute immediate 'insert into OIL_ASSAY_PRIRECORDER('||
          'RECPRIID,AREAID,WEKPRECID,SENTSAMPEO,'||
          'RECEIPTPEO,RECESAMTIME,FINTIME,DETECTESTATUS,'||
          'JCSTYPEVAL,JCNUM,DEALADVICE,QUASITUATION,'||
          'JWDCODE)'||
      ' select '|| 
          'RECPRIID,AREAID,WEKPRECID,SENTSAMPEO,'||
          'RECEIPTPEO,RECESAMTIME,FINTIME,DETECTESTATUS,'||
          'JCSTYPEVAL,JCNUM,DEALADVICE,QUASITUATION,'||
          ''''||v_jwdcode||''''||
     ' from OIL_ASSAY_PRIRECORDER@'||v_dblink;
  commit;

  --初始化OIL_ASSAY_ITEM---
  delete from OIL_ASSAY_ITEM t where t.JWDCODE=v_jwdcode;
  commit;
  execute immediate 'insert into OIL_ASSAY_ITEM('||
          'REPORTITEMID,REPORTITEMPY,REPORTITEMDEFIN,SERES,'||
          'ISUSED,JCVALUE,JWDCODE)'||
      ' select '|| 
          'REPORTITEMID,REPORTITEMPY,REPORTITEMDEFIN,SERES,'||
          'ISUSED,JCVALUE,'''||v_jwdcode||''''||
     ' from OIL_ASSAY_ITEM@'||v_dblink;
  commit; 

  --初始化OIL_ASSAY_SUBITEM---
  delete from OIL_ASSAY_SUBITEM t where t.JWDCODE=v_jwdcode;
  commit;
  execute immediate 'insert into OIL_ASSAY_SUBITEM('||
          'SUBITEMID,PROTEAMID,REPORTITEMID,SUBITEMTITLE,'||
          'SUBITEMPY,FREQUENCY,ISUSED,ISUSUAL,'||
          'MAXVAL,MINVAL,FILLDEFVAL,JCSTYPEVAL,'||
          'JWDCODE)'||
      ' select '|| 
          'SUBITEMID,PROTEAMID,REPORTITEMID,SUBITEMTITLE,'||
          'SUBITEMPY,FREQUENCY,ISUSED,ISUSUAL,'||
          'MAXVAL,MINVAL,FILLDEFVAL,JCSTYPEVAL,'||
          ''''||v_jwdcode||''''||
     ' from OIL_ASSAY_SUBITEM@'||v_dblink;
  commit;

  --初始化PJ_DYNAMICINFO---
  delete from PJ_DYNAMICINFO t where t.JWDCODE=v_jwdcode;
  commit;
  execute immediate 'insert into PJ_DYNAMICINFO('||
          'PJDID,PJSID,FACTORYNUM,PJBARCODE,'||
          'PJNAME,STOREPOSITION,PY,PJSTATUS,'||
          'FACTORY,OUTFACDATE,FIXFLOWNAME,GETONNUM,'||
          'PJNUM,HRID,COMMENTS,JWDCODE)'||
      ' select '|| 
          'PJDID,PJSID,FACTORYNUM,PJBARCODE,'||
          'PJNAME,STOREPOSITION,PY,PJSTATUS,'||
          'FACTORY,OUTFACDATE,FIXFLOWNAME,GETONNUM,'||
          'PJNUM,HRID,COMMENTS,'''||v_jwdcode||''''||
     ' from PJ_DYNAMICINFO@'||v_dblink;
  commit;

  --初始化PJ_FIXFLOWRECORD---
  delete from PJ_FIXFLOWRECORD t where t.JWDCODE=v_jwdcode;
  commit;
  execute immediate 'insert into PJ_FIXFLOWRECORD('||
          'RECID,STATUS,NODEID,PROTEAMID,'||
          'PLANID,JWDCODE)'||
      ' select '|| 
          'RECID,STATUS,NODEID,PROTEAMID,'||
          'PLANID,'''||v_jwdcode||''''||
     ' from PJ_FIXFLOWRECORD@'||v_dblink;
  commit;

  --初始化PJ_FIXITEM---
  delete from PJ_FIXITEM t where t.JWDCODE=v_jwdcode;
  commit;
  execute immediate 'insert into PJ_FIXITEM('||
          'PJITEMID,JWDCODE,PJSID,PJNAME,'||
          'NODEID,FIXITEM,ITEMORDER,TECHSTANDARD,'||
          'ITEMFILLDEFA,QUERYSHWSTAS,ITEMPY,ITEMCTRLLEAD,'||
          'ITEMCTRLCOMLD,ITEMCTRLQI,ITEMCTRLTECH,ITEMCTRLACCE,'||
          'MINVAL,MAXVAL,CHILDPJID,PROTEAMID,'||
          'CHILDPJNAME,POSINAME,'||
          'UNIT,AMOUNT,ITEMCTRLREPT)'||
      ' select '|| 
          'PJITEMID,'''||v_jwdcode||''',PJSID,PJNAME,'||
          'NODEID,FIXITEM,ITEMORDER,TECHSTANDARD,'||
          'ITEMFILLDEFA,QUERYSHWSTAS,ITEMPY,ITEMCTRLLEAD,'||
          'ITEMCTRLCOMLD,ITEMCTRLQI,ITEMCTRLTECH,ITEMCTRLACCE,'||
          'MINVAL,MAXVAL,CHILDPJID,PROTEAMID,'||
          'CHILDPJNAME,POSINAME,'||
          'UNIT,AMOUNT,ITEMCTRLREPT'||
     ' from PJ_FIXITEM@'||v_dblink;
  commit;

  --初始化PJ_FIXRECORD---
  delete from PJ_FIXRECORD t where t.JWDCODE=v_jwdcode;
  commit;
  execute immediate 'insert into PJ_FIXRECORD('||
          'PJRECID,PJITEMID,PJSID,PJDID,'||
          'JWDCODE,PJPREDICTID,DOWNPJNUM,UPPJNUM,'||
          'PJNAME,LEFTMARGIN,RIGHTMARGIN,FIXSITUATION,'||
          'FIXEMPID,FIXEMP,EMPAFFIRMTIME,LEADID,'||
          'LEAD,LDAFFIRMTIME,COMMITLEADID,COMMITLEAD,'||
          'COMLDAFFITIME,QIID,QI,QIAFFITIME,'||
          'ACCEPTERID,ACCEPTER,ACCEAFFITIME,PJFIXRECSID,'||
          'PRESTATUS,TYPE,RECSTAS,ACCEPTTIME,'||
          'CHILDPJID,TECHID,TECHNAME,TECHTIME,'||
          'RECID,TEAMS,PJNUM,PARENTID,'||
          'RJHMID,REPTID,REPT,REPTAFFIRMTIME,'||
          'DEALSITUATION,ITEMCTRLREPT,POSINAME,FIXITEM,'||
          'UNIT,ITEMCTRLLEAD,ITEMCTRLCOMLD,ITEMCTRLQI,'||
          'ITEMCTRLTECH,ITEMCTRLACCE)'||
      ' select '|| 
          'PJRECID,PJITEMID,PJSID,PJDID,'||''''||
          v_jwdcode||''',PJPREDICTID,DOWNPJNUM,UPPJNUM,'||
          'PJNAME,LEFTMARGIN,RIGHTMARGIN,FIXSITUATION,'||
          'FIXEMPID,FIXEMP,EMPAFFIRMTIME,LEADID,'||
          'LEAD,LDAFFIRMTIME,COMMITLEADID,COMMITLEAD,'||
          'COMLDAFFITIME,QIID,QI,QIAFFITIME,'||
          'ACCEPTERID,ACCEPTER,ACCEAFFITIME,PJFIXRECSID,'||
          'PRESTATUS,TYPE,RECSTAS,ACCEPTTIME,'||
          'CHILDPJID,TECHID,TECHNAME,TECHTIME,'||
          'RECID,TEAMS,PJNUM,PARENTID,'||
          'RJHMID,REPTID,REPT,REPTAFFIRMTIME,'||
          'DEALSITUATION,ITEMCTRLREPT,POSINAME,FIXITEM,'||
          'UNIT,ITEMCTRLLEAD,ITEMCTRLCOMLD,ITEMCTRLQI,'||
          'ITEMCTRLTECH,ITEMCTRLACCE'||
     ' from PJ_FIXRECORD@'||v_dblink;
  commit;

  --初始化PJ_STATICINFO---
  delete from PJ_STATICINFO t where t.JWDCODE=v_jwdcode;
  commit;
  execute immediate 'insert into PJ_STATICINFO('||
          'PJSID,PARENTID,JWDCODE,PJNAME,'||
          'LOWESTSTORE,MOSTSTORE,FIRSTUNITID,PY,'||
          'JCTYPE,VISITRECORD,FLOWTYPEID,AMOUNT,'||
          'TYPE,BZIDS,SECUNITID)'||
      ' select '|| 
          'PJSID,PARENTID,'''||v_jwdcode||''',PJNAME,'||
          'LOWESTSTORE,MOSTSTORE,FIRSTUNITID,PY,'||
          'JCTYPE,VISITRECORD,FLOWTYPEID,AMOUNT,'||
          'TYPE,BZIDS,SECUNITID'||
     ' from PJ_STATICINFO@'||v_dblink;
  commit;

  --初始化YSJC_ITEM---
  delete from YSJC_ITEM t where t.JWDCODE=v_jwdcode;
  commit;
  execute immediate 'insert into YSJC_ITEM('||
          'ITEMID,CLASSIFY,ITEMNAME,ORDERNO,'||
          'UNIT,MAX,MIN,ISCHECK,'||
          'JCTYPE,JWDCODE)'||
      ' select '|| 
          'ITEMID,CLASSIFY,ITEMNAME,ORDERNO,'||
          'UNIT,MAX,MIN,ISCHECK,'||
          'JCTYPE,'''||v_jwdcode||''''||
     ' from YSJC_ITEM@'||v_dblink;
  commit;

  --初始化YSJC_REC---
  delete from YSJC_REC t where t.JWDCODE=v_jwdcode;
  commit;
  execute immediate 'insert into YSJC_REC('||
          'RECID,RJHMID,ITEMID,FIXSITUATION,'||
          'FIXEMP,FIXEMPTIME,TECH,TECHAFFITIME,'||
          'ACCEPT,ACCEPTAFFITIME,COMMITLEAD,COMMAFFITIME,'||
          'CLASSIFY,ITEMNAME,UNIT,ORDERNO,'||
          'JWDCODE)'||
      ' select '|| 
          'RECID,RJHMID,ITEMID,FIXSITUATION,'||
          'FIXEMP,FIXEMPTIME,TECH,TECHAFFITIME,'||
          'ACCEPT,ACCEPTAFFITIME,COMMITLEAD,COMMAFFITIME,'||
          'CLASSIFY,ITEMNAME,UNIT,ORDERNO,'''||v_jwdcode||''''||
     ' from YSJC_REC@'||v_dblink;
  commit;     
  
   --初始化交车竣工单表
  delete from SIGNEDFORFINISH t where t.JWDCODE=v_jwdcode;
  commit;
  execute immediate 'insert into SIGNEDFORFINISH('||
      'JGID,DPID,JCLX,JCH,'||
      'XCXC,KSSJ,JSSJ,JCGZID,'||
      'JCGZXM,JXZRID,JXZRXM,YSYID,'||
      'YSYXM,DZID,DZXM,TYPE,'||
      'BLONGAREA,FIXAREA,REASON,JWDCODE)'||
  ' select '||
       'JGID,DPID,JCLX,JCH,'||
      'XCXC,KSSJ,JSSJ,JCGZID,'||
      'JCGZXM,JXZRID,JXZRXM,YSYID,'||
      'YSYXM,DZID,DZXM,TYPE,'||
      'BLONGAREA,FIXAREA,REASON,'''||v_jwdcode||''''||
  ' from SIGNEDFORFINISH@'||v_dblink;
  commit;

   --初始化故障表
  delete from DICT_FAILURE t ;
  commit;
  execute immediate 'insert into DICT_FAILURE('||
      'ID,FIRSTUNITNAME,SECUNITNAME,THIRDUNITNAME,'||
      'CONTENT,FIXCONTENT,SCORE)'||
  ' select '||
      'ID,FIRSTUNITNAME,SECUNITNAME,THIRDUNITNAME,'||
      'CONTENT,FIXCONTENT,SCORE'||
  ' from DICT_FAILURE@'||v_dblink;
  commit;

    --初始化用户表
  delete from USERS_PRIVS t where t.JWDCODE=v_jwdcode;
  commit;
  execute immediate 'insert into USERS_PRIVS('||
      'USERID,AREAID,ISUSE,DEPATID,'||
      'BZID,ZWID,XM,NAME,GONGHAO,'||
      'IDKID,ROLEID,PWD,LOGINTIME,'||
      'PROTEAMID,UPTIME,SEX,QUE,ANS,'||
      'TEL,FAX,MOBILE,MOBILE2,HOMEPHONE,'||
      'ADDRESS,IP,PY,QITA,JWDCODE)'||
  ' select '||
      'USERID,AREAID,ISUSE,DEPATID,'||
      'BZID,ZWID,XM,NAME,GONGHAO,'||
      'IDKID,ROLEID,PWD,LOGINTIME,'||
      'PROTEAMID,UPTIME,SEX,QUE,ANS,'||
      'TEL,FAX,MOBILE,MOBILE2,HOMEPHONE,'||
      'ADDRESS,IP,PY,QITA,'''||v_jwdcode||''''||
  ' from USERS_PRIVS@'||v_dblink;
  commit;
end;