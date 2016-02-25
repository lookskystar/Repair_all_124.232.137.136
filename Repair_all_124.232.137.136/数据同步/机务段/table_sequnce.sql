-- Create sequence 
create sequence SEQ_SYNCHRO_DATA
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;


-- Create table
create table SYNCHRO_DATA_RECORD
(
  SD_RECORD_ID  NUMBER not null,
  SD_RECORD_SQL VARCHAR2(2000),
  SD_FLAG       NUMBER,
  CREATE_TIME   VARCHAR2(30)
);

comment on table SYNCHRO_DATA_RECORD is '记录需要同步的信息';
comment on column SYNCHRO_DATA_RECORD.SD_RECORD_SQL is '同步的SQL';
comment on column SYNCHRO_DATA_RECORD.SD_FLAG is '同步标识 0：未同步 1：已同步';
comment on column SYNCHRO_DATA_RECORD.CREATE_TIME is '创建日期';


alter table SYNCHRO_DATA_RECORD
  add constraint SYNCHRO_DATA_PRIMARY primary key (SD_RECORD_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

create index SYNCHRO_DATA_INDEX on SYNCHRO_DATA_RECORD (SD_FLAG)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );


---触发器异常信息---
create table SYNCHRO_DATA_TRIG_LOG
(
  ID             VARCHAR2(40) not null,
  TRIGGER_NAME   VARCHAR2(30),
  EXCEPTION_INFO VARCHAR2(1000),
  EXCEPTION_TIME VARCHAR2(30)
);
-- Create/Recreate primary, unique and foreign key constraints 
alter table SYNCHRO_DATA_TRIG_LOG
  add constraint SYNCHRO_DATA_TRIG_LOG_PK primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

