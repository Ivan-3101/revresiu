UPDATE ui.perspectivequery
SET  vcquery='select d.dscore as "Score", d.dinfo as "Order", d.vcremark as "Remarks", r.vcrulename as "RuleName" from
transactions.decisiondetails d
left join masters.rules r on r.iruleid = d.iruleid
where vcmsgid  = :vcMsgID'
	WHERE iperspectivequeryid=36;