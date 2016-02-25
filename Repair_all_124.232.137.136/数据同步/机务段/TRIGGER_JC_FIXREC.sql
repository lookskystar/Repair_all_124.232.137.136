--------------------------------------------------------
--  DDL for Trigger TRIGGER_JC_FIXREC
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "ADMIN"."TRIGGER_JC_FIXREC" 
AFTER INSERT OR DELETE OR UPDATE
ON JC_FIXREC for each row

/** HEAD
 * @name 小辅修记录表触发器
 * @description 变更事件，形成ddl语句插入同步表中
 * @version 1.0.0
 * @author L
 * @create-date 2014-07-01
 */
declare
  v_sql nvarchar2(3000);             --临时存放sql
  v_jwdcode varchar2(30):='08052';    --机务段代码
  v_exception varchar2(500);
begin
  v_sql := null;
  case when inserting then
          v_sql := 'insert into JC_FIXREC('||
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
          'values('''||
          :new.JCRECID||''','''||v_jwdcode||''','''||:new.JCID||''','''||:new.DYPRECID||''','''||
          :new.DOPJBARCODE||''','''||:new.DOWNPJNUM||''','''||:new.UPPJBARCODE||''','''||:new.UPPJNUM||''','''||
          :new.THIRDUNITID||''','''||replace(:new.ITEMNAME,'''','')||''','''||:new.PJSID||''','''||replace(:new.PJNAME,'''','')||''','''||
          :new.LEFTMARGIN||''','''||:new.RIGHTMARGIN||''','''||:new.FIXSITUATION||''','''||:new.FIXEMP||''','''||
          :new.EMPAFFIRMTIME||''','''||:new.LEAD||''','''||:new.LDAFFIRMTIME||''','''||:new.COMMITLEAD||''','''||
          :new.COMLDAFFITIME||''','''||:new.QI||''','''||:new.QIAFFITIME||''','''||:new.ACCEPTER||''','''||
          :new.ACCEAFFITIME||''','''||:new.RECSTAS||''','''||:new.PROFESSION||''','''||replace(:new.POSINAME,'''','')||''','''||
          replace(:new.SECUNITNAME,'''','')||''','''||:new.ITEMORDER||''','''||:new.FILLDEFAVAL||''','''||:new.TECHSTANDARD||''','''||
          :new.JCRECMID||''','''||:new.BZID||''','''||:new.MOREN||''','''||:new.JCNUM||''','''||
          :new.JCTYPE||''','''||:new.UNIT||''','''||replace(:new.PROTEAM,'''','')||''','''||:new.JHTIME||''','''||
          :new.FIXEMPID||''','''||:new.ITEMTYPE||''','''||:new.TECHAFFITIME||''','''||:new.TECH||''','''||
          :new.WEKPRECID||''','''||:new.DURATION||''','''||replace(:new.UNITNAME,'''','')||''','''||:new.ITEMCTRLLEAD||''','''||
          :new.ITEMCTRLCOMLD||''','''||:new.ITEMCTRLQI||''','''||:new.ITEMCTRLTECH||''','''||:new.ITEMCTRLACCE||''','''||
          :new.FIRSTUNITID||''')';
       when updating then
          v_sql := 'update JC_FIXREC set '||
                       'JCID='''||:new.JCID||''''||
                       ',DYPRECID='''||:new.DYPRECID||''''||
                       ',DOPJBARCODE='''||:new.DOPJBARCODE||''''||
                       ',DOWNPJNUM='''||:new.DOWNPJNUM||''''||
                       ',UPPJBARCODE='''||:new.UPPJBARCODE||''''||
                       ',UPPJNUM='''||:new.UPPJNUM||''''||
                       ',THIRDUNITID='''||:new.THIRDUNITID||''''||
                       ',ITEMNAME='''||replace(:new.ITEMNAME,'''','')||''''||
                       ',PJSID='''||:new.PJSID||''''||
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
                       ',PROFESSION='''||:new.PROFESSION||''''||
                       ',POSINAME='''||replace(:new.POSINAME,'''','')||''''||
                       ',SECUNITNAME='''||replace(:new.SECUNITNAME,'''','')||''''||
                       ',ITEMORDER='''||:new.ITEMORDER||''''||
                       ',FILLDEFAVAL='''||:new.FILLDEFAVAL||''''||
                       ',TECHSTANDARD='''||:new.TECHSTANDARD||''''||
                       ',JCRECMID='''||:new.JCRECMID||''''||
                       ',BZID='''||:new.BZID||''''||
                       ',MOREN='''||:new.MOREN||''''||
                       ',JCNUM='''||:new.JCNUM||''''||
                       ',JCTYPE='''||:new.JCTYPE||''''||
                       ',UNIT='''||:new.UNIT||''''||
                       ',PROTEAM='''||replace(:new.PROTEAM,'''','')||''''||
                       ',JHTIME='''||:new.JHTIME||''''||
                       ',FIXEMPID='''||:new.FIXEMPID||''''||
                       ',ITEMTYPE='''||:new.ITEMTYPE||''''||
                       ',TECHAFFITIME='''||:new.TECHAFFITIME||''''||
                       ',TECH='''||:new.TECH||''''||
                       ',WEKPRECID='''||:new.WEKPRECID||''''||
                       ',DURATION='''||:new.DURATION||''''||
                       ',UNITNAME='''||replace(:new.UNITNAME,'''','')||''''||
                       ',ITEMCTRLLEAD='''||:new.ITEMCTRLLEAD||''''||
                       ',ITEMCTRLCOMLD='''||:new.ITEMCTRLCOMLD||''''||
                       ',ITEMCTRLQI='''||:new.ITEMCTRLQI||''''||
                       ',ITEMCTRLTECH='''||:new.ITEMCTRLTECH||''''||
                       ',ITEMCTRLACCE='''||:new.ITEMCTRLACCE||''''||
                       ',FIRSTUNITID='''||:new.FIRSTUNITID||''''||
                    ' where '||
                       'JCRECID='||:old.JCRECID||' and jwdcode='''||v_jwdcode||'''';
       when deleting then
          v_sql := 'delete from JC_FIXREC t where t.JCRECID='||:old.JCRECID||' and t.jwdcode='''||v_jwdcode||'''';
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
             (sys_guid(),'TRIGGER_JC_FIXREC',v_exception,to_char(sysdate,'YYYY-MM-DD HH24:MI:SS'));
end TRIGGER_JC_FIXREC;
/
ALTER TRIGGER "ADMIN"."TRIGGER_JC_FIXREC" ENABLE;
