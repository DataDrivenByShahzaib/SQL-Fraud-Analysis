select (step/24)+1 as day, 
count(*) as total_transactions
from fraud_detection

group by 1
order by 2 desc