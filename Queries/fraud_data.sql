create index index_on_fraud on fraud_detection(isfraud)
select * from fraud_detection
where  isfraud=1