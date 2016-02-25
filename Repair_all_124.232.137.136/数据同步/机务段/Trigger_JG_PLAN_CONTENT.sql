--------------------------------------------------------
--  DDL for Trigger TRIGGER_JG_PLAN_CONTENT
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "ADMIN"."TRIGGER_JG_PLAN_CONTENT" 
  after insert or update or delete
  on JG_PLAN_CONTENT FOR EACH ROW

/** HEAD
 * @name 加改项目表触发器
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
        v_sql := 'insert into JG_PLAN_CONTENT('||
          'ID,JG_CONTENT,PLAN_NUM,JC_TYPE,'||
          'JWDCODE)'||
          'values('''||
          :new.ID||''','''||replace(:new.JG_CONTENT,'''','')||''','''||:new.PLAN_NUM||''','''||:new.JC_TYPE||''','''||
          v_jwdcode||''')';
       when updating then
          v_sql := 'update JG_PLAN_CONTENT set '||
                       'JG_CONTENT='''||replace(:new.JG_CONTENT,'''','')||''''||
                       ',PLAN_NUM='''||:new.PLAN_NUM||''''||
                       ',JC_TYPE='''||:new.JC_TYPE||''''||
                    ' where '||
                       'ID='||:old.ID||' and JWDCODE='''||v_jwdcode||'''';
       when deleting then
          v_sql := 'delete from JG_PLAN_CONTENT t where t.ID='||:old.ID||' and t.JWDCODE='''||v_jwdcode||'''';
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
             (sys_guid(),'Trigger_JG_PLAN_CONTENT',v_exception,to_char(sysdate,'YYYY-MM-DD HH24:MI:SS'));
end Trigger_JG_PLAN_CONTENT;
/
ALTER TRIGGER "ADMIN"."TRIGGER_JG_PLAN_CONTENT" ENABLE;
