UPDATE ui.groupdesc
	SET vcgroupid='riskanalyst', vcgroupname='Risk Analyst', vcgrouptype='WORKFLOW'
	WHERE igroupid=1020;
	
UPDATE ui.groupdesc
	SET vcgroupid='risksupervisor', vcgroupname='Risk Supervisor', vcgrouptype='WORKFLOW'
	WHERE igroupid=1021;

UPDATE ui.webuser
	SET vcusername='cadmin', vcfirstname='cadmin', vclastname='cadmin', vcemailid='cadmin@dronapay.com'
	WHERE iuserid=1;
	
UPDATE ui.webuser
	SET vcusername='madmin', vcfirstname='madmin', vclastname='madmin', vcemailid='madmin@dronapay.com'
	WHERE iuserid=2;