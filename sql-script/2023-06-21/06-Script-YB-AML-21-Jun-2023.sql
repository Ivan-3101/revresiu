INSERT INTO ui.emailtemplate (id, body, subject, associateid) VALUES (4, '<p>Ticket no <span th:text="${ticketId}"></span> is still Open. Ticket was created on <span th:text="${createdDate}"></span></p>', 'QC Alert | [(${ticketId})]', 'ybqc');
INSERT INTO ui.emailtemplate (id, body, subject, associateid) VALUES (3, '<p>Hii <span th:text="${name}"></span>,</p>
<br>
<p>A Case is assigned to you with case id : <span th:text="${ticketId}"> </span></p>
<br>
<p>Comment : <span th:text="${comment}"> </span> </p>
<br>
<p>AML Team</p>', 'AML Alert | [(${ticketId})]', 'ybaml');