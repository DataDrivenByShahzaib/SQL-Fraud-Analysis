with average as (
select type,avg(amount) as average_amount
from fraud_detection
where isfraud=1
group by 1 

)
select FD.type, count(FD.type) from fraud_detection FD
join average on average.type=FD.type
where  FD.amount>average.average_amount
group by 1