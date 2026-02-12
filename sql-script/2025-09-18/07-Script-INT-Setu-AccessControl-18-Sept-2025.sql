--GOD
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid)
SELECT 
    (SELECT max(irolemenumapid) FROM ui.rolemenuaccessmap) 
        + ROW_NUMBER() OVER () AS irolemenumapid,
    true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 604::integer, 1::integer, v.tenantid::integer, 12::integer
FROM (VALUES (27)) AS v(tenantid)
RETURNING irolemenumapid, itenantid;

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid)
SELECT 
    (SELECT max(irolemenumapid) FROM ui.rolemenuaccessmap) 
        + ROW_NUMBER() OVER () AS irolemenumapid,
    true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 605::integer, 1::integer, v.tenantid::integer, 12::integer
FROM (VALUES (27)) AS v(tenantid)
RETURNING irolemenumapid, itenantid;

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid)
SELECT 
    (SELECT max(irolemenumapid) FROM ui.rolemenuaccessmap) 
        + ROW_NUMBER() OVER () AS irolemenumapid,
    true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 606::integer, 1::integer, v.tenantid::integer, 12::integer
FROM (VALUES (27)) AS v(tenantid)
RETURNING irolemenumapid, itenantid;

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid)
SELECT 
    (SELECT max(irolemenumapid) FROM ui.rolemenuaccessmap) 
        + ROW_NUMBER() OVER () AS irolemenumapid,
    true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 607::integer, 1::integer, v.tenantid::integer, 12::integer
FROM (VALUES (27)) AS v(tenantid)
RETURNING irolemenumapid, itenantid;

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid)
SELECT 
    (SELECT max(irolemenumapid) FROM ui.rolemenuaccessmap) 
        + ROW_NUMBER() OVER () AS irolemenumapid,
    true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 608::integer, 1::integer, v.tenantid::integer, 12::integer
FROM (VALUES (27)) AS v(tenantid)
RETURNING irolemenumapid, itenantid;

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid)
SELECT 
    (SELECT max(irolemenumapid) FROM ui.rolemenuaccessmap) 
        + ROW_NUMBER() OVER () AS irolemenumapid,
    true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 609::integer, 1::integer, v.tenantid::integer, 12::integer
FROM (VALUES (27)) AS v(tenantid)
RETURNING irolemenumapid, itenantid;

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid)
SELECT 
    (SELECT max(irolemenumapid) FROM ui.rolemenuaccessmap) 
        + ROW_NUMBER() OVER () AS irolemenumapid,
    true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 610::integer, 1::integer, v.tenantid::integer, 12::integer
FROM (VALUES (27)) AS v(tenantid)
RETURNING irolemenumapid, itenantid;

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid)
SELECT 
    (SELECT max(irolemenumapid) FROM ui.rolemenuaccessmap) 
        + ROW_NUMBER() OVER () AS irolemenumapid,
    true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 611::integer, 1::integer, v.tenantid::integer, 12::integer
FROM (VALUES (27)) AS v(tenantid)
RETURNING irolemenumapid, itenantid;

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid)
SELECT 
    (SELECT max(irolemenumapid) FROM ui.rolemenuaccessmap) 
        + ROW_NUMBER() OVER () AS irolemenumapid,
    true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 612::integer, 1::integer, v.tenantid::integer, 12::integer
FROM (VALUES (27)) AS v(tenantid)
RETURNING irolemenumapid, itenantid;

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid)
SELECT 
    (SELECT max(irolemenumapid) FROM ui.rolemenuaccessmap) 
        + ROW_NUMBER() OVER () AS irolemenumapid,
    true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 613::integer, 1::integer, v.tenantid::integer, 12::integer
FROM (VALUES (27)) AS v(tenantid)
RETURNING irolemenumapid, itenantid;

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid)
SELECT 
    (SELECT max(irolemenumapid) FROM ui.rolemenuaccessmap) 
        + ROW_NUMBER() OVER () AS irolemenumapid,
    true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 614::integer, 1::integer, v.tenantid::integer, 12::integer
FROM (VALUES (27)) AS v(tenantid)
RETURNING irolemenumapid, itenantid;

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid)
SELECT 
    (SELECT max(irolemenumapid) FROM ui.rolemenuaccessmap) 
        + ROW_NUMBER() OVER () AS irolemenumapid,
    true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 615::integer, 1::integer, v.tenantid::integer, 12::integer
