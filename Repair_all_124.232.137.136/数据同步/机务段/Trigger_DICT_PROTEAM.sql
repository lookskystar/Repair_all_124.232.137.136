--------------------------------------------------------
--  DDL for Trigger TRIGGER_DICT_PROTEAM
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "ADMIN"."TRIGGER_DICT_PROTEAM" 
  after insert or update or delete
  on DICT_PROTEAM FOR EACH ROW

/** HEAD
 * @name 班组表触发器
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
          v_sql := 'insert into DICT_PROTEAM('||
          'PROTEAMID,PROTEAMNAME,PY,PROID,'||
          'JCTYPE,WORKFLAG,ZXFLAG,JWDCODE)'||
          'values('''||
          :new.PROTEAMID||''','''||replace(:new.PROTEAMNAME,'''','')||''','''||:new.PY||''','''||:new.PROID||''','''||
          :new.JCTYPE||''','''||:new.WORKFLAG||''','''||:new.ZXFLAG||''','''||v_jwdcode||''')';
       when updating then
          v_sql := 'update DICT_PROTEAM set '||
                       'PROTEAMNAME='''||replace(:new.PROTEAMNAME,'''','')||''''||
                       ',PY='''||:new.PY||''''||
                       ',PROID='''||:new.PROID||''''||
                       ',JCTYPE='''||:new.JCTYPE||''''||
                       ',WORKFLAG='''||:new.WORKFLAG||''''||
                       ',ZXFLAG='''||:new.ZXFLAG||''''||
                    ' where '||
                       'PROTEAMID='||:old.PROTEAMID||' and JWDCODE='''||v_jwdcode||'''';
       when deleting then
          v_sql := 'delete from DICT_PROTEAM t where t.PROTEAMID='||:old.PROTEAMID||' and t.JWDCODE='''||v_jwdcode||'''';
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
             (sys_guid(),'Trigger_DICT_PROTEAM',v_exception,to_char(sysdate,'YYYY-MM-DD HH24:MI:SS'));
end Trigger_DICT_PROTEAM;
/
ALTER TRIGGER "ADMIN"."TRIGGER_DICT_PROTEAM" ENABLE;
