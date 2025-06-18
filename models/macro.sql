select
  payment_id as id,
  {{ cents_to_dollars('amount') }} as amount_usd
from {{ source('databricks', 'payment') }}