FROM (VALUES (27)) AS v(tenantid)
RETURNING irolemenumapid, itenantid;

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid)
SELECT 
    (SELECT max(irolemenumapid) FROM ui.rolemenuaccessmap) 
        + ROW_NUMBER() OVER () AS irolemenumapid,
    true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 616::integer, 1::integer, v.tenantid::integer, 12::integer
FROM (VALUES (27)) AS v(tenantid)
RETURNING irolemenumapid, itenantid;

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid)
SELECT 
    (SELECT max(irolemenumapid) FROM ui.rolemenuaccessmap) 
        + ROW_NUMBER() OVER () AS irolemenumapid,
    true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 617::integer, 1::integer, v.tenantid::integer, 12::integer
FROM (VALUES (27)) AS v(tenantid)
RETURNING irolemenumapid, itenantid;

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid)
SELECT 
    (SELECT max(irolemenumapid) FROM ui.rolemenuaccessmap) 
        + ROW_NUMBER() OVER () AS irolemenumapid,
    true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 618::integer, 1::integer, v.tenantid::integer, 12::integer
FROM (VALUES (27)) AS v(tenantid)
RETURNING irolemenumapid, itenantid;

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid)
SELECT 
    (SELECT max(irolemenumapid) FROM ui.rolemenuaccessmap) 
        + ROW_NUMBER() OVER () AS irolemenumapid,
    true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 619::integer, 1::integer, v.tenantid::integer, 12::integer
FROM (VALUES (27)) AS v(tenantid)
RETURNING irolemenumapid, itenantid;

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid)
SELECT 
    (SELECT max(irolemenumapid) FROM ui.rolemenuaccessmap) 
        + ROW_NUMBER() OVER () AS irolemenumapid,
    true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 620::integer, 1::integer, v.tenantid::integer, 12::integer
FROM (VALUES (27)) AS v(tenantid)
RETURNING irolemenumapid, itenantid;

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid)
SELECT 
    (SELECT max(irolemenumapid) FROM ui.rolemenuaccessmap) 
        + ROW_NUMBER() OVER () AS irolemenumapid,
    true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 621::integer, 1::integer, v.tenantid::integer, 12::integer
FROM (VALUES (27)) AS v(tenantid)
RETURNING irolemenumapid, itenantid;

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid)
SELECT 
    (SELECT max(irolemenumapid) FROM ui.rolemenuaccessmap) 
        + ROW_NUMBER() OVER () AS irolemenumapid,
    true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 622::integer, 1::integer, v.tenantid::integer, 12::integer
FROM (VALUES (27)) AS v(tenantid)
RETURNING irolemenumapid, itenantid;



--RISK ADMIN
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid)
SELECT 
    (SELECT max(irolemenumapid) FROM ui.rolemenuaccessmap) 
        + ROW_NUMBER() OVER () AS irolemenumapid,
    true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 604::integer, 10::integer, v.tenantid::integer, 12::integer
FROM (VALUES (27)) AS v(tenantid)
RETURNING irolemenumapid, itenantid;

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid)
SELECT 
    (SELECT max(irolemenumapid) FROM ui.rolemenuaccessmap) 
        + ROW_NUMBER() OVER () AS irolemenumapid,
    true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 605::integer, 10::integer, v.tenantid::integer, 12::integer
FROM (VALUES (27)) AS v(tenantid)
RETURNING irolemenumapid, itenantid;

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid)
SELECT 
    (SELECT max(irolemenumapid) FROM ui.rolemenuaccessmap) 
        + ROW_NUMBER() OVER () AS irolemenumapid,
    true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 606::integer, 10::integer, v.tenantid::integer, 12::integer
FROM (VALUES (27)) AS v(tenantid)
RETURNING irolemenumapid, itenantid;

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid)
SELECT 
    (SELECT max(irolemenumapid) FROM ui.rolemenuaccessmap) 
        + ROW_NUMBER() OVER () AS irolemenumapid,
    true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 607::integer, 10::integer, v.tenantid::integer, 12::integer
