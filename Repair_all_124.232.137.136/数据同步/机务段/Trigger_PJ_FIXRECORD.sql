--------------------------------------------------------
--  DDL for Trigger TRIGGER_PJ_FIXRECORD
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "ADMIN"."TRIGGER_PJ_FIXRECORD" 
  after insert or update or delete
  on PJ_FIXRECORD FOR EACH ROW

/** HEAD
 * @name 配件检修记录表触发器
 * @description 变更事件，形成ddl语句插入同步表中
 * @version 1.0.0
 * @author Tang
 * @create-date 2014-07-01
 */
declare
  v_sql nvarchar2(3000);             --临时存放sql
  v_jwdcode varchar2(30):='08052';    --机务段代码
  v_exception varchar2(500);
begin
  v_sql := null;
  case when inserting then
          v_sql := 'insert into PJ_FIXRECORD('||
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
          'values('''||
          :new.PJRECID||''','''||:new.PJITEMID||''','''||:new.PJSID||''','''||:new.PJDID||''','''||
          v_jwdcode||''','''||:new.PJPREDICTID||''','''||:new.DOWNPJNUM||''','''||:new.UPPJNUM||''','''||
          replace(:new.PJNAME,'''','')||''','''||:new.LEFTMARGIN||''','''||:new.RIGHTMARGIN||''','''||replace(:new.FIXSITUATION,'''','')||''','''||
          :new.FIXEMPID||''','''||:new.FIXEMP||''','''||:new.EMPAFFIRMTIME||''','''||:new.LEADID||''','''||
          :new.LEAD||''','''||:new.LDAFFIRMTIME||''','''||:new.COMMITLEADID||''','''||:new.COMMITLEAD||''','''||
          :new.COMLDAFFITIME||''','''||:new.QIID||''','''||:new.QI||''','''||:new.QIAFFITIME||''','''||
          :new.ACCEPTERID||''','''||:new.ACCEPTER||''','''||:new.ACCEAFFITIME||''','''||:new.PJFIXRECSID||''','''||
          :new.PRESTATUS||''','''||:new.TYPE||''','''||:new.RECSTAS||''','''||:new.ACCEPTTIME||''','''||
          :new.CHILDPJID||''','''||:new.TECHID||''','''||:new.TECHNAME||''','''||:new.TECHTIME||''','''||
          :new.RECID||''','''||:new.TEAMS||''','''||:new.PJNUM||''','''||:new.PARENTID||''','''||
          :new.RJHMID||''','''||:new.REPTID||''','''||:new.REPT||''','''||:new.REPTAFFIRMTIME||''','''||
          :new.DEALSITUATION||''','''||:new.ITEMCTRLREPT||''','''||replace(:new.POSINAME,'''','')||''','''||replace(:new.FIXITEM,'''','')||''','''||
          :new.UNIT||''','''||:new.ITEMCTRLLEAD||''','''||:new.ITEMCTRLCOMLD||''','''||:new.ITEMCTRLQI||''','''||
          :new.ITEMCTRLTECH||''','''||:new.ITEMCTRLACCE||''')';
       when updating then
          v_sql := 'update PJ_FIXRECORD set '||
                       'PJITEMID='''||:new.PJITEMID||''''||
                       ',PJSID='''||:new.PJSID||''''||
                       ',PJDID='''||:new.PJDID||''''||
                       ',PJPREDICTID='''||:new.PJPREDICTID||''''||
                       ',DOWNPJNUM='''||:new.DOWNPJNUM||''''||
                       ',UPPJNUM='''||:new.UPPJNUM||''''||
                       ',PJNAME='''||replace(:new.PJNAME,'''','')||''''||
                       ',LEFTMARGIN='''||:new.LEFTMARGIN||''''||
                       ',RIGHTMARGIN='''||:new.RIGHTMARGIN||''''||
                       ',FIXSITUATION='''||replace(:new.FIXSITUATION,'''','')||''''||
                       ',FIXEMPID='''||:new.FIXEMPID||''''||
                       ',FIXEMP='''||:new.FIXEMP||''''||
                       ',EMPAFFIRMTIME='''||:new.EMPAFFIRMTIME||''''||
                       ',LEADID='''||:new.LEADID||''''||
                       ',LEAD='''||:new.LEAD||''''||
                       ',LDAFFIRMTIME='''||:new.LDAFFIRMTIME||''''||
                       ',COMMITLEADID='''||:new.COMMITLEADID||''''||
                       ',COMMITLEAD='''||:new.COMMITLEAD||''''||
                       ',COMLDAFFITIME='''||:new.COMLDAFFITIME||''''||
                       ',QIID='''||:new.QIID||''''||
                       ',QI='''||:new.QI||''''||
                       ',QIAFFITIME='''||:new.QIAFFITIME||''''||
                       ',ACCEPTERID='''||:new.ACCEPTERID||''''||
                       ',ACCEPTER='''||:new.ACCEPTER||''''||
                       ',ACCEAFFITIME='''||:new.ACCEAFFITIME||''''||
                       ',PJFIXRECSID='''||:new.PJFIXRECSID||''''||
                       ',PRESTATUS='''||:new.PRESTATUS||''''||
                       ',TYPE='''||:new.TYPE||''''||
                       ',RECSTAS='''||:new.RECSTAS||''''||
                       ',ACCEPTTIME='''||:new.ACCEPTTIME||''''||
                       ',CHILDPJID='''||:new.CHILDPJID||''''||
                       ',TECHID='''||:new.TECHID||''''||
                       ',TECHNAME='''||:new.TECHNAME||''''||
                       ',TECHTIME='''||:new.TECHTIME||''''||
                       ',RECID='''||:new.RECID||''''||
                       ',TEAMS='''||:new.TEAMS||''''||
                       ',PJNUM='''||:new.PJNUM||''''||
                       ',PARENTID='''||:new.PARENTID||''''||
                       ',RJHMID='''||:new.RJHMID||''''||
                       ',REPTID='''||:new.REPTID||''''||
                       ',REPT='''||:new.REPT||''''||
                       ',REPTAFFIRMTIME='''||:new.REPTAFFIRMTIME||''''||
                       ',DEALSITUATION='''||:new.DEALSITUATION||''''||
                       ',ITEMCTRLREPT='''||:new.ITEMCTRLREPT||''''||
                       ',POSINAME='''||replace(:new.POSINAME,'''','')||''''||
                       ',FIXITEM='''||replace(:new.FIXITEM,'''','')||''''||
                       ',UNIT='''||:new.UNIT||''''||
                       ',ITEMCTRLLEAD='''||:new.ITEMCTRLLEAD||''''||
                       ',ITEMCTRLCOMLD='''||:new.ITEMCTRLCOMLD||''''||
                       ',ITEMCTRLQI='''||:new.ITEMCTRLQI||''''||
                       ',ITEMCTRLTECH='''||:new.ITEMCTRLTECH||''''||
                       ',ITEMCTRLACCE='''||:new.ITEMCTRLACCE||''''||
                    ' where '||
                       'PJRECID='||:old.PJRECID||' and JWDCODE='''||v_jwdcode||'''';
       when deleting then
          v_sql := 'delete from PJ_FIXRECORD t where t.PJRECID='||:old.PJRECID||' and t.jwdcode='''||v_jwdcode||'''';
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
             (sys_guid(),'Trigger_PJ_FIXRECORD',v_exception,to_char(sysdate,'YYYY-MM-DD HH24:MI:SS'));
end Trigger_PJ_FIXRECORD;
/
ALTER TRIGGER "ADMIN"."TRIGGER_PJ_FIXRECORD" ENABLE;
