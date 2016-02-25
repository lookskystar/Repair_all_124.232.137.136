-- 创建job
declare job1 number;
begin   
  dbms_job.submit(job1, 'PRO_SYNCHRO_DATA;', sysdate, 'sysdate+2/24');--每10插入一条记录
end;

/**
select * from user_jobs;-- 正在运行job
select * from dba_jobs_running;
show parameter job_queue_process;--查看并发的job的数量
alter system set job_queue_processes = 10; --调整启动oracle的job。
**/


-- 运行job
begin   
  dbms_job.run(25);--和select * from user_jobs; 中的job值对应，看what对应的过程
end; 