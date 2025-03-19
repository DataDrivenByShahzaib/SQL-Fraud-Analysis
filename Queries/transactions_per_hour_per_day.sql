select (step/24)+1 as day, 
step%24 as hour,
count(*)
from fraud_detection
group by 1,2
