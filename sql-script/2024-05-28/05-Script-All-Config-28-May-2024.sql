INSERT INTO ui.masterconfig (
iconfigid, bdelete, configjson, configname) VALUES (
'5'::integer, false::boolean, '[{"label":"COUNT","value":"COUNT"},{"label":"SUM","value":"SUM"},{"label":"COUNT_IF","value":"COUNT_IF"},{"label":"SUM_IF","value":"SUM_IF"},{"label":"COUNT_UNIQUE","value":"COUNT_UNIQUE"},{"label":"COUNT_ALIKE","value":"COUNT_ALIKE"},{"label":"LAST_KNOWN","value":"LAST_KNOWN"}]'::jsonb, 'Observation Aggregation Dropdown'::character varying);


UPDATE ui.validationfieldslist
SET vcvalidation = NULL
WHERE vcfielddisplayname = 'Payer Card' OR vcfielddisplayname = 'Payee Card';
