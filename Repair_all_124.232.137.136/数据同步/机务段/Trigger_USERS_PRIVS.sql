--------------------------------------------------------
--  DDL for Trigger TRIGGER_USERS_PRIVS
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "ADMIN"."TRIGGER_USERS_PRIVS" 
  after insert or update or delete
  on USERS_PRIVS FOR EACH ROW

/** HEAD
 * @name 用户表触发器
 * @description 变更事件，形成ddl语句插入同步表中
 * @version 1.0.0
 * @author Tang
 * @create-date 2014-07-24
 */
declare
  v_sql nvarchar2(3000);             --临时存放sql
  v_jwdcode varchar2(30):='0809';    --机务段代码
  v_exception varchar2(500);
begin
  v_sql := null;
  case when inserting then
          v_sql := 'insert into USERS_PRIVS('||
          'USERID,JWDCODE,AREAID,ISUSE,'||
          'DEPATID,BZID,ZWID,XM,'||
          'NAME,GONGHAO,IDKID,ROLEID,'||
          'PWD,LOGINTIME,PROTEAMID,UPTIME,'||
          'SEX,QUE,ANS,TEL,'||
          'FAX,MOBILE,MOBILE2,HOMEPHONE,'||
          'ADDRESS,IP,PY,QITA)'||
          'values('''||
          :new.USERID||''','''||:new.JWDCODE||''','''||:new.AREAID||''','''||:new.ISUSE||''','''||
          :new.DEPATID||''','''||:new.BZID||''','''||:new.ZWID||''','''||replace(:new.XM,'''','')||''','''||
          replace(:new.NAME,'''','')||''','''||:new.GONGHAO||''','''||:new.IDKID||''','''||:new.ROLEID||''','''||
          :new.PWD||''','''||:new.LOGINTIME||''','''||:new.PROTEAMID||''','''||:new.UPTIME||''','''||
          :new.SEX||''','''||:new.QUE||''','''||:new.ANS||''','''||:new.TEL||''','''||
          :new.FAX||''','''||:new.MOBILE||''','''||:new.MOBILE2||''','''||:new.HOMEPHONE||''','''||
          :new.ADDRESS||''','''||:new.IP||''','''||:new.PY||''','''||:new.QITA||''')';
       when updating then
          v_sql := 'update USERS_PRIVS set '||
                       'AREAID='''||:new.AREAID||''''||
                       ',ISUSE='''||:new.ISUSE||''''||
                       ',DEPATID='''||:new.DEPATID||''''||
                       ',BZID='''||:new.BZID||''''||
                       ',ZWID='''||:new.ZWID||''''||
                       ',XM='''||replace(:new.XM,'''','')||''''||
                       ',NAME='''||replace(:new.NAME,'''','')||''''||
                       ',GONGHAO='''||:new.GONGHAO||''''||
                       ',IDKID='''||:new.IDKID||''''||
                       ',ROLEID='''||:new.ROLEID||''''||
                       ',PWD='''||:new.PWD||''''||
                       ',LOGINTIME='''||:new.LOGINTIME||''''||
                       ',PROTEAMID='''||:new.PROTEAMID||''''||
                       ',UPTIME='''||:new.UPTIME||''''||
                       ',SEX='''||:new.SEX||''''||
                       ',QUE='''||:new.QUE||''''||
                       ',ANS='''||:new.ANS||''''||
                       ',TEL='''||:new.TEL||''''||
                       ',FAX='''||:new.FAX||''''||
                       ',MOBILE='''||:new.MOBILE||''''||
                       ',MOBILE2='''||:new.MOBILE2||''''||
                       ',HOMEPHONE='''||:new.HOMEPHONE||''''||
                       ',ADDRESS='''||:new.ADDRESS||''''||
                       ',IP='''||:new.IP||''''||
                       ',PY='''||:new.PY||''''||
                       ',QITA='''||:new.QITA||''''||
                    ' where '||
                       'USERID='||:old.USERID||' and JWDCODE='''||v_jwdcode||'''';
       when deleting then
          v_sql := 'delete from USERS_PRIVS t where t.USERID='||:old.USERID||' and t.JWDCODE='''||v_jwdcode||'''';
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
             (sys_guid(),'Trigger_USERS_PRIVS',v_exception,to_char(sysdate,'YYYY-MM-DD HH24:MI:SS'));
end Trigger_USERS_PRIVS;
/
ALTER TRIGGER "ADMIN"."TRIGGER_USERS_PRIVS" ENABLE;
