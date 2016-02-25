--------------------------------------------------------
--  DDL for Trigger TRIGGER_SIGNEDFORFINISH
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "ADMIN"."TRIGGER_SIGNEDFORFINISH" 
  after insert or update or delete
  on SIGNEDFORFINISH FOR EACH ROW

/** HEAD
 * @name 交车竣工表触发器
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
          v_sql := 'insert into SIGNEDFORFINISH('||
          'JGID,DPID,JCLX,JCH,'||
          'XCXC,KSSJ,JSSJ,JCGZID,'||
          'JCGZXM,JXZRID,JXZRXM,YSYID,'||
          'YSYXM,DZID,DZXM,TYPE,'||
          'BLONGAREA,FIXAREA,REASON,JWDCODE)'||
          'values('''||
          :new.JGID||''','''||:new.DPID||''','''||:new.JCLX||''','''||:new.JCH||''','''||
          :new.XCXC||''','''||:new.KSSJ||''','''||:new.JSSJ||''','''||:new.JCGZID||''','''||
          replace(:new.JCGZXM,'''','')||''','''||:new.JXZRID||''','''||replace(:new.JXZRXM,'''','')||''','''||:new.YSYID||''','''||
          replace(:new.YSYXM,'''','')||''','''||:new.DZID||''','''||replace(:new.DZXM,'''','')||''','''||:new.TYPE||''','''||
          :new.BLONGAREA||''','''||:new.FIXAREA||''','''||:new.REASON||''','''||v_jwdcode||''')';
       when updating then
          v_sql := 'update SIGNEDFORFINISH set '||
                       'DPID='''||:new.DPID||''''||
                       ',JCLX='''||:new.JCLX||''''||
                       ',JCH='''||:new.JCH||''''||
                       ',XCXC='''||:new.XCXC||''''||
                       ',KSSJ='''||:new.KSSJ||''''||
                       ',JSSJ='''||:new.JSSJ||''''||
                       ',JCGZID='''||:new.JCGZID||''''||
                       ',JCGZXM='''||replace(:new.JCGZXM,'''','')||''''||
                       ',JXZRID='''||:new.JXZRID||''''||
                       ',JXZRXM='''||replace(:new.JXZRXM,'''','')||''''||
                       ',YSYID='''||:new.YSYID||''''||
                       ',YSYXM='''||replace(:new.YSYXM,'''','')||''''||
                       ',DZID='''||:new.DZID||''''||
                       ',DZXM='''||replace(:new.DZXM,'''','')||''''||
                       ',TYPE='''||:new.TYPE||''''||
                       ',BLONGAREA='''||:new.BLONGAREA||''''||
                       ',FIXAREA='''||:new.FIXAREA||''''||
                       ',REASON='''||:new.REASON||''''||
                    ' where '||
                       'JGID='||:old.JGID||' and JWDCODE='''||v_jwdcode||'''';
       when deleting then
          v_sql := 'delete from SIGNEDFORFINISH t where t.JGID='||:old.JGID||' and t.JWDCODE='''||v_jwdcode||'''';
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
             (sys_guid(),'Trigger_SIGNEDFORFINISH',v_exception,to_char(sysdate,'YYYY-MM-DD HH24:MI:SS'));
end Trigger_SIGNEDFORFINISH;
/
ALTER TRIGGER "ADMIN"."TRIGGER_SIGNEDFORFINISH" ENABLE;
