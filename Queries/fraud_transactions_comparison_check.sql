
with multiple_frauds as (select namedest, count(namedest) as frequent from fraud_detection
where isfraud=1
group by 1
having count(namedest)>1
order by 2 desc
),
fraud_transactions_with_lead_lag as(
    SELECT FD.*,
           MF.frequent,
           lag(nameorig) over ( order by FD.namedest asc) as prev_nameorig,
           lead(nameorig) over ( order by FD.namedest asc) as next_nameorig
    FROM fraud_detection FD
    JOIN multiple_frauds MF ON FD.namedest = MF.namedest
    WHERE FD.isfraud = 1
)
select FL.*,
case
	when FL.nameorig=FL.prev_nameorig then 'Orig account is the same'
	when FL.nameorig=FL.next_nameorig then 'Orig account is the same'
	else 'Different'
end as orig_account_comparison 
from fraud_transactions_with_lead_lag FL
