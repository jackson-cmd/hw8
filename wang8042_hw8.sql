--1
with air as (
         select airline_id, source_airport_id, destination_airport_id from route
),
sa as (
    select id
    from airport
    inner join
    air
    on id = source_airport_id
    where altitude >10000
),
da as (
    select id
    from airport
    inner join
    air
    on id = destination_airport_id
    where altitude >10000
),
aname as (--join the airline,route and airport
    select name
    from airline
    inner join
    air
    on id = airline_id
    inner join
    sa
    on gt_10000.id= source_airport_id
    inner join
    da
    on gt1_10000.id =destination_airport_id
)select distinct * from aname;




--2

with MIN as (
	select * from route
	inner join airport
	on airport.id = source_airport_id
	where city = 'Minneapolis' and country = 'United States'
),AG as(
	select * from route
	inner join airport
	on airport.id = destination_airport_id
	where city = 'Athens' and country = 'Greece'
),sov as(
	select destination_airport
        from MIN
	intersect
	select distinct AG.source_airport
        from AG
),st as(--join airport and route
        select name,city,country
        from airport
        inner join
        sov
        on airport.iata =sov.destination_airport
)
select * from st;


--3
with nam as (
      select airline_id from route where source_airport='MSP'
),
dp as (--except from airline
        select id,name
        from airline
        inner join
        nam
        on id=airline_id
        EXCEPT
        select id, name
        from airline
        where country ='ALASKA'
)select distinct name from dp;



--4
create view onew as (--create view table
        with oneway as (
        select source_airport_id, destination_airport_id from route
        EXCEPT
        select destination_airport_id,source_airport_id from route
     )
    select source.name sor, dest.name des
    from oneway
    inner join
    airport source
    on
    source.id =oneway.source_airport_id
    inner join
    airport dest
    on
    dest.id =oneway.destination_airport_id
);
select sor,des from onew;


--5
select des, count(des) As howmany--rewrite
from onew
group by des
order by howmany desc;

/*Results
Amsterdam Airport Schiphol with 16 one way routes
*/
