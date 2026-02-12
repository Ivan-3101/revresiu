-- Update assignee_ in act_hi_actinst
UPDATE camunda.act_hi_actinst
SET assignee_ = (
    SELECT iuserid::varchar 
    FROM ui.webuser 
    WHERE vcusername = camunda.act_hi_actinst.assignee_ AND istatus = 4
)
WHERE EXISTS (
    SELECT 1 
    FROM ui.webuser 
    WHERE vcusername = camunda.act_hi_actinst.assignee_ AND istatus = 4
);

-- Update description_ in act_hi_attachment
UPDATE camunda.act_hi_attachment
SET description_ = jsonb_set(
    cast(description_ as jsonb), 
    '{user}', 
    cast('"' || (
        SELECT iuserid::varchar 
        FROM ui.webuser 
        WHERE vcusername = cast(description_ as json)->>'user' AND istatus = 4
    ) || '"' AS jsonb), 
    false
)
WHERE EXISTS (
    SELECT 1 
    FROM ui.webuser 
    WHERE vcusername = cast(description_ as json)->>'user' AND istatus = 4
);

-- Update create_user_id_ in act_hi_batch
UPDATE camunda.act_hi_batch
SET create_user_id_ = (
    SELECT iuserid::varchar 
    FROM ui.webuser 
    WHERE vcusername = camunda.act_hi_batch.create_user_id_ AND istatus = 4
)
WHERE EXISTS (
    SELECT 1 
    FROM ui.webuser 
    WHERE vcusername = camunda.act_hi_batch.create_user_id_ AND istatus = 4
);

-- Update user_id_ in act_hi_comment
UPDATE camunda.act_hi_comment
SET user_id_ = (
    SELECT iuserid::varchar 
    FROM ui.webuser 
    WHERE vcusername = camunda.act_hi_comment.user_id_ AND istatus = 4
)
WHERE EXISTS (
    SELECT 1 
    FROM ui.webuser 
    WHERE vcusername = camunda.act_hi_comment.user_id_ AND istatus = 4
);

-- Update user_id_ in act_hi_identitylink
UPDATE camunda.act_hi_identitylink
SET user_id_ = (
    SELECT iuserid::varchar 
    FROM ui.webuser 
    WHERE vcusername = camunda.act_hi_identitylink.user_id_ AND istatus = 4
)
WHERE EXISTS (
    SELECT 1 
    FROM ui.webuser 
    WHERE vcusername = camunda.act_hi_identitylink.user_id_ AND istatus = 4
);

-- Update assigner_id_ in act_hi_identitylink
UPDATE camunda.act_hi_identitylink
SET assigner_id_ = (
    SELECT iuserid::varchar 
    FROM ui.webuser 
    WHERE vcusername = camunda.act_hi_identitylink.assigner_id_ AND istatus = 4
)
WHERE EXISTS (
    SELECT 1 
    FROM ui.webuser 
    WHERE vcusername = camunda.act_hi_identitylink.assigner_id_ AND istatus = 4
);

-- Update user_id_ in act_hi_op_log
UPDATE camunda.act_hi_op_log
SET user_id_ = (
    SELECT iuserid::varchar 
    FROM ui.webuser 
    WHERE vcusername = camunda.act_hi_op_log.user_id_ AND istatus = 4
)
WHERE EXISTS (
    SELECT 1 
    FROM ui.webuser 
    WHERE vcusername = camunda.act_hi_op_log.user_id_ AND istatus = 4
);

-- Update org_value_ and new_value_ in act_hi_op_log
UPDATE camunda.act_hi_op_log
SET org_value_ = (
    SELECT iuserid::varchar 
    FROM ui.webuser 
    WHERE vcusername = camunda.act_hi_op_log.org_value_ AND istatus = 4
),
new_value_ = (
    SELECT iuserid::varchar 
    FROM ui.webuser 
    WHERE vcusername = camunda.act_hi_op_log.new_value_ AND istatus = 4
)
WHERE property_ = 'assignee' 
AND EXISTS (
    SELECT 1 
    FROM ui.webuser 
    WHERE vcusername IN (camunda.act_hi_op_log.org_value_, camunda.act_hi_op_log.new_value_) 
    AND istatus = 4
);

-- Update start_user_id_ in act_hi_procinst
UPDATE camunda.act_hi_procinst
SET start_user_id_ = (
    SELECT iuserid::varchar 
    FROM ui.webuser 
    WHERE vcusername = camunda.act_hi_procinst.start_user_id_ AND istatus = 4
)
WHERE EXISTS (
    SELECT 1 
    FROM ui.webuser 
    WHERE vcusername = camunda.act_hi_procinst.start_user_id_ AND istatus = 4
);

-- Update assignee_ in act_hi_taskinst
UPDATE camunda.act_hi_taskinst
SET assignee_ = (
    SELECT iuserid::varchar 
    FROM ui.webuser 
    WHERE vcusername = camunda.act_hi_taskinst.assignee_ AND istatus = 4
)
WHERE EXISTS (
    SELECT 1 
    FROM ui.webuser 
    WHERE vcusername = camunda.act_hi_taskinst.assignee_ AND istatus = 4
);

-- Update assignee_ in act_ru_task
UPDATE camunda.act_ru_task
SET assignee_ = (
    SELECT iuserid::varchar 
    FROM ui.webuser 
    WHERE vcusername = camunda.act_ru_task.assignee_ AND istatus = 4
)
WHERE EXISTS (
    SELECT 1 
    FROM ui.webuser 
    WHERE vcusername = camunda.act_ru_task.assignee_ AND istatus = 4
);

-- Update user_id_ in act_ru_authorization
UPDATE camunda.act_ru_authorization
SET user_id_ = (
    SELECT iuserid::varchar 
    FROM ui.webuser 
    WHERE vcusername = camunda.act_ru_authorization.user_id_ AND istatus = 4
)
WHERE EXISTS (
    SELECT 1 
    FROM ui.webuser 
    WHERE vcusername = camunda.act_ru_authorization.user_id_ AND istatus = 4
);

-- Update user_id_ in act_id_user
UPDATE camunda.act_id_user
SET id_ = (
    SELECT iuserid::varchar 
    FROM ui.webuser 
    WHERE vcusername = camunda.act_id_user.id_ AND istatus = 4
)
WHERE EXISTS (
    SELECT 1 
    FROM ui.webuser 
    WHERE vcusername = camunda.act_id_user.id_ AND istatus = 4
);

-- Update first name, last name, and email in act_id_user
UPDATE camunda.act_id_user 
SET first_ = wb.vcfirstname,
    last_ = wb.vclastname, 
    email_ = wb.vcemailid
FROM ui.webuser wb 
WHERE camunda.act_id_user.id_ = wb.iuserid::varchar;
