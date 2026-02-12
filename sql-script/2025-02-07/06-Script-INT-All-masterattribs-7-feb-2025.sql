
----52696

-----master extract Attributes

--jpb
delete FROM ui.masterextractattribs where itenantid = 12;

	INSERT INTO ui.masterextractattribs (
    attribpath, level, datatype, displayname, itenantid, attribs
)
VALUES 
    ('vcattribs->>''kyc''', 'Customer', 'String', 'KYC', 12, NULL),
    ('vcattribs->>''risk''', 'Customer', 'String', 'Risk', 12, NULL),
    ('vcattribs->>''dealer_id''', 'Customer', 'String', 'Dealer ID', 12, NULL),
    ('vcattribs->>''gross_income''', 'Customer', 'String', 'Gross Income', 12, NULL),
    ('vcattribs->>''source_of_income''', 'Customer', 'String', 'Income', 12, NULL),
    ('vcattribs->>''termination_status''', 'Customer', 'String', 'Termination Status', 12, NULL),
    ('vcattribs->>''customer_onboard_type''', 'Customer', 'String', 'Customer Onboard Type', 12, NULL),
    ('vcattribs->>''occupation''', 'Customer', 'String', 'Occupation', 12, NULL),
    ('vcattribs->>''city''', 'Customer', 'String', 'City', 12, NULL),
    ('vcattribs->>''state''', 'Customer', 'String', 'State', 12, NULL),
    ('vcattribs->>''accountType''', 'Customer', 'String', 'Account Type', 12, NULL),
    ('vcattribs->>''doi_dob''', 'Customer', 'String', 'Date of Birth', 12, NULL),
    ('vcattribs->>''gender''', 'Customer', 'String', 'Gender', 12, NULL),
    ('vcattribs->>''ucic_id''', 'Customer', 'String', 'UCIC ID', 12, NULL),
    ('vcattribs->>''Mobile_no_UpdateTime''', 'Customer', 'String', 'Mobile no UpdateTime', 12, null),
    ('Vcregisteredmobile', 'Customer', 'String', 'Mobile Number', 12, null),
    ('vcexternalcustid', 'Customer', 'String', 'Customer ID', 12, '{
  "validations": [],
  "mandatoryTransposeField": true
}'),
    ('vcexternalaccountid', 'Account', 'String', 'Account ID', 12, '{
  "validations": [],
  "mandatoryTransposeField": true
}'),
    ('vcaccount', 'Account', 'String', 'Account Number', 12, NULL),
    ('vcexternaladdressid', 'VPA', 'String', 'Address ID', 12, '{
  "validations": [],
  "mandatoryTransposeField": true
}');

---epifi
delete FROM ui.masterextractattribs where itenantid = 5;

INSERT INTO ui.masterextractattribs (
    attribpath, level, datatype, displayname, itenantid, attribs
)
VALUES 
    ('attrib.kyc_type', 'Customer', 'String', 'Kyc Type', 5, NULL),
    ('attrib.phone_number', 'Customer', 'String', 'Phone Number', 5, NULL),
    ('attrib.employment_type', 'Customer', 'String', 'Employement Type', 5, NULL),
    ('attrib.onboarding_state', 'Customer', 'String', 'Onboarding State', 5, NULL),
    ('attrib.declared_salary_max', 'Customer', 'String', 'declared salary_max', 5, NULL),
    ('attrib.declared_salary_min', 'Customer', 'String', 'declared salary_min', 5, NULL),
    ('attrib.liveness_geolocation', 'Customer', 'String', 'liveness geolocation', 5, NULL),
    ('attrib.internal_liveness_score', 'Customer', 'String', 'internal liveness_score', 5, NULL),
    ('attrib.shipping_address_state', 'Customer', 'String', 'shipping address_state', 5, NULL),
    ('attrib.mailing_address_postalcode', 'Customer', 'String', 'mailing address_postalcode', 5, NULL),
    ('attrib.shipping_address_postalcode', 'Customer', 'String', 'shipping address_postalcode', 5, NULL),
    ('icustomerid', 'Customer', 'Integer', 'Customer ID', 5, NULL),
    ('vcexternalcustid', 'Customer', 'String', 'Customer External ID', 5, '{
  "validations": [],
  "mandatoryTransposeField": true
}'),
    ('vcattribs->> ''account_categories''', 'Account', 'String', 'Account Category', 5, NULL),
    ('vcexternalaccountid', 'Account', 'String', 'Account External ID', 5, '{
  "validations": [],
  "mandatoryTransposeField": true
}'),
    ('vcattribs->> ''vpa_categories''', 'VPA', 'String', 'VPA Category', 5, NULL),
    ('vcexternaladdressid', 'VPA', 'String', 'Address ID', 5, '{
  "validations": [],
  "mandatoryTransposeField": true
}');

