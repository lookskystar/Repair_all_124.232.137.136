--------------------------------------------------------
--  DDL for Trigger TRIGGER_MAINPLAN
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "ADMIN"."TRIGGER_MAINPLAN" 
  after insert or update or delete
  on MAINPLAN FOR EACH ROW

/** HEAD
 * @name 主计划表触发器
 * @description 变更事件，形成ddl语句插入同步表中
 * @version 1.0.0
 * @author Tangxf
 * @create-date 2014-07-01
 */
declare
  v_sql nvarchar2(3000);             --临时存放sql
  v_jwdcode varchar2(30):='08052';    --机务段代码
  v_exception varchar2(500);
begin
  v_sql := null;
 case when inserting then
          v_sql := 'insert into MAINPLAN('||
          'ID,STARTTIME,ENDTIME,TITLE,MAKEPEOPLE,'||
          'MAKETIME,COMMENTS,STATUS,JWDCODE)'||
          'values('''||
          :new.ID||''','''||:new.STARTTIME||''','''||:new.ENDTIME||''','''||replace(:new.TITLE,'''','')||''','''||
          :new.MAKEPEOPLE||''','''||:new.MAKETIME||''','''||replace(:new.COMMENTS,'''','')||''','''||:new.STATUS||''','''||
          v_jwdcode||''')';
        when updating then
                v_sql := 'update MAINPLAN set '||
                             'STARTTIME='''||:new.STARTTIME||''''||
                             ',ENDTIME='''||:new.ENDTIME||''''||
                             ',TITLE='''||replace(:new.TITLE,'''','')||''''||
                             ',MAKEPEOPLE='''||:new.MAKEPEOPLE||''''||
                             ',MAKETIME='''||:new.MAKETIME||''''||
                             ',COMMENTS='''||replace(:new.COMMENTS,'''','')||''''||
                             ',STATUS='''||:new.STATUS||''''||
                          ' where '||
                             'ID='||:old.ID||' and jwdcode='''||v_jwdcode||'''';
             when deleting then
          v_sql := 'delete from MAINPLAN t where t.ID='||:old.ID||' and t.jwdcode='''||v_jwdcode||'''';
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
             (sys_guid(),'Trigger_MAINPLAN',v_exception,to_char(sysdate,'YYYY-MM-DD HH24:MI:SS'));
end Trigger_MAINPLAN;
/
ALTER TRIGGER "ADMIN"."TRIGGER_MAINPLAN" ENABLE;
