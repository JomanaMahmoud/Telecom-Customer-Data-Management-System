CREATE DATABASE Telecom_Team_64

GO

USE Telecom_Team_64

GO
CREATE PROCEDURE createAllTables
AS
BEGIN
	CREATE TABLE Customer_profile( 
	nationalID int PRIMARY KEY,
	first_name varchar(50),
	last_name varchar(50),
	email varchar(50),
	address varchar(50),
	date_of_birth date)

	CREATE TABLE Customer_Account(
	mobileNo char(11) PRIMARY KEY,
	pass varchar(50),
	balance decimal(10,1),
	account_type varchar(50),
	start_date date,
	status varchar(50),
	point int,
	nationalID int FOREIGN KEY references Customer_profile(nationalID))

	CREATE TABLE Service_Plan(
	planID int PRIMARY KEY IDENTITY(1,1),
	SMS_offered int,
	minutes_offered int,
	data_offered int,
	name varchar(50),
	price int,
	description varchar(50))

	CREATE TABLE Subscription(
	mobileNo char(11) PRIMARY KEY,
	planID int PRIMARY KEY IDENTITY(1,1),
	subscription_date date,
	status varchar(50),
	FOREIGN KEY (mobileNo) references Customer_Account(mobileNo),
	FOREIGN KEY (planID) references Service_Plan(planID))

	CREATE TABLE Plan_Usage(
	usageID int PRIMARY KEY IDENTITY(1,1),
	start_date date,
	end_date date,
	data_consumption int,
	minutes_used int,
	SMS_sent int,
	mobileNo char(11) FOREIGN KEY references Customer_Account(mobileNo),
	planID int FOREIGN KEY references Service_Plan(planID))

	CREATE TABLE Payment(
	paymentID int PRIMARY KEY IDENTITY(1,1),
	amount decimal(10,1),
	date_of_payment date,
	payment_method varchar(50),
	status varchar(50),
	mobileNo char(11) FOREIGN KEY references Customer_Account(mobileNo))

	CREATE TABLE Process_Payment(
	paymentID int PRIMARY KEY IDENTITY(1,1),
	planID int FOREIGN KEY REFERENCES Service_Plan(planID),
    remaining_balance AS (
        CASE 
            WHEN (SELECT amount FROM Payment WHERE Payment.paymentID = Process_Payment.paymentID) < 
                 (SELECT price FROM Service_Plan WHERE Service_Plan.planID = Process_Payment.planID)
            THEN (SELECT price FROM Service_Plan WHERE Service_Plan.planID = Process_Payment.planID) - 
                 (SELECT amount FROM Payment WHERE Payment.paymentID = Process_Payment.paymentID)
			ELSE 0
		END
    ),
    extra_amount AS (
        CASE 
            WHEN (SELECT amount FROM Payment WHERE Payment.paymentID = Process_Payment.paymentID) > 
                 (SELECT price FROM Service_Plan WHERE Service_Plan.planID = Process_Payment.planID)
            THEN (SELECT amount FROM Payment WHERE Payment.paymentID = Process_Payment.paymentID) - 
                 (SELECT price FROM Service_Plan WHERE Service_Plan.planID = Process_Payment.planID)
			ELSE 0
		END
    ),
    FOREIGN KEY (paymentID) REFERENCES Payment(paymentID))

	CREATE TABLE Wallet(
	walletID int PRIMARY KEY IDENTITY(1,1),
	current_balance decimal(10,2),
	currency varchar(50),
	last_modified_date date,
	nationalID int FOREIGN KEY references Customer_profile(nationalID),
	mobileNo char(11))

	CREATE TABLE Transfer_money(
	walletID1 int PRIMARY KEY IDENTITY(1,1),
	walletID2 int PRIMARY KEY IDENTITY(1,1),
	transfer_id int PRIMARY KEY IDENTITY(1,1),
	amount decimal(10,2),
	transfer_date date,
	walletID1 int FOREIGN KEY references Wallet(walletID),
	walletID2 int FOREIGN KEY references Wallet(walletID))

	CREATE TABLE Benefits(
	benefitID int PRIMARY KEY IDENTITY(1,1),
	description varchar(50),
	validity_date date,
	status varchar(50),	
	mobileNo char(11) FOREIGN KEY references Customer_Account(mobileNo))

	CREATE TABLE Points_Group(
	pointID int PRIMARY KEY IDENTITY(1,1),
	benefitID int PRIMARY KEY IDENTITY(1,1),
	pointsAmount int,
	benefitID int FOREIGN KEY references Benefits(benefitID),
	PaymentID int FOREIGN KEY references Payment(PaymentID))

	CREATE TABLE Exclusive_Offer(
	OfferID int PRIMARY KEY IDENTITY(1,1),
	benefitID int PRIMARY KEY IDENTITY(1,1),
	internet_offered int,
	SMS_offered int,	
	minutes_offered int,
	benefitID int FOREIGN KEY references Benefits(benefitID))

	CREATE TABLE Cashback(
	CashbackID int PRIMARY KEY IDENTITY(1,1),
	benefitID int PRIMARY KEY IDENTITY(1,1),
	walletID int FOREIGN KEY references Wallet(walletID),
	amount int,
	credit_date date,
	benefitID int FOREIGN KEY references Benefits(benefitID))

	CREATE TABLE Plan_Provides_Benefits(
	benefitID int PRIMARY KEY IDENTITY(1,1),
	planID int PRIMARY KEY IDENTITY(1,1),
	benefitID int FOREIGN KEY references Benefits(benefitID),
	planID int FOREIGN KEY references Service_Plan(planID))

	CREATE TABLE Shop(
	shopID int PRIMARY KEY IDENTITY(1,1),
	name varchar(50),
	category varchar(50))

	CREATE TABLE Physical_Shop(
	shopID int PRIMARY KEY IDENTITY(1,1),
	address varchar(50),
	working_hours varchar(50),
	shopID int FOREIGN KEY references Shop(shopID))

	CREATE TABLE E_shop(
	shopID int PRIMARY KEY IDENTITY(1,1),
	URL varchar(50),
	rating int,
	shopID int FOREIGN KEY references Shop(shopID))

	CREATE TABLE Voucher(
	voucherID int PRIMARY KEY IDENTITY(1,1),
	value int,
	expiry_date date,
	points int,
	mobileNo char(11) FOREIGN KEY references Customer_Account(mobileNo),
	shopID int FOREIGN KEY references Shop(shopID),
	redeem_date date)

	CREATE TABLE Technical_Support_Ticket(
	ticketID int PRIMARY KEY IDENTITY(1,1),
	mobileNo char(11) PRIMARY KEY,
	Issue_description varchar(50),
	priority_level int,
	status varchar(50),
	mobileNo char(11) FOREIGN KEY references Customer_Account(mobileNo))
END
GO

EXEC createAllTables

GO
CREATE PROCEDURE dropAllTables
AS
BEGIN
DROP TABLE Customer_profile
DROP TABLE Customer_Account
DROP TABLE Service_Plan
DROP TABLE Subscription
DROP TABLE Plan_Usage
DROP TABLE Payment
DROP TABLE Process_Payment
DROP TABLE Wallet
DROP TABLE Transfer_money
DROP TABLE Benefits
DROP TABLE Points_Group
DROP TABLE Exclusive_Offer
DROP TABLE Cashback
DROP TABLE Plan_Provides_Benefits
DROP TABLE Shop
DROP TABLE Physical_Shop
DROP TABLE E_shop
DROP TABLE Voucher
DROP TABLE Technical_Support_Ticket
END
GO

EXEC dropAllTables


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
