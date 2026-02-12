
INSERT INTO ui.emailtemplate (id, itenantid, body, subject, associateid)  
SELECT 
    32 AS id,
    t.itenantid,
    '<p>Hello,</p>  
    <p>We are pleased to inform you that your DronaPay user profile has been successfully created.</p>  
    <p>To get started, please use the following temporary password to log in to your account:</p>  
    <p><strong>Temporary Password: <span th:text="${temporaryPassword}"></span></strong></p>  
    <p>You can access the login page by clicking the link below:</p>  
    <p><a th:href="@{${loginurl}}">Login Page</a></p>  
    <p>For security reasons, once you log in, you will be prompted to reset your password.</p>  
    <p>If you have any questions or need assistance, feel free to reach out to your SPOC.</p>  
    <br>  
    <p>Best regards,<br>The DronaPay Team</p>' AS body,  
    'Welcome to DronaPay - User Account Setup and Login Information' AS subject,  
    'drona' AS associateid
FROM ui.tenants t
WHERE NOT EXISTS (
    SELECT 1 FROM ui.emailtemplate e 
    WHERE e.id = 32 AND e.itenantid = t.itenantid
) and t.itenantid !=0
RETURNING id, itenantid;


INSERT INTO ui.emailtemplate (id, itenantid, body, subject, associateid)  
SELECT 
    33 AS id,
    t.itenantid,
    '<p>Hello,</p>  
    <p>We are pleased to inform you that your DronaPay user profile has been reset successfully.</p>  
    <p>To get started, please use the following temporary password to log in to your account:</p>  
    <p><strong>Temporary Password: <span th:text="${temporaryPassword}"></span></strong></p>  
    <p>You can access the login page by clicking the link below:</p>  
    <p><a th:href="@{${loginurl}}">Login Page</a></p>  
    <p>For security reasons, once you log in, you will be prompted to reset your password.</p>  
    <p>If you have any questions or need assistance, feel free to reach out to your SPOC.</p>  
    <br>  
    <p>Best regards,<br>The DronaPay Team</p>' AS body,  
    'Welcome to DronaPay - User Account Reset Information' AS subject,  
    'drona' AS associateid
FROM ui.tenants t
WHERE NOT EXISTS (
    SELECT 1 FROM ui.emailtemplate e 
    WHERE e.id = 33 AND e.itenantid = t.itenantid
) and t.itenantid !=0
RETURNING id, itenantid;

UPDATE ui.emailtemplate  
SET body =  
'<p>Hello,</p>  
<p>We have received a request to reset your password.</p>  
<p>To proceed with resetting your password, please click the link below:</p>  
<p><a th:href="@{${dronauiurl} + ''/auth/reset-password?token='' + ${resetToken}}">Change my password</a></p>  
<p>If you did not request this change or if you remember your password, please disregard this email.</p>  
<p>For any further assistance, feel free to reach out to your SPOC.</p>  
<br>  
<p>Best regards,<br>The DronaPay Team</p>',  
subject = 'Password Reset Request for Your DronaPay Account'  
WHERE id = 5;

