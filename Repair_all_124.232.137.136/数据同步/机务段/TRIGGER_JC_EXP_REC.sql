--------------------------------------------------------
--  DDL for Trigger TRIGGER_JC_EXP_REC
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "ADMIN"."TRIGGER_JC_EXP_REC" 
after INSERT OR DELETE OR UPDATE
ON JC_EXP_REC for each row

/** HEAD
 * @name 机车试验记录表触发器
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
          v_sql := 'insert into JC_EXP_REC('||
          'JCERID,JWDCODE,JCNUM,DYPRECID,'||
          'XC,DOPJBARCODE,DOWNPJNUM,UPPJBARCODE,'||
          'UPPJNUM,ITEMID,ITEMNAME,EXPSTATUS,'||
          'UNIT,FIXEMPID,FIXEMP,EMPAFFIRMTIME,'||
          'LEADID,LEADER,LDAFFIRMTIME,TEACHID,'||
          'TEACHNAME,TEACHFITIME,QIID,QI,'||
          'QIAFFITIME,COMMITLEADID,COMMITLEAD,COMLDAFFITIME,'||
          'ACCEPTERID,ACCEPTER,ACCEAFFITIME,RECSTAS,'||
          'FIXSIGNEEID,FIXSIGNEE,EXPTYPE)'||
          'values('''||
          :new.JCERID||''','''||v_jwdcode||''','''||:new.JCNUM||''','''||replace(:new.DYPRECID,'''','')||''','''||
          :new.XC||''','''||replace(:new.DOPJBARCODE,'''','')||''','''||replace(:new.DOWNPJNUM,'''','')||''','''||replace(:new.UPPJBARCODE,'''','')||''','''||
          replace(:new.UPPJNUM,'''','')||''','''||:new.ITEMID||''','''||replace(:new.ITEMNAME,'''','')||''','''||:new.EXPSTATUS||''','''||
          :new.UNIT||''','''||:new.FIXEMPID||''','''||:new.FIXEMP||''','''||:new.EMPAFFIRMTIME||''','''||
          :new.LEADID||''','''||:new.LEADER||''','''||:new.LDAFFIRMTIME||''','''||:new.TEACHID||''','''||
          :new.TEACHNAME||''','''||:new.TEACHFITIME||''','''||:new.QIID||''','''||:new.QI||''','''||
          :new.QIAFFITIME||''','''||:new.COMMITLEADID||''','''||:new.COMMITLEAD||''','''||:new.COMLDAFFITIME||''','''||
          :new.ACCEPTERID||''','''||:new.ACCEPTER||''','''||:new.ACCEAFFITIME||''','''||:new.RECSTAS||''','''||
          :new.FIXSIGNEEID||''','''||replace(:new.FIXSIGNEE,'''','')||''','''||replace(:new.EXPTYPE,'''','')||''')';
          
       when updating then
          v_sql := 'update JC_EXP_REC set '||
                       'JCNUM='''||:new.JCNUM||''''||
                       ',DYPRECID='''||replace(:new.DYPRECID,'''','')||''''||
                       ',XC='''||:new.XC||''''||
                       ',DOPJBARCODE='''||replace(:new.DOPJBARCODE,'''','')||''''||
                       ',DOWNPJNUM='''||replace(:new.DOWNPJNUM,'''','')||''''||
                       ',UPPJBARCODE='''||replace(:new.UPPJBARCODE,'''','')||''''||
                       ',UPPJNUM='''||replace(:new.UPPJNUM,'''','')||''''||
                       ',ITEMID='''||:new.ITEMID||''''||
                       ',ITEMNAME='''||replace(:new.ITEMNAME,'''','')||''''||
                       ',EXPSTATUS='''||:new.EXPSTATUS||''''||
                       ',UNIT='''||:new.UNIT||''''||
                       ',FIXEMPID='''||:new.FIXEMPID||''''||
                       ',FIXEMP='''||:new.FIXEMP||''''||
                       ',EMPAFFIRMTIME='''||:new.EMPAFFIRMTIME||''''||
                       ',LEADID='''||:new.LEADID||''''||
                       ',LEADER='''||:new.LEADER||''''||
                       ',LDAFFIRMTIME='''||:new.LDAFFIRMTIME||''''||
                       ',TEACHID='''||:new.TEACHID||''''||
                       ',TEACHNAME='''||:new.TEACHNAME||''''||
                       ',TEACHFITIME='''||:new.TEACHFITIME||''''||
                       ',COMMITLEAD='''||:new.COMMITLEAD||''''||
                       ',COMLDAFFITIME='''||:new.COMLDAFFITIME||''''||
                       ',ACCEPTERID='''||:new.ACCEPTERID||''''||
                       ',ACCEPTER='''||:new.ACCEPTER||''''||
                       ',ACCEAFFITIME='''||:new.ACCEAFFITIME||''''||
                       ',RECSTAS='''||:new.RECSTAS||''''||
                       ',FIXSIGNEEID='''||:new.FIXSIGNEEID||''''||
                       ',FIXSIGNEE='''||replace(:new.FIXSIGNEE,'''','')||''''||
                       ',EXPTYPE='''||replace(:new.EXPTYPE,'''','')||''''||
                    ' where '||
                       'JCERID='||:old.JCERID||' and jwdcode='''||v_jwdcode||'''';
       when deleting then
          v_sql := 'delete from JC_EXP_REC t where t.JCERID='||:old.JCERID||' and t.jwdcode='''||v_jwdcode||'''';
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
             (sys_guid(),'TRIGGER_JC_EXP_REC',v_exception,to_char(sysdate,'YYYY-MM-DD HH24:MI:SS'));
end TRIGGER_JC_EXP_REC;
/
ALTER TRIGGER "ADMIN"."TRIGGER_JC_EXP_REC" ENABLE;
