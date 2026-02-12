UPDATE ui.orgs
SET attribs = jsonb_set(
    attribs,
    '{caseManagementConfig}',
    '{
        "dropdownConfig": {
            "closed": {
                "actualLabel": "Recently closed"
            },
            "myclosed": {
                "actualLabel": "Recently Closed by me"
            }
        }
    }'::jsonb,
    true
)
WHERE iorgid = 10;