--jpsl
delete FROM ui.masterextractattribs where itenantid = 14;

INSERT INTO ui.masterextractattribs (
    attribpath, level, datatype, displayname, itenantid, attribs
)
VALUES 
    -- Customer Level Attributes
    ('vcexternalcustid', 'Customer', 'String', 'External Customer ID', 14, '{
  "validations": [],
  "mandatoryTransposeField": true
}'),
    ('vccustomername', 'Customer', 'String', 'Name', 14, NULL),
    ('vcattribs->>''subGroupId''', 'Customer', 'String', 'Sub-Group ID', 14, NULL),
    ('vcattribs->>''postalcode''', 'Customer', 'String', 'Postal Code', 14, NULL),
    ('vcattribs->>''merchantType''', 'Customer', 'String', 'Merchant Type', 14, NULL),
    ('imcc', 'Customer', 'Integer', 'MCC', 14, NULL),
    ('vcattribs->>''longitude''', 'Customer', 'String', 'Longitude', 14, NULL),
    ('vcattribs->>''latitude''', 'Customer', 'String', 'Latitude', 14, NULL),
    ('vcattribs->>''internationalAcceptance''', 'Customer', 'String', 'International Acceptance', 14, NULL),
    ('vcattribs->>''groupId''', 'Customer', 'String', 'Group ID', 14, NULL),
    ('vcattribs->>''date_of_incorporation''', 'Customer', 'String', 'Date of Incorporation', 14, NULL),
    ('vcattribs->>''cumulativeDailyTransactionVolume''', 'Customer', 'String', 'Cumulative Daily Transaction Volume', 14, NULL),
    ('vcattribs->>''cumulativeDailyTransactionExitVolume''', 'Customer', 'String', 'Cumulative Daily Transaction Exit Volume', 14, NULL),
    ('vcattribs->>''cumulativeDailyTransactionExitCount''', 'Customer', 'String', 'Cumulative Daily Transaction Exit Count', 14, NULL),
    ('vcattribs->>''cumulativeDailyTransactionCount''', 'Customer', 'String', 'Cumulative Daily Transaction Count', 14, NULL),
    ('vcattribs->>''cumulativeDailyRefundVolume''', 'Customer', 'String', 'Cumulative Daily Refund Volume', 14, NULL),
    ('vcattribs->>''cumulativeDailyRefundExitVolume''', 'Customer', 'String', 'Cumulative Daily Refund Exit Volume', 14, NULL),
    ('vcattribs->>''cumulativeDailyRefundExitCount''', 'Customer', 'String', 'Cumulative Daily Refund Exit Count', 14, NULL),
    ('vcattribs->>''cumulativeDailyRefundCount''', 'Customer', 'String', 'Cumulative Daily Refund Count', 14, NULL),
    ('vcattribs->>''business_division''', 'Customer', 'String', 'GST Business Division', 14, NULL),
    ('vcattribs->>''businessChannel''', 'Customer', 'String', 'Business Channel', 14, NULL),

    -- Account Level Attributes
    ('vcexternalaccountid', 'Account', 'String', 'External Account ID', 14, '{
  "validations": [],
  "mandatoryTransposeField": true
}'),
    ('imcc', 'Account', 'Integer', 'MCC', 14, NULL),

    -- VPA Level Attributes
    ('vcexternaladdressid', 'VPA', 'String', 'External Address ID', 14, '{
  "validations": [],
  "mandatoryTransposeField": true
}'),
    ('imcc', 'VPA', 'Integer', 'MCC', 14, NULL);


--pinelabs
delete FROM ui.masterextractattribs where itenantid = 10;

