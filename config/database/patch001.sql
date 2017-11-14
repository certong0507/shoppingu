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
UPDATE db_version SET Version = '0.0.4', LastUpdatedDate = NOW(), LastUpdatedBy = 'ChengYew' WHERE ID = 1;

ALTER TABLE `SHOPPINGU_TEST`.`T_Profile_Account` CHANGE COLUMN `SaltPass` `SaltPass` VARCHAR(1000)  NULL  , CHANGE COLUMN `HashPass` `HashPass` VARCHAR(1000)  NOT NULL  ;

-- End 0.0.3 ChengYew 12/11/2017

-- 0.0.4 ChengYew 14/11/2017
--Country and Category data insert
INSERT INTO T_Country VALUES ('ed71ddf4-95e5-11e7-b85b-5d64dd272c67','AF','Afghanistan');
INSERT INTO T_Country VALUES ('ed7212ec-95e5-11e7-b85b-5d64dd272c67','AL','Albania');
INSERT INTO T_Country VALUES ('ed7249e2-95e5-11e7-b85b-5d64dd272c67','DZ','Algeria');
INSERT INTO T_Country VALUES ('ed7281d2-95e5-11e7-b85b-5d64dd272c67','DS','American Samoa');
INSERT INTO T_Country VALUES ('ed72b65c-95e5-11e7-b85b-5d64dd272c67','AD','Andorra');
INSERT INTO T_Country VALUES ('ed72e118-95e5-11e7-b85b-5d64dd272c67','AO','Angola');
INSERT INTO T_Country VALUES ('ed73328a-95e5-11e7-b85b-5d64dd272c67','AI','Anguilla');
INSERT INTO T_Country VALUES ('ed7365d4-95e5-11e7-b85b-5d64dd272c67','AQ','Antarctica');
INSERT INTO T_Country VALUES ('ed739838-95e5-11e7-b85b-5d64dd272c67','AG','Antigua and Barbuda');
INSERT INTO T_Country VALUES ('ed73c89e-95e5-11e7-b85b-5d64dd272c67','AR','Argentina');
INSERT INTO T_Country VALUES ('ed73f184-95e5-11e7-b85b-5d64dd272c67','AM','Armenia');
INSERT INTO T_Country VALUES ('ed744f9e-95e5-11e7-b85b-5d64dd272c67','AW','Aruba');
INSERT INTO T_Country VALUES ('ed7482d4-95e5-11e7-b85b-5d64dd272c67','AU','Australia');
INSERT INTO T_Country VALUES ('ed74a91c-95e5-11e7-b85b-5d64dd272c67','AT','Austria');
INSERT INTO T_Country VALUES ('ed74cf82-95e5-11e7-b85b-5d64dd272c67','AZ','Azerbaijan');
INSERT INTO T_Country VALUES ('ed74fbf6-95e5-11e7-b85b-5d64dd272c67','BS','Bahamas');
INSERT INTO T_Country VALUES ('ed753d50-95e5-11e7-b85b-5d64dd272c67','BH','Bahrain');
INSERT INTO T_Country VALUES ('ed756ece-95e5-11e7-b85b-5d64dd272c67','BD','Bangladesh');
INSERT INTO T_Country VALUES ('ed75957a-95e5-11e7-b85b-5d64dd272c67','BB','Barbados');
INSERT INTO T_Country VALUES ('ed75bcb2-95e5-11e7-b85b-5d64dd272c67','BY','Belarus');
INSERT INTO T_Country VALUES ('ed75df8a-95e5-11e7-b85b-5d64dd272c67','BE','Belgium');
INSERT INTO T_Country VALUES ('ed76071c-95e5-11e7-b85b-5d64dd272c67','BZ','Belize');
INSERT INTO T_Country VALUES ('ed7632be-95e5-11e7-b85b-5d64dd272c67','BJ','Benin');
INSERT INTO T_Country VALUES ('ed765b7c-95e5-11e7-b85b-5d64dd272c67','BM','Bermuda');
INSERT INTO T_Country VALUES ('ed767d6e-95e5-11e7-b85b-5d64dd272c67','BT','Bhutan');
INSERT INTO T_Country VALUES ('ed769a92-95e5-11e7-b85b-5d64dd272c67','BO','Bolivia');
INSERT INTO T_Country VALUES ('ed76bd56-95e5-11e7-b85b-5d64dd272c67','BA','Bosnia and Herzegovina');
INSERT INTO T_Country VALUES ('ed76dbec-95e5-11e7-b85b-5d64dd272c67','BW','Botswana');
INSERT INTO T_Country VALUES ('ed770086-95e5-11e7-b85b-5d64dd272c67','BV','Bouvet Island');
INSERT INTO T_Country VALUES ('ed7724ee-95e5-11e7-b85b-5d64dd272c67','BR','Brazil');
INSERT INTO T_Country VALUES ('ed774bb8-95e5-11e7-b85b-5d64dd272c67','IO','British Indian Ocean Territory');
INSERT INTO T_Country VALUES ('ed776dd2-95e5-11e7-b85b-5d64dd272c67','BN','Brunei Darussalam');
INSERT INTO T_Country VALUES ('ed7790be-95e5-11e7-b85b-5d64dd272c67','BG','Bulgaria');
INSERT INTO T_Country VALUES ('ed77b4ea-95e5-11e7-b85b-5d64dd272c67','BF','Burkina Faso');
INSERT INTO T_Country VALUES ('ed7800ee-95e5-11e7-b85b-5d64dd272c67','BI','Burundi');
INSERT INTO T_Country VALUES ('ed782ccc-95e5-11e7-b85b-5d64dd272c67','KH','Cambodia');
INSERT INTO T_Country VALUES ('ed784e3c-95e5-11e7-b85b-5d64dd272c67','CM','Cameroon');
INSERT INTO T_Country VALUES ('ed786bc4-95e5-11e7-b85b-5d64dd272c67','CA','Canada');
INSERT INTO T_Country VALUES ('ed788a3c-95e5-11e7-b85b-5d64dd272c67','CV','Cape Verde');
INSERT INTO T_Country VALUES ('ed78a6ac-95e5-11e7-b85b-5d64dd272c67','KY','Cayman Islands');
INSERT INTO T_Country VALUES ('ed78c380-95e5-11e7-b85b-5d64dd272c67','CF','Central African Republic');
INSERT INTO T_Country VALUES ('ed78e2d4-95e5-11e7-b85b-5d64dd272c67','TD','Chad');
INSERT INTO T_Country VALUES ('ed79032c-95e5-11e7-b85b-5d64dd272c67','CL','Chile');
INSERT INTO T_Country VALUES ('ed792352-95e5-11e7-b85b-5d64dd272c67','CN','China');
INSERT INTO T_Country VALUES ('ed793d06-95e5-11e7-b85b-5d64dd272c67','CX','Christmas Island');
INSERT INTO T_Country VALUES ('ed7955f2-95e5-11e7-b85b-5d64dd272c67','CC','Cocos (Keeling) Islands');
INSERT INTO T_Country VALUES ('ed7979e2-95e5-11e7-b85b-5d64dd272c67','CO','Colombia');
INSERT INTO T_Country VALUES ('ed7999b8-95e5-11e7-b85b-5d64dd272c67','KM','Comoros');
INSERT INTO T_Country VALUES ('ed79b3b2-95e5-11e7-b85b-5d64dd272c67','CG','Congo');
INSERT INTO T_Country VALUES ('ed79ceba-95e5-11e7-b85b-5d64dd272c67','CK','Cook Islands');
INSERT INTO T_Country VALUES ('ed79e710-95e5-11e7-b85b-5d64dd272c67','CR','Costa Rica');
INSERT INTO T_Country VALUES ('ed79ff48-95e5-11e7-b85b-5d64dd272c67','HR','Croatia (Hrvatska)');
INSERT INTO T_Country VALUES ('ed7a1866-95e5-11e7-b85b-5d64dd272c67','CU','Cuba');
INSERT INTO T_Country VALUES ('ed7a31b6-95e5-11e7-b85b-5d64dd272c67','CY','Cyprus');
INSERT INTO T_Country VALUES ('ed7a62c6-95e5-11e7-b85b-5d64dd272c67','CZ','Czech Republic');
INSERT INTO T_Country VALUES ('ed7a83b4-95e5-11e7-b85b-5d64dd272c67','DK','Denmark');
INSERT INTO T_Country VALUES ('ed7a9f5c-95e5-11e7-b85b-5d64dd272c67','DJ','Djibouti');
INSERT INTO T_Country VALUES ('ed7ab618-95e5-11e7-b85b-5d64dd272c67','DM','Dominica');
INSERT INTO T_Country VALUES ('ed7ace82-95e5-11e7-b85b-5d64dd272c67','DO','Dominican Republic');
INSERT INTO T_Country VALUES ('ed7ae610-95e5-11e7-b85b-5d64dd272c67','TP','East Timor');
INSERT INTO T_Country VALUES ('ed7afb82-95e5-11e7-b85b-5d64dd272c67','EC','Ecuador');
INSERT INTO T_Country VALUES ('ed7b233c-95e5-11e7-b85b-5d64dd272c67','EG','Egypt');
INSERT INTO T_Country VALUES ('ed7b41b4-95e5-11e7-b85b-5d64dd272c67','SV','El Salvador');
INSERT INTO T_Country VALUES ('ed7b5ece-95e5-11e7-b85b-5d64dd272c67','GQ','Equatorial Guinea');
INSERT INTO T_Country VALUES ('ed7b76c0-95e5-11e7-b85b-5d64dd272c67','ER','Eritrea');
INSERT INTO T_Country VALUES ('ed7b904c-95e5-11e7-b85b-5d64dd272c67','EE','Estonia');
INSERT INTO T_Country VALUES ('ed7ba7d0-95e5-11e7-b85b-5d64dd272c67','ET','Ethiopia');
INSERT INTO T_Country VALUES ('ed7bbe46-95e5-11e7-b85b-5d64dd272c67','FK','Falkland Islands (Malvinas)');
INSERT INTO T_Country VALUES ('ed7bda52-95e5-11e7-b85b-5d64dd272c67','FO','Faroe Islands');
INSERT INTO T_Country VALUES ('ed7bfb7c-95e5-11e7-b85b-5d64dd272c67','FJ','Fiji');
INSERT INTO T_Country VALUES ('ed7c1404-95e5-11e7-b85b-5d64dd272c67','FI','Finland');
INSERT INTO T_Country VALUES ('ed7c2e08-95e5-11e7-b85b-5d64dd272c67','FR','France');
INSERT INTO T_Country VALUES ('ed7c474e-95e5-11e7-b85b-5d64dd272c67','FX','France, Metropolitan');
INSERT INTO T_Country VALUES ('ed7c5e78-95e5-11e7-b85b-5d64dd272c67','GF','French Guiana');
INSERT INTO T_Country VALUES ('ed7c770a-95e5-11e7-b85b-5d64dd272c67','PF','French Polynesia');
INSERT INTO T_Country VALUES ('ed7c9a14-95e5-11e7-b85b-5d64dd272c67','TF','French Southern Territories');
INSERT INTO T_Country VALUES ('ed7cd3da-95e5-11e7-b85b-5d64dd272c67','GA','Gabon');
INSERT INTO T_Country VALUES ('ed7d03fa-95e5-11e7-b85b-5d64dd272c67','GM','Gambia');
INSERT INTO T_Country VALUES ('ed7d28d0-95e5-11e7-b85b-5d64dd272c67','GE','Georgia');
INSERT INTO T_Country VALUES ('ed7d47ac-95e5-11e7-b85b-5d64dd272c67','DE','Germany');
INSERT INTO T_Country VALUES ('ed7d662e-95e5-11e7-b85b-5d64dd272c67','GH','Ghana');
INSERT INTO T_Country VALUES ('ed7d8186-95e5-11e7-b85b-5d64dd272c67','GI','Gibraltar');
INSERT INTO T_Country VALUES ('ed7d9a68-95e5-11e7-b85b-5d64dd272c67','GK','Guernsey');
INSERT INTO T_Country VALUES ('ed7db4bc-95e5-11e7-b85b-5d64dd272c67','GR','Greece');
INSERT INTO T_Country VALUES ('ed7dd672-95e5-11e7-b85b-5d64dd272c67','GL','Greenland');
INSERT INTO T_Country VALUES ('ed7df954-95e5-11e7-b85b-5d64dd272c67','GD','Grenada');
INSERT INTO T_Country VALUES ('ed7e1204-95e5-11e7-b85b-5d64dd272c67','GP','Guadeloupe');
INSERT INTO T_Country VALUES ('ed7e2abe-95e5-11e7-b85b-5d64dd272c67','GU','Guam');
INSERT INTO T_Country VALUES ('ed7e4850-95e5-11e7-b85b-5d64dd272c67','GT','Guatemala');
INSERT INTO T_Country VALUES ('ed7e6a24-95e5-11e7-b85b-5d64dd272c67','GN','Guinea');
INSERT INTO T_Country VALUES ('ed7e87d4-95e5-11e7-b85b-5d64dd272c67','GW','Guinea-Bissau');
INSERT INTO T_Country VALUES ('ed7ea214-95e5-11e7-b85b-5d64dd272c67','GY','Guyana');
INSERT INTO T_Country VALUES ('ed7eb8e4-95e5-11e7-b85b-5d64dd272c67','HT','Haiti');
INSERT INTO T_Country VALUES ('ed7ed194-95e5-11e7-b85b-5d64dd272c67','HM','Heard and Mc Donald Islands');
INSERT INTO T_Country VALUES ('ed7ee7ec-95e5-11e7-b85b-5d64dd272c67','HN','Honduras');
INSERT INTO T_Country VALUES ('ed7f0010-95e5-11e7-b85b-5d64dd272c67','HK','Hong Kong');
INSERT INTO T_Country VALUES ('ed7f1c62-95e5-11e7-b85b-5d64dd272c67','HU','Hungary');
INSERT INTO T_Country VALUES ('ed7f3eae-95e5-11e7-b85b-5d64dd272c67','IS','Iceland');
INSERT INTO T_Country VALUES ('ed7f5894-95e5-11e7-b85b-5d64dd272c67','IN','India');
INSERT INTO T_Country VALUES ('ed7f7cf2-95e5-11e7-b85b-5d64dd272c67','IM','Isle of Man');
INSERT INTO T_Country VALUES ('ed7f9462-95e5-11e7-b85b-5d64dd272c67','ID','Indonesia');
INSERT INTO T_Country VALUES ('ed7fab96-95e5-11e7-b85b-5d64dd272c67','IR','Iran (Islamic Republic of)');
INSERT INTO T_Country VALUES ('ed7fc4c8-95e5-11e7-b85b-5d64dd272c67','IQ','Iraq');
INSERT INTO T_Country VALUES ('ed7fdbf2-95e5-11e7-b85b-5d64dd272c67','IE','Ireland');
INSERT INTO T_Country VALUES ('ed8002bc-95e5-11e7-b85b-5d64dd272c67','IL','Israel');
INSERT INTO T_Country VALUES ('ed801e50-95e5-11e7-b85b-5d64dd272c67','IT','Italy');
INSERT INTO T_Country VALUES ('ed803822-95e5-11e7-b85b-5d64dd272c67','CI','Ivory Coast');
INSERT INTO T_Country VALUES ('ed80503c-95e5-11e7-b85b-5d64dd272c67','JE','Jersey');
INSERT INTO T_Country VALUES ('ed806b1c-95e5-11e7-b85b-5d64dd272c67','JM','Jamaica');
INSERT INTO T_Country VALUES ('ed808750-95e5-11e7-b85b-5d64dd272c67','JP','Japan');
INSERT INTO T_Country VALUES ('ed80a172-95e5-11e7-b85b-5d64dd272c67','JO','Jordan');
INSERT INTO T_Country VALUES ('ed80be00-95e5-11e7-b85b-5d64dd272c67','KZ','Kazakhstan');
INSERT INTO T_Country VALUES ('ed80e3c6-95e5-11e7-b85b-5d64dd272c67','KE','Kenya');
INSERT INTO T_Country VALUES ('ed810522-95e5-11e7-b85b-5d64dd272c67','KI','Kiribati');
INSERT INTO T_Country VALUES ('ed812052-95e5-11e7-b85b-5d64dd272c67','KP','Korea, Democratic People\'s Republic of');
INSERT INTO T_Country VALUES ('ed814294-95e5-11e7-b85b-5d64dd272c67','KR','Korea, Republic of');
INSERT INTO T_Country VALUES ('ed815ebe-95e5-11e7-b85b-5d64dd272c67','XK','Kosovo');
INSERT INTO T_Country VALUES ('ed817e58-95e5-11e7-b85b-5d64dd272c67','KW','Kuwait');
INSERT INTO T_Country VALUES ('ed81a1e4-95e5-11e7-b85b-5d64dd272c67','KG','Kyrgyzstan');
INSERT INTO T_Country VALUES ('ed81c354-95e5-11e7-b85b-5d64dd272c67','LA','Lao People\'s Democratic Republic');
INSERT INTO T_Country VALUES ('ed81e078-95e5-11e7-b85b-5d64dd272c67','LV','Latvia');
INSERT INTO T_Country VALUES ('ed81fd24-95e5-11e7-b85b-5d64dd272c67','LB','Lebanon');
INSERT INTO T_Country VALUES ('ed82155c-95e5-11e7-b85b-5d64dd272c67','LS','Lesotho');
INSERT INTO T_Country VALUES ('ed822db2-95e5-11e7-b85b-5d64dd272c67','LR','Liberia');
INSERT INTO T_Country VALUES ('ed8247b6-95e5-11e7-b85b-5d64dd272c67','LY','Libyan Arab Jamahiriya');
INSERT INTO T_Country VALUES ('ed826548-95e5-11e7-b85b-5d64dd272c67','LI','Liechtenstein');
INSERT INTO T_Country VALUES ('ed8287ee-95e5-11e7-b85b-5d64dd272c67','LT','Lithuania');
INSERT INTO T_Country VALUES ('ed82a35a-95e5-11e7-b85b-5d64dd272c67','LU','Luxembourg');
INSERT INTO T_Country VALUES ('ed82bb06-95e5-11e7-b85b-5d64dd272c67','MO','Macau');
INSERT INTO T_Country VALUES ('ed82d1f4-95e5-11e7-b85b-5d64dd272c67','MK','Macedonia');
INSERT INTO T_Country VALUES ('ed82eb4e-95e5-11e7-b85b-5d64dd272c67','MG','Madagascar');
INSERT INTO T_Country VALUES ('ed8313ee-95e5-11e7-b85b-5d64dd272c67','MW','Malawi');
INSERT INTO T_Country VALUES ('ed8335f4-95e5-11e7-b85b-5d64dd272c67','MY','Malaysia');
INSERT INTO T_Country VALUES ('ed834ea4-95e5-11e7-b85b-5d64dd272c67','MV','Maldives');
INSERT INTO T_Country VALUES ('ed836678-95e5-11e7-b85b-5d64dd272c67','ML','Mali');
INSERT INTO T_Country VALUES ('ed837e24-95e5-11e7-b85b-5d64dd272c67','MT','Malta');
INSERT INTO T_Country VALUES ('ed8395bc-95e5-11e7-b85b-5d64dd272c67','MH','Marshall Islands');
INSERT INTO T_Country VALUES ('ed83ab10-95e5-11e7-b85b-5d64dd272c67','MQ','Martinique');
INSERT INTO T_Country VALUES ('ed83c37a-95e5-11e7-b85b-5d64dd272c67','MR','Mauritania');
INSERT INTO T_Country VALUES ('ed83e1c0-95e5-11e7-b85b-5d64dd272c67','MU','Mauritius');
INSERT INTO T_Country VALUES ('ed840542-95e5-11e7-b85b-5d64dd272c67','TY','Mayotte');
INSERT INTO T_Country VALUES ('ed842180-95e5-11e7-b85b-5d64dd272c67','MX','Mexico');
INSERT INTO T_Country VALUES ('ed843c38-95e5-11e7-b85b-5d64dd272c67','FM','Micronesia, Federated States of');
INSERT INTO T_Country VALUES ('ed84527c-95e5-11e7-b85b-5d64dd272c67','MD','Moldova, Republic of');
INSERT INTO T_Country VALUES ('ed846ab4-95e5-11e7-b85b-5d64dd272c67','MC','Monaco');
INSERT INTO T_Country VALUES ('ed84830a-95e5-11e7-b85b-5d64dd272c67','MN','Mongolia');
INSERT INTO T_Country VALUES ('ed84a902-95e5-11e7-b85b-5d64dd272c67','ME','Montenegro');
INSERT INTO T_Country VALUES ('ed84d21a-95e5-11e7-b85b-5d64dd272c67','MS','Montserrat');
INSERT INTO T_Country VALUES ('ed84ea70-95e5-11e7-b85b-5d64dd272c67','MA','Morocco');
INSERT INTO T_Country VALUES ('ed850226-95e5-11e7-b85b-5d64dd272c67','MZ','Mozambique');
INSERT INTO T_Country VALUES ('ed8519dc-95e5-11e7-b85b-5d64dd272c67','MM','Myanmar');
INSERT INTO T_Country VALUES ('ed852f3a-95e5-11e7-b85b-5d64dd272c67','NA','Namibia');
INSERT INTO T_Country VALUES ('ed85451a-95e5-11e7-b85b-5d64dd272c67','NR','Nauru');
INSERT INTO T_Country VALUES ('ed855ce4-95e5-11e7-b85b-5d64dd272c67','NP','Nepal');
INSERT INTO T_Country VALUES ('ed857a30-95e5-11e7-b85b-5d64dd272c67','NL','Netherlands');
INSERT INTO T_Country VALUES ('ed859f60-95e5-11e7-b85b-5d64dd272c67','AN','Netherlands Antilles');
INSERT INTO T_Country VALUES ('ed85bcca-95e5-11e7-b85b-5d64dd272c67','NC','New Caledonia');
INSERT INTO T_Country VALUES ('ed85d32c-95e5-11e7-b85b-5d64dd272c67','NZ','New Zealand');
INSERT INTO T_Country VALUES ('ed85ecae-95e5-11e7-b85b-5d64dd272c67','NI','Nicaragua');
INSERT INTO T_Country VALUES ('ed860400-95e5-11e7-b85b-5d64dd272c67','NE','Niger');
INSERT INTO T_Country VALUES ('ed861d1e-95e5-11e7-b85b-5d64dd272c67','NG','Nigeria');
INSERT INTO T_Country VALUES ('ed864226-95e5-11e7-b85b-5d64dd272c67','NU','Niue');
INSERT INTO T_Country VALUES ('ed866148-95e5-11e7-b85b-5d64dd272c67','NF','Norfolk Island');
INSERT INTO T_Country VALUES ('ed867a84-95e5-11e7-b85b-5d64dd272c67','MP','Northern Mariana Islands');
INSERT INTO T_Country VALUES ('ed8691fe-95e5-11e7-b85b-5d64dd272c67','NO','Norway');
INSERT INTO T_Country VALUES ('ed86ab12-95e5-11e7-b85b-5d64dd272c67','OM','Oman');
INSERT INTO T_Country VALUES ('ed86c110-95e5-11e7-b85b-5d64dd272c67','PK','Pakistan');
INSERT INTO T_Country VALUES ('ed86d7f4-95e5-11e7-b85b-5d64dd272c67','PW','Palau');
INSERT INTO T_Country VALUES ('ed86f7a2-95e5-11e7-b85b-5d64dd272c67','PS','Palestine');
INSERT INTO T_Country VALUES ('ed8719d0-95e5-11e7-b85b-5d64dd272c67','PA','Panama');
INSERT INTO T_Country VALUES ('ed873366-95e5-11e7-b85b-5d64dd272c67','PG','Papua New Guinea');
INSERT INTO T_Country VALUES ('ed874b80-95e5-11e7-b85b-5d64dd272c67','PY','Paraguay');
INSERT INTO T_Country VALUES ('ed8763a4-95e5-11e7-b85b-5d64dd272c67','PE','Peru');
INSERT INTO T_Country VALUES ('ed877b6e-95e5-11e7-b85b-5d64dd272c67','PH','Philippines');
INSERT INTO T_Country VALUES ('ed879478-95e5-11e7-b85b-5d64dd272c67','PN','Pitcairn');
INSERT INTO T_Country VALUES ('ed87ab8e-95e5-11e7-b85b-5d64dd272c67','PL','Poland');
INSERT INTO T_Country VALUES ('ed87ccae-95e5-11e7-b85b-5d64dd272c67','PT','Portugal');
INSERT INTO T_Country VALUES ('ed87f3d2-95e5-11e7-b85b-5d64dd272c67','PR','Puerto Rico');
INSERT INTO T_Country VALUES ('ed880e62-95e5-11e7-b85b-5d64dd272c67','QA','Qatar');
INSERT INTO T_Country VALUES ('ed882b0e-95e5-11e7-b85b-5d64dd272c67','RE','Reunion');
INSERT INTO T_Country VALUES ('ed88471a-95e5-11e7-b85b-5d64dd272c67','RO','Romania');
INSERT INTO T_Country VALUES ('ed885f8e-95e5-11e7-b85b-5d64dd272c67','RU','Russian Federation');
INSERT INTO T_Country VALUES ('ed887708-95e5-11e7-b85b-5d64dd272c67','RW','Rwanda');
INSERT INTO T_Country VALUES ('ed888e78-95e5-11e7-b85b-5d64dd272c67','KN','Saint Kitts and Nevis');
INSERT INTO T_Country VALUES ('ed88ab74-95e5-11e7-b85b-5d64dd272c67','LC','Saint Lucia');
INSERT INTO T_Country VALUES ('ed88cd3e-95e5-11e7-b85b-5d64dd272c67','VC','Saint Vincent and the Grenadines');
INSERT INTO T_Country VALUES ('ed88e7ba-95e5-11e7-b85b-5d64dd272c67','WS','Samoa');
INSERT INTO T_Country VALUES ('ed89013c-95e5-11e7-b85b-5d64dd272c67','SM','San Marino');
INSERT INTO T_Country VALUES ('ed8917f8-95e5-11e7-b85b-5d64dd272c67','ST','Sao Tome and Principe');
INSERT INTO T_Country VALUES ('ed89333c-95e5-11e7-b85b-5d64dd272c67','SA','Saudi Arabia');
INSERT INTO T_Country VALUES ('ed89524a-95e5-11e7-b85b-5d64dd272c67','SN','Senegal');
INSERT INTO T_Country VALUES ('ed8971f8-95e5-11e7-b85b-5d64dd272c67','RS','Serbia');
INSERT INTO T_Country VALUES ('ed898c6a-95e5-11e7-b85b-5d64dd272c67','SC','Seychelles');
INSERT INTO T_Country VALUES ('ed89a600-95e5-11e7-b85b-5d64dd272c67','SL','Sierra Leone');
INSERT INTO T_Country VALUES ('ed89bd84-95e5-11e7-b85b-5d64dd272c67','SG','Singapore');
INSERT INTO T_Country VALUES ('ed89d5bc-95e5-11e7-b85b-5d64dd272c67','SK','Slovakia');
INSERT INTO T_Country VALUES ('ed89edcc-95e5-11e7-b85b-5d64dd272c67','SI','Slovenia');
INSERT INTO T_Country VALUES ('ed8a0708-95e5-11e7-b85b-5d64dd272c67','SB','Solomon Islands');
INSERT INTO T_Country VALUES ('ed8a1ff4-95e5-11e7-b85b-5d64dd272c67','SO','Somalia');
INSERT INTO T_Country VALUES ('ed8a3f5c-95e5-11e7-b85b-5d64dd272c67','ZA','South Africa');
INSERT INTO T_Country VALUES ('ed8a5df2-95e5-11e7-b85b-5d64dd272c67','GS','South Georgia South Sandwich Islands');
INSERT INTO T_Country VALUES ('ed8a7486-95e5-11e7-b85b-5d64dd272c67','ES','Spain');
INSERT INTO T_Country VALUES ('ed8a9560-95e5-11e7-b85b-5d64dd272c67','LK','Sri Lanka');
INSERT INTO T_Country VALUES ('ed8ab9be-95e5-11e7-b85b-5d64dd272c67','SH','St. Helena');
INSERT INTO T_Country VALUES ('ed8ae182-95e5-11e7-b85b-5d64dd272c67','PM','St. Pierre and Miquelon');
INSERT INTO T_Country VALUES ('ed8b0126-95e5-11e7-b85b-5d64dd272c67','SD','Sudan');
INSERT INTO T_Country VALUES ('ed8b1dfa-95e5-11e7-b85b-5d64dd272c67','SR','Suriname');
INSERT INTO T_Country VALUES ('ed8b3682-95e5-11e7-b85b-5d64dd272c67','SJ','Svalbard and Jan Mayen Islands');
INSERT INTO T_Country VALUES ('ed8b4d20-95e5-11e7-b85b-5d64dd272c67','SZ','Swaziland');
INSERT INTO T_Country VALUES ('ed8b66c0-95e5-11e7-b85b-5d64dd272c67','SE','Sweden');
INSERT INTO T_Country VALUES ('ed8b7c64-95e5-11e7-b85b-5d64dd272c67','CH','Switzerland');
INSERT INTO T_Country VALUES ('ed8b9460-95e5-11e7-b85b-5d64dd272c67','SY','Syrian Arab Republic');
INSERT INTO T_Country VALUES ('ed8bb242-95e5-11e7-b85b-5d64dd272c67','TW','Taiwan');
INSERT INTO T_Country VALUES ('ed8bd696-95e5-11e7-b85b-5d64dd272c67','TJ','Tajikistan');
INSERT INTO T_Country VALUES ('ed8bf414-95e5-11e7-b85b-5d64dd272c67','TZ','Tanzania, United Republic of');
INSERT INTO T_Country VALUES ('ed8c161a-95e5-11e7-b85b-5d64dd272c67','TH','Thailand');
INSERT INTO T_Country VALUES ('ed8c3258-95e5-11e7-b85b-5d64dd272c67','TG','Togo');
INSERT INTO T_Country VALUES ('ed8c4ee6-95e5-11e7-b85b-5d64dd272c67','TK','Tokelau');
INSERT INTO T_Country VALUES ('ed8c6930-95e5-11e7-b85b-5d64dd272c67','TO','Tonga');
INSERT INTO T_Country VALUES ('ed8c9216-95e5-11e7-b85b-5d64dd272c67','TT','Trinidad and Tobago');
INSERT INTO T_Country VALUES ('ed8cb138-95e5-11e7-b85b-5d64dd272c67','TN','Tunisia');
INSERT INTO T_Country VALUES ('ed8cc8d0-95e5-11e7-b85b-5d64dd272c67','TR','Turkey');
INSERT INTO T_Country VALUES ('ed8ce14e-95e5-11e7-b85b-5d64dd272c67','TM','Turkmenistan');
INSERT INTO T_Country VALUES ('ed8cf86e-95e5-11e7-b85b-5d64dd272c67','TC','Turks and Caicos Islands');
INSERT INTO T_Country VALUES ('ed8d107e-95e5-11e7-b85b-5d64dd272c67','TV','Tuvalu');
INSERT INTO T_Country VALUES ('ed8d2a8c-95e5-11e7-b85b-5d64dd272c67','UG','Uganda');
INSERT INTO T_Country VALUES ('ed8d4bd4-95e5-11e7-b85b-5d64dd272c67','UA','Ukraine');
INSERT INTO T_Country VALUES ('ed8d6f92-95e5-11e7-b85b-5d64dd272c67','AE','United Arab Emirates');
INSERT INTO T_Country VALUES ('ed8d8ee6-95e5-11e7-b85b-5d64dd272c67','GB','United Kingdom');
INSERT INTO T_Country VALUES ('ed8dad7c-95e5-11e7-b85b-5d64dd272c67','US','United States');
INSERT INTO T_Country VALUES ('ed8dd61c-95e5-11e7-b85b-5d64dd272c67','UM','United States minor outlying islands');
INSERT INTO T_Country VALUES ('ed8e1348-95e5-11e7-b85b-5d64dd272c67','UY','Uruguay');
INSERT INTO T_Country VALUES ('ed8e4020-95e5-11e7-b85b-5d64dd272c67','UZ','Uzbekistan');
INSERT INTO T_Country VALUES ('ed8e68de-95e5-11e7-b85b-5d64dd272c67','VU','Vanuatu');
INSERT INTO T_Country VALUES ('ed8e8f58-95e5-11e7-b85b-5d64dd272c67','VA','Vatican City State');
INSERT INTO T_Country VALUES ('ed8eb1f4-95e5-11e7-b85b-5d64dd272c67','VE','Venezuela');
INSERT INTO T_Country VALUES ('ed8ed0ee-95e5-11e7-b85b-5d64dd272c67','VN','Vietnam');
INSERT INTO T_Country VALUES ('ed8ef286-95e5-11e7-b85b-5d64dd272c67','VG','Virgin Islands (British)');
INSERT INTO T_Country VALUES ('ed8f1202-95e5-11e7-b85b-5d64dd272c67','VI','Virgin Islands (U.S.)');
INSERT INTO T_Country VALUES ('ed8f364c-95e5-11e7-b85b-5d64dd272c67','WF','Wallis and Futuna Islands');
INSERT INTO T_Country VALUES ('ed8f6022-95e5-11e7-b85b-5d64dd272c67','EH','Western Sahara');
INSERT INTO T_Country VALUES ('ed8f8048-95e5-11e7-b85b-5d64dd272c67','YE','Yemen');
INSERT INTO T_Country VALUES ('ed8fa12c-95e5-11e7-b85b-5d64dd272c67','ZR','Zaire');
INSERT INTO T_Country VALUES ('ed8fc4c2-95e5-11e7-b85b-5d64dd272c67','ZM','Zambia');
INSERT INTO T_Country VALUES ('ed8fed76-95e5-11e7-b85b-5d64dd272c67','ZW','Zimbabwe');

