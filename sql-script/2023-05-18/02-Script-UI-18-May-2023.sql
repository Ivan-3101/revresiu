insert into ui.metadata (vcpath, vcdtype, bscore, bml, bui, vccolumnname, vcdescription, vcroot, irecordstatus, vcquery, config, vcprefix)
select vcpath, vcdtype, bscore, bml, bui, vccolumnname, vcdescription, vcroot, irecordstatus, vcquery, config, vcprefix
from profiles.metadata;