INSERT INTO ui.masterextractattribs (
    attribpath, level, datatype, displayname, itenantid, attribs
)
VALUES 
    -- Account Level Attributes
    ('vcexternalaccountid', 'Account', 'String', 'Store ID', 10, '{
  "validations": [],
  "mandatoryTransposeField": true
}'),
    ('vcattribs->>''reg_address''', 'Account', 'String', 'Registered Address', 10, NULL),
    ('vcattribs->>''postal_code''', 'Account', 'String', 'Postal Code', 10, NULL),
    ('vcattribs->>''merchant_type''', 'Account', 'String', 'Account Merchant Type', 10, NULL),
    ('vcattribs->>''registered_mobile''', 'Account', 'String', 'Registered Mobile', 10, NULL),
    ('vcattribs->>''email''', 'Account', 'String', 'Email', 10, NULL),

    -- Customer Level Attributes
    ('dtonboardingdate', 'Customer', 'String', 'Customer Onboarding Date', 10, NULL),
    ('vcexternalcustid', 'Customer', 'String', 'Merchant ID', 10, '{
  "validations": [],
  "mandatoryTransposeField": true
}'),
    ('vcattribs->>''accountaddress''', 'Customer', 'String', 'Account Address', 10, NULL),
    ('vcattribs->>''accountnumber''', 'Customer', 'String', 'Account Number', 10, NULL),
    ('vcattribs->>''ifsccode''', 'Customer', 'String', 'IFSC Code', 10, NULL),
    ('vcattribs->>''bankname''', 'Customer', 'String', 'Bank Name', 10, NULL),
    ('vcattribs->>''settlementmode''', 'Customer', 'String', 'Settlement Mode', 10, NULL),
    ('vcattribs->>''accountonboardingdate''', 'Customer', 'String', 'Account Onboarding Date', 10, NULL),
    ('vcattribs->>''address''', 'Customer', 'String', 'Address', 10, NULL),
    ('vcemail', 'Customer', 'String', 'Email', 10, NULL),
    ('vcattribs->>''postalcode''', 'Customer', 'String', 'Postal Code', 10, NULL),
    ('vcattribs->>''annualturnover''', 'Customer', 'String', 'Annual Turnover', 10, NULL),
    ('vcattribs->>''registeredmobile''', 'Customer', 'String', 'Registered Mobile', 10, NULL),
    ('vcattribs->>''merchanttype''', 'Customer', 'String', 'Customer Merchant Type', 10, NULL),
    ('vcattribs->>''attribs_merchanttype''', 'Customer', 'String', 'Customer Merchant Attribs', 10, NULL),
    ('vcattribs->>''merchant_type''', 'Customer', 'String', 'Customer Merchant Type', 10, NULL),
    ('vcattribs->>''category''', 'Customer', 'String', 'Customer Category', 10, NULL),
    ('vccustomername', 'Customer', 'String', 'Customer Name', 10, NULL),
    ('vcattribs->>''accounttype''', 'Customer', 'String', 'Customer Account Type', 10, NULL),
    ('vcattribs->>''Ownershiptype''', 'Customer', 'String', 'Customer Ownership Type', 10, NULL),

    -- VPA Level Attributes
    ('vcexternaladdressid', 'VPA', 'String', 'MDP POS ID', 10, '{
  "validations": [],
  "mandatoryTransposeField": true
}'),
    ('vcattribs->>''merchant_type''', 'VPA', 'String', 'Merchant Type', 10, NULL);

---yb pobo 

delete FROM ui.masterextractattribs where itenantid = 16;

