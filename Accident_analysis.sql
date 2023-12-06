--Question 1: How many accidents have occurred in urban areas versus rural areas?
select area, count(accidentindex) as totat_accident
from accident
group by area

--Question 2: Which day of the week has the highest number of accidents?
select day, count(accidentindex) as totat_accident
from accident
group by 1
order by 2 desc

--Question 3: What is the average age of vehicles involved in accidents based on their type?
select vehicletype, avg(agevehicle) as age
from vehicle
group by vehicletype
having avg(agevehicle) is not null
order by 2 desc

--Question 4: Can we identify any trends in accidents based on the age of vehicles involved?

--step 1: add a column with datatype as varchar
alter table vehicle
add column age varchar(255)
--step 2: set column having age new/old/regular according to the age number
update vehicle
set age=
case
when agevehicle between 0 and 5 then 'new'
when agevehicle between 6 and 10 then 'regular'
when agevehicle is null then 'not defined'
else 'old'
end
--step 3: Find how many accidents occur for each age type
select age, count(accidentindex) as total_accident
from vehicle
group by 1
having age!='not defined'
order by 2 desc

--Question 5: Are there any specific weather conditions that contribute to severe accidents?
select weatherconditions,severity, count(accidentindex) as total_accident
from accident
where severity='Serious'
group by 1,2
order by 3 desc

--Question 6: Do accidents often involve impacts on the left-hand(driving side) side of vehicles?
select lefthand, count(accidentindex) as total_accident
from vehicle
where lefthand!='Data missing or out of range'
group by 1
order by 2 desc

--Question 7: Are there any relationships between journey purposes and the severity of accidents?
select v.journeypurpose, a.severity, count(v.vehicleid) as total_accident
from accident as a
join vehicle as v
on v.accidentindex=a.accidentindex
where a.severity='Serious'
group by 1,2
having v.journeypurpose!='Not known'
order by 3 desc

--Question 8: Calculate the average age of vehicles involved in accidents , considering Daylight, darkness and point of impact:
select v.pointimpact, a.lightconditions, avg(agevehicle) as avg_agevehicle
from accident as a
join vehicle as v
on v.accidentindex=a.accidentindex
group by 1,2
order by 3 desc

--Question 9: What is the distribution of accidents based on different speed limits?
select speedlimit, count(accidentindex) as total_accident
from accident
group by 1
order by 2 desc

--Question 10: Can we identify any patterns in accidents based on the type of propulsion used by vehicles?
select v.propulsion, count(a.accidentindex) as total_accident
from vehicle as v
join accident as a
on v.accidentindex=a.accidentindex
group by 1
order by 2 desc

--Question 11: Are there any specific road conditions that are associated with a higher number of accidents?
select roadconditions, count(accidentindex) as total_accident
from accident
group by 1
order by 2 desc

--Question 12: What is the average speed of vehicles involved in accidents based on the severity level?
select v.vehicletype, a.severity, avg(speedlimit) as avg_speed
from accident as a
join vehicle as v
on v.accidentindex=a.accidentindex
group by 1,2
order by 3 desc

--Question 13: Are there particular days of the week when accidents involving young vehicles (0-5 years) are more common?
select a.day, count(v.accidentindex) as total_accident
from accident as a
join vehicle as v
on v.accidentindex=a.accidentindex
where v.age='new'
group by 1
order by 2 desc

--Question 14: Is there a correlation between the type of vehicle and the area where accidents occur most frequently?
select v.vehicletype, a.area, count(a.accidentindex) as total_accident
from vehicle as v
join accident as a
on v.accidentindex=a.accidentindex
where a.area='Rural'
group by 1,2
order by 3 desc