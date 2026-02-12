UPDATE ui.tenants SET attribs = jsonb_set(attribs, '{outboundEmailSettings, email.provider.properties,karix.from.email}', '"no-reply@ypassist.yes.bank.in"', true) WHERE itenantid in (9,19);
UPDATE ui.tenants SET attribs = jsonb_set(attribs, '{outboundEmailSettings, email.provider.properties,karix.reply.email}', '"no-reply@ypassist.yes.bank.in"', true) WHERE itenantid in (9,19);
