--------------------------------------------------------
--  DDL for Trigger TRIGGER_JC_QZ_FIXREC
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "ADMIN"."TRIGGER_JC_QZ_FIXREC" 
  after insert or update or delete
  on JC_QZ_FIXREC FOR EACH ROW

/** HEAD
 * @name 秋整记录表触发器
 * @description 变更事件，形成ddl语句插入同步表中
 * @version 1.0.0
 * @author Tang
 * @create-date 2014-07-01
 */
declare
  v_sql nvarchar2(3000);             --临时存放sql
  v_jwdcode varchar2(30):='08052';    --机务段代码
  v_exception varchar(500);
begin
  v_sql := null;
  case when inserting then
          v_sql := 'insert into JC_QZ_FIXREC('||
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
          'values('''||
          :new.JCRECID||''','''||:new.WEKPRECID||''','''||:new.PJSID||''','''||:new.JCID||''','''||
          :new.DOPJBARCODE||''','''||:new.DOWNPJNUM||''','''||:new.UPPJBARCODE||''','''||:new.UPPJNUM||''','''||
          :new.THIRDUNITID||''','''||replace(:new.ITEMNAME,'''','')||''','''||replace(:new.PJNAME,'''','')||''','''||:new.LEFTMARGIN||''','''||
          :new.RIGHTMARGIN||''','''||:new.FIXSITUATION||''','''||:new.FIXEMP||''','''||:new.EMPAFFIRMTIME||''','''||
          :new.LEAD||''','''||:new.LDAFFIRMTIME||''','''||:new.COMMITLEAD||''','''||:new.COMLDAFFITIME||''','''||
          :new.QI||''','''||:new.QIAFFITIME||''','''||:new.ACCEPTER||''','''||:new.ACCEAFFITIME||''','''||
          :new.RECSTAS||''','''||:new.JCRECMID||''','''||:new.BZID||''','''||:new.MOREN||''','''||
          :new.BBRW||''','''||:new.BBRWAFFITIME||''','''||:new.JXZR||''','''||:new.JXZRAFFITIME||''','''||
          :new.ZJKZ||''','''||:new.ZJKZAFFITIME||''','''||:new.JSKZ||''','''||:new.JSKZAFFITIME||''','''||
          :new.DLD||''','''||:new.DLDAFFITIME||''','''||:new.LEADNAME||''','''||:new.WORKERNAME||''','''||
          :new.WORKERID||''','''||:new.ITEMTYPE||''','''||:new.TECHAFFITIME||''','''||:new.TECH||''','''||
          v_jwdcode||''')';
       when updating then
          v_sql := 'update JC_QZ_FIXREC set '||
                       'WEKPRECID='''||:new.WEKPRECID||''''||
                       ',PJSID='''||:new.PJSID||''''||
                       ',JCID='''||:new.JCID||''''||
                       ',DOPJBARCODE='''||:new.DOPJBARCODE||''''||
                       ',DOWNPJNUM='''||:new.DOWNPJNUM||''''||
                       ',UPPJBARCODE='''||:new.UPPJBARCODE||''''||
                       ',UPPJNUM='''||:new.UPPJNUM||''''||
                       ',THIRDUNITID='''||:new.THIRDUNITID||''''||
                       ',ITEMNAME='''||replace(:new.ITEMNAME,'''','')||''''||
                       ',PJNAME='''||replace(:new.PJNAME,'''','')||''''||
                       ',LEFTMARGIN='''||:new.LEFTMARGIN||''''||
                       ',RIGHTMARGIN='''||:new.RIGHTMARGIN||''''||
                       ',FIXSITUATION='''||:new.FIXSITUATION||''''||
                       ',FIXEMP='''||:new.FIXEMP||''''||
                       ',EMPAFFIRMTIME='''||:new.EMPAFFIRMTIME||''''||
                       ',LEAD='''||:new.LEAD||''''||
                       ',LDAFFIRMTIME='''||:new.LDAFFIRMTIME||''''||
                       ',COMMITLEAD='''||:new.COMMITLEAD||''''||
                       ',COMLDAFFITIME='''||:new.COMLDAFFITIME||''''||
                       ',QI='''||:new.QI||''''||
                       ',QIAFFITIME='''||:new.QIAFFITIME||''''||
                       ',ACCEPTER='''||:new.ACCEPTER||''''||
                       ',ACCEAFFITIME='''||:new.ACCEAFFITIME||''''||
                       ',RECSTAS='''||:new.RECSTAS||''''||
                       ',JCRECMID='''||:new.JCRECMID||''''||
                       ',BZID='''||:new.BZID||''''||
                       ',MOREN='''||:new.MOREN||''''||
                       ',BBRW='''||:new.BBRW||''''||
                       ',BBRWAFFITIME='''||:new.BBRWAFFITIME||''''||
                       ',JXZR='''||:new.JXZR||''''||
                       ',JXZRAFFITIME='''||:new.JXZRAFFITIME||''''||
                       ',ZJKZ='''||:new.ZJKZ||''''||
                       ',ZJKZAFFITIME='''||:new.ZJKZAFFITIME||''''||
                       ',JSKZ='''||:new.JSKZ||''''||
                       ',JSKZAFFITIME='''||:new.JSKZAFFITIME||''''||
                       ',DLD='''||:new.DLD||''''||
                       ',DLDAFFITIME='''||:new.DLDAFFITIME||''''||
                       ',LEADNAME='''||:new.LEADNAME||''''||
                       ',WORKERNAME='''||:new.WORKERNAME||''''||
                       ',WORKERID='''||:new.WORKERID||''''||
                       ',ITEMTYPE='''||:new.ITEMTYPE||''''||
                       ',TECHAFFITIME='''||:new.TECHAFFITIME||''''||
                       ',TECH='''||:new.TECH||''''||
                    ' where '||
                       'JCRECID='||:old.JCRECID||' and JWDCODE='''||v_jwdcode||'''';
       when deleting then
          v_sql := 'delete from JC_QZ_FIXREC t where t.JCRECID='||:old.JCRECID||' and t.JWDCODE='''||v_jwdcode||'''';
  end case;
  if v_sql is not null then
     insert into
            synchro_data_record(sd_record_id,sd_record_sql,sd_flag,create_time)
          values(SEQ_SYNCHRO_DATA.NEXTVAL,v_sql,0,to_char(sysdate,'YYYY-MM-DD HH24:MI:SS'));
  end if;
exception
  when others then
       v_exception := substr(sqlcode||'---'||sqlerrm, 1, 500);
      insert into SYNCHRO_DATA_TRIG_LOG
             (ID,TRIGGER_NAME,EXCEPTION_INFO,EXCEPTION_TIME)
      values
             (sys_guid(),'Trigger_DATEPLAN_PRI',v_exception,to_char(sysdate,'YYYY-MM-DD HH24:MI:SS'));
end Trigger_JC_QZ_FIXREC;
/
ALTER TRIGGER "ADMIN"."TRIGGER_JC_QZ_FIXREC" ENABLE;
