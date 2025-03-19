create index index_on_type on fraud_detection(type)
with transact_data as (select type as transact_type, avg(amount) as Average_amount from fraud_detection
GROUP by 1)
select transact_type, Average_amount, dense_rank()over(partition by 1 order by Average_amount desc)
from transact_data