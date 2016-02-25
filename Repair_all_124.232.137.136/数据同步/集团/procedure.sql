create or replace
PROCEDURE PRO_SYNCHRO_DATA 
/** HEAD
  * @name 数据同步
  * @description 将dict_area表中的地区数据，同步到总服务器上
  * @version 1.0.0
  * @author Tang
  * @create-date 2014-07-01
  */
IS 
  v_result_count    integer :=0;       --总条数
  v_page_count      integer :=1000;    --每页条数
  
  v_sql             varchar2(3000);     --用于sql拼接
  v_status          number;
  v_success_count   number;            --统计成功数
  
  v_cur_record      number;            --用于查询结果提取
  v_record_id       varchar2(50);
  v_record_sql      varchar2(3000);
  
  v_array_record_id clob;    --记录已处理的ID 
  
  --扫描地区表
  cursor v_cur_area is select name,dblinkname,jwdcode from dict_area where isused=1;
    
BEGIN
  --循环地区表
  for cur in v_cur_area loop
      v_result_count := 0;
      v_success_count := 0;
  
      v_sql := 'select count(*) from synchro_data_record@'||cur.dblinkname||' where sd_flag=0';
      execute immediate v_sql into v_result_count; --计算记录总数
            
      synchro_data.log_output('开始同步'||cur.name||',需处理'||v_result_count||'条数据',0,cur.jwdcode);
      
      --分页提取数据
      loop
        v_sql := 'select * from ('
                  ||'select A.*, rownum rn from '
                  ||'(select sd_record_id,sd_record_sql from synchro_data_record@'||cur.dblinkname||' where sd_flag=0 order by sd_record_id) A) '
                  ||'where rn <= '|| (case when v_page_count>v_result_count then v_result_count else v_page_count end)||'';
        
        v_cur_record := dbms_sql.open_cursor;--打开游标
        dbms_sql.parse(v_cur_record, v_sql, dbms_sql.native);  --解析游标
        dbms_sql.define_column(v_cur_record, 1, v_record_id,50);  --定义列
        dbms_sql.define_column(v_cur_record, 2, v_record_sql,3000);
        v_status := dbms_sql.execute(v_cur_record); --执行查询
        v_array_record_id := '';
        
        --迭代执行查询结果
        loop
          exit when dbms_sql.fetch_rows(v_cur_record) <= 0;  --fetch_rows在结果集中移动游标，如果未抵达末尾，返回1。
          dbms_sql.column_value(v_cur_record, 1, v_record_id);   --将当前行的查询结果写入上面定义的列中。
          dbms_sql.column_value(v_cur_record, 2, v_record_sql);
      
          begin
            execute immediate v_record_sql; --执行远程SQL
            v_success_count := v_success_count +1;
            v_array_record_id :=synchro_data.deal_string(v_array_record_id,v_record_id);
          exception
          when others then
            dbms_output.put_line(sqlerrm||'--'||sqlcode);
            synchro_data.log_output('异常SQL:'||cur.name||','||sqlerrm||'--'||v_record_sql,1,cur.jwdcode);
            execute immediate 'update synchro_data_record@'||cur.dblinkname||' set sd_flag=1 where sd_record_id='||v_record_id;
          end;          
        end loop;
        commit;
        
        --删除已处理的同步记录--
        if v_array_record_id is not null then 
            execute immediate 'delete from synchro_data_record@'||cur.dblinkname||' where sd_record_id in ('||v_array_record_id||')';
            commit;
        end if;
        
        dbms_sql.close_cursor(v_cur_record);
        
        v_sql := 'select count(*) from synchro_data_record@'||cur.dblinkname||' where sd_flag=0';
        execute immediate v_sql into v_result_count; --计算记录总数
        
        exit when(v_result_count=0);
      end loop;
      synchro_data.log_output('结束同步'||cur.name||',成功处理'||v_success_count||'条数据',0,cur.jwdcode);
  end loop;
EXCEPTION
  -- 程序出错，得到出错信息，回滚事务，记录程序出错日志，出错返回
  when others then
    rollback;
    synchro_data.log_output(substr(sqlerrm, 1, 200),1,null); 
END PRO_SYNCHRO_DATA;