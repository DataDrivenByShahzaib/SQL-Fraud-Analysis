with multiple_frauds as (select namedest, count(namedest) as frequent from fraud_detection
where isfraud=1
group by 1

order by 2 desc
), 
fraud_amount as(
select FD.namedest as dest_account, sum(FD.amount) as amount from fraud_detection FD
join multiple_frauds MF on FD.namedest=MF.namedest
group by 1)
select FA.dest_account, FA.amount, MF.frequent from fraud_amount FA
join multiple_frauds MF on MF.namedest=FA.dest_account
order by MF.frequent DESC