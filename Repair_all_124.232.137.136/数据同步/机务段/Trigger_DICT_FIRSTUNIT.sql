--------------------------------------------------------
--  DDL for Trigger TRIGGER_DICT_FIRSTUNIT
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "ADMIN"."TRIGGER_DICT_FIRSTUNIT" 
  after insert or update or delete
  on DICT_FIRSTUNIT FOR EACH ROW

/** HEAD
 * @name 一级部件表触发器
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
          v_sql := 'insert into DICT_FIRSTUNIT('||
          'FIRSTUNITID,FIRSTUNITNAME,PY,JCSTYPEVALUE,'||
          'URL,JWDCODE)'||
          'values('''||
          replace(:new.FIRSTUNITID,'''','')||''','''||replace(:new.FIRSTUNITNAME,'''','')||''','''||replace(:new.PY,'''','')||''','''||replace(:new.JCSTYPEVALUE,'''','')||''','''||
          replace(:new.URL,'''','')||''','''||v_jwdcode||''')';
       when updating then
          v_sql := 'update DICT_FIRSTUNIT set '||
                       'FIRSTUNITNAME='''||replace(:new.FIRSTUNITNAME,'''','')||''''||
                       ',PY='''||replace(:new.PY,'''','')||''''||
                       ',JCSTYPEVALUE='''||replace(:new.JCSTYPEVALUE,'''','')||''''||
                       ',URL='''||replace(:new.URL,'''','')||''''||
                    ' where '||
                       'FIRSTUNITID='||:old.FIRSTUNITID||' and JWDCODE='''||v_jwdcode||'''';
       when deleting then
          v_sql := 'delete from DICT_FIRSTUNIT t where t.FIRSTUNITID='||:old.FIRSTUNITID||' and t.JWDCODE='''||v_jwdcode||'''';
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
             (sys_guid(),'Trigger_DICT_FIRSTUNIT',v_exception,to_char(sysdate,'YYYY-MM-DD HH24:MI:SS'));
end Trigger_DICT_FIRSTUNIT;
/
ALTER TRIGGER "ADMIN"."TRIGGER_DICT_FIRSTUNIT" ENABLE;
