UPDATE camunda.act_hi_actinst
	SET assignee_= case when (SELECT
case
	when iuserid is not null
	then iuserid::varchar
	else
				   case when id_ is not null
				   then id_
				   else assignee_
				   end
end
 FROM camunda.act_id_user
 left join ui.webuser on vcusername = id_ and istatus = 1 where id_ = assignee_) is not null
 then
 (SELECT
case
	when iuserid is not null
	then iuserid::varchar
	else
				   case when id_ is not null
				   then id_
				   else assignee_
				   end
end
 FROM camunda.act_id_user
 left join ui.webuser on vcusername = id_ and istatus = 1 where id_ = assignee_)
 else
 assignee_
 end ;



UPDATE camunda.act_hi_attachment
	SET description_ =  jsonb_set(cast(description_ as jsonb), '{user}',
	cast('"'||case when (SELECT
case
	when iuserid is not null
	then iuserid::varchar
	else
				   case when id_ is not null
				   then id_
				   else cast(description_ as json)->>'user'
				   end
end
 FROM camunda.act_id_user
 left join ui.webuser on vcusername = id_ and istatus = 1 where id_ = cast(description_ as json)->>'user' ) is not null
 then
 (SELECT
case
	when iuserid is not null
	then iuserid::varchar
	else
				   case when id_ is not null
				   then id_
				   else cast(description_ as json)->>'user'
				   end
end
 FROM camunda.act_id_user
 left join ui.webuser on vcusername = id_ and istatus = 1 where id_ = cast(description_ as json)->>'user')
 else
 cast(description_ as json)->>'user'
 end||'"' as jsonb), false);



UPDATE camunda.act_hi_batch
	SET create_user_id_= case when (SELECT
case
	when iuserid is not null
	then iuserid::varchar
	else
				   case when id_ is not null
				   then id_
				   else create_user_id_
				   end
end
 FROM camunda.act_id_user
 left join ui.webuser on vcusername = id_ and istatus = 1 where id_ = create_user_id_) is not null
 then
 (SELECT
case
	when iuserid is not null
	then iuserid::varchar
	else
				   case when id_ is not null
				   then id_
				   else create_user_id_
				   end
end
 FROM camunda.act_id_user
 left join ui.webuser on vcusername = id_ and istatus = 1 where id_ = create_user_id_)
 else
 create_user_id_
 end ;


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


UPDATE camunda.act_hi_comment
	SET full_msg_ = case
	when is_valid_json(encode(full_msg_, 'escape'))
	then
	cast(jsonb_set(cast(encode(full_msg_, 'escape') as jsonb), '{user}',
	cast('"'||case when (SELECT
case
	when iuserid is not null
	then iuserid::varchar
	else
				   case when id_ is not null
				   then id_
				   else cast(encode(full_msg_, 'escape') as json)->>'user'
				   end
end
 FROM camunda.act_id_user
 left join ui.webuser on vcusername = id_ and istatus = 1 where id_ = cast(encode(full_msg_, 'escape') as json)->>'user' ) is not null
 then
 (SELECT
case
	when iuserid is not null
	then iuserid::varchar
	else
				   case when id_ is not null
				   then id_
				   else cast(encode(full_msg_, 'escape') as json)->>'user'
				   end
end
 FROM camunda.act_id_user
 left join ui.webuser on vcusername = id_ and istatus = 1 where id_ = cast(encode(full_msg_, 'escape') as json)->>'user')
 else
 cast(encode(full_msg_, 'escape') as json)->>'user'
 end||'"' as jsonb), false) as text)::bytea

 else
 full_msg_
 end
 ;



