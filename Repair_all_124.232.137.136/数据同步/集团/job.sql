-- ����job
declare job1 number;
begin   
  dbms_job.submit(job1, 'PRO_SYNCHRO_DATA;', sysdate, 'sysdate+2/24');--ÿ10����һ����¼
end;

/**
select * from user_jobs;-- ��������job
select * from dba_jobs_running;
show parameter job_queue_process;--�鿴������job������
alter system set job_queue_processes = 10; --��������oracle��job��
**/


-- ����job
begin   
  dbms_job.run(25);--��select * from user_jobs; �е�jobֵ��Ӧ����what��Ӧ�Ĺ���
end; 