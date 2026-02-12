-- 1. Remove tenant-specific user-group mappings
DELETE FROM camunda.act_id_membership
WHERE group_id_ ~ '_[0-9]+$';

-- 2. Remove tenant-specific group authorizations
DELETE FROM camunda.act_ru_authorization
WHERE group_id_ ~ '_[0-9]+$';

-- 3. Remove tenant-specific groups
DELETE FROM camunda.act_id_group
WHERE id_ ~ '_[0-9]+$';

-- 4. Restore original group IDs
UPDATE ui.groupdesc
SET vcgroupid = SUBSTRING(vcgroupid FROM '^[^_]+')
WHERE vcgroupid ~ '_[0-9]+$';
