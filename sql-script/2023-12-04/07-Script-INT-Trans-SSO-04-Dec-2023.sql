UPDATE ui.organizations SET
attribs = '{
  "ssoConfig": {  
    "uiserver.sso": false,
    "drona.ui.scope": "openid",
    "drona.ui.clientid": "dronauidit",
    "uiserver.sso.type": "openid",
    "drona.ui.authorize": "http://localhost:8081/realms/dronaui/protocol/openid-connect/auth",
    "drona.ui.token.url": "http://localhost:8081/realms/dronaui/protocol/openid-connect/token",
    "drona.ui.logout.url": "http://localhost:8081/realms/dronaui/protocol/openid-connect/logout?post_logout_redirect_uri=http://localhost:8085/dronaui/auth/login",
    "drona.ui.redirect.url": "http://localhost:3001/dronaui/SIT/auth/login",
    "drona.ui.client.secret": "QDG8Q~~Aryb8W~9VVcsSLqGdH6PQZAGtkBj.VbfV",
    "spring.security.oauth2.resourceserver.jwt.issuer-uri": "http://localhost:8081/realms/dronaui",
    "spring.security.oauth2.resourceserver.jwt.jwk-set-uri": "http://localhost:8081/realms/dronaui/protocol/openid-connect/certs",
    "spring.security.oauth2.resourceserver.jwt.user-name-attribute": "preferred_username"
  },
  "vclogourl": "",
  "pismo.processing.enabled": true
}'::jsonb WHERE
iorgid = 1;