INSERT INTO ui.masterextractattribs (
    attribpath, level, datatype, displayname, itenantid, attribs
)
VALUES 
    -- Customer Level Attributes
    ('icustomerid', 'Customer', 'Integer', 'Customer ID', 16, NULL),
    ('vcexternalcustid', 'Customer', 'String', 'Client External ID', 16, '{
  "validations": [],
  "mandatoryTransposeField": true
}'),
    ('vccustomername', 'Customer', 'String', 'Customer Name', 16, NULL),
    ('vccustomertype', 'Customer', 'String', 'Customer Type', 16, NULL),
    ('vcverifiedname', 'Customer', 'String', 'Verified Name', 16, NULL),
    ('dtonboardingdate', 'Customer', 'String', 'Onboarded On', 16, NULL),
    ('vcemail', 'Customer', 'String', 'Email', 16, NULL),
    ('vcregisteredmobile', 'Customer', 'String', 'Registered Mobile', 16, NULL),
    ('imcc', 'Customer', 'String', 'MCC', 16, NULL),
    ('irecordstatus', 'Customer', 'Integer', 'Record Status', 16, NULL),
    ('dtentrydatetime', 'Customer', 'String', 'Entry Date Time', 16, NULL),
    ('vcattribs->>''panNo''', 'Customer', 'String', 'Pan Number', 16, NULL),
    ('vcattribs->>''purpose''', 'Customer', 'String', 'Purpose', 16, NULL),
    ('vcattribs->>''partnerID''', 'Customer', 'String', 'Partner ID', 16, NULL),
    ('vcattribs->>''partnerName''', 'Customer', 'String', 'Partner Name', 16, NULL),
    ('vcattribs->>''ecollectAccNo''', 'Customer', 'String', 'Merchant No', 16, NULL),
    ('vcattribs->>''merchant_type''', 'Customer', 'String', 'Merchant type', 16, NULL),
    ('vcattribs->>''typeOfCompany''', 'Customer', 'String', 'Type Of Company', 16, NULL),
    ('vcattribs->>''clientIdentifier''', 'Customer', 'String', 'Client Identifier', 16, NULL),
    ('vcattribs->>''registeredAddress''', 'Customer', 'String', 'Registered Address', 16, NULL),
    ('vcattribs->>''dateOfRegistration''', 'Customer', 'String', 'Date Of Registration', 16, NULL),
    ('vcattribs->>''dueDiligenceStatus''', 'Customer', 'String', 'Due Diligence Status', 16, NULL),
    ('vcattribs->>''lastTurnoverUpdate''', 'Customer', 'String', 'Last Turnover Update', 16, NULL),

    -- Account Level Attributes
    ('iaccountid', 'Account', 'Integer', 'Account ID', 16, NULL),
    ('icustomerid', 'Account', 'Integer', 'Customer ID', 16, NULL),
    ('vcexternalaccountid', 'Account', 'String', 'External Account ID', 16, '{
  "validations": [],
  "mandatoryTransposeField": true
}'),
    ('vcaccountname', 'Account', 'String', 'Account Name', 16, NULL),
    ('dtonboardingdate', 'Account', 'String', 'Onboarded On', 16, NULL),
    ('imcc', 'Account', 'String', 'MCC', 16, NULL),
    ('bmerchant', 'Account', 'Boolean', 'Merchant', 16, NULL),
    ('irecordstatus', 'Account', 'Integer', 'Record Status', 16, NULL),

    -- VPA Level Attributes
    ('ivpaid', 'VPA', 'Integer', 'VPA ID', 16, NULL),
    ('iaccountid', 'VPA', 'Integer', 'Account ID', 16, NULL),
    ('vcexternaladdressid', 'VPA', 'String', 'External Address ID', 16, '{
  "validations": [],
  "mandatoryTransposeField": true
}'),
    ('vcaddress', 'VPA', 'String', 'Payment Address', 16, NULL),
    ('vcvpaname', 'VPA', 'String', 'VPA Name', 16, NULL),
    ('imcc', 'VPA', 'String', 'MCC', 16, NULL),
    ('bmerchant', 'VPA', 'Boolean', 'Merchant', 16, NULL),
    ('dtentrydatetime', 'VPA', 'String', 'Entry Date Time', 16, NULL),
    ('irecordstatus', 'VPA', 'Integer', 'Record Status', 16, NULL);


--yb bapa
delete FROM ui.masterextractattribs where itenantid = 8;

