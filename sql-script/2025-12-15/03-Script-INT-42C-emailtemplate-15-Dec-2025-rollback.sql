-- Rollback for tenant 24
DELETE FROM ui.emailtemplate
WHERE id IN (1, 2)
  AND itenantid = 24;

-- Rollback for tenant 20
DELETE FROM ui.emailtemplate
WHERE id IN (1, 2)
  AND itenantid = 20;