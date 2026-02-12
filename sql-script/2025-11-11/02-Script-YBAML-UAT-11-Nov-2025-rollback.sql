UPDATE ui.tenants SET attribs = jsonb_set(attribs, '{outboundEmailSettings, email.provider.properties,karix.from.email}', '"support@dronapay.com"', true) WHERE itenantid in (8,16,17,21,22);
UPDATE ui.tenants SET attribs = jsonb_set(attribs, '{outboundEmailSettings, email.provider.properties,karix.reply.email}', '"support@dronapay.com"', true) WHERE itenantid in (8,16,17,21,22);
