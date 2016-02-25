--------------------------------------------------------
--  DDL for Trigger TRIGGER_OIL_ASSAY_SUBITEM
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "ADMIN"."TRIGGER_OIL_ASSAY_SUBITEM" 
  after insert or update or delete
  on OIL_ASSAY_SUBITEM FOR EACH ROW

/** HEAD
 * @name 油水化验分离项目表触发器
 * @description 变更事件，形成ddl语句插入同步表中
 * @version 1.0.0
 * @author Ning
 * @create-date 2014-07-01
 */
declare
  v_sql nvarchar2(3000);             --临时存放sql
  v_jwdcode varchar2(30):='08052';    --机务段代码
  v_exception varchar2(500);
begin
  v_sql := null;
  case when inserting then
          v_sql := 'insert into OIL_ASSAY_SUBITEM('||
          'SUBITEMID,PROTEAMID,REPORTITEMID,SUBITEMTITLE,'||
          'SUBITEMPY,FREQUENCY,ISUSED,ISUSUAL,'||
          'MAXVAL,MINVAL,FILLDEFVAL,JCSTYPEVAL,'||
          'JWDCODE)'||
          'values('''||
          :new.SUBITEMID||''','''||:new.PROTEAMID||''','''||:new.REPORTITEMID||''','''||replace(:new.SUBITEMTITLE,'''','')||''','''||
          replace(:new.SUBITEMPY,'''','')||''','''||replace(:new.FREQUENCY,'''','')||''','''||replace(:new.ISUSED,'''','')||''','''||replace(:new.ISUSUAL,'''','')||''','''||
          replace(:new.MAXVAL,'''','')||''','''||replace(:new.MINVAL,'''','')||''','''||replace(:new.FILLDEFVAL,'''','')||''','''||replace(:new.JCSTYPEVAL,'''','')||''','''||
          v_jwdcode||''')';
       when updating then
          v_sql := 'update OIL_ASSAY_SUBITEM set '||
                       'PROTEAMID='''||:new.PROTEAMID||''''||
                       ',REPORTITEMID='''||:new.REPORTITEMID||''''||
                       ',SUBITEMTITLE='''||replace(:new.SUBITEMTITLE,'''','')||''''||
                       ',SUBITEMPY='''||replace(:new.SUBITEMPY,'''','')||''''||
                       ',FREQUENCY='''||replace(:new.FREQUENCY,'''','')||''''||
                       ',ISUSED='''||replace(:new.ISUSED,'''','')||''''||
                       ',ISUSUAL='''||replace(:new.ISUSUAL,'''','')||''''||
                       ',MAXVAL='''||replace(:new.MAXVAL,'''','')||''''||
                       ',MINVAL='''||replace(:new.MINVAL,'''','')||''''||
                       ',FILLDEFVAL='''||replace(:new.FILLDEFVAL,'''','')||''''||
                       ',JCSTYPEVAL='''||replace(:new.JCSTYPEVAL,'''','')||''''||
                    ' where '||
                       'SUBITEMID='||:old.SUBITEMID||' and jwdcode='''||v_jwdcode||'''';
       when deleting then
          v_sql := 'delete from OIL_ASSAY_SUBITEM t where t.SUBITEMID='||:old.SUBITEMID||' and t.jwdcode='''||v_jwdcode||'''';
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
             (sys_guid(),'Trigger_OIL_ASSAY_SUBITEM',v_exception,to_char(sysdate,'YYYY-MM-DD HH24:MI:SS'));
end Trigger_OIL_ASSAY_SUBITEM;
/
ALTER TRIGGER "ADMIN"."TRIGGER_OIL_ASSAY_SUBITEM" ENABLE;
