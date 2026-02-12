UPDATE ui.emailtemplate	SET subject='TransactionId#:[(${transactionId})] | Hold on Identified Risky Transaction', camunda_message_name='response_from_merchant' WHERE id=11;
	
UPDATE ui.emailtemplate	SET subject='TransactionId#:[(${transactionId})] | Request for Information Regarding Identified Risky Transaction', camunda_message_name='response_from_merchant' WHERE id=12;

UPDATE ui.emailtemplate	SET subject='TransactionId#:[(${transactionId})] | Transaction Settlement Processed' WHERE id=13;