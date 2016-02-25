--------------------------------------------------------
--  DDL for Trigger TRIGGER_PJ_FIXFLOWRECORD
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "ADMIN"."TRIGGER_PJ_FIXFLOWRECORD" 
  after insert or update or delete
  on PJ_FIXFLOWRECORD FOR EACH ROW

/** HEAD
 * @name 配件流程记录表触发器
 * @description 配件流程记录表变更事件，形成ddl语句插入同步表中
 * @version 1.0.0
 * @author Ning
 * @create-date 2014-07-01
 */
declare
  v_sql nvarchar2(3000);             --临时存放sql
  v_jwdcode varchar2(30):='08052';    --机务段代码
  v_exception varchar2(500);
begin
  v_sql := null;
  case when inserting then
          v_sql := 'insert into PJ_FIXFLOWRECORD('||
          'RECID,STATUS,NODEID,PROTEAMID,'||
          'PLANID,JWDCODE)'||
          'values('''||
          :new.RECID||''','''||replace(:new.STATUS,'''','')||''','''||:new.NODEID||''','''||:new.PROTEAMID||''','''||
          :new.PLANID||''','''||v_jwdcode||''')';
       when updating then
          v_sql := 'update PJ_FIXFLOWRECORD set '||
                       'STATUS='''||replace(:new.STATUS,'''','')||''''||
                       ',NODEID='''||:new.NODEID||''''||
                       ',PROTEAMID='''||:new.PROTEAMID||''''||
                       ',PLANID='''||:new.PLANID||''''||
                    ' where '||
                       'RECID='||:old.RECID||' and jwdcode='''||v_jwdcode||'''';
       when deleting then
          v_sql := 'delete from PJ_FIXFLOWRECORD t where t.RECID='||:old.RECID||' and t.jwdcode='''||v_jwdcode||'''';
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
             (sys_guid(),'Trigger_PJ_FIXFLOWRECORD',v_exception,to_char(sysdate,'YYYY-MM-DD HH24:MI:SS'));
end Trigger_PJ_FIXFLOWRECORD;
/
ALTER TRIGGER "ADMIN"."TRIGGER_PJ_FIXFLOWRECORD" ENABLE;
