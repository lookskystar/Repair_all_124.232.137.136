--------------------------------------------------------
--  DDL for Trigger TRIGGER_PJ_DYNAMICINFO
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "ADMIN"."TRIGGER_PJ_DYNAMICINFO" 
  after insert or update or delete
  on PJ_DYNAMICINFO FOR EACH ROW

/** HEAD
 * @name 动态配件表表触发器
 * @description 变更事件，形成ddl语句插入同步表中
 * @version 1.0.0
 * @author Ning
 * @create-date 2014-07-01
 */
declare
  v_sql nvarchar2(3000);             --临时存放sql
  v_jwdcode varchar2(30):='08052';    --机务段代码
  v_exception varchar(500);
begin
  v_sql := null;
  case when inserting then
          v_sql := 'insert into PJ_DYNAMICINFO('||
          'PJDID,PJSID,FACTORYNUM,PJBARCODE,'||
          'PJNAME,STOREPOSITION,PY,PJSTATUS,'||
          'FACTORY,OUTFACDATE,FIXFLOWNAME,GETONNUM,'||
          'PJNUM,HRID,COMMENTS,JWDCODE)'||
          'values('''||
          :new.PJDID||''','''||:new.PJSID||''','''||replace(:new.FACTORYNUM,'''','')||''','''||replace(:new.PJBARCODE,'''','')||''','''||
          replace(:new.PJNAME,'''','')||''','''||replace(:new.STOREPOSITION,'''','')||''','''||replace(:new.PY,'''','')||''','''||replace(:new.PJSTATUS,'''','')||''','''||
          replace(:new.FACTORY,'''','')||''','''||replace(:new.OUTFACDATE,'''','')||''','''||replace(:new.FIXFLOWNAME,'''','')||''','''||replace(:new.GETONNUM,'''','')||''','''||
          replace(:new.PJNUM,'''','')||''','''||replace(:new.HRID,'''','')||''','''||replace(:new.COMMENTS,'''','')||''','''||v_jwdcode||''')';
       when updating then
          v_sql := 'update PJ_DYNAMICINFO set '||
                       'PJSID='''||:new.PJSID||''''||
                       ',FACTORYNUM='''||replace(:new.FACTORYNUM,'''','')||''''||
                       ',PJBARCODE='''||replace(:new.PJBARCODE,'''','')||''''||
                       ',PJNAME='''||replace(:new.PJNAME,'''','')||''''||
                       ',STOREPOSITION='''||replace(:new.STOREPOSITION,'''','')||''''||
                       ',PY='''||replace(:new.PY,'''','')||''''||
                       ',PJSTATUS='''||replace(:new.PJSTATUS,'''','')||''''||
                       ',FACTORY='''||replace(:new.FACTORY,'''','')||''''||
                       ',OUTFACDATE='''||replace(:new.OUTFACDATE,'''','')||''''||
                       ',FIXFLOWNAME='''||replace(:new.FIXFLOWNAME,'''','')||''''||
                       ',GETONNUM='''||replace(:new.GETONNUM,'''','')||''''||
                       ',PJNUM='''||replace(:new.PJNUM,'''','')||''''||
                       ',HRID='''||replace(:new.HRID,'''','')||''''||
                       ',COMMENTS='''||replace(:new.COMMENTS,'''','')||''''||
                    ' where '||
                       'PJDID='||:old.PJDID||' and jwdcode='''||v_jwdcode||'''';
       when deleting then
          v_sql := 'delete from PJ_DYNAMICINFO t where t.PJDID='||:old.PJDID||' and t.jwdcode='''||v_jwdcode||'''';
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
             (sys_guid(),'Trigger_PJ_DYNAMICINFO',v_exception,to_char(sysdate,'YYYY-MM-DD HH24:MI:SS'));
end Trigger_PJ_DYNAMICINFO;
/
ALTER TRIGGER "ADMIN"."TRIGGER_PJ_DYNAMICINFO" ENABLE;
