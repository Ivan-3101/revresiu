select * from pg_extension;

CREATE EXTENSION IF NOT EXISTS postgres_fdw;

select * from pg_foreign_server;

CREATE SERVER live_server FOREIGN DATA WRAPPER postgres_fdw OPTIONS (host 'localhost', port '5432', dbname 'sit', updatable 'false');

select * from pg_user_mapping;

CREATE USER MAPPING FOR appusersit SERVER live_server OPTIONS (user 'appusersit', password 'Drona!1234!Sit', password_required 'false');

GRANT USAGE ON FOREIGN SERVER live_server TO appusersit;

CREATE SCHEMA IF NOT EXISTS masters;

IMPORT FOREIGN SCHEMA masters LIMIT TO (vpa,decisions,rules,transactionclasses) FROM SERVER live_server INTO masters;

GRANT USAGE ON SCHEMA masters TO appusersit;
grant select on all tables in schema masters to appusersit;

select * from masters.rules;
select * from masters.vpa limit 100;
select * from masters.decisions;
select * from masters.transactionclasses;
