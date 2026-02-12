ALTER TABLE ui.metadataaudit ADD COLUMN imetadataid INTEGER, ADD CONSTRAINT fk_audit_imetadataid FOREIGN KEY(imetadataid) REFERENCES ui.metadata(imetadataid); 

ALTER TABLE ui.metadata ALTER COLUMN imetadataid DROP IDENTITY;

ALTER TABLE IF EXISTS ui.dashboardcustomlayout
    ADD COLUMN itenantid integer;
	
ALTER TABLE IF EXISTS ui.dashboardcustomlayoutaudit
    ADD COLUMN itenantid integer;