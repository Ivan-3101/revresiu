DROP TYPE IF EXISTS transactions.decisiondetail;

CREATE TYPE transactions.decisiondetail AS
(
	score numeric,
	ruleno numeric,
	side text,
	rulename text
);
