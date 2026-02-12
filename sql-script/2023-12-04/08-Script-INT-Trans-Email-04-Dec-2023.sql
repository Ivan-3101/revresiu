UPDATE ui.tenants SET
attribs = '{
  "outboundEmailSettings": {
    "email.provider": "smtp",
    "email.provider.properties": {
      "mail.sender": "Risk Team",
      "mail.password": "lmcyvxrcwzluytkt",
      "mail.username": "dronapay@gmail.com",
      "mail.smtp.auth": "true",
      "mail.smtp.host": "smtp.gmail.com",
      "mail.smtp.port": "587",
      "mail.smtp.timeout": "5000",
      "mail.smtp.writetimeout": "5000",
      "mail.smtp.starttls.enable": "true",
      "mail.smtp.connectiontimeout": "5000"
    }
  }
}'::jsonb WHERE
itenantid = 1 or itenantid = 2 or itenantid = 3 or itenantid = 4;