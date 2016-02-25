--------------------------------------------------------
--  DDL for Trigger TRIGGER_JC_FLOWREC
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "ADMIN"."TRIGGER_JC_FLOWREC" 
  after insert or update or delete
  on JC_FLOWREC FOR EACH ROW

/** HEAD
 * @name 流程记录表触发器
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
          v_sql := 'insert into JC_FLOWREC('||
          'JCFLOWRECID,JCFLOWID,BZID,FINISHSTATUS,'||
          'FINISHTIME,DYPRECID,JWDCODE)'||
          'values('''||
          :new.JCFLOWRECID||''','''||:new.JCFLOWID||''','''||:new.BZID||''','''||:new.FINISHSTATUS||''','''||
          :new.FINISHTIME||''','''||:new.DYPRECID||''','''||v_jwdcode||''')';
       when updating then
          v_sql := 'update JC_FLOWREC set '||
                       'JCFLOWID='''||:new.JCFLOWID||''''||
                       ',BZID='''||:new.BZID||''''||
                       ',FINISHSTATUS='''||:new.FINISHSTATUS||''''||
                       ',FINISHTIME='''||:new.FINISHTIME||''''||
                       ',DYPRECID='''||:new.DYPRECID||''''||
                    ' where '||
                       'JCFLOWRECID='||:old.JCFLOWRECID||' and JWDCODE='''||v_jwdcode||'''';
       when deleting then
          v_sql := 'delete from JC_FLOWREC t where t.JCFLOWRECID='||:old.JCFLOWRECID||' and t.JWDCODE='''||v_jwdcode||'''';
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
             (sys_guid(),'Trigger_JC_FLOWREC',v_exception,to_char(sysdate,'YYYY-MM-DD HH24:MI:SS'));
end Trigger_JC_FLOWREC;


/
ALTER TRIGGER "ADMIN"."TRIGGER_JC_FLOWREC" ENABLE;
