UPDATE ui.tenants SET
attribs = '{
  "inboundEmailSettings": {
    "email.id": "riskdocs.pinelabs.demo@outlook.com",
    "email.password": "Drona@1234",
    "mail.imap.auth": "true",
    "mail.imap.host": "outlook.office365.com",
    "mail.imap.port": "993",
    "mail.imap.timeout": "5000",
    "correlation.id.name": "TransactionId#:",
    "mail.store.protocol": "imap",
    "mail.imap.ssl.enable": "true",
    "mail.imap.writetimeout": "5000",
    "imap.auth.provider.type": "basic",
    "email.subject.filter.list": "Hold on Identified Risky Transaction;Request for Information Regarding Identified Risky Transaction",
    "mail.imap.starttls.enable": "true",
    "mail.imap.connectiontimeout": "5000"
  },
  "outboundEmailSettings": {
    "email.provider": "smtp",
    "email.provider.properties": {
      "mail.sender": "Risk Docs Pinelabs",
      "mail.password": "Drona@1234",
      "mail.username": "riskdocs.pinelabs.demo@outlook.com",
      "mail.smtp.auth": "true",
      "mail.smtp.host": "smtp-mail.outlook.com",
      "mail.smtp.port": "587",
      "mail.smtp.timeout": "5000",
      "mail.smtp.writetimeout": "5000",
      "mail.smtp.starttls.enable": "true",
      "mail.smtp.connectiontimeout": "5000"
    }
  }
}'::jsonb WHERE
itenantid = 10;