INSERT INTO T_Product_Cat VALUES ('4bc9abf2-c787-11e7-84e9-90bbf6a2477f',"Women's Fashion",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_Cat VALUES ('4bca03ea-c787-11e7-84e9-90bbf6a2477f',"Beauty and Health",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_Cat VALUES ('4bca9698-c787-11e7-84e9-90bbf6a2477f',"Sports",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_Cat VALUES ('4bcafbe2-c787-11e7-84e9-90bbf6a2477f',"Baby and Kids",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_Cat VALUES ('4bcb5a7e-c787-11e7-84e9-90bbf6a2477f',"Foods and Drink",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_Cat VALUES ('4bcbaa24-c787-11e7-84e9-90bbf6a2477f',"Books and Stationery",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_Cat VALUES ('4bcbf2e0-c787-11e7-84e9-90bbf6a2477f',"Gaming",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_Cat VALUES ('4bccbc52-c787-11e7-84e9-90bbf6a2477f',"Automatives",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_Cat VALUES ('4bccf924-c787-11e7-84e9-90bbf6a2477f',"Others",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');

INSERT INTO T_Product_SubCat VALUES (uuid(),'4bc9abf2-c787-11e7-84e9-90bbf6a2477f',"Clothes",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_SubCat VALUES (uuid(),'4bc9abf2-c787-11e7-84e9-90bbf6a2477f',"Watches",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_SubCat VALUES (uuid(),'4bc9abf2-c787-11e7-84e9-90bbf6a2477f',"Wallets",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_SubCat VALUES (uuid(),'4bc9abf2-c787-11e7-84e9-90bbf6a2477f',"Bags",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_SubCat VALUES (uuid(),'4bc9abf2-c787-11e7-84e9-90bbf6a2477f',"Shoes",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_SubCat VALUES (uuid(),'4bc9abf2-c787-11e7-84e9-90bbf6a2477f',"Jewellery",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_SubCat VALUES (uuid(),'4bc9abf2-c787-11e7-84e9-90bbf6a2477f',"Accessories",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_SubCat VALUES (uuid(),'4bc9abf2-c787-11e7-84e9-90bbf6a2477f',"Others",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');

INSERT INTO T_Product_SubCat VALUES (uuid(),'4bccbc52-c787-11e7-84e9-90bbf6a2477f',"Car Camera",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_SubCat VALUES (uuid(),'4bccbc52-c787-11e7-84e9-90bbf6a2477f',"Car Stickers",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_SubCat VALUES (uuid(),'4bccbc52-c787-11e7-84e9-90bbf6a2477f',"Accessories",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_SubCat VALUES (uuid(),'4bccbc52-c787-11e7-84e9-90bbf6a2477f',"Others",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');

INSERT INTO T_Product_SubCat VALUES (uuid(),'4bcafbe2-c787-11e7-84e9-90bbf6a2477f',"Toys",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_SubCat VALUES (uuid(),'4bcafbe2-c787-11e7-84e9-90bbf6a2477f',"Baby Clothing",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_SubCat VALUES (uuid(),'4bcafbe2-c787-11e7-84e9-90bbf6a2477f',"Baby Gears",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_SubCat VALUES (uuid(),'4bcafbe2-c787-11e7-84e9-90bbf6a2477f',"Baby Foods and Drinks",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_SubCat VALUES (uuid(),'4bcafbe2-c787-11e7-84e9-90bbf6a2477f',"Kid's Clothing (Girl)",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_SubCat VALUES (uuid(),'4bcafbe2-c787-11e7-84e9-90bbf6a2477f',"Kid's Clothing (Boy)",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_SubCat VALUES (uuid(),'4bcafbe2-c787-11e7-84e9-90bbf6a2477f',"Bags",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_SubCat VALUES (uuid(),'4bcafbe2-c787-11e7-84e9-90bbf6a2477f',"Accessories",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_SubCat VALUES (uuid(),'4bcafbe2-c787-11e7-84e9-90bbf6a2477f',"Others",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');

INSERT INTO T_Product_SubCat VALUES (uuid(),'4bca03ea-c787-11e7-84e9-90bbf6a2477f',"Skin Care",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_SubCat VALUES (uuid(),'4bca03ea-c787-11e7-84e9-90bbf6a2477f',"Health Care",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_SubCat VALUES (uuid(),'4bca03ea-c787-11e7-84e9-90bbf6a2477f',"Body Care",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_SubCat VALUES (uuid(),'4bca03ea-c787-11e7-84e9-90bbf6a2477f',"Makeup",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_SubCat VALUES (uuid(),'4bca03ea-c787-11e7-84e9-90bbf6a2477f',"Perfume",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_SubCat VALUES (uuid(),'4bca03ea-c787-11e7-84e9-90bbf6a2477f',"Supplement and Nutrition",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_SubCat VALUES (uuid(),'4bca03ea-c787-11e7-84e9-90bbf6a2477f',"Others",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');

INSERT INTO T_Product_SubCat VALUES (uuid(),'4bcbaa24-c787-11e7-84e9-90bbf6a2477f',"Magazine",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_SubCat VALUES (uuid(),'4bcbaa24-c787-11e7-84e9-90bbf6a2477f',"Comics",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_SubCat VALUES (uuid(),'4bcbaa24-c787-11e7-84e9-90bbf6a2477f',"Novels",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_SubCat VALUES (uuid(),'4bcbaa24-c787-11e7-84e9-90bbf6a2477f',"Stationery",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_SubCat VALUES (uuid(),'4bcbaa24-c787-11e7-84e9-90bbf6a2477f',"Others",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');

INSERT INTO T_Product_SubCat VALUES (uuid(),'c308f510-9956-11e7-b85b-5d64dd272c67',"Smartphones",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_SubCat VALUES (uuid(),'c308f510-9956-11e7-b85b-5d64dd272c67',"Tablets",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_SubCat VALUES (uuid(),'c308f510-9956-11e7-b85b-5d64dd272c67',"Laptops",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_SubCat VALUES (uuid(),'c308f510-9956-11e7-b85b-5d64dd272c67',"Desktop Computers",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_SubCat VALUES (uuid(),'c308f510-9956-11e7-b85b-5d64dd272c67',"Camera",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_SubCat VALUES (uuid(),'c308f510-9956-11e7-b85b-5d64dd272c67',"Smartphone Accessories",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_SubCat VALUES (uuid(),'c308f510-9956-11e7-b85b-5d64dd272c67',"Computer Accessories",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_SubCat VALUES (uuid(),'c308f510-9956-11e7-b85b-5d64dd272c67',"Gaming",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_SubCat VALUES (uuid(),'c308f510-9956-11e7-b85b-5d64dd272c67',"Headphones",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_SubCat VALUES (uuid(),'c308f510-9956-11e7-b85b-5d64dd272c67',"Monitors",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_SubCat VALUES (uuid(),'c308f510-9956-11e7-b85b-5d64dd272c67',"Others",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');

INSERT INTO T_Product_SubCat VALUES (uuid(),'4bcb5a7e-c787-11e7-84e9-90bbf6a2477f',"Carbonated Drinks",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_SubCat VALUES (uuid(),'4bcb5a7e-c787-11e7-84e9-90bbf6a2477f',"Alcoholic Drinks",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_SubCat VALUES (uuid(),'4bcb5a7e-c787-11e7-84e9-90bbf6a2477f',"Non-Alcoholic Drinks",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_SubCat VALUES (uuid(),'4bcb5a7e-c787-11e7-84e9-90bbf6a2477f',"Snacks",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_SubCat VALUES (uuid(),'4bcb5a7e-c787-11e7-84e9-90bbf6a2477f',"Instant Foods",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_SubCat VALUES (uuid(),'4bcb5a7e-c787-11e7-84e9-90bbf6a2477f',"Others",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');

INSERT INTO T_Product_SubCat VALUES (uuid(),'e86ab50a-9956-11e7-b85b-5d64dd272c67',"Clothes",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_SubCat VALUES (uuid(),'e86ab50a-9956-11e7-b85b-5d64dd272c67',"Watches",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_SubCat VALUES (uuid(),'e86ab50a-9956-11e7-b85b-5d64dd272c67',"Wallets",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_SubCat VALUES (uuid(),'e86ab50a-9956-11e7-b85b-5d64dd272c67',"Bags",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_SubCat VALUES (uuid(),'e86ab50a-9956-11e7-b85b-5d64dd272c67',"Shoes",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_SubCat VALUES (uuid(),'e86ab50a-9956-11e7-b85b-5d64dd272c67',"Accessories",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_SubCat VALUES (uuid(),'e86ab50a-9956-11e7-b85b-5d64dd272c67',"Others",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');

INSERT INTO T_Product_SubCat VALUES (uuid(),'4bca9698-c787-11e7-84e9-90bbf6a2477f',"Fitness",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_SubCat VALUES (uuid(),'4bca9698-c787-11e7-84e9-90bbf6a2477f',"Sportswear",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_SubCat VALUES (uuid(),'4bca9698-c787-11e7-84e9-90bbf6a2477f',"Basketball",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_SubCat VALUES (uuid(),'4bca9698-c787-11e7-84e9-90bbf6a2477f',"Badminton",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_SubCat VALUES (uuid(),'4bca9698-c787-11e7-84e9-90bbf6a2477f',"Football Kits",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_SubCat VALUES (uuid(),'4bca9698-c787-11e7-84e9-90bbf6a2477f',"Sport Accessories",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_SubCat VALUES (uuid(),'4bca9698-c787-11e7-84e9-90bbf6a2477f',"Sport Gears",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');
INSERT INTO T_Product_SubCat VALUES (uuid(),'4bca9698-c787-11e7-84e9-90bbf6a2477f',"Others",1,null,now(),'2e3da212-9953-11e7-b85b-5d64dd272c67',now(),'2e3da212-9953-11e7-b85b-5d64dd272c67');

-- End 0.0.4 ChengYew 14/11/2017