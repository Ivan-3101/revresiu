 ALTER TABLE IF EXISTS ui.observationwindowsuiaudit
    ADD COLUMN idexpr text;

ALTER TABLE IF EXISTS ui.observationwindowsuiaudit
    ADD COLUMN tsexpr text;

ALTER TABLE IF EXISTS ui.observationwindowsui
    ADD COLUMN idexpr text;

ALTER TABLE IF EXISTS ui.observationwindowsui
    ADD COLUMN tsexpr text;