-- 1. Update ALL group IDs to include tenant suffix, EXCLUDING system groups
UPDATE ui.groupdesc
SET vcgroupid = vcgroupid || '_' || itenantid
WHERE vcgroupid NOT IN ('usermgmt');

-- 2. Insert tenant-specific groups and group authorization
DO $$
DECLARE
    tenant_record RECORD;
BEGIN
    RAISE NOTICE 'Starting migration for ALL tenants';

    -- Process ALL tenants automatically
    FOR tenant_record IN
        SELECT DISTINCT itenantid
        FROM ui.groupdesc
        WHERE vcgroupid NOT IN ('usermgmt')
        AND itenantid IS NOT NULL
        ORDER BY itenantid
    LOOP
        RAISE NOTICE 'Processing tenant: %', tenant_record.itenantid;

        -- Insert tenant-specific groups into Camunda
        INSERT INTO camunda.act_id_group (id_, rev_, name_, type_)
        SELECT vcgroupid, 1, vcgroupname, 'WORKFLOW'
        FROM ui.groupdesc
        WHERE itenantid = tenant_record.itenantid
        AND vcgroupid NOT IN ('usermgmt')
        AND vcgroupid NOT IN (SELECT id_ FROM camunda.act_id_group)
		group by vcgroupid, vcgroupname;

        -- Add group authorization
        INSERT INTO camunda.act_ru_authorization(id_, rev_, type_, group_id_, resource_type_, resource_id_, perms_)
        SELECT
            gen_random_uuid()::VARCHAR,
            1,
            1,
            vcgroupid,
            2,
            vcgroupid,
            2
        FROM ui.groupdesc
        WHERE itenantid = tenant_record.itenantid
        AND vcgroupid NOT IN ('usermgmt')
        AND vcgroupid NOT IN (
            SELECT DISTINCT group_id_
            FROM camunda.act_ru_authorization
            WHERE group_id_ IS NOT NULL
        ) group by vcgroupid;
    END LOOP;

    RAISE NOTICE 'Migration completed for ALL tenants';
END $$;

-- 3. Update User-Group Mappings

INSERT INTO camunda.act_id_membership (USER_ID_, GROUP_ID_)
SELECT
    CAST(usermap.webuserid AS VARCHAR),
    groupdesc.vcgroupid
FROM ui.webusermapping usermap
INNER JOIN ui.groupdesc ON groupdesc.igroupid = usermap.mappingid AND groupdesc.itenantid = usermap.itenantid
INNER JOIN camunda.act_id_user camunda_user ON camunda_user.id_ = CAST(usermap.webuserid AS VARCHAR) -- ONLY existing Camunda users
WHERE usermap.mappingtype = 'Group'
    AND groupdesc.vcgroupid NOT IN ('usermgmt')
ORDER BY mappingid ASC, mappingtype ASC, webuserid ASC;