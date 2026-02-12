CREATE TABLE IF NOT EXISTS ui.emailtemplate
(
    id integer NOT NULL,
    body text COLLATE pg_catalog."default",
    subject text COLLATE pg_catalog."default",
    associateid character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT emailtemplate_pkey PRIMARY KEY (id)
);

INSERT INTO ui.emailtemplate (id, body, subject, associateid) VALUES (5, '<p>Hello,</p><p>You have requested to reset your password.</p>
<p>Click the link below to change your password:</p>
<p><a th:href="@{${dronauiurl} + ''/auth/reset-password?token='' + ${resetToken}}">Change my password<a></p>
<br>
<p>Ignore this email if you do remember your password or you have not made the request</p>', 'Password reset request for DronaPay app', 'drona');