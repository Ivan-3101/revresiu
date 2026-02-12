create or replace function is_valid_json(p_json text)
  returns boolean
as
$$
begin
  return (p_json::json is not null);
exception
  when others then
     return false;
end;
$$
language plpgsql
immutable;




UPDATE camunda.act_ge_bytearray
SET  bytes_=
REGEXP_REPLACE(encode(bytes_, 'escape'),
'{{cardaddress}}', '"{{cardaddress}}"','g')::bytea
WHERE name_ ='Transaction' and is_valid_json(encode(bytes_, 'escape'))
= false;


UPDATE camunda.act_ge_bytearray
SET  bytes_=
REGEXP_REPLACE(encode(bytes_, 'escape'),
'{{merchantaddress}}', '"{{merchantaddress}}"','g')::bytea
WHERE name_ ='Transaction' and is_valid_json(encode(bytes_, 'escape'))
= false;


UPDATE camunda.act_ge_bytearray
SET  bytes_=
REGEXP_REPLACE(encode(bytes_, 'escape'),
'{{onBoardedBy}}', '"{{onBoardedBy}}"','g')::bytea
WHERE name_ ='Transaction' and is_valid_json(encode(bytes_, 'escape'))
= false;



UPDATE camunda.act_ge_bytearray
SET  bytes_=
REGEXP_REPLACE(encode(bytes_, 'escape'),
'{{AMLTEST2}}', '"{{AMLTEST2}}"','g')::bytea
WHERE name_ ='Transaction' and is_valid_json(encode(bytes_, 'escape'))
= false;


UPDATE camunda.act_ge_bytearray
SET  bytes_=
REGEXP_REPLACE(encode(bytes_, 'escape'),
'{{YESBANK18}}', '"{{YESBANK18}}"','g')::bytea
WHERE name_ ='Transaction' and is_valid_json(encode(bytes_, 'escape'))
= false;


UPDATE camunda.act_ge_bytearray
SET  bytes_=
REGEXP_REPLACE(encode(bytes_, 'escape'),
'{{YESBANK19}}', '"{{YESBANK19}}"','g')::bytea
WHERE name_ ='Transaction' and is_valid_json(encode(bytes_, 'escape'))
= false;

UPDATE camunda.act_ge_bytearray
SET  bytes_=
REGEXP_REPLACE(encode(bytes_, 'escape'),
'{{AMLRULE1}}', '"{{AMLRULE1}}"','g')::bytea
WHERE name_ ='Transaction' and is_valid_json(encode(bytes_, 'escape'))
= false;


UPDATE camunda.act_ge_bytearray
SET  bytes_=
REGEXP_REPLACE(encode(bytes_, 'escape'),
'{{MID}}', '"{{MID}}"','g')::bytea
WHERE name_ ='Transaction' and is_valid_json(encode(bytes_, 'escape'))
= false;

UPDATE camunda.act_ge_bytearray
SET  bytes_=
REGEXP_REPLACE(encode(bytes_, 'escape'),
'{{timestamp}}', '"{{timestamp}}"','g')::bytea
WHERE name_ ='Transaction' and is_valid_json(encode(bytes_, 'escape'))
= false;




UPDATE camunda.act_ge_bytearray
SET  bytes_=
REGEXP_REPLACE(encode(bytes_, 'escape'),
'{{settlement_mode}}', '"{{settlement_mode}}"','g')::bytea
WHERE name_ ='Transaction' and is_valid_json(encode(bytes_, 'escape'))
= false;



UPDATE camunda.act_ge_bytearray
SET  bytes_=
REGEXP_REPLACE(encode(bytes_, 'escape'),
'{{addhaar}}', '"{{addhaar}}"','g')::bytea
WHERE name_ ='Transaction' and is_valid_json(encode(bytes_, 'escape'))
= false;

UPDATE camunda.act_ge_bytearray
SET  bytes_=
REGEXP_REPLACE(encode(bytes_, 'escape'),
'{,', '{",','g')::bytea
WHERE name_ ='Transaction' and is_valid_json(encode(bytes_, 'escape'))
= false;

UPDATE camunda.act_ge_bytearray
SET  bytes_=
REGEXP_REPLACE(encode(bytes_, 'escape'),
'{",', '"{",','g')::bytea
WHERE name_ ='Transaction' and is_valid_json(encode(bytes_, 'escape'))
= false;

UPDATE camunda.act_ge_bytearray
SET  bytes_=
REGEXP_REPLACE(encode(bytes_, 'escape'),
'{{"', '"{{"','g')::bytea
WHERE name_ ='Transaction' and is_valid_json(encode(bytes_, 'escape'))
= false;



UPDATE camunda.act_ge_bytearray
SET  bytes_=
REGEXP_REPLACE(encode(bytes_, 'escape'),
'{{POSEM}}', '"{{POSEM}}"','g')::bytea
WHERE name_ ='Transaction' and is_valid_json(encode(bytes_, 'escape'))
= false;

