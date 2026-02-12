INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (691, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 479, 8);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (692, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 494, 8);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (693, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 479, 9);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (694, true, true, true, true, true, true, NULL, NULL, true, NULL,NULL,494,9);



INSERT INTO ui.dashboard (
idashboardid, bactive, bdelete, vcdashboardname, iorder, irowcount) VALUES (
'18'::integer, true::boolean, false::boolean, 'Pendency Report'::character varying, '18'::integer, '1'::integer)
 returning idashboardid;

 INSERT INTO ui.dashboard (
 idashboardid, bactive, bdelete, vcdashboardname, iorder, irowcount) VALUES (
 '19'::integer, true::boolean, false::boolean, 'Daily Productivity Report'::character varying, '19'::integer, '1'::integer)
  returning idashboardid;

INSERT INTO ui.dashboardfilters (
idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, vcdashboardfilterdisplayname) VALUES (
'42'::integer, '0'::integer, 'Date'::character varying, '19'::integer, 'DatePicker'::character varying, '1'::integer, 'Date'::character varying)
 returning idashboardfilterid;


 INSERT INTO ui.dashboardquery (
 idashboardqueryid, bparametersrequired, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired) VALUES (
 '59'::integer, false::boolean, '

 SELECT pdef.name_ as "Workflow Name",
 task.assignee_ as "Username",
 task.name_ as "User task / status",
 grp.name_ as "Group Name",
 count(distinct CASE
     WHEN DATE_PART(''day'', current_timestamp - hdetail.time_) = 0 THEN task.proc_inst_id_
     ELSE null
 END) as "Day 0",
 count(distinct CASE
     WHEN DATE_PART(''day'', current_timestamp - hdetail.time_) = 1 THEN task.proc_inst_id_
     ELSE null
 END) as "Day 1",
 count(distinct CASE
     WHEN DATE_PART(''day'', current_timestamp - hdetail.time_) = 2 THEN task.proc_inst_id_
     ELSE null
 END) as "Day 2",
 count(distinct CASE
     WHEN DATE_PART(''day'', current_timestamp - hdetail.time_) = 3 THEN task.proc_inst_id_
     ELSE null
 END) as "Day 3",
 count(distinct CASE
     WHEN DATE_PART(''day'', current_timestamp - hdetail.time_) = 4 THEN task.proc_inst_id_
     ELSE null
 END) as "Day 4",
 count(distinct CASE
     WHEN DATE_PART(''day'', current_timestamp - hdetail.time_) = 5 THEN task.proc_inst_id_
     ELSE null
 END) as "Day 5",
 count(distinct CASE
     WHEN DATE_PART(''day'', current_timestamp - hdetail.time_) = 6 THEN task.proc_inst_id_
     ELSE null
 END) as "Day 6",
 count(distinct CASE
     WHEN DATE_PART(''day'', current_timestamp - hdetail.time_) = 7 THEN task.proc_inst_id_
     ELSE null
 END) as "Day 7"
 FROM public.act_re_procdef pdef
 right join public.act_ru_task task on task.proc_def_id_ = pdef.id_
 inner join public.act_hi_detail hdetail on hdetail.proc_inst_id_ = task.proc_inst_id_
 and hdetail.name_ = ''userActivity''
 right join public.act_id_membership memb on task.assignee_ = memb.user_id_

 right join public.act_hi_identitylink idl on idl.id_ = (SELECT id_ FROM public.act_hi_identitylink
 														 where task_id_ = task.id_
 and type_= ''candidate''
 order by timestamp_ desc
  limit 1)
  right join public.act_id_group grp on grp.id_ = idl.group_id_
 where task.assignee_ is not null  and DATE_PART(''day'', current_timestamp - hdetail.time_) between 0 and 7 group by
 pdef.name_, task.assignee_, task.name_, grp.name_

 '::text, false::boolean, false::boolean, false::boolean)
  returning idashboardqueryid;

  INSERT INTO ui.dashboardquery (
  idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired) VALUES (
  '60'::integer, true::boolean, '{"Date" : null }'::text, 'SELECT pdef.name_ as "Workflow Name",
  taskinst.assignee_ as "Username",
  count(hiproc.proc_inst_id_) as "Cases Closed",
  array_length(string_to_array(STRING_AGG(trim(both ''[]'' from hvar.text_), '',''),'',''),1) as "Alerts Closed"
  FROM public.act_hi_procinst hiproc
  right join public.act_re_procdef pdef on hiproc.proc_def_id_ = pdef.id_
  right join public.act_hi_varinst hvar on hvar.proc_inst_id_ = hiproc.proc_inst_id_ and hvar.name_ = ''failedRules''
  left join public.act_hi_taskinst taskinst on taskinst.proc_inst_id_ = hiproc.proc_inst_id_  and taskinst.delete_reason_ =''completed''
  and taskinst.id_ = (select id_  from public.act_hi_taskinst where proc_inst_id_ = hiproc.proc_inst_id_ and delete_reason_ =''completed''
  					order by end_time_ desc limit 1)
  WHERE hiproc.state_ = ''COMPLETED'' and hvar.text_ != ''''
   and cast(hiproc.end_time_ as date) = :Date
   group by  pdef.name_,  taskinst.assignee_
  '::text, false::boolean, false::boolean, false::boolean)
   returning idashboardqueryid;


   INSERT INTO ui.dashboardqueryparameters (
   idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (
   '98'::integer, 'Date'::character varying, 'Date'::character varying, '60'::integer)
    returning idashboardparameterid;


INSERT INTO ui.dashboardresultset (
idashboardresultsetid, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardqueryid, idashboardid, vcdashboardresultsetschema, irowno) VALUES (
'27'::integer, '{
   "sizes":[
      1,
      0
   ],
   "detail":{
      "main":null
   },
   "mode":"globalFilters",
   "master":{
      "widgets":[
         "PERSPECTIVE_GENERATED_ID_1"
      ],
      "sizes":[
         1
      ]
   },
   "viewers":{
      "PERSPECTIVE_GENERATED_ID_1":{
         "plugin":"Custom Datagrid",
         "plugin_config":{
            "columns":{

            },
            "editable":false,
            "scroll_lock":true
         },
         "settings":true,
         "theme":"Material Dark",
         "group_by":[

         ],
         "split_by":[

         ],
         "columns":[
            "Workflow Name", "Username", "User Task / State", "Group Name", "Day 0", "Day 1", "Day 2", "Day 3", "Day 4", "Day 5", "Day 6", "Day 7"
         ],
         "filter":[

         ],
         "sort":[

         ],
         "expressions":[

         ],
         "aggregates":{

         },
         "master":true,
         "name":"Pendency Report",
         "table":"pendencyreport",
         "linked":false,
         "selectable":""
      }
   }
}'::text, 'pendencyreport'::character varying, '59'::integer, '18'::integer, '{
   "Workflow Name":  "string",
   "Username": "string",
   "User Task / State": "string",
   "Group Name": "string",
   "Day 0":"integer",
   "Day 1":"integer",
   "Day 2":"integer",
   "Day 3":"integer",
   "Day 4":"integer",
   "Day 5":"integer",
   "Day 6":"integer",
   "Day 7":"integer"
}
'::text, '1'::integer)
 returning idashboardresultsetid;


 INSERT INTO ui.dashboardresultset (
 idashboardresultsetid, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardqueryid, idashboardid, vcdashboardresultsetschema, irowno) VALUES (
 '28'::integer, '{
    "sizes":[
       1,
       0
    ],
    "detail":{
       "main":null
    },
    "mode":"globalFilters",
    "master":{
       "widgets":[
          "PERSPECTIVE_GENERATED_ID_1"
       ],
       "sizes":[
          1
       ]
    },
    "viewers":{
       "PERSPECTIVE_GENERATED_ID_1":{
          "plugin":"Custom Datagrid",
          "plugin_config":{
             "columns":{

             },
             "editable":false,
             "scroll_lock":true
          },
          "settings":true,
          "theme":"Material Dark",
          "group_by":[

          ],
          "split_by":[

          ],
          "columns":[
             "Workflow Name", "Username","Cases Closed", "Alerts Closed"
          ],
          "filter":[

          ],
          "sort":[

          ],
          "expressions":[

          ],
          "aggregates":{

          },
          "master":true,
          "name":"Daily Productivity Report",
          "table":"dailyproductivityreport",
          "linked":false,
          "selectable":""
       }
    }
 }
 '::text, 'dailyproductivityreport'::character varying, '60'::integer, '19'::integer, '{
    "Workflow Name":  "string",
    "Username": "string",
    "Cases Closed":"integer",
    "Alerts Closed":"integer"
 }
 '::text, '1'::integer)
  returning idashboardresultsetid;