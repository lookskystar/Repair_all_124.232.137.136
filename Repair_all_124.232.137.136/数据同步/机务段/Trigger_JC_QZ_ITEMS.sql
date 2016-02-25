--------------------------------------------------------
--  DDL for Trigger TRIGGER_JC_QZ_ITEMS
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "ADMIN"."TRIGGER_JC_QZ_ITEMS" 
  after insert or update or delete
  on JC_QZ_ITEMS FOR EACH ROW

/** HEAD
 * @name 秋整项目表触发器
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
          v_sql := 'insert into JC_QZ_ITEMS('||
          'ID,FIRSTUNITID,UNITNUM,UNITNAME,'||
          'XH,ITEMNAME,TECHSTANDARD,'||
          'FILLDEFAVAL,MIN1,MAX1,XIUCI,JCSTYPE,'||
          'BZID,JWDCODE)'||
          'values('''||
          :new.ID||''','''||:new.FIRSTUNITID||''','''||:new.UNITNUM||''','''||replace(:new.UNITNAME,'''','')||''','''||
          :new.XH||''','''||replace(:new.ITEMNAME,'''','')||''','''||:new.TECHSTANDARD||''','''||replace(:new.FILLDEFAVAL,'''','')||''','''||
          :new.MIN1||''','''||:new.MAX1||''','''||:new.XIUCI||''','''||:new.JCSTYPE||''','''||
          :new.BZID||''','''||v_jwdcode||''')';
       when updating then
          v_sql := 'update JC_QZ_ITEMS set '||
                       'FIRSTUNITID='''||:new.FIRSTUNITID||''''||
                       ',UNITNUM='''||:new.UNITNUM||''''||
                       ',UNITNAME='''||replace(:new.UNITNAME,'''','')||''''||
                       ',XH='''||:new.XH||''''||
                       ',ITEMNAME='''||replace(:new.ITEMNAME,'''','')||''''||
                       ',TECHSTANDARD='''||:new.TECHSTANDARD||''''||
                       ',FILLDEFAVAL='''||replace(:new.FILLDEFAVAL,'''','')||''''||
                       ',MIN1='''||:new.MIN1||''''||
                       ',MAX1='''||:new.MAX1||''''||
                       ',XIUCI='''||:new.XIUCI||''''||
                       ',JCSTYPE='''||:new.JCSTYPE||''''||
                       ',BZID='''||:new.BZID||''''||
                    ' where '||
                       'ID='||:old.ID||' and JWDCODE='''||v_jwdcode||'''';
       when deleting then
          v_sql := 'delete from JC_QZ_ITEMS t where t.ID='||:old.ID||' and t.JWDCODE='''||v_jwdcode||'''';
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
             (sys_guid(),'Trigger_JC_QZ_ITEMS',v_exception,to_char(sysdate,'YYYY-MM-DD HH24:MI:SS'));
end Trigger_JC_QZ_ITEMS;
/
ALTER TRIGGER "ADMIN"."TRIGGER_JC_QZ_ITEMS" ENABLE;
