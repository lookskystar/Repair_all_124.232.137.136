--------------------------------------------------------
--  DDL for Trigger TRIGGER_DATEPLAN_PRI
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "ADMIN"."TRIGGER_DATEPLAN_PRI" 
  after insert or update or delete
  on DATEPLAN_PRI FOR EACH ROW

/** HEAD
 * @name 日计划表触发器
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
          v_sql := 'insert into dateplan_pri('||
          'RJHMID,JCTYPE,JCNUM,FIXFREQUE,'||
          'KCSJ,JHQJSJ,JHJCSJ,ZHIJIAN,'||
          'GONGZHANG,PLANSTATUE,GDH,TWH,'||
          'ZDR,ZDSJ,NODEID,YANSHOU,'||
          'JISHU,PROJECTTYPE,BANZU,SJQJSJ,'||
          'SJJCSJ,COMMENTS,WORKTEAM,JWDCODE)'||
          'values('''||
          replace(:new.RJHMID,'''','')||''','''||replace(:new.JCTYPE,'''','')||''','''||replace(:new.JCNUM,'''','')||''','''||:new.FIXFREQUE||''','''||
          :new.KCSJ||''','''||:new.JHQJSJ||''','''||:new.JHJCSJ||''','''||:new.ZHIJIAN||''','''||
          :new.GONGZHANG||''','''||:new.PLANSTATUE||''','''||:new.GDH||''','''||:new.TWH||''','''||
          :new.ZDR||''','''||:new.ZDSJ||''','''||:new.NODEID||''','''||:new.YANSHOU||''','''||
          :new.JISHU||''','''||:new.PROJECTTYPE||''','''||:new.BANZU||''','''||:new.SJQJSJ||''','''||
          :new.SJJCSJ||''','''||:new.COMMENTS||''','''||:new.WORKTEAM||''','''||v_jwdcode||''')';
       when updating then
          v_sql := 'update dateplan_pri set '||
                       'JCTYPE='''||replace(:new.JCTYPE,'''','')||''''||
                       ',JCNUM='''||:new.JCNUM||''''||
                       ',FIXFREQUE='''||:new.FIXFREQUE||''''||
                       ',KCSJ='''||:new.KCSJ||''''||
                       ',JHQJSJ='''||:new.JHQJSJ||''''||
                       ',JHJCSJ='''||:new.JHJCSJ||''''||
                       ',ZHIJIAN='''||:new.ZHIJIAN||''''||
                       ',GONGZHANG='''||:new.GONGZHANG||''''||
                       ',PLANSTATUE='''||:new.PLANSTATUE||''''||
                       ',GDH='''||:new.GDH||''''||
                       ',TWH='''||:new.TWH||''''||
                       ',ZDR='''||:new.ZDR||''''||
                       ',ZDSJ='''||:new.ZDSJ||''''||
                       ',NODEID='''||:new.NODEID||''''||
                       ',YANSHOU='''||:new.YANSHOU||''''||
                       ',JISHU='''||:new.JISHU||''''||
                       ',PROJECTTYPE='''||:new.PROJECTTYPE||''''||
                       ',BANZU='''||:new.BANZU||''''||
                       ',SJQJSJ='''||:new.SJQJSJ||''''||
                       ',SJJCSJ='''||:new.SJJCSJ||''''||
                       ',COMMENTS='''||:new.COMMENTS||''''||
                       ',WORKTEAM='''||:new.WORKTEAM||''''||
                    ' where '||
                       'rjhmid='||:old.rjhmid||' and jwdcode='''||v_jwdcode||'''';
       when deleting then
          v_sql := 'delete from dateplan_pri t where t.rjhmid='||:old.rjhmid||' and t.jwdcode='''||v_jwdcode||'''';
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
             (sys_guid(),'Trigger_DATEPLAN_PRI',v_exception,to_char(sysdate,'YYYY-MM-DD HH24:MI:SS'));
end Trigger_DATEPLAN_PRI;

/
ALTER TRIGGER "ADMIN"."TRIGGER_DATEPLAN_PRI" ENABLE;
