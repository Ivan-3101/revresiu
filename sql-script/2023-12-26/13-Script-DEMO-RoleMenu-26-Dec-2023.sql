INSERT INTO ui.rolemenuaccessmap(
	 badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, 
	iroleid)
SELECT true, true, true, true, true, true, true, 575, iroleid FROM ui.roledesc where iroleid > 1;

INSERT INTO ui.rolemenuaccessmap(
	 badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, 
	iroleid)
SELECT true, true, true, true, true, true, true, 576, iroleid FROM ui.roledesc where iroleid > 1;

INSERT INTO ui.rolemenuaccessmap(
	 badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, 
	iroleid)
SELECT true, true, true, true, true, true, true, 480, iroleid FROM ui.roledesc where iroleid > 1;