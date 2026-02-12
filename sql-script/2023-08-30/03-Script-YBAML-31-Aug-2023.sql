UPDATE ui.dashboardresultset SET
vcdashboardresultsetschema = '{
"Analyst Name":"string",
"Workflow Name":"string",
"#Closed Cases":"integer",
"#Cases Referred to DB":"integer",
"#Cases Referred to Branch":"integer",
"#Cases Escalated":"integer",
"Total Cases":"integer"
}
'::text WHERE
idashboardresultsetid = 28;

UPDATE ui.dashboardresultset SET
vcdashboardresultsetlayout = '{"sizes":[1],"detail":{"main":{"type":"tab-area","widgets":["PERSPECTIVE_GENERATED_ID_1"],"currentIndex":0}},"mode":"globalFilters","viewers":{"PERSPECTIVE_GENERATED_ID_1":{"plugin":"Datagrid","plugin_config":{"columns":{},"editable":false,"scroll_lock":false},"settings":false,"theme":"Pro Dark","title":"Daily Productivity Report","group_by":[],"split_by":[],"columns":["Analyst Name",
"Workflow Name",
"#Closed Cases",
"#Cases Referred to DB",
"#Cases Referred to Branch",
"#Cases Escalated",
"Total Cases"],"filter":[],"sort":[],"expressions":[],"aggregates":{},"master":false,"table":"dailyproductivityreport","linked":false}}} '::text WHERE
idashboardresultsetid = 28;

UPDATE ui.dashboardquery SET
vcdashboardquery = 'select taskl1l2.assignee_ as "Analyst Name", ''AML Cases'' as "Workflow Name",
sum(case when ActionV.text_=''notsuspicious'' then 1 else 0 end) as "#Closed Cases",
sum(case when ActionV.text_=''suspicioussendtodb'' then 1 else 0 end) as "#Cases Referred to DB",
sum(case when ActionV.text_=''suspicioussendtobranch'' then 1 else 0 end) as "#Cases Referred to Branch",
sum (case when ActionV.text_=''suspicious'' then 1 else 0 end) as "#Cases Escalated", 
sum(case when ActionV.text_ is not null then 1 else 0 end) as "Total Cases"
FROM (SELECT * FROM CAMUNDA.ACT_HI_PROCINST WHERE PROC_DEF_KEY_=''AMLCases'') AS PROC
INNER JOIN (SELECT distinct on (proc_inst_id_) * FROM CAMUNDA.ACT_HI_TASKINST WHERE NAME_ = ''Review Case By L1/ L2'' and assignee_ is not null order by proc_inst_id_, start_time_ desc) AS TASKL1L2
ON PROC.PROC_INST_ID_=TASKL1L2.PROC_INST_ID_
LEFT JOIN camunda.act_hi_varinst as ActionV
ON taskl1l2.proc_inst_id_=ActionV.proc_inst_id_ and ActionV.name_=''Action'' and date(ActionV.create_time_) = :Date
group by taskl1l2.assignee_'::text WHERE
idashboardqueryid = 60;

UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT 
unnest(array[''Above 30 days'', ''30'', ''29'', ''28'', ''27'', ''26'', ''25'', ''24'', ''23'', ''22'', ''21'', ''20'', ''19'', ''18'', ''17'', ''16'', ''15'', ''14'', ''13'', ''12'', ''11'', ''10'', ''9'', ''8'', ''7'', ''6'', ''5'', ''4'', ''3'', ''2'', ''1'', ''0'']) as "Ageing of Cases",
unnest(array["Day 30+", "Day 30", "Day 29", "Day 28", "Day 27", "Day 26", "Day 25", "Day 24", "Day 23", "Day 22", "Day 21", "Day 20", "Day 19", "Day 18", "Day 17", "Day 16", "Day 15", "Day 14", "Day 13", "Day 12", "Day 11", "Day 10", "Day 9", "Day 8", "Day 7", "Day 6", "Day 5", "Day 4", "Day 3", "Day 2", "Day 1", "Day 0" ]) as "Count of Cases"
FROM (
SELECT
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp -  proc.start_time_) = 0 THEN proc.id_
ELSE null
END) as "Day 0",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp -  proc.start_time_ ) = 1 THEN proc.id_
ELSE null
END) as "Day 1",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp -  proc.start_time_ ) = 2 THEN proc.id_
ELSE null
END) as "Day 2",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp -  proc.start_time_ ) = 3 THEN proc.id_
ELSE null
END) as "Day 3",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp -  proc.start_time_ ) = 4 THEN proc.id_
ELSE null
END) as "Day 4",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp -  proc.start_time_ ) = 5 THEN proc.id_
ELSE null
END) as "Day 5",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp -  proc.start_time_ ) = 6 THEN proc.id_
ELSE null
END) as "Day 6",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp -  proc.start_time_ ) = 7 THEN proc.id_
ELSE null
END) as "Day 7",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp -  proc.start_time_ ) = 8 THEN proc.id_
ELSE null
END) as "Day 8",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp -  proc.start_time_ ) = 9 THEN proc.id_
ELSE null
END) as "Day 9",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp -  proc.start_time_ ) = 10 THEN proc.id_
ELSE null
END) as "Day 10",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp -  proc.start_time_ ) = 11 THEN proc.id_
ELSE null
END) as "Day 11",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp -  proc.start_time_ ) = 12 THEN proc.id_
ELSE null
END) as "Day 12",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp -  proc.start_time_ ) = 13 THEN proc.id_
ELSE null
END) as "Day 13",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp -  proc.start_time_ ) = 14 THEN proc.id_
ELSE null
END) as "Day 14",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp -  proc.start_time_ ) = 15 THEN proc.id_
ELSE null
END) as "Day 15",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp -  proc.start_time_ ) = 16 THEN proc.id_
ELSE null
END) as "Day 16",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp -  proc.start_time_ ) = 17 THEN proc.id_
ELSE null
END) as "Day 17",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp -  proc.start_time_ ) = 18 THEN proc.id_
ELSE null
END) as "Day 18",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp -  proc.start_time_ ) = 19 THEN proc.id_
ELSE null
END) as "Day 19",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp -  proc.start_time_ ) = 20 THEN proc.id_
ELSE null
END) as "Day 20",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp -  proc.start_time_ ) = 21 THEN proc.id_
ELSE null
END) as "Day 21",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp -  proc.start_time_ ) = 22 THEN proc.id_
ELSE null
END) as "Day 22",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp -  proc.start_time_ ) = 23 THEN proc.id_
ELSE null
END) as "Day 23",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp -  proc.start_time_ ) = 24 THEN proc.id_
ELSE null
END) as "Day 24",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp -  proc.start_time_ ) = 25 THEN proc.id_
ELSE null
END) as "Day 25",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp -  proc.start_time_ ) = 26 THEN proc.id_
ELSE null
END) as "Day 26",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp -  proc.start_time_ ) = 27 THEN proc.id_
ELSE null
END) as "Day 27",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp -  proc.start_time_ ) = 28 THEN proc.id_
ELSE null
END) as "Day 28",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp -  proc.start_time_ ) = 29 THEN proc.id_
ELSE null
END) as "Day 29",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp -  proc.start_time_ ) = 30 THEN proc.id_
ELSE null
END) as "Day 30",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp -  proc.start_time_ ) > 30 THEN proc.id_
ELSE null
END) as "Day 30+"
FROM
camunda.act_hi_procinst proc where state_=''ACTIVE'') as report'::text WHERE
idashboardqueryid = 75;

UPDATE ui.dashboardresultset SET
vcdashboardresultsetschema = '{"Ageing of Cases":"string",
"Count of Cases":"integer"}'::text WHERE
idashboardresultsetid = 34;