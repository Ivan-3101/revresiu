--risk analyst
INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    false :: boolean,
    false :: boolean,
    false :: boolean,
    false :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    604 :: integer,
    13 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    false :: boolean,
    false :: boolean,
    false :: boolean,
    false :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    605 :: integer,
    13 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    false :: boolean,
    false :: boolean,
    false :: boolean,
    false :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    606 :: integer,
    13 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    false :: boolean,
    false :: boolean,
    false :: boolean,
    false :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    607 :: integer,
    13 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    false :: boolean,
    false :: boolean,
    false :: boolean,
    false :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    608 :: integer,
    13 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    false :: boolean,
    false :: boolean,
    false :: boolean,
    false :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    609 :: integer,
    13 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    false :: boolean,
    false :: boolean,
    false :: boolean,
    false :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    610 :: integer,
    13 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    false :: boolean,
    false :: boolean,
    false :: boolean,
    false :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    611 :: integer,
    13 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    false :: boolean,
    false :: boolean,
    false :: boolean,
    false :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    612 :: integer,
    13 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    false :: boolean,
    false :: boolean,
    false :: boolean,
    false :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    613 :: integer,
    13 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    false :: boolean,
    false :: boolean,
    false :: boolean,
    false :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    614 :: integer,
    13 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    false :: boolean,
    false :: boolean,
    false :: boolean,
    false :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    615 :: integer,
    13 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    false :: boolean,
    false :: boolean,
    false :: boolean,
    false :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    616 :: integer,
    13 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    false :: boolean,
    false :: boolean,
    false :: boolean,
    false :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    617 :: integer,
    13 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    false :: boolean,
    false :: boolean,
    false :: boolean,
    false :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    618 :: integer,
    13 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    false :: boolean,
    false :: boolean,
    false :: boolean,
    false :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    619 :: integer,
    13 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    false :: boolean,
    false :: boolean,
    false :: boolean,
    false :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    620 :: integer,
    13 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    false :: boolean,
    false :: boolean,
    false :: boolean,
    false :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    621 :: integer,
    13 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    false :: boolean,
    false :: boolean,
    false :: boolean,
    false :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    622 :: integer,
    13 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

--risk supervisor(maker)
INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    604 :: integer,
    14 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    605 :: integer,
    14 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    606 :: integer,
    14 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    607 :: integer,
    14 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    608 :: integer,
    14 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    609 :: integer,
    14 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    610 :: integer,
    14 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    611 :: integer,
    14 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    612 :: integer,
    14 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    613 :: integer,
    14 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    614 :: integer,
    14 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    615 :: integer,
    14 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    616 :: integer,
    14 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    617 :: integer,
    14 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    618 :: integer,
    14 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    619 :: integer,
    14 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    620 :: integer,
    14 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    621 :: integer,
    14 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    622 :: integer,
    14 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

--User Access Manager - Checker
INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    604 :: integer,
    16 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    605 :: integer,
    16 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    606 :: integer,
    16 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    607 :: integer,
    16 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    608 :: integer,
    16 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    609 :: integer,
    16 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    610 :: integer,
    16 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    611 :: integer,
    16 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    612 :: integer,
    16 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    613 :: integer,
    16 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    614 :: integer,
    16 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    615 :: integer,
    16 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    616 :: integer,
    16 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    617 :: integer,
    16 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    618 :: integer,
    16 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    619 :: integer,
    16 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    620 :: integer,
    16 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    621 :: integer,
    16 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    622 :: integer,
    16 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

--admin
INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    604 :: integer,
    1 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    605 :: integer,
    1 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    606 :: integer,
    1 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    607 :: integer,
    1 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    608 :: integer,
    1 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    609 :: integer,
    1 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    610 :: integer,
    1 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    611 :: integer,
    1 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    612 :: integer,
    1 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    613 :: integer,
    1 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    614 :: integer,
    1 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    615 :: integer,
    1 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    616 :: integer,
    1 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    617 :: integer,
    1 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    618 :: integer,
    1 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    619 :: integer,
    1 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    620 :: integer,
    1 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    621 :: integer,
    1 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

INSERT INTO
    ui.rolemenuaccessmap (
        irolemenumapid,
        badd,
        bapprove,
        bdelete,
        bedit,
        bpublish,
        bview,
        istatus,
        imenuid,
        iroleid,
        itenantid,
        iorgid
    )
SELECT
    (
        SELECT
            max(irolemenumapid)
        FROM
            ui.rolemenuaccessmap
    ) + ROW_NUMBER() OVER () AS irolemenumapid,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    true :: boolean,
    622 :: integer,
    1 :: integer,
    v.tenantid :: integer,
    10 :: integer
FROM
    (
        VALUES
            (14)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;