UPDATE ui.dashboardfilters SET
validation = '{
  "limitDays":{
    "limit": true,
    "daysAllowed" : 30
  }
}'::jsonb WHERE
idashboardid =73 and vcdashboardfiltername = 'DateRange' AND itenantid in(8, 17, 21, 22, 23);