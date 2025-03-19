with transaction_data as (
    select 
        (step / 24) + 1 as day,
        step % 24 as hour,
        count(*) filter (where isfraud = 0) as non_fraud_total,  -- count of non-fraud transactions
        count(*) filter (where isfraud = 1) as fraud_total       -- count of fraud transactions
    from 
        fraud_detection
    group by 
        day, hour
),
daily_totals as (
    select 
        day,
        sum(non_fraud_total) as daily_non_fraud_total,
        sum(fraud_total) as daily_fraud_total
    from 
        transaction_data
    group by 
        day
)

select 
    td.day, 
    td.hour, 
    td.non_fraud_total,
    td.fraud_total,
    (td.non_fraud_total::float / nullif(dt.daily_non_fraud_total, 0)) as non_fraud_ratio,
    (td.fraud_total::float / nullif(dt.daily_fraud_total, 0)) as fraud_ratio,
	
from 
    transaction_data td
join 
    daily_totals dt on td.day = dt.day
order by 
    td.day, td.hour;
