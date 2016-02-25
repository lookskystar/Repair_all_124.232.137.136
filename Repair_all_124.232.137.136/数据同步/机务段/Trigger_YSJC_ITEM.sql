--------------------------------------------------------
--  DDL for Trigger TRIGGER_YSJC_ITEM
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "ADMIN"."TRIGGER_YSJC_ITEM" 
  after insert or update or delete
  on YSJC_ITEM FOR EACH ROW

/** HEAD
 * @name 机车试验项目表触发器
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
          v_sql := 'insert into YSJC_ITEM('||
          'ITEMID,CLASSIFY,ITEMNAME,ORDERNO,'||
          'UNIT,MAX,MIN,ISCHECK,'||
          'JCTYPE,JWDCODE)'||
          'values('''||
          :new.ITEMID||''','''||:new.CLASSIFY||''','''||replace(:new.ITEMNAME,'''','')||''','''||:new.ORDERNO||''','''||
          :new.UNIT||''','''||:new.MAX||''','''||:new.MIN||''','''||:new.ISCHECK||''','''||
          :new.JCTYPE||''','''||v_jwdcode||''')';
       when updating then
          v_sql := 'update YSJC_ITEM set '||
                       'CLASSIFY='''||:new.CLASSIFY||''''||
                       ',ITEMNAME='''||replace(:new.ITEMNAME,'''','')||''''||
                       ',ORDERNO='''||:new.ORDERNO||''''||
                       ',UNIT='''||:new.UNIT||''''||
                       ',MAX='''||:new.MAX||''''||
                       ',MIN='''||:new.MIN||''''||
                       ',ISCHECK='''||:new.ISCHECK||''''||
                       ',JCTYPE='''||:new.JCTYPE||''''||
                    ' where '||
                       'ITEMID='||:old.ITEMID||' and JWDCODE='''||v_jwdcode||'''';
       when deleting then
          v_sql := 'delete from YSJC_ITEM t where t.ITEMID='||:old.ITEMID||' and t.JWDCODE='''||v_jwdcode||'''';
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
             (sys_guid(),'Trigger_YSJC_ITEM',v_exception,to_char(sysdate,'YYYY-MM-DD HH24:MI:SS'));
end Trigger_YSJC_ITEM;
/
ALTER TRIGGER "ADMIN"."TRIGGER_YSJC_ITEM" ENABLE;
