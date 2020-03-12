


create user teste identified by teste
default tablespace tsd_selo
temporary tablespace temp;


grant connect,resource to teste;


create table teste
(
a number,
b varchar2(2000),
c varchar2(2000)
)
/




begin
for i in 1..1000000000 loop
	insert into teste values(1,'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa','bbbbbbbbbbbbbbbbbbb');
        commit;
end loop;

end;



