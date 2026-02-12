UPDATE ui.tenants SET
vctenantid = 'PAYOUTS'::character varying WHERE
itenantid = 23;
UPDATE ui.tenants SET
vctenantid = 'GIFTCARD'::character varying WHERE
itenantid = 22;
UPDATE ui.tenants SET
vctenantid = 'PMTAGG'::character varying WHERE
itenantid = 21;
UPDATE masters.tenants SET
vctenantid = 'PAYOUTS'::character varying WHERE
itenantid = 23;
UPDATE masters.tenants SET
vctenantid = 'GIFTCARD'::character varying WHERE
itenantid = 22;
UPDATE masters.tenants SET
vctenantid = 'PMTAGG'::character varying WHERE
itenantid = 21;
UPDATE camunda.act_id_tenant SET name_ = 'PAYOUTS' WHERE id_ = '23';
UPDATE camunda.act_id_tenant SET name_ = 'GIFTCARD' WHERE id_ = '22';
UPDATE camunda.act_id_tenant SET name_ = 'PMTAGG' WHERE id_ = '21' ;