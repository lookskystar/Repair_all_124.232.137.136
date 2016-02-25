--------------------------------------------------------
--  DDL for Trigger TRIGGER_MAINPLANDETAIL
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "ADMIN"."TRIGGER_MAINPLANDETAIL" 
  after insert or update or delete
  on MAINPLANDETAIL FOR EACH ROW

/** HEAD
 * @name 主计划详情表触发器
 * @description 变更事件，形成ddl语句插入同步表中
 * @version 1.0.0
 * @author TangXf
 * @create-date 2014-07-01
 */
declare
  v_sql nvarchar2(3000);             --临时存放sql
  v_jwdcode varchar2(30):='08052';    --机务段代码
  v_exception varchar2(500);
begin
  v_sql := null;
  case when inserting then
          v_sql := 'insert into MAINPLANDETAIL('||
          'ID,MAINPLANID,PLANTIME,PLANWEEK,'||
          'NUM,JCTYPE,JCNUM,XCXC,'||
          'KILOMETRE,KCAREA,COMMENTS,ISCASH,'||
          'CASHREASON,REALKILOMETRE,RJHMID,JWDCODE)'||
          'values('''||
          :new.ID||''','''||:new.MAINPLANID||''','''||:new.PLANTIME||''','''||:new.PLANWEEK||''','''||
          :new.NUM||''','''||:new.JCTYPE||''','''||:new.JCNUM||''','''||:new.XCXC||''','''||
          :new.KILOMETRE||''','''||:new.KCAREA||''','''||replace(:new.COMMENTS,'''','')||''','''||:new.ISCASH||''','''||
          replace(:new.CASHREASON,'''','')||''','''||:new.REALKILOMETRE||''','''||:new.RJHMID||''','''||v_jwdcode||''')';

       when updating then
          v_sql := 'update MAINPLANDETAIL set '||
                       'MAINPLANID='''||:new.MAINPLANID||''''||
                       ',PLANTIME='''||:new.PLANTIME||''''||
                       ',PLANWEEK='''||:new.PLANWEEK||''''||
                       ',NUM='''||:new.NUM||''''||
                       ',JCTYPE='''||:new.JCTYPE||''''||
                       ',JCNUM='''||:new.JCNUM||''''||
                       ',XCXC='''||:new.XCXC||''''||
                       ',KILOMETRE='''||:new.KILOMETRE||''''||
                       ',KCAREA='''||:new.KCAREA||''''||
                       ',COMMENTS='''||replace(:new.COMMENTS,'''','')||''''||
                       ',ISCASH='''||:new.ISCASH||''''||
                       ',CASHREASON='''||replace(:new.CASHREASON,'''','')||''''||
                       ',REALKILOMETRE='''||:new.REALKILOMETRE||''''||
                       ',RJHMID='''||:new.RJHMID||''''||
                    ' where '||
                       'ID='||:old.ID||' and jwdcode='''||v_jwdcode||'''';
       when deleting then
          v_sql := 'delete from MAINPLANDETAIL t where t.ID='||:old.ID||' and t.jwdcode='''||v_jwdcode||'''';
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
             (sys_guid(),'Trigger_MAINPLANDETAIL',v_exception,to_char(sysdate,'YYYY-MM-DD HH24:MI:SS'));
end Trigger_MAINPLANDETAIL;
/
ALTER TRIGGER "ADMIN"."TRIGGER_MAINPLANDETAIL" ENABLE;
