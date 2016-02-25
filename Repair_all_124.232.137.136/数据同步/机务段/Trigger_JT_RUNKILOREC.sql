--------------------------------------------------------
--  DDL for Trigger TRIGGER_JT_RUNKILOREC
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "ADMIN"."TRIGGER_JT_RUNKILOREC" 
  after insert or update or delete
  on JT_RUNKILOREC FOR EACH ROW

/** HEAD
 * @name 机车走行公里表触发器
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
        v_sql := 'insert into JT_RUNKILOREC('||
          'RUNID,JWDCODE,NOWDATE,JCTYPE,'||
          'JCNUM,DAYRUNKILO,MINORRUNKILO,SMARUNKILO,'||
          'MIDRUNKILO,LARRUNKILO,TOTALRUNKILO,REGISTRANT,'||
          'REGISTTIME,VARY)'||
          'values('''||
          :new.RUNID||''','''||v_jwdcode||''','''||:new.NOWDATE||''','''||:new.JCTYPE||''','''||
          :new.JCNUM||''','''||:new.DAYRUNKILO||''','''||:new.MINORRUNKILO||''','''||:new.SMARUNKILO||''','''||
          :new.MIDRUNKILO||''','''||:new.LARRUNKILO||''','''||:new.TOTALRUNKILO||''','''||:new.REGISTRANT||''','''||
          :new.REGISTTIME||''','''||:new.VARY||''')';
       when updating then
          v_sql := 'update JT_RUNKILOREC set '||
                       'NOWDATE='''||:new.NOWDATE||''''||
                       ',JCTYPE='''||:new.JCTYPE||''''||
                       ',JCNUM='''||:new.JCNUM||''''||
                       ',DAYRUNKILO='''||:new.DAYRUNKILO||''''||
                       ',MINORRUNKILO='''||:new.MINORRUNKILO||''''||
                       ',SMARUNKILO='''||:new.SMARUNKILO||''''||
                       ',MIDRUNKILO='''||:new.MIDRUNKILO||''''||
                       ',LARRUNKILO='''||:new.LARRUNKILO||''''||
                       ',TOTALRUNKILO='''||:new.TOTALRUNKILO||''''||
                       ',REGISTRANT='''||:new.REGISTRANT||''''||
                       ',REGISTTIME='''||:new.REGISTTIME||''''||
                       ',VARY='''||:new.VARY||''''||
                    ' where '||
                       'RUNID='||:old.RUNID||' and JWDCODE='''||v_jwdcode||'''';
       when deleting then
          v_sql := 'delete from JT_RUNKILOREC t where t.RUNID='||:old.RUNID||' and t.JWDCODE='''||v_jwdcode||'''';
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
             (sys_guid(),'Trigger_JT_RUNKILOREC',v_exception,to_char(sysdate,'YYYY-MM-DD HH24:MI:SS'));
end Trigger_JT_RUNKILOREC;


/
ALTER TRIGGER "ADMIN"."TRIGGER_JT_RUNKILOREC" ENABLE;
