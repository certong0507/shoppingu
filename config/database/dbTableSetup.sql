-- 0.0.2 Certong 6/11/2017 
-- Create table script. 
UPDATE db_version SET Version = '0.0.2', LastUpdatedDate = NOW(), LastUpdatedBy = 'Certong' WHERE ID = 1;

CREATE TABLE IF NOT EXISTS t_country (
	CountryID VARCHAR(36) NOT NULL,
    CountryCode CHAR(3) NOT NULL,
    CountryName VARCHAR(45) NOT NULL,
    PRIMARY KEY (CountryID)
)engine=InnoDB;

CREATE TABLE IF NOT EXISTS t_currency (
	CurrencyID VARCHAR(36) NOT NULL,
    CurrencyCode CHAR(5) NOT NULL,
    CurrencyName VARCHAR(45) NOT NULL,
    PRIMARY KEY (CurrencyID)
)engine=InnoDB;

CREATE TABLE IF NOT EXISTS t_product_cat (
	ProductCatID VARCHAR(36) NOT NULL,
    ProductCatDesc VARCHAR(500) NOT NULL,
    IsActive INT(1) NOT NULL,
    Remarks VARCHAR(500) NULL,
    CreatedDate Datetime NOT NULL,
    CreatedBy VARCHAR(36) NOT NULL,
	LastUpdatedDate Datetime NOT NULL,
    LastUpdatedBy VARCHAR(36) NOT NULL,
    PRIMARY KEY (ProductCatID)
)engine=InnoDB;

CREATE TABLE IF NOT EXISTS t_profile (
	ProfileID VARCHAR(36) NOT NULL,
    FirstName VARCHAR(45) NOT NULL,
    LastName VARCHAR(45) NOT NULL,
    FullName VARCHAR(45) NOT NULL,
    Address VARCHAR(500) NULL,
    Gender INT(11) NOT NULL,
    DOB DATETIME,
    Remarks VARCHAR(500) NULL,
    CreatedDate Datetime NOT NULL,
    CreatedBy VARCHAR(36) NOT NULL,
	LastUpdatedDate Datetime NOT NULL,
    LastUpdatedBy VARCHAR(36) NOT NULL,
    PRIMARY KEY (ProfileID)
)engine=InnoDB;


CREATE TABLE IF NOT EXISTS t_profile_document (
	ProfileDocumentID VARCHAR(36) NOT NULL,
    ProfileID VARCHAR(45) NOT NULL,
    DocumentName VARCHAR(500) NOT NULL,
    DocumentType CHAR(20) NOT NULL,
    DocumentPath VARCHAR(500) NOT NULL,
    Remarks VARCHAR(500) NULL,
    CreatedDate Datetime NOT NULL,
    CreatedBy VARCHAR(36) NOT NULL,
	LastUpdatedDate Datetime NOT NULL,
    LastUpdatedBy VARCHAR(36) NOT NULL,
    PRIMARY KEY (ProfileDocumentID),
    
    FOREIGN KEY fk_ProfileID(ProfileID)
    REFERENCES t_profile(ProfileID)
    ON UPDATE CASCADE
	ON DELETE RESTRICT
)engine=InnoDB;

CREATE TABLE IF NOT EXISTS t_profile_account (
	ProfileAccountID VARCHAR(36) NOT NULL,
    ProfileID VARCHAR(45) NOT NULL,
    LoginID INT(11) NOT NULL,
    SaltPass VARBINARY(100) NOT NULL,
    HashPass VARBINARY(100) NULL,
    RetryCount INT(11) NOT NULL,
    IsActive INT(1),
    Remarks VARCHAR(500) NULL,
    CreatedDate Datetime NOT NULL,
    CreatedBy VARCHAR(36) NOT NULL,
	LastUpdatedDate Datetime NOT NULL,
    LastUpdatedBy VARCHAR(36) NOT NULL,
    PRIMARY KEY (ProfileAccountID),
    
    FOREIGN KEY fk_ProfileID(ProfileID)
    REFERENCES t_profile(ProfileID)
    ON UPDATE CASCADE
	ON DELETE RESTRICT
)engine=InnoDB;

