create table dbo.TICKETDRAW (
   ID                   numeric(19)                    identity,
   CrdNo                char(21)                       not null,
   SgnMob               char(11)                       not null,
   MobTel               char(11)                       default '' not null,
   Drawlevel            char(1)                        default '0' not null,
   RecvSign             char(1)                        default '0' not null,
   NO                   numeric(19)                    default 0 not null,
   constraint PK_LOTTDRAW primary key (ID)
         on "default"
)