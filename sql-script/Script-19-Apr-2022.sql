ALTER SEQUENCE ui.ticket_seq RESTART WITH 1;
DELETE FROM ui.ticketidgenerator;
ALTER TABLE ui.ticketidgenerator Drop ticketid;
ALTER TABLE ui.ticketidgenerator add ticketid bigint DEFAULT nextval('ui.ticket_seq'::regclass) NOT NULL;
ALTER TABLE ui.ticketidgenerator add processinstanceid character varying(255) NOT NULL;
