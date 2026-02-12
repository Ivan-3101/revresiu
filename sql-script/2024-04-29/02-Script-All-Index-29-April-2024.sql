CREATE INDEX IF NOT EXISTS ix_batchtrans_l1_batchtrans_dttrxntime_risk_override_idx
    ON analytics.batchtrans USING btree
    (dttrxntime ASC NULLS LAST, risk_override ASC NULLS LAST)
;

CREATE INDEX IF NOT EXISTS ix_trans_l1_dtrxntime_risk_override_itenant
    ON analytics.trans USING btree
    (itenantid ASC NULLS LAST, dttrxntime DESC NULLS FIRST, risk_override ASC NULLS LAST)
;


CREATE INDEX IF NOT EXISTS ix_adaptor_requests_id_endipoint
    ON transactions.adaptor_requests USING btree
    ( id COLLATE pg_catalog."default" ASC NULLS LAST, endpoint COLLATE pg_catalog."default" ASC NULLS LAST)
;