FROM (VALUES (27)) AS v(tenantid)
RETURNING irolemenumapid, itenantid;

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid)
SELECT 
    (SELECT max(irolemenumapid) FROM ui.rolemenuaccessmap) 
        + ROW_NUMBER() OVER () AS irolemenumapid,
    true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 608::integer, 10::integer, v.tenantid::integer, 12::integer
FROM (VALUES (27)) AS v(tenantid)
RETURNING irolemenumapid, itenantid;

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid)
SELECT 
    (SELECT max(irolemenumapid) FROM ui.rolemenuaccessmap) 
        + ROW_NUMBER() OVER () AS irolemenumapid,
    true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 609::integer, 10::integer, v.tenantid::integer, 12::integer
FROM (VALUES (27)) AS v(tenantid)
RETURNING irolemenumapid, itenantid;

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid)
SELECT 
    (SELECT max(irolemenumapid) FROM ui.rolemenuaccessmap) 
        + ROW_NUMBER() OVER () AS irolemenumapid,
    true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 610::integer, 10::integer, v.tenantid::integer, 12::integer
FROM (VALUES (27)) AS v(tenantid)
RETURNING irolemenumapid, itenantid;

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid)
SELECT 
    (SELECT max(irolemenumapid) FROM ui.rolemenuaccessmap) 
        + ROW_NUMBER() OVER () AS irolemenumapid,
    true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 611::integer, 10::integer, v.tenantid::integer, 12::integer
FROM (VALUES (27)) AS v(tenantid)
RETURNING irolemenumapid, itenantid;

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid)
SELECT 
    (SELECT max(irolemenumapid) FROM ui.rolemenuaccessmap) 
        + ROW_NUMBER() OVER () AS irolemenumapid,
    true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 612::integer, 10::integer, v.tenantid::integer, 12::integer
FROM (VALUES (27)) AS v(tenantid)
RETURNING irolemenumapid, itenantid;

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid)
SELECT 
    (SELECT max(irolemenumapid) FROM ui.rolemenuaccessmap) 
        + ROW_NUMBER() OVER () AS irolemenumapid,
    true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 613::integer, 10::integer, v.tenantid::integer, 12::integer
FROM (VALUES (27)) AS v(tenantid)
RETURNING irolemenumapid, itenantid;

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid)
SELECT 
    (SELECT max(irolemenumapid) FROM ui.rolemenuaccessmap) 
        + ROW_NUMBER() OVER () AS irolemenumapid,
    true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 614::integer, 10::integer, v.tenantid::integer, 12::integer
FROM (VALUES (27)) AS v(tenantid)
RETURNING irolemenumapid, itenantid;

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid)
SELECT 
    (SELECT max(irolemenumapid) FROM ui.rolemenuaccessmap) 
        + ROW_NUMBER() OVER () AS irolemenumapid,
    true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 615::integer, 10::integer, v.tenantid::integer, 12::integer
FROM (VALUES (27)) AS v(tenantid)
RETURNING irolemenumapid, itenantid;

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid)
SELECT 
    (SELECT max(irolemenumapid) FROM ui.rolemenuaccessmap) 
        + ROW_NUMBER() OVER () AS irolemenumapid,
    true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 616::integer, 10::integer, v.tenantid::integer, 12::integer
FROM (VALUES (27)) AS v(tenantid)
RETURNING irolemenumapid, itenantid;

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid)
SELECT 
    (SELECT max(irolemenumapid) FROM ui.rolemenuaccessmap) 
        + ROW_NUMBER() OVER () AS irolemenumapid,
    true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 617::integer, 10::integer, v.tenantid::integer, 12::integer
FROM (VALUES (27)) AS v(tenantid)
RETURNING irolemenumapid, itenantid;

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid)
SELECT 
    (SELECT max(irolemenumapid) FROM ui.rolemenuaccessmap) 
        + ROW_NUMBER() OVER () AS irolemenumapid,
    true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 618::integer, 10::integer, v.tenantid::integer, 12::integer
FROM (VALUES (27)) AS v(tenantid)
RETURNING irolemenumapid, itenantid;

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid)
SELECT 
    (SELECT max(irolemenumapid) FROM ui.rolemenuaccessmap) 
        + ROW_NUMBER() OVER () AS irolemenumapid,
    true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 619::integer, 10::integer, v.tenantid::integer, 12::integer
