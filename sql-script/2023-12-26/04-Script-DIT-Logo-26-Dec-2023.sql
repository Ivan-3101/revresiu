update ui.organizations set attribs = 
jsonb_set(attribs, '{vclogourl}', cast ('"42c-logo.png"' as jsonb))
where iorgid=2;