
with multiple_frauds as (select namedest, count(namedest) as frequent 
from fraud_detection
where isfraud=1 
group by 1
order by 2 desc
), 
dest_fraud_detail as(
select FRD.* 
from fraud_detection FRD
join multiple_frauds MUL_F on FRD.namedest=MUL_f.namedest
)
select distinct FD.* 
from fraud_detection FD
join dest_fraud_detail DFD on FD.nameorig=DFD.namedest

order by  FD.namedest desc