UPDATE camunda.act_hi_comment
	SET user_id_= case when (SELECT
case
	when iuserid is not null
	then iuserid::varchar
	else
				   case when id_ is not null
				   then id_
				   else user_id_
				   end
end
 FROM camunda.act_id_user
 left join ui.webuser on vcusername = id_ and istatus = 1 where id_ = user_id_) is not null
 then
 (SELECT
case
	when iuserid is not null
	then iuserid::varchar
	else
				   case when id_ is not null
				   then id_
				   else user_id_
				   end
end
 FROM camunda.act_id_user
 left join ui.webuser on vcusername = id_ and istatus = 1 where id_ = user_id_)
 else
 user_id_
 end, message_=substring( encode(full_msg_, 'escape') from 0 for 4000);










UPDATE camunda.act_hi_detail
	SET text_ = case
	when is_valid_json(text_) and cast(text_ as jsonb)->>'user' is not null
	then
	cast(jsonb_set(cast(text_ as jsonb), '{user}',
	cast('"'||case when (SELECT
case
	when iuserid is not null
	then iuserid::varchar
	else
				   case when id_ is not null
				   then id_
				   else cast(text_ as json)->>'user'
				   end
end
 FROM camunda.act_id_user
 left join ui.webuser on vcusername = id_ and istatus = 1 where id_ = cast(text_ as json)->>'user' ) is not null
 then
 (SELECT
case
	when iuserid is not null
	then iuserid::varchar
	else
				   case when id_ is not null
				   then id_
				   else cast(text_ as json)->>'user'
				   end
end
 FROM camunda.act_id_user
 left join ui.webuser on vcusername = id_ and istatus = 1 where id_ = cast(text_ as json)->>'user')
 else
 cast(text_ as json)->>'user'
 end||'"' as jsonb), false) as text)

 else
 text_
 end
  where name_ = 'userActivity' ;




  UPDATE camunda.act_hi_identitylink
  	SET user_id_= case when (SELECT
  case
  	when iuserid is not null
  	then iuserid::varchar
  	else
  				   case when id_ is not null
  				   then id_
  				   else user_id_
  				   end
  end
   FROM camunda.act_id_user
   left join ui.webuser on vcusername = id_ and istatus = 1 where id_ = user_id_) is not null
   then
   (SELECT
  case
  	when iuserid is not null
  	then iuserid::varchar
  	else
  				   case when id_ is not null
  				   then id_
  				   else user_id_
  				   end
  end
   FROM camunda.act_id_user
   left join ui.webuser on vcusername = id_ and istatus = 1 where id_ = user_id_)
   else
   user_id_
   end,


   assigner_id_= case when (SELECT
  case
  	when iuserid is not null
  	then iuserid::varchar
  	else
  				   case when id_ is not null
  				   then id_
  				   else assigner_id_
  				   end
  end
   FROM camunda.act_id_user
   left join ui.webuser on vcusername = id_ and istatus = 1 where id_ = assigner_id_) is not null
   then
   (SELECT
  case
  	when iuserid is not null
  	then iuserid::varchar
  	else
  				   case when id_ is not null
  				   then id_
  				   else assigner_id_
  				   end
  end
   FROM camunda.act_id_user
   left join ui.webuser on vcusername = id_ and istatus = 1 where id_ = assigner_id_)
   else
   assigner_id_
   end  ;





UPDATE camunda.act_hi_op_log
	SET user_id_= case when (SELECT
case
	when iuserid is not null
	then iuserid::varchar
	else
				   case when id_ is not null
				   then id_
				   else user_id_
				   end
end
 FROM camunda.act_id_user
 left join ui.webuser on vcusername = id_ and istatus = 1 where id_ = user_id_) is not null
 then
 (SELECT
case
	when iuserid is not null
	then iuserid::varchar
	else
				   case when id_ is not null
				   then id_
				   else user_id_
				   end
end
 FROM camunda.act_id_user
 left join ui.webuser on vcusername = id_ and istatus = 1 where id_ = user_id_)
 else
 user_id_
 end ;





