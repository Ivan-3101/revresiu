UPDATE ui.menustructuredesc SET isortorder=0 WHERE imenuid=507;
UPDATE ui.menustructuredesc SET isortorder=1 WHERE imenuid=508;
UPDATE ui.menustructuredesc SET isortorder=2 WHERE imenuid=509;
UPDATE ui.menustructuredesc	SET isortorder=3, vcaction='DataAnalyzer', vccontroller='DataAnalyzer', vclayout='/user', vcmenuname='Data Analyzer', vcmini='DA', vcpath='/analytics/data-analyzer', iparentmenu=478, istatus=1 WHERE imenuid = 510;
