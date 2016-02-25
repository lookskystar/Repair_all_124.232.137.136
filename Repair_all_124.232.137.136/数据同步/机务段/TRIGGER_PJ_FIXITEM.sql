--------------------------------------------------------
--  DDL for Trigger TRIGGER_PJ_FIXITEM
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "ADMIN"."TRIGGER_PJ_FIXITEM" 
AFTER INSERT OR DELETE OR UPDATE
ON PJ_FIXITEM for each row


/** HEAD
 * @name 配件项目表触发器
 * @description 变更事件，形成ddl语句插入同步表中
 * @version 1.0.0
 * @author L
 * @create-date 2014-07-01
 */
declare
  v_sql nvarchar2(3000);             --临时存放sql
  v_jwdcode varchar2(30):='08052';    --机务段代码
  v_exception varchar2(500);
begin
  v_sql := null;
  case when inserting then
          v_sql := 'insert into PJ_FIXITEM('||
          'PJITEMID,JWDCODE,PJSID,PJNAME,'||
          'NODEID,FIXITEM,ITEMORDER,TECHSTANDARD,'||
          'ITEMFILLDEFA,QUERYSHWSTAS,ITEMPY,ITEMCTRLLEAD,'||
          'ITEMCTRLCOMLD,ITEMCTRLQI,ITEMCTRLTECH,ITEMCTRLACCE,'||
          'MINVAL,MAXVAL,CHILDPJID,PROTEAMID,'||
          'CHILDPJNAME,POSINAME,'||
          'UNIT,AMOUNT,ITEMCTRLREPT)'||
          'values('''||
          :new.PJITEMID||''','''||v_jwdcode||''','''||:new.PJSID||''','''||replace(:new.PJNAME,'''','')||''','''||
          :new.NODEID||''','''||replace(:new.FIXITEM,'''','')||''','''||:new.ITEMORDER||''','''||:new.TECHSTANDARD||''','''||
          :new.ITEMFILLDEFA||''','''||:new.QUERYSHWSTAS||''','''||:new.ITEMPY||''','''||:new.ITEMCTRLLEAD||''','''||
          :new.ITEMCTRLCOMLD||''','''||:new.ITEMCTRLQI||''','''||:new.ITEMCTRLTECH||''','''||:new.ITEMCTRLACCE||''','''||
          :new.MINVAL||''','''||:new.MAXVAL||''','''||:new.CHILDPJID||''','''||:new.PROTEAMID||''','''||
          replace(:new.CHILDPJNAME,'''','')||''','''||replace(:new.POSINAME,'''','')||''','''||

          :new.UNIT||''','''||:new.AMOUNT||''','''||:new.ITEMCTRLREPT||''')';
       when updating then
          v_sql := 'update PJ_FIXITEM set '||
                       'PJSID='''||:new.PJSID||''''||
                       ',PJNAME='''||replace(:new.PJNAME,'''','')||''''||
                       ',NODEID='''||:new.NODEID||''''||
                       ',FIXITEM='''||replace(:new.FIXITEM,'''','')||''''||
                       ',ITEMORDER='''||:new.ITEMORDER||''''||
                       ',TECHSTANDARD='''||:new.TECHSTANDARD||''''||
                       ',ITEMFILLDEFA='''||:new.ITEMFILLDEFA||''''||
                       ',QUERYSHWSTAS='''||:new.QUERYSHWSTAS||''''||
                       ',ITEMPY='''||:new.ITEMPY||''''||
                       ',ITEMCTRLLEAD='''||:new.ITEMCTRLLEAD||''''||
                       ',ITEMCTRLCOMLD='''||:new.ITEMCTRLCOMLD||''''||
                       ',ITEMCTRLQI='''||:new.ITEMCTRLQI||''''||
                       ',ITEMCTRLTECH='''||:new.ITEMCTRLTECH||''''||
                       ',ITEMCTRLACCE='''||:new.ITEMCTRLACCE||''''||
                       ',MINVAL='''||:new.MINVAL||''''||
                       ',MAXVAL='''||:new.MAXVAL||''''||
                       ',CHILDPJID='''||:new.CHILDPJID||''''||
                       ',PROTEAMID='''||:new.PROTEAMID||''''||
                       ',CHILDPJNAME='''||replace(:new.CHILDPJNAME,'''','')||''''||
                       ',POSINAME='''||replace(:new.POSINAME,'''','')||''''||
                       ',UNIT='''||:new.UNIT||''''||
                       ',AMOUNT='''||:new.AMOUNT||''''||
                       ',ITEMCTRLREPT='''||:new.ITEMCTRLREPT||''''||
                    ' where '||
                       'PJITEMID='||:old.PJITEMID||' and jwdcode='''||v_jwdcode||'''';
       when deleting then
          v_sql := 'delete from PJ_FIXITEM t where t.PJITEMID='||:old.PJITEMID||' and t.jwdcode='''||v_jwdcode||'''';
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
             (sys_guid(),'TRIGGER_PJ_FIXITEM',v_exception,to_char(sysdate,'YYYY-MM-DD HH24:MI:SS'));
end TRIGGER_PJ_FIXITEM;
/
ALTER TRIGGER "ADMIN"."TRIGGER_PJ_FIXITEM" ENABLE;
