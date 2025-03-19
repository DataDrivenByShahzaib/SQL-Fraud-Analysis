
with multiple_frauds as (select nameorig, count(nameorig) as frequent from fraud_detection
where isfraud=1
group by 1
having count(nameorig)>1
order by 2 desc
)
select FD.*,MF.frequent from fraud_detection FD
 join multiple_frauds MF on FD.nameorig=MF.nameorig
order by FD.nameorig asc
