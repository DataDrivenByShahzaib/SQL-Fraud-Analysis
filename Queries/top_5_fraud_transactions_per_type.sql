create index index_on_type_amount_fraud on fraud_detection(type, amount, isfraud)
with data as(select type as payment_type, amount, 
dense_rank() over(partition by type order by amount desc) as ranking
from fraud_detection
where isfraud=1

)
select payment_type, amount, ranking from data
where ranking<=5