UPDATE camunda.act_hi_op_log
SET org_value_= case when (SELECT
case
when iuserid is not null
then iuserid::varchar
else
			   case when id_ is not null
			   then id_
			   else org_value_
			   end
end
FROM camunda.act_id_user
left join ui.webuser on vcusername = id_ and istatus = 1 where id_ = org_value_) is not null
then
(SELECT
case
when iuserid is not null
then iuserid::varchar
else
			   case when id_ is not null
			   then id_
			   else org_value_
			   end
end
FROM camunda.act_id_user
left join ui.webuser on vcusername = id_ and istatus = 1 where id_ = org_value_)
else
org_value_
end,


new_value_= case when (SELECT
case
when iuserid is not null
then iuserid::varchar
else
			   case when id_ is not null
			   then id_
			   else new_value_
			   end
end
FROM camunda.act_id_user
left join ui.webuser on vcusername = id_ and istatus = 1 where id_ = new_value_) is not null
then
(SELECT
case
when iuserid is not null
then iuserid::varchar
else
			   case when id_ is not null
			   then id_
			   else new_value_
			   end
end
FROM camunda.act_id_user
left join ui.webuser on vcusername = id_ and istatus = 1 where id_ = new_value_)
else
new_value_
end  where property_ = 'assignee';



UPDATE camunda.act_hi_procinst
	SET start_user_id_= case when (SELECT
case
	when iuserid is not null
	then iuserid::varchar
	else
				   case when id_ is not null
				   then id_
				   else start_user_id_
				   end
end
 FROM camunda.act_id_user
 left join ui.webuser on vcusername = id_ and istatus = 1 where id_ = start_user_id_) is not null
 then
 (SELECT
case
	when iuserid is not null
	then iuserid::varchar
	else
				   case when id_ is not null
				   then id_
				   else start_user_id_
				   end
end
 FROM camunda.act_id_user
 left join ui.webuser on vcusername = id_ and istatus = 1 where id_ = start_user_id_)
 else
 start_user_id_
 end ;




UPDATE camunda.act_hi_taskinst
	SET assignee_= case when (SELECT
case
	when iuserid is not null
	then iuserid::varchar
	else
				   case when id_ is not null
				   then id_
				   else assignee_
				   end
end
 FROM camunda.act_id_user
 left join ui.webuser on vcusername = id_ and istatus = 1 where id_ = assignee_) is not null
 then
 (SELECT
case
	when iuserid is not null
	then iuserid::varchar
	else
				   case when id_ is not null
				   then id_
				   else assignee_
				   end
end
 FROM camunda.act_id_user
 left join ui.webuser on vcusername = id_ and istatus = 1 where id_ = assignee_)
 else
 assignee_
 end ;




UPDATE camunda.act_hi_varinst
	SET text_ = case
	when is_valid_json(text_) and cast(text_ as jsonb)->>'user' is not null
	then
	cast(jsonb_set(cast(text_ as jsonb), '{user}',
	cast('"'||case when (SELECT
case
	when iuserid is not null
	then iuserid::varchar
	else
				   case when id_ is not null
				   then id_
				   else cast(text_ as json)->>'user'
				   end
end
 FROM camunda.act_id_user
 left join ui.webuser on vcusername = id_ and istatus = 1 where id_ = cast(text_ as json)->>'user' ) is not null
 then
 (SELECT
case
	when iuserid is not null
	then iuserid::varchar
	else
				   case when id_ is not null
				   then id_
				   else cast(text_ as json)->>'user'
				   end
end
 FROM camunda.act_id_user
 left join ui.webuser on vcusername = id_ and istatus = 1 where id_ = cast(text_ as json)->>'user')
 else
 cast(text_ as json)->>'user'
 end||'"' as jsonb), false) as text)

 else
 text_
 end
  where name_ = 'userActivity'  ;



