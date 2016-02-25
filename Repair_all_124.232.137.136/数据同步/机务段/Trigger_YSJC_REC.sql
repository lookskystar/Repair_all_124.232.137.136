--------------------------------------------------------
--  DDL for Trigger TRIGGER_YSJC_REC
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "ADMIN"."TRIGGER_YSJC_REC" 
  after insert or update or delete
  on YSJC_REC FOR EACH ROW

/** HEAD
 * @name 机车试验记录表触发器
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
          v_sql := 'insert into YSJC_REC('||
          'RECID,RJHMID,ITEMID,FIXSITUATION,'||
          'FIXEMP,FIXEMPTIME,TECH,TECHAFFITIME,'||
          'ACCEPT,ACCEPTAFFITIME,COMMITLEAD,COMMAFFITIME,'||
          'CLASSIFY,ITEMNAME,UNIT,ORDERNO,'||
          'JWDCODE)'||
          'values('''||
          :new.RECID||''','''||:new.RJHMID||''','''||:new.ITEMID||''','''||replace(:new.FIXSITUATION,'''','')||''','''||
          :new.FIXEMP||''','''||:new.FIXEMPTIME||''','''||:new.TECH||''','''||:new.TECHAFFITIME||''','''||
          :new.ACCEPT||''','''||:new.ACCEPTAFFITIME||''','''||:new.COMMITLEAD||''','''||:new.COMMAFFITIME||''','''||
          :new.CLASSIFY||''','''||replace(:new.ITEMNAME,'''','')||''','''||:new.UNIT||''','''||:new.ORDERNO||''','''||
          v_jwdcode||''')';
       when updating then
          v_sql := 'update YSJC_REC set '||
                       'RJHMID='''||:new.RJHMID||''''||
                       ',ITEMID='''||:new.ITEMID||''''||
                       ',FIXSITUATION='''||replace(:new.FIXSITUATION,'''','')||''''||
                       ',FIXEMP='''||:new.FIXEMP||''''||
                       ',FIXEMPTIME='''||:new.FIXEMPTIME||''''||
                       ',TECH='''||:new.TECH||''''||
                       ',TECHAFFITIME='''||:new.TECHAFFITIME||''''||
                       ',ACCEPT='''||:new.ACCEPT||''''||
                       ',ACCEPTAFFITIME='''||:new.ACCEPTAFFITIME||''''||
                       ',COMMITLEAD='''||:new.COMMITLEAD||''''||
                       ',COMMAFFITIME='''||:new.COMMAFFITIME||''''||
                       ',CLASSIFY='''||:new.CLASSIFY||''''||
                       ',ITEMNAME='''||replace(:new.ITEMNAME,'''','')||''''||
                       ',UNIT='''||:new.UNIT||''''||
                       ',ORDERNO='''||:new.ORDERNO||''''||
                    ' where '||
                       'RECID='||:old.RECID||' and JWDCODE='''||v_jwdcode||'''';
       when deleting then
          v_sql := 'delete from YSJC_REC t where t.RECID='||:old.RECID||' and t.JWDCODE='''||v_jwdcode||'''';
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
             (sys_guid(),'Trigger_YSJC_REC',v_exception,to_char(sysdate,'YYYY-MM-DD HH24:MI:SS'));
end Trigger_YSJC_REC;
/
ALTER TRIGGER "ADMIN"."TRIGGER_YSJC_REC" ENABLE;
