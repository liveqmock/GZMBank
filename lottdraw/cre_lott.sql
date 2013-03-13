if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.LOTTDRAW')
            and   name  = 'Index_1'
            and   indid > 0
            and   indid < 255)
   drop index LOTTDRAW.Index_1
go

if exists (select 1
            from  sysobjects
            where id = object_id('dbo.LOTTDRAW')
            and   type = 'U')
   drop table dbo.LOTTDRAW
go

/*==============================================================*/
/* Table: LOTTDRAW                                              */
/*==============================================================*/
create table dbo.LOTTDRAW (
   ID                   numeric(19)                    identity,
   PhoneNO              char(11)                       null,
   Drawlevel            char(1)                        null,
   RecvSign             char(1)                        null,
   NO                   numeric(19)                    null,
   constraint PK_LOTTDRAW primary key (ID)
         on "default"
)
lock allpages
go

/*==============================================================*/
/* Index: Index_1                                               */
/*==============================================================*/
create unique index Index_1 on dbo.LOTTDRAW (
PhoneNO ASC
)
on "default"
go