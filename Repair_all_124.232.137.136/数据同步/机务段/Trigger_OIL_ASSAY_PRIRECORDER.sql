--------------------------------------------------------
--  DDL for Trigger TRIGGER_OIL_ASSAY_PRIRECORDER
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "ADMIN"."TRIGGER_OIL_ASSAY_PRIRECORDER" 
  after insert or update or delete
  on OIL_ASSAY_PRIRECORDER FOR EACH ROW

/** HEAD
 * @name 油水化验日计划表触发器
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
          v_sql := 'insert into OIL_ASSAY_PRIRECORDER('||
          'RECPRIID,AREAID,WEKPRECID,SENTSAMPEO,'||
          'RECEIPTPEO,RECESAMTIME,FINTIME,DETECTESTATUS,'||
          'JCSTYPEVAL,JCNUM,DEALADVICE,QUASITUATION,'||
          'JWDCODE)'||
          'values('''||
          :new.RECPRIID||''','''||:new.AREAID||''','''||:new.WEKPRECID||''','''||replace(:new.SENTSAMPEO,'''','')||''','''||
          replace(:new.RECEIPTPEO,'''','')||''','''||replace(:new.RECESAMTIME,'''','')||''','''||replace(:new.FINTIME,'''','')||''','''||replace(:new.DETECTESTATUS,'''','')||''','''||
          replace(:new.JCSTYPEVAL,'''','')||''','''||replace(:new.JCNUM,'''','')||''','''||replace(:new.DEALADVICE,'''','')||''','''||replace(:new.QUASITUATION,'''','')||''','''||
          v_jwdcode||''')';
       when updating then
          v_sql := 'update OIL_ASSAY_PRIRECORDER set '||
                       'AREAID='''||:new.AREAID||''''||
                       ',WEKPRECID='''||:new.WEKPRECID||''''||
                       ',SENTSAMPEO='''||replace(:new.SENTSAMPEO,'''','')||''''||
                       ',RECEIPTPEO='''||replace(:new.RECEIPTPEO,'''','')||''''||
                       ',RECESAMTIME='''||replace(:new.RECESAMTIME,'''','')||''''||
                       ',FINTIME='''||replace(:new.FINTIME,'''','')||''''||
                       ',DETECTESTATUS='''||replace(:new.DETECTESTATUS,'''','')||''''||
                       ',JCSTYPEVAL='''||replace(:new.JCSTYPEVAL,'''','')||''''||
                       ',JCNUM='''||replace(:new.JCNUM,'''','')||''''||
                       ',DEALADVICE='''||replace(:new.DEALADVICE,'''','')||''''||
                       ',QUASITUATION='''||replace(:new.QUASITUATION,'''','')||''''||
                    ' where '||
                       'RECPRIID='||:old.RECPRIID||' and jwdcode='''||v_jwdcode||'''';
       when deleting then
          v_sql := 'delete from OIL_ASSAY_PRIRECORDER t where t.RECPRIID='||:old.RECPRIID||' and t.jwdcode='''||v_jwdcode||'''';
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
             (sys_guid(),'Trigger_OIL_ASSAY_PRIRECORDER',v_exception,to_char(sysdate,'YYYY-MM-DD HH24:MI:SS'));
end Trigger_OIL_ASSAY_PRIRECORDER;
/
ALTER TRIGGER "ADMIN"."TRIGGER_OIL_ASSAY_PRIRECORDER" ENABLE;