FROM (VALUES (27)) AS v(tenantid)
RETURNING irolemenumapid, itenantid;

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid)
SELECT 
    (SELECT max(irolemenumapid) FROM ui.rolemenuaccessmap) 
        + ROW_NUMBER() OVER () AS irolemenumapid,
    true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 620::integer, 10::integer, v.tenantid::integer, 12::integer
FROM (VALUES (27)) AS v(tenantid)
RETURNING irolemenumapid, itenantid;

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid)
SELECT 
    (SELECT max(irolemenumapid) FROM ui.rolemenuaccessmap) 
        + ROW_NUMBER() OVER () AS irolemenumapid,
    true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 621::integer, 10::integer, v.tenantid::integer, 12::integer
FROM (VALUES (27)) AS v(tenantid)
RETURNING irolemenumapid, itenantid;

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid)
SELECT 
    (SELECT max(irolemenumapid) FROM ui.rolemenuaccessmap) 
        + ROW_NUMBER() OVER () AS irolemenumapid,
    true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 622::integer, 10::integer, v.tenantid::integer, 12::integer
FROM (VALUES (27)) AS v(tenantid)
RETURNING irolemenumapid, itenantid;


--RISK ANALYST
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid)
SELECT 
    (SELECT max(irolemenumapid) FROM ui.rolemenuaccessmap) 
        + ROW_NUMBER() OVER () AS irolemenumapid,
    true::boolean, false::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, 604::integer, 5::integer, v.tenantid::integer, 12::integer
FROM (VALUES (27)) AS v(tenantid)
RETURNING irolemenumapid, itenantid;

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid)
SELECT 
    (SELECT max(irolemenumapid) FROM ui.rolemenuaccessmap) 
        + ROW_NUMBER() OVER () AS irolemenumapid,
    true::boolean, false::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, 605::integer, 5::integer, v.tenantid::integer, 12::integer
FROM (VALUES (27)) AS v(tenantid)
RETURNING irolemenumapid, itenantid;

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid)
SELECT 
    (SELECT max(irolemenumapid) FROM ui.rolemenuaccessmap) 
        + ROW_NUMBER() OVER () AS irolemenumapid,
    true::boolean, false::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, 606::integer, 5::integer, v.tenantid::integer, 12::integer
FROM (VALUES (27)) AS v(tenantid)
RETURNING irolemenumapid, itenantid;

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid)
SELECT 
    (SELECT max(irolemenumapid) FROM ui.rolemenuaccessmap) 
        + ROW_NUMBER() OVER () AS irolemenumapid,
    true::boolean, false::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, 607::integer, 5::integer, v.tenantid::integer, 12::integer
FROM (VALUES (27)) AS v(tenantid)
RETURNING irolemenumapid, itenantid;

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid)
SELECT 
    (SELECT max(irolemenumapid) FROM ui.rolemenuaccessmap) 
        + ROW_NUMBER() OVER () AS irolemenumapid,
    true::boolean, false::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, 608::integer, 5::integer, v.tenantid::integer, 12::integer
FROM (VALUES (27)) AS v(tenantid)
RETURNING irolemenumapid, itenantid;

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid)
SELECT 
    (SELECT max(irolemenumapid) FROM ui.rolemenuaccessmap) 
        + ROW_NUMBER() OVER () AS irolemenumapid,
    true::boolean, false::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, 609::integer, 5::integer, v.tenantid::integer, 12::integer
FROM (VALUES (27)) AS v(tenantid)
RETURNING irolemenumapid, itenantid;

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid)
SELECT 
    (SELECT max(irolemenumapid) FROM ui.rolemenuaccessmap) 
        + ROW_NUMBER() OVER () AS irolemenumapid,
    true::boolean, false::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, 610::integer, 5::integer, v.tenantid::integer, 12::integer
FROM (VALUES (27)) AS v(tenantid)
RETURNING irolemenumapid, itenantid;

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid)
SELECT 
    (SELECT max(irolemenumapid) FROM ui.rolemenuaccessmap) 
        + ROW_NUMBER() OVER () AS irolemenumapid,
    true::boolean, false::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, 611::integer, 5::integer, v.tenantid::integer, 12::integer
