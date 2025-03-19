create index index_on_name_orign on fraud_detection(nameorig)
with multiple_fraud as (select nameorig, count(nameorig) as frequent from fraud_detection
where isfraud=1
group by 1

)
select *, MF.frequent from fraud_detection FD
inner join multiple_fraud MF on 
FD.nameorig=MF.nameorig or FD.namedest=MF.nameorig
order by MF.frequent desc