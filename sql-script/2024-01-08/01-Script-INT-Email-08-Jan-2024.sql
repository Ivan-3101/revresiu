update ui.tenants set attribs 
= jsonb_set(attribs, '{outboundEmailSettings, email.provider.properties, mail.password}', 
to_jsonb(pgp_sym_encrypt((attribs->'outboundEmailSettings'->'email.provider.properties'->>'mail.password')::text,
'1234'::text)));

update ui.tenants set attribs 
= jsonb_set(attribs, '{inboundEmailSettings, email.password}', 
to_jsonb(pgp_sym_encrypt((attribs->'inboundEmailSettings'->>'email.password')::text,
'1234'::text))) where attribs->'inboundEmailSettings'->>'email.password' is not null;