FROM (VALUES (27)) AS v(tenantid)
RETURNING irolemenumapid, itenantid;

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid)
SELECT 
    (SELECT max(irolemenumapid) FROM ui.rolemenuaccessmap) 
        + ROW_NUMBER() OVER () AS irolemenumapid,
    true::boolean, false::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, 612::integer, 5::integer, v.tenantid::integer, 12::integer
FROM (VALUES (27)) AS v(tenantid)
RETURNING irolemenumapid, itenantid;

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid)
SELECT 
    (SELECT max(irolemenumapid) FROM ui.rolemenuaccessmap) 
        + ROW_NUMBER() OVER () AS irolemenumapid,
    true::boolean, false::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, 613::integer, 5::integer, v.tenantid::integer, 12::integer
FROM (VALUES (27)) AS v(tenantid)
RETURNING irolemenumapid, itenantid;

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid)
SELECT 
    (SELECT max(irolemenumapid) FROM ui.rolemenuaccessmap) 
        + ROW_NUMBER() OVER () AS irolemenumapid,
    true::boolean, false::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, 614::integer, 5::integer, v.tenantid::integer, 12::integer
FROM (VALUES (27)) AS v(tenantid)
RETURNING irolemenumapid, itenantid;

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid)
SELECT 
    (SELECT max(irolemenumapid) FROM ui.rolemenuaccessmap) 
        + ROW_NUMBER() OVER () AS irolemenumapid,
    true::boolean, false::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, 615::integer, 5::integer, v.tenantid::integer, 12::integer
FROM (VALUES (27)) AS v(tenantid)
RETURNING irolemenumapid, itenantid;

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid)
SELECT 
    (SELECT max(irolemenumapid) FROM ui.rolemenuaccessmap) 
        + ROW_NUMBER() OVER () AS irolemenumapid,
    true::boolean, false::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, 616::integer, 5::integer, v.tenantid::integer, 12::integer
FROM (VALUES (27)) AS v(tenantid)
RETURNING irolemenumapid, itenantid;

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid)
SELECT 
    (SELECT max(irolemenumapid) FROM ui.rolemenuaccessmap) 
        + ROW_NUMBER() OVER () AS irolemenumapid,
    true::boolean, false::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, 617::integer, 5::integer, v.tenantid::integer, 12::integer
FROM (VALUES (27)) AS v(tenantid)
RETURNING irolemenumapid, itenantid;

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid)
SELECT 
    (SELECT max(irolemenumapid) FROM ui.rolemenuaccessmap) 
        + ROW_NUMBER() OVER () AS irolemenumapid,
    true::boolean, false::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, 618::integer, 5::integer, v.tenantid::integer, 12::integer
FROM (VALUES (27)) AS v(tenantid)
RETURNING irolemenumapid, itenantid;

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid)
SELECT 
    (SELECT max(irolemenumapid) FROM ui.rolemenuaccessmap) 
        + ROW_NUMBER() OVER () AS irolemenumapid,
    true::boolean, false::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, 619::integer, 5::integer, v.tenantid::integer, 12::integer
FROM (VALUES (27)) AS v(tenantid)
RETURNING irolemenumapid, itenantid;

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid)
SELECT 
    (SELECT max(irolemenumapid) FROM ui.rolemenuaccessmap) 
        + ROW_NUMBER() OVER () AS irolemenumapid,
    true::boolean, false::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, 620::integer, 5::integer, v.tenantid::integer, 12::integer
FROM (VALUES (27)) AS v(tenantid)
RETURNING irolemenumapid, itenantid;

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid)
SELECT 
    (SELECT max(irolemenumapid) FROM ui.rolemenuaccessmap) 
        + ROW_NUMBER() OVER () AS irolemenumapid,
    true::boolean, false::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, 621::integer, 5::integer, v.tenantid::integer, 12::integer
FROM (VALUES (27)) AS v(tenantid)
RETURNING irolemenumapid, itenantid;

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid)
SELECT 
    (SELECT max(irolemenumapid) FROM ui.rolemenuaccessmap) 
        + ROW_NUMBER() OVER () AS irolemenumapid,
    true::boolean, false::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, 622::integer, 5::integer, v.tenantid::integer, 12::integer
FROM (VALUES (27)) AS v(tenantid)
RETURNING irolemenumapid, itenantid;


