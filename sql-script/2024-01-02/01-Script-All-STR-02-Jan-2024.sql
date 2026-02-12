ALTER table ui.formmaster add column itenantid integer;
update ui.formmaster set itenantid=1;
alter table ui.formmaster drop constraint  formmaster_pkey cascade;
alter table ui.formmaster add constraint formmaster_pkey primary key(ifromid, itenantid);
ALTER table ui.formmaster drop constraint uk_olfhqb97urkv2cjy4ch22qbmq;

