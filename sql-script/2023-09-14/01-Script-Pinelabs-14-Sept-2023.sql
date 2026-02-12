UPDATE ui.emailtemplate SET
body = '<p>Dear <span th:text="${merchantName}">Merchant</span> ,</p>
<p>Gentle Reminder!!</p>
<p>This is to kindly remind you about our previous email regarding a risky transaction that we identified on your platform. We understand that you may have been busy, and we genuinely appreciate your cooperation in providing us with the requested information.</p>
<p>As mentioned before, the transaction in question has raised concerns due to its potentially risky nature. To ensure the security and integrity of our operations, it is essential that we receive the requested details from you.</p>
<p>Your prompt attention to this matter is important, and we kindly request you to provide the requested information at your earliest convenience. Your cooperation in this regard will greatly assist us in conducting a thorough investigation and addressing any potential security issues.</p>
<p>Thank you for your attention to this reminder. We look forward to receiving your response soon.</p>
<p>Sincerely,</p>
<p>Pine Labs Team
'::text WHERE
id = 13;
