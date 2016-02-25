--------------------------------------------------------
--  DDL for Trigger TRIGGER_JC_FIXITEM
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "ADMIN"."TRIGGER_JC_FIXITEM" 
AFTER INSERT OR DELETE OR UPDATE
ON JC_FIXITEM for each row

/** HEAD
 * @name 小辅修项目表触发器
 * @description 变更事件，形成ddl语句插入同步表中
 * @version 1.0.0
 * @author L
 * @create-date 2014-07-01
 */
declare
  v_sql nvarchar2(3000);             --临时存放sql
  v_jwdcode varchar2(30):='08052';    --机务段代码
  v_exception varchar2(500);
begin
  v_sql := null;
  case when inserting then
          v_sql := 'insert into JC_FIXITEM('||
          'THIRDUNITID,JWDCODE,NODEID,FIRSTUNITID,'||
          'UNITNUM,UNITNAME,SECUNITID,SECUNITNUM,'||
          'SECUNITNAME,POSINUM,POSINAME,ITEMNAME,'||
          'ITEMORDER,TECHSTANDARD,FILLDEFAVAL,CHECKTIMES,'||
          'ISUSED,QUERYSHW,ITEMPY,UNITIPY,'||
          'SECUNITPY,ITEMCTRLLEAD,ITEMCTRLCOMLD,ITEMCTRLQI,'||
          'ITEMCTRLTECH,ITEMCTRLACCE,MIN1,MAX1,'||
          'PROTEAM,XIUCI,JCSTYPEVALUE,BZID,JC,'||
          'PROSETID,UNIT,DURATION)'||
          'values('''||
          :new.THIRDUNITID||''','''||v_jwdcode||''','''||:new.NODEID||''','''||:new.FIRSTUNITID||''','''||
          :new.UNITNUM||''','''||replace(:new.UNITNAME,'''','')||''','''||:new.SECUNITID||''','''||:new.SECUNITNUM||''','''||
          replace(:new.SECUNITNAME,'''','')||''','''||:new.POSINUM||''','''||replace(:new.POSINAME,'''','')||''','''||replace(:new.ITEMNAME,'''','')||''','''||
          :new.ITEMORDER||''','''||:new.TECHSTANDARD||''','''||replace(:new.FILLDEFAVAL,'''','')||''','''||replace(:new.CHECKTIMES,'''','')||''','''||
          :new.ISUSED||''','''||:new.QUERYSHW||''','''||:new.ITEMPY||''','''||:new.UNITIPY||''','''||
          :new.SECUNITPY||''','''||:new.ITEMCTRLLEAD||''','''||:new.ITEMCTRLCOMLD||''','''||:new.ITEMCTRLQI||''','''||
          :new.ITEMCTRLTECH||''','''||:new.ITEMCTRLACCE||''','''||:new.MIN1||''','''||:new.MAX1||''','''||
          replace(:new.PROTEAM,'''','')||''','''||:new.XIUCI||''','''||:new.JCSTYPEVALUE||''','''||:new.BZID||''','''||:new.JC||''','''||
          :new.PROSETID||''','''||:new.UNIT||''','''||:new.DURATION||''')';
       when updating then
          v_sql := 'update JC_FIXITEM set '||
                       'NODEID='''||:new.NODEID||''''||
                       ',FIRSTUNITID='''||:new.FIRSTUNITID||''''||
                       ',UNITNUM='''||:new.UNITNUM||''''||
                       ',UNITNAME='''||replace(:new.UNITNAME,'''','')||''''||
                       ',SECUNITID='''||:new.SECUNITID||''''||
                       ',SECUNITNAME='''||replace(:new.SECUNITNAME,'''','')||''''||
                       ',POSINUM='''||:new.POSINUM||''''||
                       ',POSINAME='''||replace(:new.POSINAME,'''','')||''''||
                       ',ITEMNAME='''||replace(:new.ITEMNAME,'''','')||''''||
                       ',TECHSTANDARD='''||:new.TECHSTANDARD||''''||
                       ',FILLDEFAVAL='''||replace(:new.FILLDEFAVAL,'''','')||''''||
                       ',CHECKTIMES='''||:new.CHECKTIMES||''''||
                       ',ISUSED='''||:new.ISUSED||''''||
                       ',QUERYSHW='''||:new.QUERYSHW||''''||
                       ',ITEMPY='''||:new.ITEMPY||''''||
                       ',UNITIPY='''||:new.UNITIPY||''''||
                       ',SECUNITPY='''||:new.SECUNITPY||''''||
                       ',ITEMCTRLLEAD='''||:new.ITEMCTRLLEAD||''''||
                       ',ITEMCTRLCOMLD='''||:new.ITEMCTRLCOMLD||''''||
                       ',ITEMCTRLQI='''||:new.ITEMCTRLQI||''''||
                       ',ITEMCTRLTECH='''||:new.ITEMCTRLTECH||''''||
                       ',ITEMCTRLACCE='''||:new.ITEMCTRLACCE||''''||
                       ',MIN1='''||:new.MIN1||''''||
                       ',MAX1='''||:new.MAX1||''''||
                       ',PROTEAM='''||replace(:new.PROTEAM,'''','')||''''||
                       ',XIUCI='''||:new.XIUCI||''''||
                       ',JCSTYPEVALUE='''||:new.JCSTYPEVALUE||''''||
                       ',BZID='''||:new.BZID||''''||
                       ',JC='''||:new.JC||''''||
                       ',PROSETID='''||:new.PROSETID||''''||
                       ',UNIT='''||:new.UNIT||''''||
                       ',DURATION='''||:new.DURATION||''''||
                    ' where '||
                       'THIRDUNITID='||:old.THIRDUNITID||' and jwdcode='''||v_jwdcode||'''';
       when deleting then
          v_sql := 'delete from JC_FIXITEM t where t.THIRDUNITID='||:old.THIRDUNITID||' and t.jwdcode='''||v_jwdcode||'''';
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
             (sys_guid(),'TRIGGER_JC_FIXITEM',v_exception,to_char(sysdate,'YYYY-MM-DD HH24:MI:SS'));
end TRIGGER_JC_FIXITEM;
/
ALTER TRIGGER "ADMIN"."TRIGGER_JC_FIXITEM" ENABLE;
