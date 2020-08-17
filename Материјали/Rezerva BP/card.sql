SELECT 
	   cardName,
	   typeName,
       name,
       surname,
       currentBalance,
       currencyName,
       creationDate,
	   expiryDate,
       statusName,
       cardSerial

FROM ebank.card

INNER JOIN ebank.card_type ON card.typeID = card_type.typeID
INNER JOIN ebank.card_name ON card.nameID = card_name.nameID
INNER JOIN ebank.card_status ON card.statusID = card_status.statusID
INNER JOIN ebank.currency ON card.currencyID = currency.currencyID
INNER JOIN ebank.card_serial_pool ON card.cardID = card_serial_pool.cardSerialID
INNER JOIN ebank.user ON card.userID = user.userID