UPDATE camunda.act_ge_bytearray
SET  bytes_=
REGEXP_REPLACE(encode(bytes_, 'escape'),
'{{TERMINALTYPE}}', '"{{TERMINALTYPE}}"','g')::bytea
WHERE name_ ='Transaction' and is_valid_json(encode(bytes_, 'escape'))
= false;


UPDATE camunda.act_ge_bytearray
SET  bytes_=
REGEXP_REPLACE(encode(bytes_, 'escape'),
'"Status{statusCode=1}', '"Status{statusCode=1}"','g')::bytea
WHERE name_ ='Transaction' and is_valid_json(encode(bytes_, 'escape'))
= false;


UPDATE camunda.act_ge_bytearray
SET  bytes_=
REGEXP_REPLACE(encode(bytes_, 'escape'),
'{{parth1}}', '"{{parth1}}"','g')::bytea
WHERE name_ ='Transaction' and is_valid_json(encode(bytes_, 'escape'))
= false;

UPDATE camunda.act_ge_bytearray
SET  bytes_=
REPLACE(encode(bytes_, 'escape'),
'{{38699}}', '"{{38699}}"')::bytea
WHERE name_ ='Transaction' and is_valid_json(encode(bytes_, 'escape'))
= false;

UPDATE camunda.act_ge_bytearray
SET  bytes_=
REPLACE(encode(bytes_, 'escape'),
'{{YESBANK15}}', '"{{YESBANK15}}"')::bytea
WHERE name_ ='Transaction' and is_valid_json(encode(bytes_, 'escape'))
= false;


UPDATE camunda.act_ge_bytearray
SET  bytes_=
REPLACE(encode(bytes_, 'escape'),
'{{YESBANK17}}', '"{{YESBANK17}}"')::bytea
WHERE name_ ='Transaction' and is_valid_json(encode(bytes_, 'escape'))
= false;


UPDATE camunda.act_ge_bytearray
SET  bytes_=
REPLACE(encode(bytes_, 'escape'),
'{{YESBANK23}}', '"{{YESBANK23}}"')::bytea
WHERE name_ ='Transaction' and is_valid_json(encode(bytes_, 'escape'))
= false;

UPDATE camunda.act_ge_bytearray
SET  bytes_=
REPLACE(encode(bytes_, 'escape'),
'"rn"', '')::bytea
WHERE name_ ='Transaction' and is_valid_json(encode(bytes_, 'escape'))
= false;



UPDATE camunda.act_ge_bytearray
SET  bytes_=
REGEXP_REPLACE(encode(bytes_, 'escape'),
'rn', '','g')::bytea
WHERE name_ ='Transaction' and is_valid_json(encode(bytes_, 'escape'))
= false;


UPDATE camunda.act_ge_bytearray
SET  bytes_=
REGEXP_REPLACE(encode(bytes_, 'escape'),
'{{txntype}}', '"{{txntype}}"','g')::bytea
WHERE name_ ='Transaction' and is_valid_json(encode(bytes_, 'escape'))
= false;


UPDATE camunda.act_ge_bytearray
SET  bytes_=
REGEXP_REPLACE(encode(bytes_, 'escape'),
'"{{onBoardedBy}}""', '"{{onBoardedBy}}"','g')::bytea
WHERE name_ ='Transaction' and is_valid_json(encode(bytes_, 'escape'))
= false;


UPDATE camunda.act_ge_bytearray
SET  bytes_=
REGEXP_REPLACE(encode(bytes_, 'escape'),
'{{AMLTEST3}}', '"{{AMLTEST3}}"','g')::bytea
WHERE name_ ='Transaction' and is_valid_json(encode(bytes_, 'escape'))
= false;


UPDATE camunda.act_ge_bytearray
SET  bytes_=
REPLACE(encode(bytes_, 'escape'),
'{{$cardaddress}}', '"{{$cardaddress}}"')::bytea
WHERE name_ ='Transaction' and is_valid_json(encode(bytes_, 'escape'))
= false;


UPDATE camunda.act_ge_bytearray
SET  bytes_=
REPLACE(encode(bytes_, 'escape'),
'{{$&merchantaddress}}', '"{{$&merchantaddress}}"')::bytea
WHERE name_ ='Transaction' and is_valid_json(encode(bytes_, 'escape'))
= false;



UPDATE camunda.act_ge_bytearray
SET  bytes_=
REPLACE(encode(bytes_, 'escape'),
'""United States""', '"United States"')::bytea
WHERE name_ ='Transaction' and is_valid_json(encode(bytes_, 'escape'))
= false;



UPDATE camunda.act_ge_bytearray
SET  bytes_=
REPLACE(encode(bytes_, 'escape'),
'{{txn_type}}', '"{{txn_type}}"')::bytea
WHERE name_ ='Transaction' and is_valid_json(encode(bytes_, 'escape'))
= false;



