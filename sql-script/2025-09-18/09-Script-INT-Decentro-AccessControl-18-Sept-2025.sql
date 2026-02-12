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
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    false :: boolean,
    true :: boolean,
    true :: boolean,
    604 :: integer,
    2 :: integer,
    v.tenantid :: integer,
    11 :: integer
FROM
    (
        VALUES
            (25)
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
    2 :: integer,
    v.tenantid :: integer,
    11 :: integer
FROM
    (
        VALUES
            (25)
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
    2 :: integer,
    v.tenantid :: integer,
    11 :: integer
FROM
    (
        VALUES
            (25)
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
    2 :: integer,
    v.tenantid :: integer,
    11 :: integer
FROM
    (
        VALUES
            (25)
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
    2 :: integer,
    v.tenantid :: integer,
    11 :: integer
FROM
    (
        VALUES
            (25)
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
    2 :: integer,
    v.tenantid :: integer,
    11 :: integer
FROM
    (
        VALUES
            (25)
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
    2 :: integer,
    v.tenantid :: integer,
    11 :: integer
FROM
    (
        VALUES
            (25)
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
    2 :: integer,
    v.tenantid :: integer,
    11 :: integer
FROM
    (
        VALUES
            (25)
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
    2 :: integer,
    v.tenantid :: integer,
    11 :: integer
FROM
    (
        VALUES
            (25)
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
    2 :: integer,
    v.tenantid :: integer,
    11 :: integer
FROM
    (
        VALUES
            (25)
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
    2 :: integer,
    v.tenantid :: integer,
    11 :: integer
FROM
    (
        VALUES
            (25)
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
    2 :: integer,
    v.tenantid :: integer,
    11 :: integer
FROM
    (
        VALUES
            (25)
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
    2 :: integer,
    v.tenantid :: integer,
    11 :: integer
FROM
    (
        VALUES
            (25)
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
    2 :: integer,
    v.tenantid :: integer,
    11 :: integer
FROM
    (
        VALUES
            (25)
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
    2 :: integer,
    v.tenantid :: integer,
    11 :: integer
FROM
    (
        VALUES
            (25)
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
    2 :: integer,
    v.tenantid :: integer,
    11 :: integer
FROM
    (
        VALUES
            (25)
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
    2 :: integer,
    v.tenantid :: integer,
    11 :: integer
FROM
    (
        VALUES
            (25)
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
    2 :: integer,
    v.tenantid :: integer,
    11 :: integer
FROM
    (
        VALUES
            (25)
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
    2 :: integer,
    v.tenantid :: integer,
    11 :: integer
FROM
    (
        VALUES
            (25)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;

--risk supervisor
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
    1 :: integer,
    v.tenantid :: integer,
    11 :: integer
FROM
    (
        VALUES
            (25)
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
    1 :: integer,
    v.tenantid :: integer,
    11 :: integer
FROM
    (
        VALUES
            (25)
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
    1 :: integer,
    v.tenantid :: integer,
    11 :: integer
FROM
    (
        VALUES
            (25)
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
    1 :: integer,
    v.tenantid :: integer,
    11 :: integer
FROM
    (
        VALUES
            (25)
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
    1 :: integer,
    v.tenantid :: integer,
    11 :: integer
FROM
    (
        VALUES
            (25)
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
    1 :: integer,
    v.tenantid :: integer,
    11 :: integer
FROM
    (
        VALUES
            (25)
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
    1 :: integer,
    v.tenantid :: integer,
    11 :: integer
FROM
    (
        VALUES
            (25)
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
    1 :: integer,
    v.tenantid :: integer,
    11 :: integer
FROM
    (
        VALUES
            (25)
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
    1 :: integer,
    v.tenantid :: integer,
    11 :: integer
FROM
    (
        VALUES
            (25)
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
    1 :: integer,
    v.tenantid :: integer,
    11 :: integer
FROM
    (
        VALUES
            (25)
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
    1 :: integer,
    v.tenantid :: integer,
    11 :: integer
FROM
    (
        VALUES
            (25)
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
    1 :: integer,
    v.tenantid :: integer,
    11 :: integer
FROM
    (
        VALUES
            (25)
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
    1 :: integer,
    v.tenantid :: integer,
    11 :: integer
FROM
    (
        VALUES
            (25)
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
    1 :: integer,
    v.tenantid :: integer,
    11 :: integer
FROM
    (
        VALUES
            (25)
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
    1 :: integer,
    v.tenantid :: integer,
    11 :: integer
FROM
    (
        VALUES
            (25)
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
    1 :: integer,
    v.tenantid :: integer,
    11 :: integer
FROM
    (
        VALUES
            (25)
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
    1 :: integer,
    v.tenantid :: integer,
    11 :: integer
FROM
    (
        VALUES
            (25)
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
    1 :: integer,
    v.tenantid :: integer,
    11 :: integer
FROM
    (
        VALUES
            (25)
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
    1 :: integer,
    v.tenantid :: integer,
    11 :: integer
FROM
    (
        VALUES
            (25)
    ) AS v(tenantid) RETURNING irolemenumapid,
    itenantid;