--------------------------------------------------------
--  DDL for Trigger TRIGGER_DICT_SECUNIT
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "ADMIN"."TRIGGER_DICT_SECUNIT" 
  after insert or update or delete
  on DICT_SECUNIT FOR EACH ROW

/** HEAD
 * @name 二级部件表触发器
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
          v_sql := 'insert into DICT_SECUNIT('||
          'SECUNITID,FIRSTUNITID,SECUNITNAME,PY,'||
          'URL,JCSTYPEVALUE,JWDCODE)'||
          'values('''||
          :new.SECUNITID||''','''||:new.FIRSTUNITID||''','''||replace(:new.SECUNITNAME,'''','')||''','''||:new.PY||''','''||
          replace(:new.URL,'''','')||''','''||replace(:new.JCSTYPEVALUE,'''','')||''','''||v_jwdcode||''')';
       when updating then
          v_sql := 'update DICT_SECUNIT set '||
                       'FIRSTUNITID='''||:new.FIRSTUNITID||''''||
                       ',SECUNITNAME='''||replace(:new.SECUNITNAME,'''','')||''''||
                       ',PY='''||:new.PY||''''||
                       ',URL='''||replace(:new.URL,'''','')||''''||
                       ',JCSTYPEVALUE='''||replace(:new.JCSTYPEVALUE,'''','')||''''||
                    ' where '||
                       'SECUNITID='||:old.SECUNITID||' and JWDCODE='''||v_jwdcode||'''';
       when deleting then
          v_sql := 'delete from DICT_SECUNIT t where t.SECUNITID='||:old.SECUNITID||' and t.JWDCODE='''||v_jwdcode||'''';
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
             (sys_guid(),'Trigger_DICT_SECUNIT',v_exception,to_char(sysdate,'YYYY-MM-DD HH24:MI:SS'));
end Trigger_DICT_SECUNIT;
/
ALTER TRIGGER "ADMIN"."TRIGGER_DICT_SECUNIT" ENABLE;
