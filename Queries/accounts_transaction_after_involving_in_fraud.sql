
 
with dest_fraud_detail as(
select FRD.* 
from fraud_detection FRD

where FRD.isfraud=1
)
,origin_account as (
select distinct FD.* ,
DFD.step as fraud_transaction_date,
FD.step as send_transaction_date 
from fraud_detection FD
join dest_fraud_detail DFD on FD.nameorig=DFD.namedest
where DFD.step<FD.step
order by  FD.namedest desc
)
select
ORG_acc.nameorig,
(ORG_acc.fraud_transaction_date/24)+1 as Fraud_transaction_day,
(ORG_acc.fraud_transaction_date%24) as Fraud_transaction_hour,
(ORG_acc.send_transaction_date/24)+1 as send_transaction_day,
(ORG_acc.send_transaction_date%24) as send_transaction_hour
from origin_account ORG_acc
