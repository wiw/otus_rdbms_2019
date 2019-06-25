--alter table public.pirates add column id SERIAL;
--alter table public.pirates drop column id;
--alter table public.ships add column pirateCount INT;

create table test (id serial, name varchar(128) not NULL);
alter table test add column optional int;

insert into test (name, optional) values ('wer', 6),('sdfdf', 15) RETURNING id, name;


insert into test (name, optional) values ('abc', 6)
on conflict (name) do nothing;
insert into test (name, optional) values ('sdfdf', 15);

select * from test;

insert into test (optional) values ( 3);

insert into public.pirates
(piratename, shipname, dateofbirth)
values ('Mad Bob', null, '1600-01-20');

insert into public.pirates
(piratename, shipname, dateofbirth)
values ('Mad Bob', null, '1600-01-20')
on conflict (piratename) DO update set dateofbirth = '1601-01-20';

if not exists (select 1
	from public.pirates
	where piratename = 'Mad Bob') then 
begin 
	insert into public.pirates
	(piratename, shipname, dateofbirth)
	values ('Mad Bob', null, '1600-01-20')
	on conflict (piratename) DO nothing RETURNING id;
end
else 
	select id
	from public.pirates
	where piratename = 'Mad Bob';

select *
from public.pirates
where piratename = 'Mad Bob';

select * into shipsWithPirates
from public.ships; 

update public.pirates
set shipname = 'Havana'
where piratename = 'Mad Bob';

select s.shipname,  p.pcount
from public.ships as s,(select p.shipname, count(piratename) as pcount 
	from public.pirates as p
	group by p.shipname) as p
WHERE s.shipname = p.shipname;

update public.ships as s
set pirateCount = p.pcount - 1
from (select p.shipname, count(piratename) as pcount 
	from public.pirates as p
	group by p.shipname) as p
WHERE s.shipname = p.shipname;

update public.ships
set pirateCount = pirateCount + 1;

select * from public.pirates
where piratename = 'Mad Bob' 
or piratename = 'Smart John Test'
or shipname = 'Havana';



insert into public.pirates
(piratename, shipname, dateofbirth)
values ('Smart John Test', null, '1619-08-23') RETURNING id,piratename,shipname;

delete from public.pirates
where piratename = 'Smart John';

insert into public.pirates_archived
(piratename, shipname, dateofbirth, dateofdearth)
select piratename, COALESCE(shipname,'No ship'), dateofbirth, dateofdearth 
from public.pirates
where dateofdearth is not NULL;

insert into public.pirates_archived
(piratename, shipname, dateofbirth, dateofdearth)
select piratename, shipname, dateofbirth, dateofdearth 
from public.pirates
where dateofdearth is not NULL;

select *
from public.pirates_archived;

delete from public.pirates_archived;