update ui.emailtemplate
SET
body =
'<p>Hello,</p><p>You have requested to reset your password.</p>
<p>Click the link below to change your password:</p>
<p><a th:href="@{${dronauiurl} + ''/auth/reset-password?token='' + ${resetToken}}">Change my password</a></p>
<br>
<p>Ignore this email if you do remember your password or you have not made the request</p>'
where id = 5;