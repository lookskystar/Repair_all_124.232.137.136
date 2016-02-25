--------------------------------------------------------
--  DDL for Trigger TRIGGER_OIL_ASSAY_ITEM
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "ADMIN"."TRIGGER_OIL_ASSAY_ITEM" 
  AFTER INSERT OR DELETE OR UPDATE
  ON OIL_ASSAY_ITEM FOR EACH ROW

/** HEAD
 * @name 油水化验项目表触发器
 * @description 变更事件，形成ddl语句插入同步表中
 * @version 1.0.0
 * @author Ning
 * @create-date 2014-07-01
 */
declare
  v_sql nvarchar2(3000);          --临时存放sql
  v_jwdcode varchar2(30):='08052'; --机务段代码
  v_exception varchar2(500);
BEGIN
  v_sql := null;
  case when inserting then
          v_sql := 'insert into OIL_ASSAY_ITEM('||
          'REPORTITEMID,REPORTITEMPY,REPORTITEMDEFIN,SERES,'||
          'ISUSED,JCVALUE,JWDCODE)'||
          'values('''||
          :new.REPORTITEMID||''','''||replace(:new.REPORTITEMPY,'''','')||''','''||replace(:new.REPORTITEMDEFIN,'''','')||''','''||replace(:new.SERES,'''','')||''','''||
          replace(:new.ISUSED,'''','')||''','''||replace(:new.JCVALUE,'''','')||''','''||v_jwdcode||''')';
        when updating then
                v_sql := 'update OIL_ASSAY_ITEM set '||
                             'REPORTITEMPY='''||replace(:new.REPORTITEMPY,'''','')||''''||
                             ',REPORTITEMDEFIN='''||replace(:new.REPORTITEMDEFIN,'''','')||''''||
                             ',SERES='''||replace(:new.SERES,'''','')||''''||
                             ',ISUSED='''||replace(:new.ISUSED,'''','')||''''||
                             ',JCVALUE='''||replace(:new.JCVALUE,'''','')||''''||
                          ' where '||
                             'REPORTITEMID='||:old.REPORTITEMID||' and jwdcode='''||v_jwdcode||'''';
             when deleting then
          v_sql := 'delete from OIL_ASSAY_ITEM t where t.REPORTITEMID='||:old.REPORTITEMID||' and t.jwdcode='''||v_jwdcode||'''';
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
             (sys_guid(),'TRIGGER_OIL_ASSAY_ITEM',v_exception,to_char(sysdate,'YYYY-MM-DD HH24:MI:SS'));
end TRIGGER_OIL_ASSAY_ITEM;
/
ALTER TRIGGER "ADMIN"."TRIGGER_OIL_ASSAY_ITEM" ENABLE;
