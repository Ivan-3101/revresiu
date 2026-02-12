UPDATE camunda.act_ge_bytearray
SET  bytes_= REGEXP_REPLACE(
REGEXP_REPLACE(REGEXP_REPLACE(encode(bytes_, 'escape'),
'"{', '{','g'), '}"', '}','g'),  '\\', '', 'g')::bytea
WHERE name_ ='Transaction';