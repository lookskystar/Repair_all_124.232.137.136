--------------------------------------------------------
--  DDL for Trigger TRIGGER_PJ_STATICINFO
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "ADMIN"."TRIGGER_PJ_STATICINFO" 
  after insert or update or delete
  on PJ_STATICINFO FOR EACH ROW

/** HEAD
 * @name 配件静态表触发器
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
          v_sql := 'insert into PJ_STATICINFO('||
          'PJSID,PARENTID,JWDCODE,PJNAME,'||
          'LOWESTSTORE,MOSTSTORE,FIRSTUNITID,PY,'||
          'JCTYPE,VISITRECORD,FLOWTYPEID,AMOUNT,'||
          'TYPE,BZIDS,SECUNITID)'||
          'values('''||
          :new.PJSID||''','''||:new.PARENTID||''','''||v_jwdcode||''','''||replace(:new.PJNAME,'''','')||''','''||
          :new.LOWESTSTORE||''','''||:new.MOSTSTORE||''','''||:new.FIRSTUNITID||''','''||:new.PY||''','''||
          :new.JCTYPE||''','''||:new.VISITRECORD||''','''||:new.FLOWTYPEID||''','''||:new.AMOUNT||''','''||
          :new.TYPE||''','''||:new.BZIDS||''','''||:new.SECUNITID||''')';
       when updating then
          v_sql := 'update PJ_STATICINFO set '||
                       'PARENTID='''||:new.PARENTID||''''||
                       ',PJNAME='''||replace(:new.PJNAME,'''','')||''''||
                       ',LOWESTSTORE='''||:new.LOWESTSTORE||''''||
                       ',MOSTSTORE='''||:new.MOSTSTORE||''''||
                       ',FIRSTUNITID='''||:new.FIRSTUNITID||''''||
                       ',PY='''||:new.PY||''''||
                       ',JCTYPE='''||:new.JCTYPE||''''||
                       ',VISITRECORD='''||:new.VISITRECORD||''''||
                       ',FLOWTYPEID='''||:new.FLOWTYPEID||''''||
                       ',AMOUNT='''||:new.AMOUNT||''''||
                       ',TYPE='''||:new.TYPE||''''||
                       ',BZIDS='''||:new.BZIDS||''''||
                       ',SECUNITID='''||:new.SECUNITID||''''||
                    ' where '||
                       'PJSID='||:old.PJSID||' and JWDCODE='''||v_jwdcode||'''';
       when deleting then
          v_sql := 'delete from PJ_STATICINFO t where t.PJSID='||:old.PJSID||' and t.jwdcode='''||v_jwdcode||'''';
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
             (sys_guid(),'Trigger_PJ_STATICINFO',v_exception,to_char(sysdate,'YYYY-MM-DD HH24:MI:SS'));
end Trigger_PJ_STATICINFO;
/
ALTER TRIGGER "ADMIN"."TRIGGER_PJ_STATICINFO" ENABLE;
