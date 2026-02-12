update ui.organizations set attribs = 
jsonb_set(attribs, '{vclogourl}', cast ('"epifi-logo.png"' as jsonb))
where iorgid=3;

update ui.organizations set attribs = 
jsonb_set(attribs, '{vclogourl}', cast ('"42c-logo.png"' as jsonb))
where iorgid=4;

update ui.organizations set attribs = 
jsonb_set(attribs, '{vclogourl}', cast ('"yb-logo.png"' as jsonb))
where iorgid=5;

update ui.organizations set attribs = 
jsonb_set(attribs, '{vclogourl}', cast ('"yb-logo.png"' as jsonb))
where iorgid=6;

update ui.organizations set attribs = 
jsonb_set(attribs, '{vclogourl}', cast ('"pl-logo.png"' as jsonb))
where iorgid=7;