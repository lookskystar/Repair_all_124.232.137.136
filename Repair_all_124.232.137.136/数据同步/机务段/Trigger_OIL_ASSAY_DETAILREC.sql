--------------------------------------------------------
--  DDL for Trigger TRIGGER_OIL_ASSAY_DETAILREC
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "ADMIN"."TRIGGER_OIL_ASSAY_DETAILREC" 
  after insert or update or delete
  on OIL_ASSAY_DETAILRECORER FOR EACH ROW

/** HEAD
 * @name 油水化验记录表触发器
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
          v_sql := 'insert into OIL_ASSAY_DETAILRECORER('||
          'RECDETAILID,RECPRIID,SUBITEMID,SUBITEMTITLE,RECEIPTPEO,'||
          'FINTIME,REALDETEVAL,QUAGRADE,JWDCODE)'||
          'values('''||
          :new.RECDETAILID||''','''||replace(:new.RECPRIID,'''','')||''','''||replace(:new.SUBITEMID,'''','')||''','''||replace(:new.SUBITEMTITLE,'''','')||''','''||
          replace(:new.RECEIPTPEO,'''','')||''','''||replace(:new.FINTIME,'''','')||''','''||replace(:new.REALDETEVAL,'''','')||''','''||replace(:new.QUAGRADE,'''','')||''','''||
          v_jwdcode||''')';
        when updating then
                v_sql := 'update OIL_ASSAY_DETAILRECORER set '||
                             'RECPRIID='''||replace(:new.RECPRIID,'''','')||''''||
                             ',SUBITEMID='''||replace(:new.SUBITEMID,'''','')||''''||
                             ',SUBITEMTITLE='''||replace(:new.SUBITEMTITLE,'''','')||''''||
                             ',RECEIPTPEO='''||replace(:new.RECEIPTPEO,'''','')||''''||
                             ',FINTIME='''||replace(:new.FINTIME,'''','')||''''||
                             ',REALDETEVAL='''||replace(:new.REALDETEVAL,'''','')||''''||
                             ',QUAGRADE='''||replace(:new.QUAGRADE,'''','')||''''||
                          ' where '||
                             'RECDETAILID='||:old.RECDETAILID||' and JWDCODE='''||v_jwdcode||'''';
             when deleting then
          v_sql := 'delete from OIL_ASSAY_DETAILRECORER t where t.RECDETAILID='||:old.RECDETAILID||' and t.jwdcode='''||v_jwdcode||'''';
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
             (sys_guid(),'Trigger_OIL_ASSAY_DETAILREC',v_exception,to_char(sysdate,'YYYY-MM-DD HH24:MI:SS'));
end Trigger_OIL_ASSAY_DETAILREC;
/
ALTER TRIGGER "ADMIN"."TRIGGER_OIL_ASSAY_DETAILREC" ENABLE;
