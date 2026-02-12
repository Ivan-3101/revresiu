delete from ui.panelaccessmap where groupid in (select igroupid from ui.groupdesc where itenantid>1);
delete from ui.grouptotaskfiltermap where igroupid in (select igroupid from ui.groupdesc where itenantid>1);
delete from ui.workflowmasters where itenantid>1;