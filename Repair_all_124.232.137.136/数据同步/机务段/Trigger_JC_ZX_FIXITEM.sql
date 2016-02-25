--------------------------------------------------------
--  DDL for Trigger TRIGGER_JC_ZX_FIXITEM
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "ADMIN"."TRIGGER_JC_ZX_FIXITEM" 
  after insert or update or delete
  on JC_ZX_FIXITEM FOR EACH ROW

/** HEAD
 * @name 机车中修项目表触发器
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
          v_sql := 'insert into JC_ZX_FIXITEM('||
          'ID,NODEID,ITEMNAME,ITEMSN,'||
          'PARENTID,TIMENUM,TECHSTANDARD,'||
          'FILLDEFAVAL,MIN,MAX,UNIT,ITEMPY,'||
          'ITEMCTRLLEAD,ITEMCTRLCOMLD,ITEMCTRLQI,ITEMCTRLTECH,ITEMCTRLACCE,'||
          'JCSTYPE,XCXC,JC,PROTEAM,YSID,'||
          'BZID,ITEMRELATION,UNITNAME,POSINAME,FIRSTUNITID,'||
          'DURATION,AMOUNT,STDPJID,ITEMCTRLREPT,JWDCODE)'||
          'values('''||
          :new.ID||''','''||:new.NODEID||''','''||replace(:new.ITEMNAME,'''','')||''','''||:new.ITEMSN||''','''||
          :new.PARENTID||''','''||:new.TIMENUM||''','''||:new.TECHSTANDARD||''','''||replace(:new.FILLDEFAVAL,'''','')||''','''||
          :new.MIN||''','''||:new.MAX||''','''||:new.UNIT||''','''||:new.ITEMPY||''','''||
          :new.ITEMCTRLLEAD||''','''||:new.ITEMCTRLCOMLD||''','''||:new.ITEMCTRLQI||''','''||:new.ITEMCTRLTECH||''','''||
          :new.ITEMCTRLACCE||''','''||:new.JCSTYPE||''','''||:new.XCXC||''','''||:new.JC||''','''||
          :new.PROTEAM||''','''||:new.YSID||''','''||:new.BZID||''','''||:new.ITEMRELATION||''','''||
          replace(:new.UNITNAME,'''','')||''','''||replace(:new.POSINAME,'''','')||''','''||:new.FIRSTUNITID||''','''||:new.DURATION||''','''||
          :new.AMOUNT||''','''||:new.STDPJID||''','''||:new.ITEMCTRLREPT||''','''||v_jwdcode||''')';
       when updating then
          v_sql := 'update JC_ZX_FIXITEM set '||
                       'NODEID='''||:old.NODEID||''''||
                       ',ITEMNAME='''||replace(:old.ITEMNAME,'''','')||''''||
                       ',ITEMSN='''||:old.ITEMSN||''''||
                       ',PARENTID='''||:old.PARENTID||''''||
                       ',TIMENUM='''||:old.TIMENUM||''''||
                       ',TECHSTANDARD='''||:old.TECHSTANDARD||''''||
                       ',FILLDEFAVAL='''||replace(:old.FILLDEFAVAL,'''','')||''''||
                       ',MIN='''||:old.MIN||''''||
                       ',MAX='''||:old.MAX||''''||
                       ',UNIT='''||:old.UNIT||''''||
                       ',ITEMPY='''||:old.ITEMPY||''''||
                       ',ITEMCTRLLEAD='''||:old.ITEMCTRLLEAD||''''||
                       ',ITEMCTRLCOMLD='''||:old.ITEMCTRLCOMLD||''''||
                       ',ITEMCTRLQI='''||:old.ITEMCTRLQI||''''||
                       ',ITEMCTRLTECH='''||:old.ITEMCTRLTECH||''''||
                       ',ITEMCTRLACCE='''||:old.ITEMCTRLACCE||''''||
                       ',JCSTYPE='''||:old.JCSTYPE||''''||
                       ',XCXC='''||:old.XCXC||''''||
                       ',JC='''||:old.JC||''''||
                       ',PROTEAM='''||:old.PROTEAM||''''||
                       ',YSID='''||:old.YSID||''''||
                       ',BZID='''||:old.BZID||''''||
                       ',ITEMRELATION='''||:old.ITEMRELATION||''''||
                       ',UNITNAME='''||replace(:old.UNITNAME,'''','')||''''||
                       ',POSINAME='''||replace(:old.POSINAME,'''','')||''''||
                       ',FIRSTUNITID='''||:old.FIRSTUNITID||''''||
                       ',DURATION='''||:old.DURATION||''''||
                       ',AMOUNT='''||:old.AMOUNT||''''||
                       ',STDPJID='''||:old.STDPJID||''''||
                       ',ITEMCTRLREPT='''||:old.ITEMCTRLREPT||''''||
                    ' where '||
                       'ID='||:old.ID||' and JWDCODE='''||v_jwdcode||'''';
       when deleting then
          v_sql := 'delete from JC_ZX_FIXITEM t where t.ID='||:old.ID||' and t.JWDCODE='''||v_jwdcode||'''';
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
             (sys_guid(),'Trigger_JC_ZX_FIXITEM',v_exception,to_char(sysdate,'YYYY-MM-DD HH24:MI:SS'));
end Trigger_JC_ZX_FIXITEM;
/
ALTER TRIGGER "ADMIN"."TRIGGER_JC_ZX_FIXITEM" ENABLE;
