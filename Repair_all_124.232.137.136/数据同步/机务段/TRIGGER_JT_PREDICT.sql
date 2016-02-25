--------------------------------------------------------
--  DDL for Trigger TRIGGER_JT_PREDICT
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "ADMIN"."TRIGGER_JT_PREDICT" 
AFTER INSERT OR DELETE OR UPDATE
ON JT_PREDICT for each row

/** HEAD
 * @name 报活表触发器
 * @description 变更事件，形成ddl语句插入同步表中
 * @version 1.0.0
 * @author txf
 * @create-date 2014-07-01
 */
declare
  v_sql nvarchar2(3000);             --临时存放sql
  v_jwdcode varchar2(30):='08052';    --机务段代码
  v_exception varchar2(500);
begin
  v_sql := null;
  case when inserting then
          v_sql := 'insert into JT_PREDICT('||
          'PREDICTID,JWDCODE,REPTIME,JCTYPE,'||
          'JCNUM,REPPOSI,REPSITUATION,FAILNUM,'||
          'FAILNOTE,REPEMPNO,REPEMP,VERIFYTIME,'||
          'VERYFIER,RECEIPTPEO,RECETIME,FIXEMP,'||
          'DEALSITUATION,FIXENDTIME,LEAD,LDAFFIRMTIME,'||
          'COMMITLD,COMLDAFFITIME,QI,QIAFFITIME,'||
          'ACCEPTER,ACCETIME,TECHNICIAN,TECHAFFITIME,'||
          'AFFIRMGRADE,TYPE,ZEROKILORECID,RECSTAS,'||
          'REPDATE,THIRDUNITID,CLQK,FIXEMPID,'||
          'LEADID,COMMITLDID,QIID,ACCEPTERID,'||
          'TECHNICIANID,IMGURL,PROTEAMID,ITEMCTRLCOMLD,'||
          'ITEMCTRQI,ITEMCTRLTECH,ITEMCTRLACCE,DATEPLANPRI,'||
          'DEALFIXEMP,FIXEMPIDS,FIXEMPS,ASSIGNEDIDS,'||
          'ASSIGNEDNAMES,FIXEMDTIME,JCRECMID,BZID,'||
          'BZNAME,DIVISIONID,SMPREDICTID,UPPJNUM,'||
          'SCORE)'||
          'values('''||
          :new.PREDICTID||''','''||v_jwdcode||''','''||:new.REPTIME||''','''||:new.JCTYPE||''','''||
          :new.JCNUM||''','''||replace(:new.REPPOSI,'''','')||''','''||replace(:new.REPSITUATION,'''','')||''','''||replace(:new.FAILNUM,'''','')||''','''||
          replace(:new.FAILNOTE,'''','')||''','''||:new.REPEMPNO||''','''||:new.REPEMP||''','''||:new.VERIFYTIME||''','''||
          :new.VERYFIER||''','''||:new.RECEIPTPEO||''','''||:new.RECETIME||''','''||:new.FIXEMP||''','''||
          replace(:new.DEALSITUATION,'''','')||''','''||:new.FIXENDTIME||''','''||:new.LEAD||''','''||:new.LDAFFIRMTIME||''','''||
          :new.COMMITLD||''','''||:new.COMLDAFFITIME||''','''||:new.QI||''','''||:new.QIAFFITIME||''','''||
          :new.ACCEPTER||''','''||:new.ACCETIME||''','''||:new.TECHNICIAN||''','''||:new.TECHAFFITIME||''','''||
          :new.AFFIRMGRADE||''','''||:new.TYPE||''','''||:new.ZEROKILORECID||''','''||:new.RECSTAS||''','''||
          :new.REPDATE||''','''||:new.THIRDUNITID||''','''||:new.CLQK||''','''||:new.FIXEMPID||''','''||
          :new.LEADID||''','''||:new.COMMITLDID||''','''||:new.QIID||''','''||:new.ACCEPTERID||''','''||
          :new.TECHNICIANID||''','''||replace(:new.IMGURL,'''','')||''','''||:new.PROTEAMID||''','''||:new.PROTEAMID||''','''||
          :new.ITEMCTRQI||''','''||:new.ITEMCTRLTECH||''','''||:new.ITEMCTRLACCE||''','''||:new.DATEPLANPRI||''','''||
          :new.DEALFIXEMP||''','''||replace(:new.FIXEMPIDS,'''','')||''','''||replace(:new.FIXEMPS,'''','')||''','''||replace(:new.ASSIGNEDIDS,'''','')||''','''||
          replace(:new.ASSIGNEDNAMES,'''','')||''','''||:new.FIXEMDTIME||''','''||:new.JCRECMID||''','''||:new.BZID||''','''||
          :new.BZNAME||''','''||:new.DIVISIONID||''','''||:new.SMPREDICTID||''','''||replace(:new.UPPJNUM,'''','')||''','''||
          :new.SCORE||''')';
       when updating then
          v_sql := 'update JT_PREDICT set '||
                       'REPTIME='''||:new.REPTIME||''''||
                       ',JCTYPE='''||:new.JCTYPE||''''||
                       ',JCNUM='''||:new.JCNUM||''''||
                       ',REPPOSI='''||replace(:new.REPPOSI,'''','')||''''||
                       ',REPSITUATION='''||replace(:new.REPSITUATION,'''','')||''''||
                       ',FAILNUM='''||replace(:new.FAILNUM,'''','')||''''||
                       ',FAILNOTE='''||replace(:new.FAILNOTE,'''','')||''''||
                       ',REPEMPNO='''||:new.REPEMPNO||''''||
                       ',REPEMP='''||:new.REPEMP||''''||
                       ',VERIFYTIME='''||:new.VERIFYTIME||''''||
                       ',VERYFIER='''||:new.VERYFIER||''''||
                       ',RECEIPTPEO='''||:new.RECEIPTPEO||''''||
                       ',RECETIME='''||:new.RECETIME||''''||
                       ',FIXEMP='''||:new.FIXEMP||''''||
                       ',DEALSITUATION='''||replace(:new.DEALSITUATION,'''','')||''''||
                       ',FIXENDTIME='''||:new.FIXENDTIME||''''||
                       ',LEAD='''||:new.LEAD||''''||
                       ',LDAFFIRMTIME='''||:new.LDAFFIRMTIME||''''||
                       ',COMMITLD='''||:new.COMMITLD||''''||
                       ',COMLDAFFITIME='''||:new.COMLDAFFITIME||''''||
                       ',QI='''||:new.QI||''''||
                       ',QIAFFITIME='''||:new.QIAFFITIME||''''||
                       ',ACCEPTER='''||:new.ACCEPTER||''''||
                       ',ACCETIME='''||:new.ACCETIME||''''||
                       ',TECHNICIAN='''||:new.TECHNICIAN||''''||
                       ',TECHAFFITIME='''||:new.TECHAFFITIME||''''||
                       ',AFFIRMGRADE='''||:new.AFFIRMGRADE||''''||
                       ',TYPE='''||:new.TYPE||''''||
                       ',ZEROKILORECID='''||:new.ZEROKILORECID||''''||
                       ',RECSTAS='''||:new.RECSTAS||''''||
                       ',REPDATE='''||:new.REPDATE||''''||
                       ',THIRDUNITID='''||:new.THIRDUNITID||''''||
                       ',CLQK='''||:new.CLQK||''''||
                       ',FIXEMPID='''||:new.FIXEMPID||''''||
                       ',LEADID='''||:new.LEADID||''''||
                       ',COMMITLDID='''||:new.COMMITLDID||''''||
                       ',QIID='''||:new.QIID||''''||
                       ',ACCEPTERID='''||:new.ACCEPTERID||''''||
                       ',TECHNICIANID='''||:new.TECHNICIANID||''''||
                       ',IMGURL='''||replace(:new.IMGURL,'''','')||''''||
                       ',PROTEAMID='''||:new.PROTEAMID||''''||
                       ',ITEMCTRLCOMLD='''||:new.ITEMCTRLCOMLD||''''||
                       ',ITEMCTRQI='''||:new.ITEMCTRQI||''''||
                       ',ITEMCTRLTECH='''||:new.ITEMCTRLTECH||''''||
                       ',ITEMCTRLACCE='''||:new.ITEMCTRLACCE||''''||
                       ',DATEPLANPRI='''||:new.DATEPLANPRI||''''||
                       ',DEALFIXEMP='''||:new.DEALFIXEMP||''''||
                       ',FIXEMPIDS='''||replace(:new.FIXEMPIDS,'''','')||''''||
                       ',FIXEMPS='''||replace(:new.FIXEMPS,'''','')||''''||
                       ',ASSIGNEDIDS='''||replace(:new.ASSIGNEDIDS,'''','')||''''||
                       ',ASSIGNEDNAMES='''||replace(:new.ASSIGNEDNAMES,'''','')||''''||
                       ',FIXEMDTIME='''||:new.FIXEMDTIME||''''||
                       ',JCRECMID='''||:new.JCRECMID||''''||
                       ',BZID='''||:new.BZID||''''||
                       ',BZNAME='''||:new.BZNAME||''''||
                       ',DIVISIONID='''||:new.DIVISIONID||''''||
                       ',SMPREDICTID='''||:new.SMPREDICTID||''''||
                       ',UPPJNUM='''||replace(:new.UPPJNUM,'''','')||''''||
                       ',SCORE='''||:new.SCORE||''''||

                    ' where '||
                       'PREDICTID='||:old.PREDICTID||' and jwdcode='''||v_jwdcode||'''';
       when deleting then
          v_sql := 'delete from JT_PREDICT t where t.PREDICTID='||:old.PREDICTID||' and t.jwdcode='''||v_jwdcode||'''';
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
             (sys_guid(),'TRIGGER_JT_PREDICT',v_exception,to_char(sysdate,'YYYY-MM-DD HH24:MI:SS'));
end TRIGGER_JT_PREDICT;
/
ALTER TRIGGER "ADMIN"."TRIGGER_JT_PREDICT" ENABLE;
