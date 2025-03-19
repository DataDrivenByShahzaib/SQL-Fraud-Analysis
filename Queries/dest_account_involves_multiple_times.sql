create index index_on_name_dest on fraud_detection(namedest)
with multiple_frauds as (select namedest, count(namedest) as frequent from fraud_detection
where isfraud=1
group by 1
having count(namedest)>1
order by 2 desc
)
select FD.*,MF.frequent from fraud_detection FD
 join multiple_frauds MF on FD.namedest=MF.namedest
where FD.isfraud=1 
order by  FD.namedest desc