INSERT INTO ui.masterextractattribs (
    attribpath, level, datatype, displayname, itenantid, attribs
)
VALUES 
    -- Customer Level Attributes
    ('vcattribs->''yb_raw''->>''pan''', 'Customer', 'String', 'PAN', 8, NULL),
    ('vcattribs->''yb_raw''->>''city''', 'Customer', 'String', 'City', 8, NULL),
    ('vcattribs->''yb_raw''->>''gstn''', 'Customer', 'String', 'GSTN', 8, NULL),
    ('vcattribs->''yb_raw''->>''state''', 'Customer', 'String', 'State', 8, NULL),
    ('vcattribs->''yb_raw''->>''pinCode''', 'Customer', 'String', 'Pin Code', 8, NULL),
    ('vcattribs->''yb_raw''->>''district''', 'Customer', 'String', 'District', 8, NULL),
    ('vcattribs->''yb_raw''->>''latitude''', 'Customer', 'String', 'Latitude', 8, NULL),
    ('vcattribs->''yb_raw''->>''longitude''', 'Customer', 'String', 'Longitude', 8, NULL),
    ('vcattribs->''yb_raw''->>''partnerName''', 'Customer', 'String', 'Partner Name', 8, NULL),
    ('vcattribs->''yb_raw''->>''businessName''', 'Customer', 'String', 'Business Name', 8, NULL),
    ('vcattribs->''yb_raw''->>''mobileNumber''', 'Customer', 'String', 'Mobile Number', 8, NULL),
    ('vcattribs->''yb_raw''->>''sellerVerifiedAccountName''', 'Customer', 'String', 'Verified Account Name', 8, NULL),
    ('vcattribs->''yb_raw''->>''turnOverType''', 'Customer', 'String', 'Turnover Type', 8, NULL),
    ('vcexternalcustid', 'Customer', 'String', 'Customer ID', 8, '{
      "validations": [],
      "mandatoryTransposeField": true
    }'),
    -- Account Level Attributes
    ('vcexternalaccountid', 'Account', 'String', 'Account ID', 8, '{
  "validations": [],
  "mandatoryTransposeField": true
}'),
    -- VPA Level Attributes
    ('vcexternaladdressid', 'VPA', 'String', 'Address ID', 8, '{
  "validations": [],
  "mandatoryTransposeField": true
}');


--yb paytm
delete FROM ui.masterextractattribs where itenantid = 17;

INSERT INTO ui.masterextractattribs (
    attribpath, level, datatype, displayname, itenantid, attribs
)
VALUES 
    -- Customer Level Attributes
    ('vcattribs->>''pan''', 'Customer', 'String', 'PAN', 17, NULL),
    ('vcattribs->>''city''', 'Customer', 'String', 'City', 17, NULL),
    ('vcattribs->>''gstn''', 'Customer', 'String', 'GSTN', 17, NULL),
    ('vcattribs->>''state''', 'Customer', 'String', 'State', 17, NULL),
    ('vcattribs->>''pinCode''', 'Customer', 'String', 'Pin Code', 17, NULL),
    ('vcattribs->>''district''', 'Customer', 'String', 'District', 17, NULL),
    ('vcattribs->>''latitude''', 'Customer', 'String', 'Latitude', 17, NULL),
    ('vcattribs->>''longitude''', 'Customer', 'String', 'Longitude', 17, NULL),
    ('vcattribs->>''partnerName''', 'Customer', 'String', 'Partner Name', 17, NULL),
    ('vcverifiedname', 'Customer', 'String', 'Business Name', 17, NULL),
    ('vcregisteredmobile', 'Customer', 'String', 'Mobile Number', 17, NULL),
    ('vccustomername', 'Customer', 'String', 'Verified Account Name', 17, NULL),
    ('vcattribs->>''turnoverType''', 'Customer', 'String', 'Turnover Type', 17, NULL),
    ('vcexternalcustid', 'Customer', 'String', 'Customer ID', 17, '{
  "validations": [],
  "mandatoryTransposeField": true
}'),

    -- Account Level Attributes
    ('vcexternalaccountid', 'Account', 'String', 'Account ID', 17, '{
  "validations": [],
  "mandatoryTransposeField": true
}'),

    -- VPA Level Attributes
    ('vcexternaladdressid', 'VPA', 'String', 'Address ID', 17, '{
  "validations": [],
  "mandatoryTransposeField": true
}');

--yb pmtagg
delete FROM ui.masterextractattribs where itenantid = 21;

INSERT INTO ui.masterextractattribs (
    attribpath, level, datatype, displayname, itenantid, attribs
)
VALUES 
    -- Customer Level Attributes
    ('vcattribs->>''pan''', 'Customer', 'String', 'PAN', 21, NULL),
    ('imcc', 'Customer', 'String', 'MCC', 21, NULL),
    ('vcattribs->>''gst''', 'Customer', 'String', 'GSTN', 21, NULL),
    ('vcemail', 'Customer', 'String', 'Email Id', 21, NULL),
    ('vcattribs->>''partnerName''', 'Customer', 'String', 'Partner Name', 21, NULL),
    ('vcregisteredmobile', 'Customer', 'String', 'Mobile Number', 21, NULL),
    ('vccustomername', 'Customer', 'String', 'Verified Account Name', 21, NULL),
    ('vcexternalcustid', 'Customer', 'String', 'Customer ID', 21, '{
      "validations": [],
      "mandatoryTransposeField": true
    }'),
    ('vcattribs->>''merchantIdentifier''', 'Customer', 'String', 'Merchant Identifier', 21, NULL),
    ('vcattribs->>''settlementAccountId''', 'Customer', 'String', 'Settlement Account ID', 21, NULL),
    
    -- Account Level Attributes
    ('vcexternalaccountid', 'Account', 'String', 'Account ID', 21, '{
      "validations": [],
      "mandatoryTransposeField": true
    }'),
    
    -- VPA Level Attributes
    ('vcexternaladdressid', 'VPA', 'String', 'Address ID', 21, '{
      "validations": [],
      "mandatoryTransposeField": true
    }');

