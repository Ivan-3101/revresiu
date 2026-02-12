UPDATE ui.taskfiltermaster SET
vcerrorname = 'Date Range'::character varying WHERE
itaskfilterid = 2;


UPDATE ui.taskfiltermaster
	SET  brequired=false;

UPDATE ui.taskfiltermaster SET
vcerrorname = 'Case Type'::character varying WHERE
itaskfilterid = 1;