UPDATE camunda.act_ru_authorization
	SET user_id_= case when (SELECT
case
	when iuserid is not null
	then iuserid::varchar
	else
				   case when id_ is not null
				   then id_
				   else user_id_
				   end
end
 FROM camunda.act_id_user
 left join ui.webuser on vcusername = id_ and istatus = 1 where id_ = user_id_) is not null
 then
 (SELECT
case
	when iuserid is not null
	then iuserid::varchar
	else
				   case when id_ is not null
				   then id_
				   else user_id_
				   end
end
 FROM camunda.act_id_user
 left join ui.webuser on vcusername = id_ and istatus = 1 where id_ = user_id_)
 else
 user_id_
 end ;



UPDATE camunda.act_ru_task
SET assignee_= case when (SELECT
case
	when iuserid is not null
	then iuserid::varchar
	else
				   case when id_ is not null
				   then id_
				   else assignee_
				   end
end
 FROM camunda.act_id_user
 left join ui.webuser on vcusername = id_ and istatus = 1 where id_ = assignee_) is not null
 then
 (SELECT
case
	when iuserid is not null
	then iuserid::varchar
	else
				   case when id_ is not null
				   then id_
				   else assignee_
				   end
end
 FROM camunda.act_id_user
 left join ui.webuser on vcusername = id_ and istatus = 1 where id_ = assignee_)
 else
 assignee_
 end ;




UPDATE camunda.act_ru_variable
	SET text_ = case
	when is_valid_json(text_) and cast(text_ as jsonb)->>'user' is not null
	then
	cast(jsonb_set(cast(text_ as jsonb), '{user}',
	cast('"'||case when (SELECT
case
	when iuserid is not null
	then iuserid::varchar
	else
				   case when id_ is not null
				   then id_
				   else cast(text_ as json)->>'user'
				   end
end
 FROM camunda.act_id_user
 left join ui.webuser on vcusername = id_ and istatus = 1 where id_ = cast(text_ as json)->>'user' ) is not null
 then
 (SELECT
case
	when iuserid is not null
	then iuserid::varchar
	else
				   case when id_ is not null
				   then id_
				   else cast(text_ as json)->>'user'
				   end
end
 FROM camunda.act_id_user
 left join ui.webuser on vcusername = id_ and istatus = 1 where id_ = cast(text_ as json)->>'user')
 else
 cast(text_ as json)->>'user'
 end||'"' as jsonb), false) as text)

 else
 text_
 end
  where name_ = 'userActivity'  ;




SELECT  iuserid, count(iuserid)	FROM ui.webuser where istatus = 1 group by iuserid;




ALTER TABLE camunda.act_id_membership
DROP CONSTRAINT act_fk_memb_user;

alter table camunda.act_id_membership
ADD CONSTRAINT act_fk_memb_user FOREIGN KEY (user_id_)
        REFERENCES camunda.act_id_user (id_) MATCH SIMPLE
        ON UPDATE cascade
        ON DELETE NO ACTION;

ALTER TABLE camunda.act_id_tenant_member
DROP CONSTRAINT act_fk_tenant_memb_user;

alter table camunda.act_id_tenant_member
ADD CONSTRAINT act_fk_tenant_memb_user FOREIGN KEY (user_id_)
        REFERENCES camunda.act_id_user (id_) MATCH SIMPLE
        ON UPDATE cascade
        ON DELETE NO ACTION;


UPDATE camunda.act_id_user
	SET id_= case when (SELECT
case
	when iuserid is not null
	then iuserid::varchar
	else id_
end
 FROM ui.webuser where vcusername = id_ and istatus = 1 ) is not null
 then
 (SELECT
case
	when iuserid is not null
	then iuserid::varchar
	else id_
end
 FROM  ui.webuser where vcusername = id_ and istatus = 1 )
 else
 id_
 end ;


---update first name, last name, email
UPDATE camunda.act_id_user c1 SET first_= wb.vcfirstname,
last_=wb.vclastname, email_=wb.vcemailid
FROM ui.webuser wb WHERE c1.id_=wb.iuserid::varchar;






