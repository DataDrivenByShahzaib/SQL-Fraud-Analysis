with fraud_data_per_day as (select ((step/24)+1) as day,
(step%24) as hour,
count(*) as total_fraud,
dense_rank()over(partition by ((step/24)+1)  order by count(*) desc) as ranking
from fraud_detection
where isfraud=1
group by 1,2
order by 1

), more_fraud_per_hour as(
select FDP.day, FDP.hour, FDP.total_fraud from fraud_data_per_day FDP
where ranking<=5)
select MFP.hour, count(*) from more_fraud_per_hour MFP
group by 1
order by 2 desc