UPDATE camunda.act_ge_bytearray
SET  bytes_=
REPLACE(encode(bytes_, 'escape'),
'{{remarks}}', '"{{remarks}}"')::bytea
WHERE name_ ='Transaction' and is_valid_json(encode(bytes_, 'escape'))
= false;



UPDATE camunda.act_ge_bytearray
SET  bytes_=
REPLACE(encode(bytes_, 'escape'),
'{{CARD111}}', '"{{CARD111}}"')::bytea
WHERE name_ ='Transaction' and is_valid_json(encode(bytes_, 'escape'))
= false;


UPDATE camunda.act_ge_bytearray
SET  bytes_=
REPLACE(encode(bytes_, 'escape'),
'{{&merchantaddress}}', '"{{&merchantaddress}}"')::bytea
WHERE name_ ='Transaction' and is_valid_json(encode(bytes_, 'escape'))
= false;



UPDATE camunda.act_ge_bytearray
SET  bytes_=
REPLACE(encode(bytes_, 'escape'),
'{"{"', '"{{"')::bytea
WHERE name_ ='Transaction' and is_valid_json(encode(bytes_, 'escape'))
= false;



UPDATE camunda.act_ge_bytearray
SET  bytes_=
REPLACE(encode(bytes_, 'escape'),
'{{payeraddress}}', '"{{payeraddress}}"')::bytea
WHERE name_ ='Transaction' and is_valid_json(encode(bytes_, 'escape'))
= false;


UPDATE camunda.act_ge_bytearray
SET  bytes_=
REPLACE(encode(bytes_, 'escape'),
'{{payeeaddress}}', '"{{payeeaddress}}"')::bytea
WHERE name_ ='Transaction' and is_valid_json(encode(bytes_, 'escape'))
= false;


UPDATE camunda.act_ge_bytearray
SET  bytes_=
REPLACE(encode(bytes_, 'escape'),
'{{EFT11}}', '"{{EFT11}}"')::bytea
WHERE name_ ='Transaction' and is_valid_json(encode(bytes_, 'escape'))
= false;


UPDATE camunda.act_ge_bytearray
SET  bytes_=
REPLACE(encode(bytes_, 'escape'),
'{{38714}}', '"{{38714}}"')::bytea
WHERE name_ ='Transaction' and is_valid_json(encode(bytes_, 'escape'))
= false;


UPDATE camunda.act_ge_bytearray
SET  bytes_=
REPLACE(encode(bytes_, 'escape'),
'{{AMLTEST1}}', '"{{AMLTEST1}}"')::bytea
WHERE name_ ='Transaction' and is_valid_json(encode(bytes_, 'escape'))
= false;





UPDATE camunda.act_ge_bytearray
SET  bytes_=
REPLACE(encode(bytes_, 'escape'),
'""United Kingdom""', '"United Kingdom"')::bytea
WHERE name_ ='Transaction' and is_valid_json(encode(bytes_, 'escape'))
= false;




UPDATE camunda.act_ge_bytearray
SET  bytes_=
REPLACE(encode(bytes_, 'escape'),
'{$randomFirstName}}@UPI"', '"{$randomFirstName}}@UPI"')::bytea
WHERE name_ ='Transaction' and is_valid_json(encode(bytes_, 'escape'))
= false;


UPDATE camunda.act_ge_bytearray
SET  bytes_=
REPLACE(encode(bytes_, 'escape'),
'{{CARD11}}', '"{{CARD11}}"')::bytea
WHERE name_ ='Transaction' and is_valid_json(encode(bytes_, 'escape'))
= false;


UPDATE camunda.act_ge_bytearray
SET  bytes_=
REPLACE(encode(bytes_, 'escape'),
'{{YESBANK21}}', '"{{YESBANK21}}"')::bytea
WHERE name_ ='Transaction' and is_valid_json(encode(bytes_, 'escape'))
= false;


UPDATE camunda.act_ge_bytearray
SET  bytes_=
REPLACE(encode(bytes_, 'escape'),
'{{YESBANK5}}', '"{{YESBANK5}}"')::bytea
WHERE name_ ='Transaction' and is_valid_json(encode(bytes_, 'escape'))
= false;



UPDATE camunda.act_ge_bytearray
SET  bytes_=
REPLACE(encode(bytes_, 'escape'),
'"bd6169b6-cc55-4457-8c12-01b9fbc9a82a97495f23-036c-4953-aa3d-b4310374fbfd}', '"bd6169b6-cc55-4457-8c12-01b9fbc9a82a97495f23-036c-4953-aa3d-b4310374fbfd}"')::bytea
WHERE name_ ='Transaction' and is_valid_json(encode(bytes_, 'escape'))
= false;


UPDATE camunda.act_ge_bytearray
SET  bytes_=
REPLACE(encode(bytes_, 'escape'),
'{{YESBANK26}}', '"{{YESBANK26}}"')::bytea
WHERE name_ ='Transaction' and is_valid_json(encode(bytes_, 'escape'))
= false;