--yb giftcard
delete FROM ui.masterextractattribs where itenantid = 22;

INSERT INTO ui.masterextractattribs (
    attribpath, level, datatype, displayname, itenantid, attribs
)
VALUES 
    -- Customer Level Attributes
    ('vcattribs->>''pan''', 'Customer', 'String', 'PAN', 22, NULL),
    ('imcc', 'Customer', 'String', 'MCC', 22, NULL),
    ('vcattribs->>''gstn''', 'Customer', 'String', 'GSTN', 22, NULL),
    ('vcemail', 'Customer', 'String', 'Email Id', 22, NULL),
    ('vcattribs->>''partnerName''', 'Customer', 'String', 'Partner Name', 22, NULL),
    ('vcregisteredmobile', 'Customer', 'String', 'Mobile Number', 22, NULL),
    ('vccustomername', 'Customer', 'String', 'Verified Account Name', 22, NULL),
    ('vcexternalcustid', 'Customer', 'String', 'Customer ID', 22, '{
      "validations": [],
      "mandatoryTransposeField": true
    }'),
    ('vcattribs->>''giftCardPurchaserId''', 'Customer', 'String', 'Purchaser ID', 22, NULL),
    
    -- Account Level Attributes
    ('vcexternalaccountid', 'Account', 'String', 'Account ID', 22, '{
      "validations": [],
      "mandatoryTransposeField": true
    }'),
    
    -- VPA Level Attributes
    ('vcexternaladdressid', 'VPA', 'String', 'Address ID', 22, '{
      "validations": [],
      "mandatoryTransposeField": true
    }');

--ybfrm
DELETE FROM ui.masterextractattribs WHERE itenantid = 9;

INSERT INTO ui.masterextractattribs (
    attribpath, level, datatype, displayname, itenantid, attribs
)
VALUES 
    -- Customer Level Attributes
    ('vcattribs->''yb_raw''->>''pan''', 'Customer', 'String', 'PAN', 9, NULL),
    ('vcattribs->''yb_raw''->>''city''', 'Customer', 'String', 'City', 9, NULL),
    ('vcattribs->''yb_raw''->>''gstn''', 'Customer', 'String', 'GSTN', 9, NULL),
    ('vcattribs->''yb_raw''->>''state''', 'Customer', 'String', 'State', 9, NULL),
    ('vcattribs->''yb_raw''->>''pinCode''', 'Customer', 'String', 'Pin Code', 9, NULL),
    ('vcattribs->''yb_raw''->>''district''', 'Customer', 'String', 'District', 9, NULL),
    ('vcattribs->''yb_raw''->>''latitude''', 'Customer', 'String', 'Latitude', 9, NULL),
    ('vcattribs->''yb_raw''->>''longitude''', 'Customer', 'String', 'Longitude', 9, NULL),
    ('vcattribs->''yb_raw''->>''partnerName''', 'Customer', 'String', 'Partner Name', 9, NULL),
    ('vcattribs->''yb_raw''->>''businessName''', 'Customer', 'String', 'Business Name', 9, NULL),
    ('vcattribs->''yb_raw''->>''mobileNumber''', 'Customer', 'String', 'Mobile Number', 9, NULL),
    ('vcattribs->''yb_raw''->>''sellerVerifiedAccountName''', 'Customer', 'String', 'Verified Account Name', 9, NULL),
    ('vcattribs->''yb_raw''->>''turnOverType''', 'Customer', 'String', 'Turnover Type', 9, NULL),
    ('vcexternalcustid', 'Customer', 'String', 'Customer ID', 9, '{
      "validations": [],
      "mandatoryTransposeField": true
    }'),

    -- Account Level Attributes
    ('vcexternalaccountid', 'Account', 'String', 'Account ID', 9, '{
      "validations": [],
      "mandatoryTransposeField": true
    }'),

    -- VPA Level Attributes
    ('vcexternaladdressid', 'VPA', 'String', 'Address ID', 9, '{
      "validations": [],
      "mandatoryTransposeField": true
    }');

