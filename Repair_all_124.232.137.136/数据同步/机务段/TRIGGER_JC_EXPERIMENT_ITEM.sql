--------------------------------------------------------
--  DDL for Trigger TRIGGER_JC_EXPERIMENT_ITEM
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "ADMIN"."TRIGGER_JC_EXPERIMENT_ITEM" 
after INSERT OR DELETE OR UPDATE
ON JC_EXPERIMENT_ITEM for each row

/** HEAD
 * @name 机车检修试验项目表触发器
 * @description 变更事件，形成ddl语句插入同步表中
 * @version 1.0.0
 * @author L
 * @create-date 2014-07-01
 */
declare
  v_sql nvarchar2(3000);             --临时存放sql
  v_jwdcode varchar2(30):='08052';    --机务段代码
  v_exception varchar(500);
begin
  v_sql := null;
  case when inserting then
          v_sql := 'insert into JC_EXPERIMENT_ITEM('||
          'JCEIID,JWDCODE,NODEID,ITEMNAE,'||
          'ITEMSN,PARENTID,CONDITION,TECHSTANDARD,'||
          'FILLDEFAVAL,EIMIN,EIMAX,UNIT,'||
          'ITEMPY,ITEMCTRLLEAD,ITEMCTRLCOMLD,ITEMCTRLQI,'||
          'ITEMCTRLTECH,ITEMCTRLACCE,JCSTYPE,XCXC,'||
          'JC,PROTEAM,YSID)'||
          'values('''||
          :new.JCEIID||''','''||v_jwdcode||''','''||:new.NODEID||''','''||replace(:new.ITEMNAE,'''','')||''','''||
          :new.ITEMSN||''','''||:new.PARENTID||''','''||replace(:new.CONDITION,'''','')||''','''||replace(:new.TECHSTANDARD,'''','')||''','''||
          replace(:new.FILLDEFAVAL,'''','')||''','''||:new.EIMIN||''','''||:new.EIMAX||''','''||:new.UNIT||''','''||
          :new.ITEMPY||''','''||:new.ITEMCTRLLEAD||''','''||:new.ITEMCTRLCOMLD||''','''||:new.ITEMCTRLQI||''','''||
          :new.ITEMCTRLTECH||''','''||:new.ITEMCTRLACCE||''','''||:new.JCSTYPE||''','''||:new.XCXC||''','''||
          :new.JC||''','''||:new.PROTEAM||''','''||:new.YSID||''')';
       when updating then
          v_sql := 'update JC_EXPERIMENT_ITEM set '||
                       'NODEID='''||:new.NODEID||''''||
                       ',ITEMNAE='''||replace(:new.ITEMNAE,'''','')||''''||
                       ',ITEMSN='''||:new.ITEMSN||''''||
                       ',PARENTID='''||:new.PARENTID||''''||
                       ',CONDITION='''||replace(:new.CONDITION,'''','')||''''||
                       ',TECHSTANDARD='''||replace(:new.TECHSTANDARD,'''','')||''''||
                       ',FILLDEFAVAL='''||replace(:new.FILLDEFAVAL,'''','')||''''||
                       ',EIMIN='''||:new.EIMIN||''''||
                       ',EIMAX='''||:new.EIMAX||''''||
                       ',UNIT='''||:new.UNIT||''''||
                       ',ITEMPY='''||:new.ITEMPY||''''||
                       ',ITEMCTRLLEAD='''||:new.ITEMCTRLLEAD||''''||
                       ',ITEMCTRLCOMLD='''||:new.ITEMCTRLCOMLD||''''||
                       ',ITEMCTRLQI='''||:new.ITEMCTRLQI||''''||
                       ',ITEMCTRLTECH='''||:new.ITEMCTRLTECH||''''||
                       ',ITEMCTRLACCE='''||:new.ITEMCTRLACCE||''''||
                       ',JCSTYPE='''||:new.JCSTYPE||''''||
                       ',XCXC='''||:new.XCXC||''''||
                       ',JC='''||:new.JC||''''||
                       ',PROTEAM='''||:new.PROTEAM||''''||
                       ',YSID='''||:new.YSID||''''||
                    ' where '||
                       'JCEIID='||:old.JCEIID||' and jwdcode='''||v_jwdcode||'''';
       when deleting then
          v_sql := 'delete from JC_EXPERIMENT_ITEM t where t.JCEIID='||:old.JCEIID||' and t.jwdcode='''||v_jwdcode||'''';
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
             (sys_guid(),'TRIGGER_JC_EXPERIMENT_ITEM',v_exception,to_char(sysdate,'YYYY-MM-DD HH24:MI:SS'));
end TRIGGER_JC_EXPERIMENT_ITEM;
/
ALTER TRIGGER "ADMIN"."TRIGGER_JC_EXPERIMENT_ITEM" ENABLE;
