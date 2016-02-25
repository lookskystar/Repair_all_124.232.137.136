create or replace
PROCEDURE PRO_SYNCHRO_DATA 
/** HEAD
  * @name ����ͬ��
  * @description ��dict_area���еĵ������ݣ�ͬ�����ܷ�������
  * @version 1.0.0
  * @author Tang
  * @create-date 2014-07-01
  */
IS 
  v_result_count    integer :=0;       --������
  v_page_count      integer :=1000;    --ÿҳ����
  
  v_sql             varchar2(3000);     --����sqlƴ��
  v_status          number;
  v_success_count   number;            --ͳ�Ƴɹ���
  
  v_cur_record      number;            --���ڲ�ѯ�����ȡ
  v_record_id       varchar2(50);
  v_record_sql      varchar2(3000);
  
  v_array_record_id clob;    --��¼�Ѵ����ID 
  
  --ɨ�������
  cursor v_cur_area is select name,dblinkname,jwdcode from dict_area where isused=1;
    
BEGIN
  --ѭ��������
  for cur in v_cur_area loop
      v_result_count := 0;
      v_success_count := 0;
  
      v_sql := 'select count(*) from synchro_data_record@'||cur.dblinkname||' where sd_flag=0';
      execute immediate v_sql into v_result_count; --�����¼����
            
      synchro_data.log_output('��ʼͬ��'||cur.name||',�账��'||v_result_count||'������',0,cur.jwdcode);
      
      --��ҳ��ȡ����
      loop
        v_sql := 'select * from ('
                  ||'select A.*, rownum rn from '
                  ||'(select sd_record_id,sd_record_sql from synchro_data_record@'||cur.dblinkname||' where sd_flag=0 order by sd_record_id) A) '
                  ||'where rn <= '|| (case when v_page_count>v_result_count then v_result_count else v_page_count end)||'';
        
        v_cur_record := dbms_sql.open_cursor;--���α�
        dbms_sql.parse(v_cur_record, v_sql, dbms_sql.native);  --�����α�
        dbms_sql.define_column(v_cur_record, 1, v_record_id,50);  --������
        dbms_sql.define_column(v_cur_record, 2, v_record_sql,3000);
        v_status := dbms_sql.execute(v_cur_record); --ִ�в�ѯ
        v_array_record_id := '';
        
        --����ִ�в�ѯ���
        loop
          exit when dbms_sql.fetch_rows(v_cur_record) <= 0;  --fetch_rows�ڽ�������ƶ��α꣬���δ�ִ�ĩβ������1��
          dbms_sql.column_value(v_cur_record, 1, v_record_id);   --����ǰ�еĲ�ѯ���д�����涨������С�
          dbms_sql.column_value(v_cur_record, 2, v_record_sql);
      
          begin
            execute immediate v_record_sql; --ִ��Զ��SQL
            v_success_count := v_success_count +1;
            v_array_record_id :=synchro_data.deal_string(v_array_record_id,v_record_id);
          exception
          when others then
            dbms_output.put_line(sqlerrm||'--'||sqlcode);
            synchro_data.log_output('�쳣SQL:'||cur.name||','||sqlerrm||'--'||v_record_sql,1,cur.jwdcode);
            execute immediate 'update synchro_data_record@'||cur.dblinkname||' set sd_flag=1 where sd_record_id='||v_record_id;
          end;          
        end loop;
        commit;
        
        --ɾ���Ѵ����ͬ����¼--
        if v_array_record_id is not null then 
            execute immediate 'delete from synchro_data_record@'||cur.dblinkname||' where sd_record_id in ('||v_array_record_id||')';
            commit;
        end if;
        
        dbms_sql.close_cursor(v_cur_record);
        
        v_sql := 'select count(*) from synchro_data_record@'||cur.dblinkname||' where sd_flag=0';
        execute immediate v_sql into v_result_count; --�����¼����
        
        exit when(v_result_count=0);
      end loop;
      synchro_data.log_output('����ͬ��'||cur.name||',�ɹ�����'||v_success_count||'������',0,cur.jwdcode);
  end loop;
EXCEPTION
  -- ��������õ�������Ϣ���ع����񣬼�¼���������־��������
  when others then
    rollback;
    synchro_data.log_output(substr(sqlerrm, 1, 200),1,null); 
END PRO_SYNCHRO_DATA;