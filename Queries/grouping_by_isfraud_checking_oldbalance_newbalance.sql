create index idx_fraud_amount
on fraud_detection (isfraud, amount);


with ranking_data as (select FD.*,
percent_rank()over(partition by FD.isfraud order by FD.amount desc) as ranking
from fraud_detection FD
order by FD.isfraud desc
)
,new_data as (
select * from ranking_data
where ranking<=0.10)
select ND.isfraud, count(ND.nameorig)  as balance_0 from new_data ND
where ND.oldbalanceorg=0.0 or ND.newbalanceorig=0.0
group by ND.isfraud