CREATE TABLE IF NOT EXISTS t_travel (
	TravelID VARCHAR(36) NOT NULL,
    ProfileID VARCHAR(45) NOT NULL,
    CountryID VARCHAR(45) NOT NULL,
    TravelDescription VARCHAR(500) NOT NULL,
    TravelStartDate Datetime NOT NULL,
    TravelEndDate Datetime NOT NULL,
    IsExpired INT(1) NOT NULL,
    Remarks VARCHAR(500) NULL,
    CreatedDate Datetime NOT NULL,
    CreatedBy VARCHAR(36) NOT NULL,
	LastUpdatedDate Datetime NOT NULL,
    LastUpdatedBy VARCHAR(36) NOT NULL,
    PRIMARY KEY (TravelID),
    
    FOREIGN KEY fk_ProfileID(ProfileID)
    REFERENCES t_profile(ProfileID)
    ON UPDATE CASCADE
	ON DELETE RESTRICT,
    
    FOREIGN KEY fk_CountryID(CountryID)
    REFERENCES t_country(CountryID)
    ON UPDATE CASCADE
	ON DELETE RESTRICT
)engine=InnoDB;

CREATE TABLE IF NOT EXISTS t_product (
	ProductID VARCHAR(36) NOT NULL,
    ProfileID VARCHAR(36) NOT NULL,
    TravelID VARCHAR(36) NOT NULL,
    Description VARCHAR(500) NOT NULL,
    Amount Decimal(10,3) NULL,
    IsActive Int(1) NOT NULL,
    Remarks VARCHAR(500) NULL,
    CreatedDate Datetime NOT NULL,
    CreatedBy VARCHAR(36) NOT NULL,
	LastUpdatedDate Datetime NOT NULL,
    LastUpdatedBy VARCHAR(36) NOT NULL,
    PRIMARY KEY (ProductID),
    
    FOREIGN KEY fk_ProfileID(ProfileID)
    REFERENCES t_profile(ProfileID)
    ON UPDATE CASCADE
	ON DELETE RESTRICT,
   
	FOREIGN KEY fk_TravelID(TravelID)
    REFERENCES t_travel(TravelID)
    ON UPDATE CASCADE
	ON DELETE RESTRICT
)engine=InnoDB;

CREATE TABLE IF NOT EXISTS t_product_subCat (
	ProductSubCatID VARCHAR(36) NOT NULL,
    ProductCatID VARCHAR(36) NOT NULL,
    ProductSubCatDesc VARCHAR(500) NOT NULL,
    IsActive INT(1) NOT NULL,
    Remarks VARCHAR(500) NULL,
    CreatedDate Datetime NOT NULL,
    CreatedBy VARCHAR(36) NOT NULL,
	LastUpdatedDate Datetime NOT NULL,
    LastUpdatedBy VARCHAR(36) NOT NULL,
    PRIMARY KEY (ProductSubCatID),

	FOREIGN KEY fk_ProductCatID(ProductCatID)
    REFERENCES t_product_cat(ProductCatID)
    ON UPDATE CASCADE
	ON DELETE RESTRICT
)engine=InnoDB;

CREATE TABLE IF NOT EXISTS t_product_detail (
	ProductDetailID VARCHAR(36) NOT NULL,
    ProductID VARCHAR(36) NOT NULL,
    ProductCatID VARCHAR(36) NOT NULL,
    ProductSubCatID VARCHAR(36) NOT NULL,
    CurrencyID VARCHAR(36) NOT NULL,
    DetailDescription VARCHAR(3000) NOT NULL,
    Amount Decimal(10,3) NULL,
    Status Int(2) NOT NULL,
    Remarks VARCHAR(500) NOT NULL,
    CreatedDate Datetime NOT NULL,
    CreatedBy VARCHAR(36) NOT NULL,
	LastUpdatedDate Datetime NOT NULL,
    LastUpdatedBy VARCHAR(36) NOT NULL,
    PRIMARY KEY (ProductDetailID),
    
    FOREIGN KEY fk_ProductCatID(ProductCatID)
    REFERENCES t_product_cat(ProductCatID)
    ON UPDATE CASCADE
	ON DELETE RESTRICT,
   
	FOREIGN KEY fk_ProductID(ProductID)
    REFERENCES t_product(ProductID)
    ON UPDATE CASCADE
	ON DELETE RESTRICT,
    
    FOREIGN KEY fk_ProductSubCatID(ProductSubCatID)
    REFERENCES t_product_subCat(ProductSubCatID)
    ON UPDATE CASCADE
	ON DELETE RESTRICT
)engine=InnoDB;

CREATE TABLE IF NOT EXISTS t_product_document (
	ProductDocumentID VARCHAR(36) NOT NULL,
    ProductDetailID VARCHAR(36) NOT NULL,
    DocumentName VARCHAR(500) NOT NULL,
    DocumentType CHAR(20) NOT NULL,
    DocumentPath VARCHAR(500) NOT NULL,
    Remarks VARCHAR(500) NULL,
    CreatedDate Datetime NOT NULL,
    CreatedBy VARCHAR(36) NOT NULL,
	LastUpdatedDate Datetime NOT NULL,
    LastUpdatedBy VARCHAR(36) NOT NULL,
    PRIMARY KEY (ProductDocumentID),

	FOREIGN KEY fk_ProductDetailID(ProductDetailID)
    REFERENCES t_product_detail(ProductDetailID)
    ON UPDATE CASCADE
	ON DELETE RESTRICT
)engine=InnoDB;

