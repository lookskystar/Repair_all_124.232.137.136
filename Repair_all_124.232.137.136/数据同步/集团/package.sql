create or replace
PACKAGE SYNCHRO_DATA 
/** HEAD
  * @name 数据同步辅助函数
  * @description 数据同步辅助函数
  * @version 1.0.0
  * @author Tang
  * @create-date 2014-07-01
  */
AS 
  --日志处理--
  procedure log_output(log_info varchar2,log_type number,jwdcode varchar2);
  --字符串处理--
  function deal_string(str_arr clob,record_id varchar2) return clob;
  
END SYNCHRO_DATA;


create or replace
PACKAGE BODY SYNCHRO_DATA 
/** HEAD
  * @name 数据同步辅助函数
  * @description 数据同步辅助函数
  * @version 1.0.0
  * @author Tang
  * @create-date 2014-07-01
  */
AS 
  
  --日志处理--
  procedure LOG_OUTPUT(log_info in varchar2,log_type in number,jwdcode varchar2) is
  begin
      insert into synchro_log(log_id,log_time,log_info,log_type,jwdcode) values (sys_guid(),TO_CHAR(SYSDATE(),'YYYY-MM-DD HH24:MI:SS'),log_info,log_type,jwdcode);
      commit;
  end LOG_OUTPUT;
  
  --字符串处理--
  function deal_string(str_arr clob,record_id varchar2) return clob is
  begin
    if str_arr='' or str_arr is null then
      return record_id;
    elsif substr(str_arr,length(str_arr)-1)=',' then
      return str_arr||record_id;
    else
      return str_arr||','||record_id;
    end if;
  end deal_string;
  
END SYNCHRO_DATA;