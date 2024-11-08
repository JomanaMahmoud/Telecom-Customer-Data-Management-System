-- 2.4 j 

go
CREATE PROC Top_Successful_Payments 
@MobileNo CHAR(11) 
AS
SELECT TOP 10 *  --selects top 10 based on amount
FROM Payment p
WHERE p.mobileNo = @MobileNo AND p.status = 'successful'
ORDER BY p.amount DESC
go

-- 2.4 L
go
CREATE PROC Initiate_plan_payment
@MobileNo CHAR(11),@amount decimal(10,1),@payment_method varchar(50),@plan_id int
AS
BEGIN 
INSERT INTO Payment (amount, date_of_payment, payment_method, status, mobileNo)
VALUES (@amount, GETDATE(), @payment_method, 'accepted', @mobileNo);
UPDATE Subscription
SET status = 'active',subscription_date = GETDATE() 
WHERE mobileNo = @MobileNo AND planID = @plan_id;
END 
go

-- 2.4 m

go
CREATE PROC Payment_wallet_cashback
@MobileNo CHAR(11),@payment_id int,@benefit_id int
AS
BEGIN

DECLARE @CashbackAmount DECIMAL(10, 2);
DECLARE @PaymentAmount DECIMAL(10, 2);
DECLARE @WalletID INT;

-- get payment amount to calculate cashback
SELECT @PaymentAmount = amount
FROM Payment p
WHERE p.paymentID = @Payment_ID AND p.mobileNo = @MobileNo

-- calculate the cashback (10%)
SET @CashbackAmount = @PaymentAmount * 0.10;

-- find wallet based on mobile to add cashback
SELECT @WalletID = walletID
FROM Wallet w
WHERE w.mobileNo = @MobileNo

--add cashback on wallet
UPDATE Wallet
SET current_balance = current_balance + @CashbackAmount,last_modified_date = GETDATE()
WHERE walletID = @WalletID;

--update cashback table with new cashback record
INSERT INTO Cashback (benefitID, walletID, amount, credit_date)
VALUES (@Benefit_ID, @WalletID, @CashbackAmount, GETDATE());

END
go