-- End 0.0.2 Certong 6/11/2017

-- 0.0.3 ChengYew 12/11/2017
-- Change T_Profile_Account HashPass data type and set SaltPass to not null.
UPDATE db_version SET Version = '0.0.3', LastUpdatedDate = NOW(), LastUpdatedBy = 'ChengYew' WHERE ID = 1;

ALTER TABLE `T_Profile_Account` CHANGE COLUMN `SaltPass` `SaltPass` VARCHAR(1000)  NULL  , CHANGE COLUMN `HashPass` `HashPass` VARCHAR(1000)  NOT NULL  ;
-- End 0.0.3 ChengYew 12/11/2017

-- 0.0.4 ChengYew 14/11/2017
-- Country and Category Settings
UPDATE db_version SET Version = '0.0.4', LastUpdatedDate = NOW(), LastUpdatedBy = 'ChengYew' WHERE ID = 1;

-- END 0.0.4 ChengYew 14/11/2017

-- 0.0.5 CerTong 14/11/2017
-- Add new columns in t_profile.
UPDATE db_version SET Version = '0.0.5', LastUpdatedDate = NOW(), LastUpdatedBy = 'CerTong' WHERE ID = 1;

DROP PROCEDURE IF EXISTS shoppingu_procedure;
DELIMITER $$
CREATE PROCEDURE shoppingu_procedure()
BEGIN
	IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS WHERE TABLE_NAME = 't_profile' AND COLUMN_NAME = 'email') THEN
		ALTER TABLE t_profile ADD COLUMN Email VARCHAR(45) NULL AFTER Address;
    END IF;

    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS WHERE TABLE_NAME = 't_profile' AND COLUMN_NAME = 'ContactNo') THEN
		ALTER TABLE t_profile ADD COLUMN ContactNo VARCHAR(45) NULL AFTER Email;
    END IF;
END$$
DELIMITER ;

CALL shoppingu_procedure();
-- END 0.0.5 CerTong 14/11/2017

-- 0.0.6 CerTong 14/11/2017
-- Modify table t_profile_account.
UPDATE db_version SET Version = '0.0.6', LastUpdatedDate = NOW(), LastUpdatedBy = 'CerTong' WHERE ID = 1;

DROP PROCEDURE IF EXISTS shoppingu_procedure;
DELIMITER $$
CREATE PROCEDURE shoppingu_procedure()
BEGIN
	IF EXISTS (SELECT * FROM information_schema.COLUMNS WHERE TABLE_NAME = 't_profile_account' AND COLUMN_NAME = 'LoginID') THEN
		ALTER TABLE t_profile_account MODIFY LoginID VARCHAR(36);
    END IF;
END$$
DELIMITER ;

CALL shoppingu_procedure();
-- END 0.0.6 CerTong 14/11/2017

-- 0.0.7 CerTong 18/11/2017
-- Modify table t_product_detail, add column ProductName.
UPDATE db_version SET Version = '0.0.7', LastUpdatedDate = NOW(), LastUpdatedBy = 'CerTong' WHERE ID = 1;

DROP PROCEDURE IF EXISTS shoppingu_procedure;
DELIMITER $$
CREATE PROCEDURE shoppingu_procedure()
BEGIN
	IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS WHERE TABLE_NAME = 't_product_detail' AND COLUMN_NAME = 'ProductName') THEN
		ALTER TABLE t_product_detail ADD COLUMN ProductName VARCHAR(50) NOT NULL AFTER CurrencyID;
    END IF;
END$$
DELIMITER ;

CALL shoppingu_procedure();
-- END 0.0.7 CerTong 18/11/2017

-- 0.0.8 ChengYew 20/11/2017
-- Add 'Status' column into T_Country table.
UPDATE db_version SET Version = '0.0.8', LastUpdatedDate = NOW(), LastUpdatedBy = 'ChengYew' WHERE ID = 1;

DROP PROCEDURE IF EXISTS shoppingu_procedure;
DELIMITER $$
CREATE PROCEDURE shoppingu_procedure()
BEGIN
	IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS WHERE TABLE_NAME = 'T_Country' AND COLUMN_NAME = 'Status') THEN
		ALTER TABLE T_Country ADD COLUMN Status INT NOT NULL AFTER CountryName;
        
        UPDATE T_Country
        SET Status=0
        WHERE Status IS NULL;
    END IF;
END$$
DELIMITER ;

CALL shoppingu_procedure();
-- END ChengYew 20/11/2017