--42c
delete FROM ui.masterextractattribs where itenantid in (7,6,20,24);

INSERT INTO ui.masterextractattribs (
    attribpath, level, datatype, displayname, itenantid, attribs
)
VALUES 
    -- Customer Level Attributes
    ('program_id', 'Customer', 'Integer', 'Program ID', 7, NULL),
    ('vcexternalcustid', 'Customer', 'String', 'Customer ID', 7, '{
  "validations": [],
  "mandatoryTransposeField": true
}'),
    ('program_id', 'Customer', 'Integer', 'Program ID', 6, NULL),
    ('vcexternalcustid', 'Customer', 'String', 'Customer ID', 6, '{
  "validations": [],
  "mandatoryTransposeField": true
}'),
    ('program_id', 'Customer', 'Integer', 'Program ID', 20, NULL),
    ('vcexternalcustid', 'Customer', 'String', 'Customer ID', 20, '{
  "validations": [],
  "mandatoryTransposeField": true
}'),
    ('program_id', 'Customer', 'Integer', 'Program ID', 24, NULL),
    ('vcexternalcustid', 'Customer', 'String', 'Customer ID', 24, '{
  "validations": [],
  "mandatoryTransposeField": true
}'),

    -- Account Level Attributes
    ('vcattribs->>''account_categories''', 'Account', 'String', 'Account Category', 7, NULL),
    ('vcexternalaccountid', 'Account', 'String', 'Account ID', 7, '{
  "validations": [],
  "mandatoryTransposeField": true
}'),
    ('vcaccount', 'Account', 'String', 'Account Number', 7, NULL),
    ('vcattribs->>''account_categories''', 'Account', 'String', 'Account Category', 6, NULL),
    ('vcexternalaccountid', 'Account', 'String', 'Account ID', 6, '{
  "validations": [],
  "mandatoryTransposeField": true
}'),
    ('vcaccount', 'Account', 'String', 'Account Number', 6, NULL),
    ('vcattribs->>''account_categories''', 'Account', 'String', 'Account Category', 20, NULL),
    ('vcexternalaccountid', 'Account', 'String', 'Account ID', 20, '{
  "validations": [],
  "mandatoryTransposeField": true
}'),
    ('vcaccount', 'Account', 'String', 'Account Number', 20, NULL),
    ('vcattribs->>''account_categories''', 'Account', 'String', 'Account Category', 24, NULL),
    ('vcexternalaccountid', 'Account', 'String', 'Account ID', 24, '{
  "validations": [],
  "mandatoryTransposeField": true
}'),
    ('vcaccount', 'Account', 'String', 'Account Number', 24, NULL),

    -- VPA Level Attributes
    ('vcattribs->>''card_brand''', 'VPA', 'String', 'Card Brand', 7, NULL),
    ('vcattribs->>''programId''', 'VPA', 'String', 'Program ID', 7, NULL),
    ('vcattribs->>''card_brand''', 'VPA', 'String', 'Card Brand', 6, NULL),
    ('vcattribs->>''programId''', 'VPA', 'String', 'Program ID', 6, NULL),
    ('vcattribs->>''card_brand''', 'VPA', 'String', 'Card Brand', 20, NULL),
    ('vcattribs->>''programId''', 'VPA', 'String', 'Program ID', 20, NULL),
    ('vcattribs->>''card_brand''', 'VPA', 'String', 'Card Brand', 24, NULL),
    ('vcattribs->>''programId''', 'VPA', 'String', 'Program ID', 24, NULL),
        ('vcexternaladdressid', 'VPA', 'String', 'Address ID', 7, '{
      "validations": [],
      "mandatoryTransposeField": true
    }'),
        ('vcexternaladdressid', 'VPA', 'String', 'Address ID', 6, '{
      "validations": [],
      "mandatoryTransposeField": true
    }'),
        ('vcexternaladdressid', 'VPA', 'String', 'Address ID', 20, '{
      "validations": [],
      "mandatoryTransposeField": true
    }'),
        ('vcexternaladdressid', 'VPA', 'String', 'Address ID', 24, '{
      "validations": [],
      "mandatoryTransposeField": true
    }');
