-- Delete the email template with id 32 (Welcome email)
delete from ui.emailaudittrail 
WHERE emailtemplateid in (32,33);

DELETE FROM ui.emailtemplate 
WHERE id = 32 ;
-- Delete the email template with id 33 (Reset email)
DELETE FROM ui.emailtemplate 
WHERE id = 33;


UPDATE ui.emailtemplate SET
body = '<p>Hello,</p><p>You have requested to reset your password.</p>
<p>Click the link below to change your password:</p> 
<p><a th:href="@{${dronauiurl} + ''/auth/reset-password?token='' + ${resetToken}}">Change my password</a></p>
<br>
<p>Ignore this email if you do remember your password or you have not made the request</p>'::text WHERE
id = 5 ;