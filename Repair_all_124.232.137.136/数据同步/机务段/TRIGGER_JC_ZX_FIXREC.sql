--------------------------------------------------------
--  DDL for Trigger TRIGGER_JC_ZX_FIXREC
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "ADMIN"."TRIGGER_JC_ZX_FIXREC" 
AFTER INSERT OR DELETE OR UPDATE
ON JC_ZX_FIXREC for each row

/** HEAD
 * @name 中修记录表触发器
 * @description 更改事件，形成ddl语句插入同步表中
 * @version 1.0.0
 * @author Txf
 * @create-date 2014-07-01
 */
declare
  v_sql nvarchar2(3000);             --临时存放sql
  v_jwdcode varchar2(30):='08052';    --机务段代码
  v_exception varchar2(500);
begin
  v_sql := null;
  case when inserting then
          v_sql := 'insert into JC_ZX_FIXREC('||
          'ID,JWDCODE,JCTYPE,DYPRECID,'||
          'DOWNPJBARCODE,DOWNPJNUM,UPPJBARCODE,UPPJNUM,'||
          'ITEMID,ITEMNAME,FIXSITUATION,UNIT,'||
          'FIXEMPID,FIXEMP,EMPAFFIRMTIME,LEADID,'||
          'LEAD,LDAFFIRMTIME,TEACHID,TEACHNAME,'||
          'TEALDAFFITIME,QIID,QI,QIAFFITIME,'||
          'COMMITLEADID,COMMITLEAD,COMLDAFFITIME,ACCEPTERID,'||
          'ACCEPTER,ACCEAFFITIME,RECSTAS,ITEMTYPE,'||
          'JCNUM,JHTIME,BZID,NODEID,'||
          'DURATION,REPTID,REPT,REPTAFFIRMTIME,'||
          'DEALSITUATION,ITEMCTRLREPT,POSINAME,UNITNAME,'||
          'ITEMCTRLLEAD,ITEMCTRLCOMLD,ITEMCTRLQI,ITEMCTRLTECH,'||
          'ITEMCTRLACCE,FIRSTUNITID)'||
          ' values('''||
          :new.ID||''','''||v_jwdcode||''','''||:new.JCTYPE||''','''||:new.DYPRECID||''','''||
          replace(:new.DOWNPJBARCODE,'''','')||''','''||replace(:new.DOWNPJNUM,'''','')||''','''||replace(:new.UPPJBARCODE,'''','')||''','''||replace(:new.UPPJNUM,'''','')||''','''||
          :new.ITEMID||''','''||replace(:new.ITEMNAME,'''','')||''','''||replace(:new.FIXSITUATION,'''','')||''','''||:new.UNIT||''','''||
          :new.FIXEMPID||''','''||:new.FIXEMP||''','''||:new.EMPAFFIRMTIME||''','''||:new.LEADID||''','''||
          :new.LEAD||''','''||:new.LDAFFIRMTIME||''','''||:new.TEACHID||''','''||:new.TEACHNAME||''','''||
          :new.TEALDAFFITIME||''','''||:new.QIID||''','''||:new.QI||''','''||:new.QIAFFITIME||''','''||
          :new.COMMITLEADID||''','''||:new.COMMITLEAD||''','''||:new.COMLDAFFITIME||''','''||:new.ACCEPTERID||''','''||
          :new.ACCEPTER||''','''||:new.ACCEAFFITIME||''','''||:new.RECSTAS||''','''||:new.ITEMTYPE||''','''||
          :new.JCNUM||''','''||:new.JHTIME||''','''||:new.BZID||''','''||:new.NODEID||''','''||
          replace(:new.DURATION,'''','')||''','''||:new.REPTID||''','''||:new.REPT||''','''||:new.REPTAFFIRMTIME||''','''||
          replace(:new.DEALSITUATION,'''','')||''','''||:new.ITEMCTRLREPT||''','''||:new.POSINAME||''','''||:new.UNITNAME||''','''||
          :new.ITEMCTRLLEAD||''','''||:new.ITEMCTRLCOMLD||''','''||:new.ITEMCTRLQI||''','''||:new.ITEMCTRLTECH||''','''||
          :new.ITEMCTRLACCE||''','''||:new.FIRSTUNITID||''')';
       when updating then
          v_sql := 'update JC_ZX_FIXREC set '||
                       'JCTYPE='''||:new.JCTYPE||''''||
                       ',DYPRECID='''||:new.DYPRECID||''''||
                       ',DOWNPJBARCODE='''||replace(:new.DOWNPJBARCODE,'''','')||''''||
                       ',DOWNPJNUM='''||replace(:new.DOWNPJNUM,'''','')||''''||
                       ',UPPJBARCODE='''||replace(:new.UPPJBARCODE,'''','')||''''||
                       ',UPPJNUM='''||replace(:new.UPPJNUM,'''','')||''''||
                       ',ITEMID='''||:new.ITEMID||''''||
                       ',ITEMNAME='''||replace(:new.ITEMNAME,'''','')||''''||
                       ',FIXSITUATION='''||replace(:new.FIXSITUATION,'''','')||''''||
                       ',UNIT='''||:new.UNIT||''''||
                       ',FIXEMPID='''||:new.FIXEMPID||''''||
                       ',FIXEMP='''||:new.FIXEMP||''''||
                       ',EMPAFFIRMTIME='''||:new.EMPAFFIRMTIME||''''||
                       ',LEADID='''||:new.LEADID||''''||
                       ',LEAD='''||:new.LEAD||''''||
                       ',LDAFFIRMTIME='''||:new.LDAFFIRMTIME||''''||
                       ',TEACHID='''||:new.TEACHID||''''||
                       ',TEACHNAME='''||:new.TEACHNAME||''''||
                       ',TEALDAFFITIME='''||:new.TEALDAFFITIME||''''||
                       ',QIID='''||:new.QIID||''''||
                       ',QI='''||:new.QI||''''||
                       ',QIAFFITIME='''||:new.QIAFFITIME||''''||
                       ',COMMITLEADID='''||:new.COMMITLEADID||''''||
                       ',COMMITLEAD='''||:new.COMMITLEAD||''''||
                       ',COMLDAFFITIME='''||:new.COMLDAFFITIME||''''||
                       ',ACCEPTERID='''||:new.ACCEPTERID||''''||
                       ',ACCEPTER='''||:new.ACCEPTER||''''||
                       ',ACCEAFFITIME='''||:new.ACCEAFFITIME||''''||
                       ',RECSTAS='''||:new.RECSTAS||''''||
                       ',ITEMTYPE='''||:new.ITEMTYPE||''''||
                       ',JCNUM='''||:new.JCNUM||''''||
                       ',JHTIME='''||:new.JHTIME||''''||
                       ',BZID='''||:new.BZID||''''||
                       ',NODEID='''||:new.NODEID||''''||
                       ',DURATION='''||replace(:new.DURATION,'''','')||''''||
                       ',REPTID='''||:new.REPTID||''''||
                       ',REPT='''||:new.REPT||''''||
                       ',REPTAFFIRMTIME='''||:new.REPTAFFIRMTIME||''''||
                       ',DEALSITUATION='''||replace(:new.DEALSITUATION,'''','')||''''||
                       ',ITEMCTRLREPT='''||:new.ITEMCTRLREPT||''''||
                       ',POSINAME='''||:new.POSINAME||''''||
                       ',UNITNAME='''||:new.UNITNAME||''''||
                       ',ITEMCTRLLEAD='''||:new.ITEMCTRLLEAD||''''||
                       ',ITEMCTRLCOMLD='''||:new.ITEMCTRLCOMLD||''''||
                       ',ITEMCTRLQI='''||:new.ITEMCTRLQI||''''||
                       ',ITEMCTRLTECH='''||:new.ITEMCTRLTECH||''''||
                       ',ITEMCTRLACCE='''||:new.ITEMCTRLACCE||''''||
                       ',FIRSTUNITID='''||:new.FIRSTUNITID||''''||
                    ' where '||
                       'ID='||:old.ID||' and jwdcode='''||v_jwdcode||'''';
       when deleting then
          v_sql := 'delete from JC_ZX_FIXREC t where t.ID='||:old.ID||' and t.jwdcode='''||v_jwdcode||'''';
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
             (sys_guid(),'TRIGGER_JC_ZX_FIXREC',v_exception,to_char(sysdate,'YYYY-MM-DD HH24:MI:SS'));
end TRIGGER_JC_ZX_FIXREC;
/
ALTER TRIGGER "ADMIN"."TRIGGER_JC_ZX_FIXREC" ENABLE;
