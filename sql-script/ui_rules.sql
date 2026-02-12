UPDATE ui.rules 
SET 
vcrulename = masterrules.vcrulename,
vcruledescription = masterrules.vcruledescription,
vcruledetail = masterrules.vcruledetail,
iversion = masterrules.iversion,
dtstartdate = masterrules.dtstartdate,
vcrulemapinfo = masterrules.vcrulemapinfo,
vcbpmnfilelocation = masterrules.vcbpmnfilelocation,
bactive = masterrules.bactive,
dtentrydatetime = masterrules.dtentrydatetime,
iuserid = masterrules.iuserid,
vcruleparams = masterrules.vcruleparams,
vcruleorder = masterrules.vcruleorder,
bcustom = masterrules.bcustom,
bdelete = masterrules.bdelete 
FROM (
    SELECT iruleid, idecisionid, vcrulename, vcruledescription, vcruledetail, iversion, dtstartdate, vcrulemapinfo, vcbpmnfilelocation, bactive, dtentrydatetime, iuserid, vcruleparams, vcruleorder, bcustom, bdelete
	FROM masters.rules) AS masterrules
WHERE 
    masterrules.iruleid = ui.rules.iruleid;


INSERT INTO ui.rules(iruleid, bactive, bcustom, bdelete, dtentrydatetime, dtstartdate, iversion, vcbpmnfilelocation, vcruledescription, vcruledetail, vcrulemapinfo, vcrulename, vcruleorder, vcruleparams, idecisionid, iuserid)
	 (select iruleid, bactive, bcustom, bdelete, dtentrydatetime, dtstartdate, iversion, vcbpmnfilelocation, vcruledescription, vcruledetail, vcrulemapinfo, vcrulename, vcruleorder, vcruleparams, idecisionid, iuserid from masters.rules where iruleid not in (select iruleid from ui.rules)
);


UPDATE ui.rules 
SET 
iruleavailableid = availablerule.iruleavailableid,
vclabel = availablerule.vclabel,
ruledimension = availablerule.ruledimension,
rulestate = availablerule.rulestate,
vcruletype = availablerule.vcruletype
from
(select vcrulename, iruleavailableid, vclabel, ruledimension, rulestate, vcruletype 
from masters.rulesavailable) as availablerule
where availablerule.vcrulename =  ui.rules.vcrulename 
	
