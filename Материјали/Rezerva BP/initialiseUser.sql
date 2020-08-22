CREATE DEFINER=`root`@`localhost` PROCEDURE `initialize_user`(
IN 
email VARCHAR(45),
password VARCHAR(60),
name VARCHAR(45),
surname VARCHAR(45),
number VARCHAR(45),
hnumber SMALLINT(10) 
)
BEGIN

DECLARE EXIT HANDLER FOR SQLEXCEPTION
 BEGIN
	/*GET DIAGNOSTICS CONDITION 1
    @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
    SELECT @p1 AS "SQL_STATE", @p2 AS "MESSAGE";*/
    GET DIAGNOSTICS @p1 = NUMBER, @p2 = ROW_COUNT;
    SELECT @p1, @p2;
    ROLLBACK;
 END;

-- 1. Start a new transaction
START TRANSACTION;

-- 2. Insert a new account
INSERT INTO account
 (
 currentBalance,
 garnishment,
 currencyID,
 dateOpened,
 dateClosed,
 userID
 )
VALUES
 (
"1",
"0",
"1",
"0100-00-00",
"0000-00-00",
"2"
 );

-- 3. Save the last inesrted accountID
SELECT @lastAccountID:=LAST_INSERT_ID();

-- 4. Insert a new user
INSERT INTO user
 (
  email,
  password,
  name,
  surname,
  number,
  address,
  hnumber,
  dateRegistered,
  defaultAccountID
 )
VALUES
 (
  email,
  password,
  name,
  surname,
  number,
  address,
  hnumber,
  TODAY(),
  "183"
 );

-- 5. Save the last inesrted userID
SELECT @lastUserID:=LAST_INSERT_ID();

-- 6. Insert a new card
INSERT INTO card
 (
  typeID,
  nameID,
  creationDate,
  expiryDate,
  statusID,
  userID
 )
VALUES
 (
  "2",
  "1",
  "0000-00-00",
  "0000-00-00",
  "1",
  "2"
 );

-- 7. Save the last inesrted cardID
SELECT @lastCardID:=LAST_INSERT_ID();

-- 8. Update userID in account
UPDATE account
SET userID = @lastUserID
WHERE accountID = @lastAccountID;

-- 9. Update accountID in user
UPDATE user
SET defaultAccountID = @lastAccountID
WHERE userID = @lastUserID;

-- 10. Update userID in card
UPDATE card
SET userID = @lastUserID
WHERE cardID = @lastCardID;

-- 11. Update accountID in card
UPDATE carSd
SET accountID = @lastAccountID
WHERE cardID = @lastCardID;

-- 12. Commit changes
COMMIT;

SELECT "C369" AS "SQL_STATE", "OK" AS "MESSAGE";
END