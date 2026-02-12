UPDATE ui.dashboardresultset SET
vcdashboardresultsetschema = '{
    "Workflow Name":  "string",
    "Username": "string",
    "User Task / State": "string",
    "Group Name": "string",
    "Day 0":"integer",
    "Day 1":"integer",
    "Day 2":"integer",
    "Day 3":"integer",
    "Day 4":"integer",
    "Day 5":"integer",
    "Day 6":"integer",
    "Day 7":"integer",
    "Day 8":"integer",
    "Day 9":"integer",
    "Day 10":"integer",
    "Day 11":"integer",
    "Day 12":"integer",
    "Day 13":"integer",
    "Day 14":"integer",
    "Day 15":"integer",
    "Day 16":"integer",
    "Day 17":"integer",
    "Day 18":"integer",
    "Day 19":"integer",
    "Day 20":"integer",
    "Day 21":"integer",
    "Day 22":"integer",
    "Day 23":"integer",
    "Day 24":"integer",
    "Day 25":"integer",
    "Day 26":"integer",
    "Day 27":"integer",
    "Day 28":"integer",
    "Day 29":"integer",
    "Day 30":"integer",
    "Day 30+":"integer"
 }
 '::text WHERE
idashboardresultsetid = 27;

UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT pdef.name_ as "Workflow Name",
task.assignee_ as "Username",
task.name_ as "User task / status",
grp.name_ as "Group Name",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp - hdetail.time_) = 0 THEN task.proc_inst_id_
ELSE null
END) as "Day 0",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp - hdetail.time_) = 1 THEN task.proc_inst_id_
ELSE null
END) as "Day 1",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp - hdetail.time_) = 2 THEN task.proc_inst_id_
ELSE null
END) as "Day 2",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp - hdetail.time_) = 3 THEN task.proc_inst_id_
ELSE null
END) as "Day 3",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp - hdetail.time_) = 4 THEN task.proc_inst_id_
ELSE null
END) as "Day 4",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp - hdetail.time_) = 5 THEN task.proc_inst_id_
ELSE null
END) as "Day 5",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp - hdetail.time_) = 6 THEN task.proc_inst_id_
ELSE null
END) as "Day 6",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp - hdetail.time_) = 7 THEN task.proc_inst_id_
ELSE null
END) as "Day 7",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp - hdetail.time_) = 8 THEN task.proc_inst_id_
ELSE null
END) as "Day 8",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp - hdetail.time_) = 9 THEN task.proc_inst_id_
ELSE null
END) as "Day 9",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp - hdetail.time_) = 10 THEN task.proc_inst_id_
ELSE null
END) as "Day 10",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp - hdetail.time_) = 11 THEN task.proc_inst_id_
ELSE null
END) as "Day 11",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp - hdetail.time_) = 12 THEN task.proc_inst_id_
ELSE null
END) as "Day 12",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp - hdetail.time_) = 13 THEN task.proc_inst_id_
ELSE null
END) as "Day 13",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp - hdetail.time_) = 14 THEN task.proc_inst_id_
ELSE null
END) as "Day 14",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp - hdetail.time_) = 15 THEN task.proc_inst_id_
ELSE null
END) as "Day 15",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp - hdetail.time_) = 16 THEN task.proc_inst_id_
ELSE null
END) as "Day 16",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp - hdetail.time_) = 17 THEN task.proc_inst_id_
ELSE null
END) as "Day 17",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp - hdetail.time_) = 18 THEN task.proc_inst_id_
ELSE null
END) as "Day 18",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp - hdetail.time_) = 19 THEN task.proc_inst_id_
ELSE null
END) as "Day 19",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp - hdetail.time_) = 20 THEN task.proc_inst_id_
ELSE null
END) as "Day 20",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp - hdetail.time_) = 21 THEN task.proc_inst_id_
ELSE null
END) as "Day 21",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp - hdetail.time_) = 22 THEN task.proc_inst_id_
ELSE null
END) as "Day 22",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp - hdetail.time_) = 23 THEN task.proc_inst_id_
ELSE null
END) as "Day 23",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp - hdetail.time_) = 24 THEN task.proc_inst_id_
ELSE null
END) as "Day 24",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp - hdetail.time_) = 25 THEN task.proc_inst_id_
ELSE null
END) as "Day 25",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp - hdetail.time_) = 26 THEN task.proc_inst_id_
ELSE null
END) as "Day 26",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp - hdetail.time_) = 27 THEN task.proc_inst_id_
ELSE null
END) as "Day 27",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp - hdetail.time_) = 28 THEN task.proc_inst_id_
ELSE null
END) as "Day 28",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp - hdetail.time_) = 29 THEN task.proc_inst_id_
ELSE null
END) as "Day 29",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp - hdetail.time_) = 30 THEN task.proc_inst_id_
ELSE null
END) as "Day 30",
count(distinct CASE
WHEN DATE_PART(''day'', current_timestamp - hdetail.time_) > 30 THEN task.proc_inst_id_
ELSE null
END) as "Day 30+"
FROM camunda.act_re_procdef pdef
right join camunda.act_ru_task task on task.proc_def_id_ = pdef.id_
inner join camunda.act_hi_detail hdetail on hdetail.proc_inst_id_ = task.proc_inst_id_
and hdetail.name_ = ''userActivity''
right join camunda.act_id_membership memb on task.assignee_ = memb.user_id_
right join camunda.act_hi_identitylink idl on idl.id_ = (SELECT id_ FROM camunda.act_hi_identitylink
where task_id_ = task.id_
and type_= ''candidate''
order by timestamp_ desc
limit 1)
right join camunda.act_id_group grp on grp.id_ = idl.group_id_
where task.assignee_ is not null   group by
pdef.name_, task.assignee_, task.name_, grp.name_'::text WHERE
idashboardqueryid = 59;


alter table if exists ui.formmaster
       add column vcdisplayname varchar(255);


UPDATE ui.formmaster SET
vcdisplayname = 'Add Account Based STR'::character varying WHERE
ifromid = 1;

UPDATE ui.formmaster SET
inputjson = '[
  {
    "section": {
      "label": "Details of Batch",
      "fields": [
        {
          "key": "Batch.ReportType",
          "type": "select",
          "label": "Report Type",
          "value": "STR",
          "options": [
            {
              "label": "Suspicious Transaction Report",
              "value": "STR"
            }
          ],
          "isDisabled": true,
          "validations": {
            "required": true
          }
        },
        {
          "key": "Batch.ReportFormatType",
          "type": "select",
          "label": "Report Format Type",
          "value": "ARF",
          "options": [
            {
              "label": "Account Based Reporting Format",
              "value": "ARF"
            }
          ],
          "isDisabled": true,
          "validations": {
            "required": true
          }
        }
      ],
      "colClassName": "mt-4"
    }
  },
  {
    "section": {
      "label": "Batch Header",
      "fields": [
        {
          "key": "Batch.BatchHeader.DataStructureVersion",
          "type": "select",
          "label": "Data Structure Version",
          "options": [
            {
              "label": "Version 1.0",
              "value": "1"
            },
            {
              "label": "Version 2.0",
              "value": "2"
            }
          ],
          "validations": {
            "required": true
          }
        },
        {
          "key": "Batch.BatchHeader.GenerationUtilityVersion",
          "type": "text",
          "label": "Generation Utility Version",
          "validations": {
            "required": false,
            "maxLength": 5
          }
        },
        {
          "key": "Batch.BatchHeader.DataSource",
          "type": "select",
          "label": "Data Source",
          "value": "xml",
          "options": [
            {
              "label": "PDF file",
              "value": "pdf"
            },
            {
              "label": "RGU file",
              "value": "rgu"
            },
            {
              "label": "Text file",
              "value": "txt"
            },
            {
              "label": "XML file",
              "value": "xml"
            }
          ],
          "validations": {
            "required": true
          }
        }
      ],
      "validations": {
        "required": true
      },
      "colClassName": "mt-4"
    }
  },
  {
    "section": {
      "key": "Batch.ReportingEntity",
      "label": "Reporting Entity",
      "fields": [
        {
          "key": "Batch.ReportingEntity.ReportingEntityName",
          "type": "text",
          "label": "Reporting Entity Name",
          "validations": {
            "required": true,
            "maxLength": 80
          }
        },
        {
          "key": "Batch.ReportingEntity.ReportingEntityCategory",
          "type": "select",
          "label": "Reporting Entity Category",
          "options": [
            {
              "label": "Public Sector Banks",
              "value": "BAPUB"
            },
            {
              "label": "Private Sector Banks",
              "value": "BAPVT"
            },
            {
              "label": "Foreign Banks",
              "value": "BAFOR"
            },
            {
              "label": "Regional Rural Banks",
              "value": "BARRB"
            },
            {
              "label": "Local Area Banks",
              "value": "BALAB"
            },
            {
              "label": "Scheduled Urban Cooperative Banks",
              "value": "BASUC"
            },
            {
              "label": "Non Scheduled Urban Cooperative Banks",
              "value": "BANUC"
            },
            {
              "label": "State Cooperative Banks",
              "value": "BASCO"
            },
            {
              "label": "District Cooperative Banks",
              "value": "BADCB"
            },
            {
              "label": "Other Banking Companies",
              "value": "BAOTH"
            },
            {
              "label": "Life Insurance Companies",
              "value": "FIINL"
            },
            {
              "label": "Non Life Insurance Companies",
              "value": "FIINN"
            },
            {
              "label": "Housing Finance Companies",
              "value": "FIHFC"
            },
            {
              "label": "Authorised Dealer Category I",
              "value": "FIAD1"
            },
            {
              "label": "Authorised Dealer Category II",
              "value": "FIAD2"
            },
            {
              "label": "Authorised Dealer Category III",
              "value": "FIAD3"
            },
            {
              "label": "Full Fledged Money Changer (FFMC)",
              "value": "FIFFM"
            },
            {
              "label": "Money Transfer Service Principal",
              "value": "FIMTP"
            },
            {
              "label": "Money Transfer Service Agent",
              "value": "FIMTA"
            },
            {
              "label": "Card System Operators",
              "value": "FICSO"
            },
            {
              "label": "Central Counter Party",
              "value": "FICCP"
            },
            {
              "label": "All India Financial Institutions",
              "value": "FIAFI"
            },
            {
              "label": "Hire Purchase Companies",
              "value": "FIHPC"
            },
            {
              "label": "Chit Fund Companies",
              "value": "FICFC"
            },
            {
              "label": "NBFC Accepting Deposits",
              "value": "FINBA"
            },
            {
              "label": "NBFC not Accepting Deposits",
              "value": "FINBN"
            },
            {
              "label": "Other Financial Institutions",
              "value": "FIOTH"
            },
            {
              "label": "Casinos",
              "value": "CASIN"
            },
            {
              "label": "Collective Investment or MF Schemes",
              "value": "INCOL"
            },
            {
              "label": "Depositories",
              "value": "INDEP"
            },
            {
              "label": "Depository Participants",
              "value": "INDPP"
            },
            {
              "label": "Share Brokers",
              "value": "INBRO"
            },
            {
              "label": "Derivative Members",
              "value": "INBDS"
            },
            {
              "label": "Share Transfer Agents",
              "value": "INSTA"
            },
            {
              "label": "Registrars and Transfer Agents",
              "value": "INRTA"
            },
            {
              "label": "Merchant Bankers",
              "value": "INMER"
            },
            {
              "label": "Underwriters",
              "value": "INUND"
            },
            {
              "label": "Bankers to an Issue",
              "value": "INBAN"
            },
            {
              "label": "Registrars to Issue",
              "value": "INREG"
            },
            {
              "label": "Portfolio Managers",
              "value": "INPOM"
            },
            {
              "label": "Investment Advisors",
              "value": "INADV"
            },
            {
              "label": "Trustees to Trust Deeds",
              "value": "INTRU"
            },
            {
              "label": "Credit Rating Agencies",
              "value": "INCRE"
            },
            {
              "label": "Domestic Venture Capital Funds",
              "value": "INVCD"
            },
            {
              "label": "Custodian of Securities",
              "value": "INCUS"
            },
            {
              "label": "Foreign Institutional Investors",
              "value": "INFII"
            },
            {
              "label": "Foreign Venture Capital Funds",
              "value": "INVCF"
            },
            {
              "label": "Commodity Broker",
              "value": "INCOM"
            },
            {
              "label": "Sub Brokers",
              "value": "INSBR"
            },
            {
              "label": "Other Intermediaries",
              "value": "INOTH"
            },
            {
              "label": "Regulators - Reserve Bank of India",
              "value": "RGRBI"
            },
            {
              "label": "Others",
              "value": "ZZZZZ"
            },
            {
              "label": "Not Categorised",
              "value": "XXXXX"
            }
          ],
          "validations": {
            "required": true
          }
        },
        {
          "key": "Batch.ReportingEntity.RERegistrationNum",
          "type": "text",
          "label": "Reporting Entity Registration Number",
          "validations": {
            "required": false,
            "maxLength": 12
          }
        },
        {
          "key": "Batch.ReportingEntity.FIUREID",
          "type": "text",
          "label": "Reporting Entity FIUREID",
          "validations": {
            "length": 10,
            "required": true
          }
        }
      ]
    }
  },
  {
    "section": {
      "label": "Principal Officer",
      "fields": [
        {
          "key": "Batch.PrincipalOfficer.POName",
          "type": "text",
          "label": "PO Name",
          "validations": {
            "required": true,
            "maxLength": 80
          }
        },
        {
          "key": "Batch.PrincipalOfficer.PODesignation",
          "type": "text",
          "label": "PO Designation",
          "validations": {
            "required": true,
            "maxLength": 80
          }
        },
        {
          "key": "Batch.PrincipalOfficer.POEmail",
          "type": "text",
          "label": "PO Email",
          "validations": {
            "regexp": "``",
            "required": true,
            "maxLength": 50,
            "minLength": 6
          }
        },
        {
          "section": {
            "label": "Principal Officer Address",
            "fields": [
              {
                "key": "Batch.PrincipalOfficer.POAddress.Address",
                "type": "text",
                "label": "Address",
                "validations": {
                  "required": true,
                  "maxLength": 225,
                  "minLength": 8
                }
              },
              {
                "key": "Batch.PrincipalOfficer.POAddress.City",
                "type": "text",
                "label": "City",
                "validations": {
                  "required": false,
                  "maxLength": 50
                }
              },
              {
                "key": "Batch.PrincipalOfficer.POAddress.StateCode",
                "type": "select",
                "label": "State Code",
                "options": [
                  {
                    "label": "Andaman & Nicobar",
                    "value": "AN"
                  },
                  {
                    "label": "Andhra Pradesh",
                    "value": "AP"
                  },
                  {
                    "label": "Arunachal Pradesh",
                    "value": "AR"
                  },
                  {
                    "label": "Assam",
                    "value": "AS"
                  },
                  {
                    "label": "Bihar",
                    "value": "BR"
                  },
                  {
                    "label": "Chandigarh",
                    "value": "CH"
                  },
                  {
                    "label": "Chhattisgarh",
                    "value": "CG"
                  },
                  {
                    "label": "Dadra and Nagar Haveli",
                    "value": "DN"
                  },
                  {
                    "label": "Daman & Diu",
                    "value": "DD"
                  },
                  {
                    "label": "Delhi",
                    "value": "DL"
                  },
                  {
                    "label": "Goa",
                    "value": "GA"
                  },
                  {
                    "label": "Gujarat",
                    "value": "GJ"
                  },
                  {
                    "label": "Haryana",
                    "value": "HR"
                  },
                  {
                    "label": "Himachal Pradesh",
                    "value": "HP"
                  },
                  {
                    "label": "Jammu & Kashmir",
                    "value": "JK"
                  },
                  {
                    "label": "Jharkhand",
                    "value": "JH"
                  },
                  {
                    "label": "Karnataka",
                    "value": "KA"
                  },
                  {
                    "label": "Kerala",
                    "value": "KL"
                  },
                  {
                    "label": "Lakshadweep",
                    "value": "LD"
                  },
                  {
                    "label": "Madhya Pradesh",
                    "value": "MP"
                  },
                  {
                    "label": "Maharashtra",
                    "value": "MH"
                  },
                  {
                    "label": "Manipur",
                    "value": "MN"
                  },
                  {
                    "label": "Meghalaya",
                    "value": "ML"
                  },
                  {
                    "label": "Mizoram",
                    "value": "MZ"
                  },
                  {
                    "label": "Nagaland",
                    "value": "NL"
                  },
                  {
                    "label": "Orissa",
                    "value": "OR"
                  },
                  {
                    "label": "Pondicherry",
                    "value": "PY"
                  },
                  {
                    "label": "Punjab",
                    "value": "PB"
                  },
                  {
                    "label": "Rajasthan",
                    "value": "RJ"
                  },
                  {
                    "label": "Sikkim",
                    "value": "SK"
                  },
                  {
                    "label": "Tamil Nadu",
                    "value": "TN"
                  },
                  {
                    "label": "Tripura",
                    "value": "TR"
                  },
                  {
                    "label": "Uttar Pradesh",
                    "value": "UP"
                  },
                  {
                    "label": "Uttarakhand",
                    "value": "UA"
                  },
                  {
                    "label": "West Bengal",
                    "value": "WB"
                  },
                  {
                    "label": "Others",
                    "value": "ZZ"
                  },
                  {
                    "label": "Not Applicable",
                    "value": "XX"
                  }
                ],
                "validations": {
                  "required": true
                }
              },
              {
                "key": "Batch.PrincipalOfficer.POAddress.PinCode",
                "type": "text",
                "label": "Pincode",
                "validations": {
                  "required": false,
                  "maxLength": 10
                }
              },
              {
                "key": "Batch.PrincipalOfficer.POAddress.CountryCode",
                "type": "select",
                "label": "Country Code",
                "options": [
                  {
                    "label": "Afghanistan",
                    "value": "AF"
                  },
                  {
                    "label": "Aland Islands",
                    "value": "AX"
                  },
                  {
                    "label": "Albania",
                    "value": "AL"
                  },
                  {
                    "label": "Algeria",
                    "value": "DZ"
                  },
                  {
                    "label": "American Samoa",
                    "value": "AS"
                  },
                  {
                    "label": "Andorra",
                    "value": "AD"
                  },
                  {
                    "label": "Angola",
                    "value": "AO"
                  },
                  {
                    "label": "Anguilla",
                    "value": "AI"
                  },
                  {
                    "label": "Antarctica",
                    "value": "AQ"
                  },
                  {
                    "label": "Antigua And Barbuda",
                    "value": "AG"
                  },
                  {
                    "label": "Argentina",
                    "value": "AR"
                  },
                  {
                    "label": "Armenia",
                    "value": "AM"
                  },
                  {
                    "label": "Aruba",
                    "value": "AW"
                  },
                  {
                    "label": "Australia",
                    "value": "AU"
                  },
                  {
                    "label": "Austria",
                    "value": "AT"
                  },
                  {
                    "label": "Azerbaijan",
                    "value": "AZ"
                  },
                  {
                    "label": "Bahamas",
                    "value": "BS"
                  },
                  {
                    "label": "Bahrain",
                    "value": "BH"
                  },
                  {
                    "label": "Bangladesh",
                    "value": "BD"
                  },
                  {
                    "label": "Barbados",
                    "value": "BB"
                  },
                  {
                    "label": "Belarus",
                    "value": "BY"
                  },
                  {
                    "label": "Belgium",
                    "value": "BE"
                  },
                  {
                    "label": "Belize",
                    "value": "BZ"
                  },
                  {
                    "label": "Benin",
                    "value": "BJ"
                  },
                  {
                    "label": "Bermuda",
                    "value": "BM"
                  },
                  {
                    "label": "Bhutan",
                    "value": "BT"
                  },
                  {
                    "label": "Bolivia",
                    "value": "BO"
                  },
                  {
                    "label": "Bosnia And Herzegovina",
                    "value": "BA"
                  },
                  {
                    "label": "Bonaire, Sint Eustatius and Saba",
                    "value": "BQ"
                  },
                  {
                    "label": "Botswana",
                    "value": "BW"
                  },
                  {
                    "label": "Bouvet Island",
                    "value": "BV"
                  },
                  {
                    "label": "Brazil",
                    "value": "BR"
                  },
                  {
                    "label": "British Indian Ocean Territory",
                    "value": "IO"
                  },
                  {
                    "label": "Brunei Darussalam",
                    "value": "BN"
                  },
                  {
                    "label": "Bulgaria",
                    "value": "BG"
                  },
                  {
                    "label": "Burkina Faso",
                    "value": "BF"
                  },
                  {
                    "label": "Burundi",
                    "value": "BI"
                  },
                  {
                    "label": "Cambodia",
                    "value": "KH"
                  },
                  {
                    "label": "Cameroon",
                    "value": "CM"
                  },
                  {
                    "label": "Canada",
                    "value": "CA"
                  },
                  {
                    "label": "Cape Verde",
                    "value": "CV"
                  },
                  {
                    "label": "Cayman Islands",
                    "value": "KY"
                  },
                  {
                    "label": "Central African Republic",
                    "value": "CF"
                  },
                  {
                    "label": "Chad",
                    "value": "TD"
                  },
                  {
                    "label": "Chile",
                    "value": "CL"
                  },
                  {
                    "label": "China",
                    "value": "CN"
                  },
                  {
                    "label": "Christmas Island",
                    "value": "CX"
                  },
                  {
                    "label": "Cocos (Keeling) Islands",
                    "value": "CC"
                  },
                  {
                    "label": "Colombia",
                    "value": "CO"
                  },
                  {
                    "label": "Comoros",
                    "value": "KM"
                  },
                  {
                    "label": "Congo",
                    "value": "CG"
                  },
                  {
                    "label": "Congo, The Democratic Republic Of The",
                    "value": "CD"
                  },
                  {
                    "label": "Cook Islands",
                    "value": "CK"
                  },
                  {
                    "label": "Costa Rica",
                    "value": "CR"
                  },
                  {
                    "label": "Côte D''ivoire",
                    "value": "CI"
                  },
                  {
                    "label": "Croatia",
                    "value": "HR"
                  },
                  {
                    "label": "Cuba",
                    "value": "CU"
                  },
                  {
                    "label": "Curacao",
                    "value": "CW"
                  },
                  {
                    "label": "Cyprus",
                    "value": "CY"
                  },
                  {
                    "label": "Czech Republic",
                    "value": "CZ"
                  },
                  {
                    "label": "Denmark",
                    "value": "DK"
                  },
                  {
                    "label": "Djibouti",
                    "value": "DJ"
                  },
                  {
                    "label": "Dominica",
                    "value": "DM"
                  },
                  {
                    "label": "Dominican Republic",
                    "value": "DO"
                  },
                  {
                    "label": "Ecuador",
                    "value": "EC"
                  },
                  {
                    "label": "Egypt",
                    "value": "EG"
                  },
                  {
                    "label": "El Salvador",
                    "value": "SV"
                  },
                  {
                    "label": "Equatorial Guinea",
                    "value": "GQ"
                  },
                  {
                    "label": "Eritrea",
                    "value": "ER"
                  },
                  {
                    "label": "Estonia",
                    "value": "EE"
                  },
                  {
                    "label": "Ethiopia",
                    "value": "ET"
                  },
                  {
                    "label": "Falkland Islands (Malvinas)",
                    "value": "FK"
                  },
                  {
                    "label": "Faroe Islands",
                    "value": "FO"
                  },
                  {
                    "label": "Fiji",
                    "value": "FJ"
                  },
                  {
                    "label": "Finland",
                    "value": "FI"
                  },
                  {
                    "label": "France",
                    "value": "FR"
                  },
                  {
                    "label": "French Guiana",
                    "value": "GF"
                  },
                  {
                    "label": "French Polynesia",
                    "value": "PF"
                  },
                  {
                    "label": "French Southern Territories",
                    "value": "TF"
                  },
                  {
                    "label": "Gabon",
                    "value": "GA"
                  },
                  {
                    "label": "Gambia",
                    "value": "GM"
                  },
                  {
                    "label": "Georgia",
                    "value": "GE"
                  },
                  {
                    "label": "Germany",
                    "value": "DE"
                  },
                  {
                    "label": "Ghana",
                    "value": "GH"
                  },
                  {
                    "label": "Gibraltar",
                    "value": "GI"
                  },
                  {
                    "label": "Greece",
                    "value": "GR"
                  },
                  {
                    "label": "Greenland",
                    "value": "GL"
                  },
                  {
                    "label": "Grenada",
                    "value": "GD"
                  },
                  {
                    "label": "Guadeloupe",
                    "value": "GP"
                  },
                  {
                    "label": "Guam",
                    "value": "GU"
                  },
                  {
                    "label": "Guatemala",
                    "value": "GT"
                  },
                  {
                    "label": "Guernsey",
                    "value": "GG"
                  },
                  {
                    "label": "Guinea",
                    "value": "GN"
                  },
                  {
                    "label": "Guinea-Bissau",
                    "value": "GW"
                  },
                  {
                    "label": "Guyana",
                    "value": "GY"
                  },
                  {
                    "label": "Haiti",
                    "value": "HT"
                  },
                  {
                    "label": "Heard Island And McDonald Islands",
                    "value": "HM"
                  },
                  {
                    "label": "Vatican City State",
                    "value": "VA"
                  },
                  {
                    "label": "Honduras",
                    "value": "HN"
                  },
                  {
                    "label": "Hong Kong",
                    "value": "HK"
                  },
                  {
                    "label": "Hungary",
                    "value": "HU"
                  },
                  {
                    "label": "Iceland",
                    "value": "IS"
                  },
                  {
                    "label": "India",
                    "value": "IN"
                  },
                  {
                    "label": "Indonesia",
                    "value": "ID"
                  },
                  {
                    "label": "Iran, Islamic Republic Of",
                    "value": "IR"
                  },
                  {
                    "label": "Iraq",
                    "value": "IQ"
                  },
                  {
                    "label": "Ireland",
                    "value": "IE"
                  },
                  {
                    "label": "Isle Of Man",
                    "value": "IM"
                  },
                  {
                    "label": "Israel",
                    "value": "IL"
                  },
                  {
                    "label": "Italy",
                    "value": "IT"
                  },
                  {
                    "label": "Jamaica",
                    "value": "JM"
                  },
                  {
                    "label": "Japan",
                    "value": "JP"
                  },
                  {
                    "label": "Jersey",
                    "value": "JE"
                  },
                  {
                    "label": "Jordan",
                    "value": "JO"
                  },
                  {
                    "label": "Kazakhstan",
                    "value": "KZ"
                  },
                  {
                    "label": "Kenya",
                    "value": "KE"
                  },
                  {
                    "label": "Kiribati",
                    "value": "KI"
                  },
                  {
                    "label": "Korea, Democratic People''s Republic Of",
                    "value": "KP"
                  },
                  {
                    "label": "Korea, Republic Of",
                    "value": "KR"
                  },
                  {
                    "label": "Kuwait",
                    "value": "KW"
                  },
                  {
                    "label": "Kyrgyzstan",
                    "value": "KG"
                  },
                  {
                    "label": "Lao People''s Democratic Republic",
                    "value": "LA"
                  },
                  {
                    "label": "Latvia",
                    "value": "LV"
                  },
                  {
                    "label": "Lebanon",
                    "value": "LB"
                  },
                  {
                    "label": "Lesotho",
                    "value": "LS"
                  },
                  {
                    "label": "Liberia",
                    "value": "LR"
                  },
                  {
                    "label": "Libyan Arab Jamahiriya",
                    "value": "LY"
                  },
                  {
                    "label": "Liechtenstein",
                    "value": "LI"
                  },
                  {
                    "label": "Lithuania",
                    "value": "LT"
                  },
                  {
                    "label": "Luxembourg",
                    "value": "LU"
                  },
                  {
                    "label": "Macao",
                    "value": "MO"
                  },
                  {
                    "label": "Macedonia, The Former Yugoslav Republic Of",
                    "value": "MK"
                  },
                  {
                    "label": "Madagascar",
                    "value": "MG"
                  },
                  {
                    "label": "Malawi",
                    "value": "MW"
                  },
                  {
                    "label": "Malaysia",
                    "value": "MY"
                  },
                  {
                    "label": "Maldives",
                    "value": "MV"
                  },
                  {
                    "label": "Mali",
                    "value": "ML"
                  },
                  {
                    "label": "Malta",
                    "value": "MT"
                  },
                  {
                    "label": "Marshall Islands",
                    "value": "MH"
                  },
                  {
                    "label": "Martinique",
                    "value": "MQ"
                  },
                  {
                    "label": "Mauritania",
                    "value": "MR"
                  },
                  {
                    "label": "Mauritius",
                    "value": "MU"
                  },
                  {
                    "label": "Mayotte",
                    "value": "YT"
                  },
                  {
                    "label": "Mexico",
                    "value": "MX"
                  },
                  {
                    "label": "Micronesia, Federated States Of",
                    "value": "FM"
                  },
                  {
                    "label": "Moldova, Republic Of",
                    "value": "MD"
                  },
                  {
                    "label": "Monaco",
                    "value": "MC"
                  },
                  {
                    "label": "Mongolia",
                    "value": "MN"
                  },
                  {
                    "label": "Montenegro",
                    "value": "ME"
                  },
                  {
                    "label": "Montserrat",
                    "value": "MS"
                  },
                  {
                    "label": "Morocco",
                    "value": "MA"
                  },
                  {
                    "label": "Mozambique",
                    "value": "MZ"
                  },
                  {
                    "label": "Myanmar",
                    "value": "MM"
                  },
                  {
                    "label": "Namibia",
                    "value": "NA"
                  },
                  {
                    "label": "Nauru",
                    "value": "NR"
                  },
                  {
                    "label": "Nepal",
                    "value": "NP"
                  },
                  {
                    "label": "Netherlands",
                    "value": "NL"
                  },
                  {
                    "label": "Netherlands Antilles",
                    "value": "AN"
                  },
                  {
                    "label": "New Caledonia",
                    "value": "NC"
                  },
                  {
                    "label": "New Zealand",
                    "value": "NZ"
                  },
                  {
                    "label": "Nicaragua",
                    "value": "NI"
                  },
                  {
                    "label": "Niger",
                    "value": "NE"
                  },
                  {
                    "label": "Nigeria",
                    "value": "NG"
                  },
                  {
                    "label": "Niue",
                    "value": "NU"
                  },
                  {
                    "label": "Norfolk Island",
                    "value": "NF"
                  },
                  {
                    "label": "Northern Mariana Islands",
                    "value": "MP"
                  },
                  {
                    "label": "Norway",
                    "value": "NO"
                  },
                  {
                    "label": "Oman",
                    "value": "OM"
                  },
                  {
                    "label": "Pakistan",
                    "value": "PK"
                  },
                  {
                    "label": "Palau",
                    "value": "PW"
                  },
                  {
                    "label": "Palestinian Territory, Occupied",
                    "value": "PS"
                  },
                  {
                    "label": "Panama",
                    "value": "PA"
                  },
                  {
                    "label": "Papua New Guinea",
                    "value": "PG"
                  },
                  {
                    "label": "Paraguay",
                    "value": "PY"
                  },
                  {
                    "label": "Peru",
                    "value": "PE"
                  },
                  {
                    "label": "Philippines",
                    "value": "PH"
                  },
                  {
                    "label": "Pitcairn",
                    "value": "PN"
                  },
                  {
                    "label": "Poland",
                    "value": "PL"
                  },
                  {
                    "label": "Portugal",
                    "value": "PT"
                  },
                  {
                    "label": "Puerto Rico",
                    "value": "PR"
                  },
                  {
                    "label": "Qatar",
                    "value": "QA"
                  },
                  {
                    "label": "Reunion Island",
                    "value": "RE"
                  },
                  {
                    "label": "Romania",
                    "value": "RO"
                  },
                  {
                    "label": "Russian Federation",
                    "value": "RU"
                  },
                  {
                    "label": "Rwanda",
                    "value": "RW"
                  },
                  {
                    "label": "Saint Barthelemy",
                    "value": "BL"
                  },
                  {
                    "label": "Saint Helena, Ascension And Tristan da Cunha",
                    "value": "SH"
                  },
                  {
                    "label": "Saint Kitts And Nevis",
                    "value": "KN"
                  },
                  {
                    "label": "Saint Lucia",
                    "value": "LC"
                  },
                  {
                    "label": "Saint Martin",
                    "value": "MF"
                  },
                  {
                    "label": "Saint Pierre And Miquelon",
                    "value": "PM"
                  },
                  {
                    "label": "Saint Vincent And The Grenadines",
                    "value": "VC"
                  },
                  {
                    "label": "Samoa",
                    "value": "WS"
                  },
                  {
                    "label": "San Marino",
                    "value": "SM"
                  },
                  {
                    "label": "Sao Tome And Principe",
                    "value": "ST"
                  },
                  {
                    "label": "Saudi Arabia",
                    "value": "SA"
                  },
                  {
                    "label": "Senegal",
                    "value": "SN"
                  },
                  {
                    "label": "Serbia",
                    "value": "RS"
                  },
                  {
                    "label": "Seychelles",
                    "value": "SC"
                  },
                  {
                    "label": "Sierra Leone",
                    "value": "SL"
                  },
                  {
                    "label": "Singapore",
                    "value": "SG"
                  },
                  {
                    "label": "Sint Marteen",
                    "value": "SX"
                  },
                  {
                    "label": "Slovakia",
                    "value": "SK"
                  },
                  {
                    "label": "Slovenia",
                    "value": "SI"
                  },
                  {
                    "label": "Solomon Islands",
                    "value": "SB"
                  },
                  {
                    "label": "Somalia",
                    "value": "SO"
                  },
                  {
                    "label": "South Africa",
                    "value": "ZA"
                  },
                  {
                    "label": "South Georgia And The South Sandwich Islands",
                    "value": "GS"
                  },
                  {
                    "label": "South Sudan",
                    "value": "SS"
                  },
                  {
                    "label": "Spain",
                    "value": "ES"
                  },
                  {
                    "label": "Sri Lanka",
                    "value": "LK"
                  },
                  {
                    "label": "Sudan",
                    "value": "SD"
                  },
                  {
                    "label": "Suriname",
                    "value": "SR"
                  },
                  {
                    "label": "Svalbard And Jan Mayen Islands",
                    "value": "SJ"
                  },
                  {
                    "label": "Swaziland",
                    "value": "SZ"
                  },
                  {
                    "label": "Sweden",
                    "value": "SE"
                  },
                  {
                    "label": "Switzerland",
                    "value": "CH"
                  },
                  {
                    "label": "Syrian Arab Republic",
                    "value": "SY"
                  },
                  {
                    "label": "Taiwan, Province Of China",
                    "value": "TW"
                  },
                  {
                    "label": "Tajikistan",
                    "value": "TJ"
                  },
                  {
                    "label": "Tanzania, United Republic Of",
                    "value": "TZ"
                  },
                  {
                    "label": "Thailand",
                    "value": "TH"
                  },
                  {
                    "label": "Timor-Leste",
                    "value": "TL"
                  },
                  {
                    "label": "Togo",
                    "value": "TG"
                  },
                  {
                    "label": "Tokelau",
                    "value": "TK"
                  },
                  {
                    "label": "Tonga",
                    "value": "TO"
                  },
                  {
                    "label": "Trinidad And Tobago",
                    "value": "TT"
                  },
                  {
                    "label": "Tunisia",
                    "value": "TN"
                  },
                  {
                    "label": "Turkey",
                    "value": "TR"
                  },
                  {
                    "label": "Turkmenistan",
                    "value": "TM"
                  },
                  {
                    "label": "Turks And Caicos Islands",
                    "value": "TC"
                  },
                  {
                    "label": "Tuvalu",
                    "value": "TV"
                  },
                  {
                    "label": "Uganda",
                    "value": "UG"
                  },
                  {
                    "label": "Ukraine",
                    "value": "UA"
                  },
                  {
                    "label": "United Arab Emirates",
                    "value": "AE"
                  },
                  {
                    "label": "United Kingdom",
                    "value": "GB"
                  },
                  {
                    "label": "United States",
                    "value": "US"
                  },
                  {
                    "label": "United States Minor Outlying Islands",
                    "value": "UM"
                  },
                  {
                    "label": "Uruguay",
                    "value": "UY"
                  },
                  {
                    "label": "Uzbekistan",
                    "value": "UZ"
                  },
                  {
                    "label": "Vanuatu",
                    "value": "VU"
                  },
                  {
                    "label": "Venezuela, Bolivarian Republic Of",
                    "value": "VE"
                  },
                  {
                    "label": "Viet Nam",
                    "value": "VN"
                  },
                  {
                    "label": "Virgin Islands, British",
                    "value": "VG"
                  },
                  {
                    "label": "Virgin Islands, U.S.",
                    "value": "VI"
                  },
                  {
                    "label": "Wallis And Futuna",
                    "value": "WF"
                  },
                  {
                    "label": "Western Sahara",
                    "value": "EH"
                  },
                  {
                    "label": "Yemen",
                    "value": "YE"
                  },
                  {
                    "label": "Zambia",
                    "value": "ZM"
                  },
                  {
                    "label": "Zimbabwe",
                    "value": "ZW"
                  },
                  {
                    "label": "Not categorised",
                    "value": "XX"
                  },
                  {
                    "label": "Others",
                    "value": "ZZ"
                  }
                ],
                "validations": {
                  "required": true
                }
              }
            ],
            "colClassName": "mt-4"
          }
        },
        {
          "section": {
            "label": "Principal Officer Phone",
            "fields": [
              {
                "key": "Batch.PrincipalOfficer.POPhone.Telephone",
                "type": "text",
                "label": "Telephone",
                "validations": {
                  "required": false,
                  "maxLength": 30,
                  "minLength": 6
                }
              },
              {
                "key": "Batch.PrincipalOfficer.POPhone.Mobile",
                "type": "text",
                "label": "Mobile",
                "validations": {
                  "required": false,
                  "maxLength": 30,
                  "minLength": 6
                }
              },
              {
                "key": "Batch.PrincipalOfficer.POPhone.Fax",
                "type": "text",
                "label": "Fax",
                "validations": {
                  "required": false,
                  "maxLength": 30,
                  "minLength": 6
                }
              }
            ],
            "colClassName": "mt-4"
          }
        }
      ],
      "colClassName": "mt-4"
    }
  },
  {
    "section": {
      "label": "Batch Details Report",
      "fields": [
        {
          "key": "Batch.BatchDetails.BatchNumber",
          "type": "text",
          "label": "Batch Number",
          "validations": {
            "required": true,
            "maxLength": 11
          }
        },
        {
          "key": "Batch.BatchDetails.BatchDate",
          "type": "date",
          "label": "Batch Date",
          "format": "YYYY-MM-DD",
          "maxDate": "new Date()",
          "minDate": "`new Date().setFullYear(new Date().getFullYear() - 1)`",
          "validations": {
            "required": true
          }
        },
        {
          "key": "Batch.BatchDetails.MonthOfReport",
          "type": "select",
          "label": "Month of Report",
          "options": [
            {
              "label": "January",
              "value": "01"
            },
            {
              "label": "February",
              "value": "02"
            },
            {
              "label": "March",
              "value": "03"
            },
            {
              "label": "April",
              "value": "04"
            },
            {
              "label": "May",
              "value": "05"
            },
            {
              "label": "June",
              "value": "06"
            },
            {
              "label": "July",
              "value": "07"
            },
            {
              "label": "August",
              "value": "08"
            },
            {
              "label": "September",
              "value": "09"
            },
            {
              "label": "October",
              "value": "10"
            },
            {
              "label": "November",
              "value": "11"
            },
            {
              "label": "December",
              "value": "12"
            },
            {
              "label": "Not Applicable",
              "value": "NA"
            }
          ],
          "validations": {
            "required": true
          }
        },
        {
          "key": "Batch.BatchDetails.YearOfReport",
          "type": "select",
          "label": "Year of Report",
          "options": [
            {
              "label": "2005",
              "value": "2005"
            },
            {
              "label": "2006",
              "value": "2006"
            },
            {
              "label": "2007",
              "value": "2007"
            },
            {
              "label": "2008",
              "value": "2008"
            },
            {
              "label": "2009",
              "value": "2009"
            },
            {
              "label": "2010",
              "value": "2010"
            },
            {
              "label": "2011",
              "value": "2011"
            },
            {
              "label": "2012",
              "value": "2012"
            },
            {
              "label": "2013",
              "value": "2013"
            },
            {
              "label": "2014",
              "value": "2014"
            },
            {
              "label": "2015",
              "value": "2015"
            },
            {
              "label": "2016",
              "value": "2016"
            },
            {
              "label": "2017",
              "value": "2017"
            },
            {
              "label": "2018",
              "value": "2018"
            },
            {
              "label": "2019",
              "value": "2019"
            },
            {
              "label": "2020",
              "value": "2020"
            },
            {
              "label": "2021",
              "value": "2021"
            },
            {
              "label": "2022",
              "value": "2022"
            },
            {
              "label": "2023",
              "value": "2023"
            },
            {
              "label": "Not Applicable",
              "value": "NA"
            }
          ],
          "validations": {
            "required": true
          }
        },
        {
          "key": "Batch.BatchDetails.OperationalMode",
          "type": "select",
          "label": "Operational Mode",
          "options": [
            {
              "label": "Production Mode",
              "value": "P"
            },
            {
              "label": "Test Mode",
              "value": "T"
            }
          ],
          "validations": {
            "required": true
          }
        },
        {
          "key": "Batch.BatchDetails.BatchType",
          "type": "select",
          "label": "Batch Type",
          "options": [
            {
              "label": "New Report",
              "value": "N"
            },
            {
              "label": "Replacement Report",
              "value": "R"
            },
            {
              "label": "Deletion Report",
              "value": "D"
            }
          ],
          "validations": {
            "required": true
          }
        },
        {
          "key": "Batch.BatchDetails.OriginalBatchID",
          "type": "text",
          "label": "Original Batch ID",
          "validations": {
            "required": true,
            "maxLength": 10
          }
        },
        {
          "key": "Batch.BatchDetails.ReasonOfRevision",
          "type": "select",
          "label": "Reason of Revision",
          "options": [
            {
              "label": "Acknowledgement of original batch had many fatal, non fatal or probable errors which are being resolved",
              "value": "A"
            },
            {
              "label": "Operational errors in original batch have been identified and reports are being revised or deleted suo moto",
              "value": "B"
            },
            {
              "label": "The replacement report is on account of additional information being submitted",
              "value": "C"
            },
            {
              "label": "Not applicable as this is a new batch",
              "value": "N"
            },
            {
              "label": "Other reason",
              "value": "Z"
            }
          ],
          "validations": {
            "required": true
          }
        },
        {
          "key": "Batch.BatchDetails.PKICertificateNum",
          "type": "text",
          "label": "PKI Certificate Number",
          "validations": {
            "required": false,
            "maxLength": 10
          }
        }
      ],
      "colClassName": "mt-4"
    }
  },
  {
    "section": {
      "label": "Details of Batch/Report",
      "fields": [
        {
          "key": "Batch.Report.ReportSerialNum",
          "type": "text",
          "label": "Report Serial Number",
          "validations": {
            "required": true,
            "maxLength": 8
          }
        },
        {
          "key": "Batch.Report.OriginalReportSerialNum",
          "type": "text",
          "label": "Original Report Serial Number",
          "validations": {
            "required": true,
            "maxLength": 8
          }
        },
        {
          "key": "Batch.Report.MainPersonName",
          "type": "text",
          "label": "Main Person Name",
          "validations": {
            "required": false,
            "maxLength": 80
          }
        },
        {
          "section": {
            "label": "Suspicious Details",
            "fields": [
              {
                "key": "Batch.Report.SuspicionDetails.SourceOfAlert",
                "type": "select",
                "label": "Source Of Alert",
                "options": [
                  {
                    "label": "Customer Verification",
                    "value": "CV"
                  },
                  {
                    "label": "Watch List",
                    "value": "WL"
                  },
                  {
                    "label": "Media Reports",
                    "value": "MR"
                  },
                  {
                    "label": "Typology",
                    "value": "TY"
                  },
                  {
                    "label": "Transaction Monitoring",
                    "value": "TM"
                  },
                  {
                    "label": "Risk Management System",
                    "value": "RM"
                  },
                  {
                    "label": "Law Enforcement Agency Query",
                    "value": "LQ"
                  },
                  {
                    "label": "Employee Initiated",
                    "value": "EI"
                  },
                  {
                    "label": "Public Complaint",
                    "value": "PC"
                  },
                  {
                    "label": "Business Associates",
                    "value": "BA"
                  },
                  {
                    "label": "Others",
                    "value": "ZZ"
                  },
                  {
                    "label": "Not Categorised",
                    "value": "XX"
                  }
                ],
                "validations": {
                  "required": true
                }
              },
              {
                "section": {
                  "label": "Alert Indicator",
                  "fields": [
                    {
                      "key": "Batch.Report.SuspicionDetails.AlertIndicator[]",
                      "type": "text",
                      "label": "Alert Indicator",
                      "validations": {
                        "required": false,
                        "maxLength": 100
                      }
                    }
                  ],
                  "isArray": true,
                  "arrayKey": "Batch.Report.SuspicionDetails.AlertIndicator",
                  "required": false,
                  "addArrayLabel": "Alert Indicator"
                }
              },
              {
                "key": "Batch.Report.SuspicionDetails.SuspicionDueToProceedsOfCrime",
                "type": "select",
                "label": "Suspicious Due To Proceeds Of Crime",
                "options": [
                  {
                    "label": "Yes",
                    "value": "Y"
                  },
                  {
                    "label": "No",
                    "value": "N"
                  },
                  {
                    "label": "Not Categorised",
                    "value": "X"
                  }
                ],
                "validations": {
                  "required": true
                }
              },
              {
                "key": "Batch.Report.SuspicionDetails.SuspicionDueToComplexTrans",
                "type": "select",
                "label": "Suspicious Due To Complex Trans",
                "options": [
                  {
                    "label": "Yes",
                    "value": "Y"
                  },
                  {
                    "label": "No",
                    "value": "N"
                  },
                  {
                    "label": "Not Categorised",
                    "value": "X"
                  }
                ],
                "validations": {
                  "required": true
                }
              },
              {
                "key": "Batch.Report.SuspicionDetails.SuspicionDueToNoEcoRationale",
                "type": "select",
                "label": "Suspicious Due To No Eco Rationale",
                "options": [
                  {
                    "label": "Yes",
                    "value": "Y"
                  },
                  {
                    "label": "No",
                    "value": "N"
                  },
                  {
                    "label": "Not Categorised",
                    "value": "X"
                  }
                ],
                "validations": {
                  "required": true
                }
              },
              {
                "key": "Batch.Report.SuspicionDetails.SuspicionOfFinancingOfTerrorism",
                "type": "select",
                "label": "Suspicious Of Financing Of Terrorism",
                "options": [
                  {
                    "label": "Yes",
                    "value": "Y"
                  },
                  {
                    "label": "No",
                    "value": "N"
                  },
                  {
                    "label": "Not Categorised",
                    "value": "X"
                  }
                ],
                "validations": {
                  "required": true
                }
              },
              {
                "key": "Batch.Report.SuspicionDetails.AttemptedTransaction",
                "type": "select",
                "label": "Attempted Transaction",
                "options": [
                  {
                    "label": "Yes",
                    "value": "Y"
                  },
                  {
                    "label": "No",
                    "value": "N"
                  },
                  {
                    "label": "Not Categorised",
                    "value": "X"
                  }
                ],
                "validations": {
                  "required": true
                }
              },
              {
                "sm": 12,
                "key": "Batch.Report.SuspicionDetails.GroundsOfSuspicion",
                "type": "textarea",
                "label": "Grounds Of Suspicion",
                "validations": {
                  "required": true,
                  "maxLength": 4000
                },
                "colClassName": "mt-3"
              },
              {
                "sm": 12,
                "key": "Batch.Report.SuspicionDetails.DetailsOfInvestigation",
                "type": "textarea",
                "label": "Details Of Investigation",
                "validations": {
                  "required": false,
                  "maxLength": 4000
                }
              },
              {
                "key": "Batch.Report.SuspicionDetails.LEAInformed",
                "type": "select",
                "label": "LEA Informed",
                "options": [
                  {
                    "label": "Information received ",
                    "value": "R"
                  },
                  {
                    "label": "Information sent",
                    "value": "S"
                  },
                  {
                    "label": "No correspondence sent or received",
                    "value": "N "
                  },
                  {
                    "label": "Not categorised",
                    "value": "X"
                  }
                ],
                "validations": {
                  "required": true
                }
              },
              {
                "key": "Batch.Report.SuspicionDetails.LEADetails",
                "type": "textarea",
                "label": "LEA Details",
                "validations": {
                  "required": false,
                  "maxLength": 250
                }
              },
              {
                "key": "Batch.Report.SuspicionDetails.PriorityRating",
                "type": "select",
                "label": "Priority Rating",
                "options": [
                  {
                    "label": "Very High Priority ",
                    "value": "P1 "
                  },
                  {
                    "label": "High Priority",
                    "value": "P2  "
                  },
                  {
                    "label": "Normal Priority",
                    "value": "P3"
                  },
                  {
                    "label": "Not categorised",
                    "value": "XX "
                  }
                ],
                "validations": {
                  "required": true
                }
              },
              {
                "key": "Batch.Report.SuspicionDetails.ReportCoverage",
                "type": "select",
                "label": "Report Coverage",
                "options": [
                  {
                    "label": "Complete",
                    "value": "C "
                  },
                  {
                    "label": "Partial",
                    "value": "P "
                  },
                  {
                    "label": "Not Categorised",
                    "value": "X "
                  }
                ],
                "validations": {
                  "required": true
                }
              },
              {
                "key": "Batch.Report.SuspicionDetails.AdditionalDocuments",
                "type": "select",
                "label": "Additional Documents",
                "options": [
                  {
                    "label": "Yes",
                    "value": "Y"
                  },
                  {
                    "label": "No",
                    "value": "N"
                  },
                  {
                    "label": "Not Categorised",
                    "value": "X"
                  }
                ],
                "validations": {
                  "required": true
                }
              }
            ],
            "colClassName": "mt-4"
          }
        },
        {
          "section": {
            "label": "Account Details",
            "fields": [
              {
                "key": "Batch.Report.Account.AccountDetails.AccountNumber",
                "type": "text",
                "label": "Account Number",
                "validations": {
                  "required": true,
                  "maxLength": 20
                }
              },
              {
                "key": "Batch.Report.Account.AccountDetails.AccountType",
                "type": "select",
                "label": "Account Type",
                "options": [
                  {
                    "label": "Savings Account",
                    "value": "BS"
                  },
                  {
                    "label": "Current Account",
                    "value": "BC"
                  },
                  {
                    "label": "Cash Credit/Overdraft Account",
                    "value": "BR  "
                  },
                  {
                    "label": "Credit Card Account",
                    "value": "BD "
                  },
                  {
                    "label": "Prepaid Card Account",
                    "value": "BP "
                  },
                  {
                    "label": "Loan Account",
                    "value": "BL"
                  },
                  {
                    "label": "Term Deposit Account",
                    "value": "BT "
                  },
                  {
                    "label": "Letter of Credit/Bank Guarantee ",
                    "value": "BG "
                  },
                  {
                    "label": "Term Insurance Policy",
                    "value": "IL "
                  },
                  {
                    "label": "Endowment Policy",
                    "value": "IE "
                  },
                  {
                    "label": "Annuity Policy(Excluding ULIP)",
                    "value": "IA "
                  },
                  {
                    "label": "ULIP Policy",
                    "value": "IU"
                  },
                  {
                    "label": "Health Insurance Policy",
                    "value": "IH"
                  },
                  {
                    "label": "Motor Insurance Policy",
                    "value": "IM"
                  },
                  {
                    "label": "Travel Insurance Policy",
                    "value": "IT"
                  },
                  {
                    "label": "Money Back Policy",
                    "value": "IB "
                  },
                  {
                    "label": "Whole Life Policy",
                    "value": "IW "
                  },
                  {
                    "label": "Trading Account",
                    "value": "ST"
                  },
                  {
                    "label": "Mutual Fund Folio",
                    "value": "MF"
                  },
                  {
                    "label": "Beneficiary Client Account",
                    "value": "DB"
                  },
                  {
                    "label": "Beneficiary House Account",
                    "value": "DH"
                  },
                  {
                    "label": "Clearing Member Pool Account",
                    "value": "DC"
                  },
                  {
                    "label": "Others",
                    "value": "ZZ"
                  },
                  {
                    "label": "Not Categorised",
                    "value": "XX"
                  }
                ],
                "validations": {
                  "required": true
                }
              },
              {
                "key": "Batch.Report.Account.AccountDetails.HolderName",
                "type": "text",
                "label": "Holder Name",
                "validations": {
                  "required": true,
                  "maxLength": 80
                }
              },
              {
                "key": "Batch.Report.Account.AccountDetails.AccountHolderType",
                "type": "select",
                "label": "Account Holder Type",
                "options": [
                  {
                    "label": "Resident Individual",
                    "value": "A"
                  },
                  {
                    "label": "Legal Person/Entity (excluding C,D,E and F)",
                    "value": "B"
                  },
                  {
                    "label": "Central/State Government",
                    "value": "C"
                  },
                  {
                    "label": "Central/State Government owned undertaking",
                    "value": "D"
                  },
                  {
                    "label": "Reporting Entity",
                    "value": "E"
                  },
                  {
                    "label": "Non Profit Organisation",
                    "value": "F"
                  },
                  {
                    "label": "Non-residential individual",
                    "value": "G"
                  },
                  {
                    "label": "Overseas corporate body/FII",
                    "value": "H"
                  },
                  {
                    "label": "Others",
                    "value": "Z"
                  },
                  {
                    "label": "Not categorised",
                    "value": "X"
                  }
                ],
                "validations": {
                  "required": true
                }
              },
              {
                "key": "Batch.Report.Account.AccountDetails.AccountStatus",
                "type": "select",
                "label": "Account Status",
                "options": [
                  {
                    "label": "Active",
                    "value": "A"
                  },
                  {
                    "label": "Inactive",
                    "value": "I"
                  },
                  {
                    "label": "Dormant ",
                    "value": "D"
                  },
                  {
                    "label": "Suspended",
                    "value": "S"
                  },
                  {
                    "label": "Frozen",
                    "value": "F"
                  },
                  {
                    "label": "Closed",
                    "value": "C"
                  },
                  {
                    "label": "Others",
                    "value": "Z"
                  },
                  {
                    "label": "Not categorised",
                    "value": "X"
                  }
                ],
                "validations": {
                  "required": true
                }
              },
              {
                "key": "Batch.Report.Account.AccountDetails.DateOfOpening",
                "type": "date",
                "label": "Date Of Opening",
                "format": "YYYY-MM-DD",
                "maxDate": "new Date()",
                "validations": {
                  "required": false
                }
              },
              {
                "key": "Batch.Report.Account.AccountDetails.RiskRating",
                "type": "select",
                "label": "Risk Rating",
                "options": [
                  {
                    "label": "High Risk Account",
                    "value": "A1"
                  },
                  {
                    "label": "Medium Risk Account",
                    "value": "A2"
                  },
                  {
                    "label": "Low Risk Account",
                    "value": "A3"
                  },
                  {
                    "label": "Not Categorised",
                    "value": "XX"
                  }
                ],
                "validations": {
                  "required": true
                }
              },
              {
                "key": "Batch.Report.Account.AccountDetails.CumulativeCreditTurnover",
                "type": "text",
                "label": "Cumulative Credit Turnover",
                "validations": {
                  "required": false,
                  "maxLength": 20
                }
              },
              {
                "key": "Batch.Report.Account.AccountDetails.CumulativeDebitTurnover",
                "type": "text",
                "label": "Cumulative Debit Turnover",
                "validations": {
                  "required": false,
                  "maxLength": 20
                }
              },
              {
                "key": "Batch.Report.Account.AccountDetails.CumulativeCashDepositTurnover",
                "type": "text",
                "label": "Cumulative Cash Deposit Turnover",
                "validations": {
                  "required": false,
                  "maxLength": 20
                },
                "internalFieldValidations": [
                  {
                    "errorMsg": "Cumulative Cash Deposit Turnover should not be greater than Cumulative Credit Turnover",
                    "condition": "(value)=>value>values.Batch.Report.Account.AccountDetails.CumulativeCreditTurnover"
                  }
                ]
              },
              {
                "key": "Batch.Report.Account.AccountDetails.CumulativeCashWithdrawalTurnov",
                "type": "text",
                "label": "Cumulative Cash Withdrawal Turnover",
                "validations": {
                  "required": false,
                  "maxLength": 20
                },
                "internalFieldValidations": [
                  {
                    "errorMsg": "Cumulative Withdrawal Turnover should not be greater than Cumulative Debit Turnover",
                    "condition": "(value)=>value>values.Batch.Report.Account.AccountDetails.CumulativeDebitTurnover"
                  }
                ]
              },
              {
                "key": "Batch.Report.Account.AccountDetails.NoTransactionsToBeReported",
                "type": "select",
                "label": "No Of Transactions To Be Reported",
                "options": [
                  {
                    "label": "Yes (No transaction to be reported)",
                    "value": "Y"
                  },
                  {
                    "label": "No (Transactions are reported)",
                    "value": "N"
                  },
                  {
                    "label": "Not Categorised",
                    "value": "X"
                  }
                ],
                "validations": {
                  "required": true
                }
              },
              {
                "section": {
                  "label": "Branch",
                  "fields": [
                    {
                      "key": "Batch.Report.Account.Branch.BranchRefNumType",
                      "type": "select",
                      "label": "Branch Ref Number Type",
                      "options": [
                        {
                          "label": "Regulator Issued",
                          "value": "R"
                        },
                        {
                          "label": "BIC",
                          "value": "B"
                        },
                        {
                          "label": "IFSC",
                          "value": "I"
                        },
                        {
                          "label": "MICR Code",
                          "value": "M"
                        },
                        {
                          "label": "Self Generated",
                          "value": "S"
                        },
                        {
                          "label": "Other sources",
                          "value": "Z"
                        },
                        {
                          "label": "Not Categorised",
                          "value": "X"
                        }
                      ],
                      "validations": {
                        "required": true
                      }
                    },
                    {
                      "key": "Batch.Report.Account.Branch.BranchRefNum",
                      "type": "text",
                      "label": "Branch Ref Number",
                      "validations": {
                        "required": true,
                        "maxLength": 20
                      }
                    },
                    {
                      "section": {
                        "label": "Branch Details",
                        "fields": [
                          {
                            "key": "Batch.Report.Account.Branch.BranchDetails.BranchName",
                            "type": "text",
                            "label": "Branch Name",
                            "validations": {
                              "required": true,
                              "maxLength": 80
                            }
                          },
                          {
                            "key": "Batch.Report.Account.Branch.BranchDetails.BranchEmail",
                            "type": "text",
                            "label": "Branch Email",
                            "validations": {
                              "regexp": "``",
                              "required": false,
                              "maxLength": 50
                            }
                          },
                          {
                            "section": {
                              "label": "Branch Address",
                              "fields": [
                                {
                                  "key": "Batch.Report.Account.Branch.BranchDetails.BranchAddress.Address",
                                  "type": "text",
                                  "label": "Address",
                                  "validations": {
                                    "required": true,
                                    "maxLength": 225,
                                    "minLength": 8
                                  }
                                },
                                {
                                  "key": "Batch.Report.Account.Branch.BranchDetails.BranchAddress.City",
                                  "type": "text",
                                  "label": "City",
                                  "validations": {
                                    "required": false,
                                    "maxLength": 50
                                  }
                                },
                                {
                                  "key": "Batch.Report.Account.Branch.BranchDetails.BranchAddress.StateCode",
                                  "type": "select",
                                  "label": "State Code",
                                  "options": [
                                    {
                                      "label": "Andaman & Nicobar",
                                      "value": "AN"
                                    },
                                    {
                                      "label": "Andhra Pradesh",
                                      "value": "AP"
                                    },
                                    {
                                      "label": "Arunachal Pradesh",
                                      "value": "AR"
                                    },
                                    {
                                      "label": "Assam",
                                      "value": "AS"
                                    },
                                    {
                                      "label": "Bihar",
                                      "value": "BR"
                                    },
                                    {
                                      "label": "Chandigarh",
                                      "value": "CH"
                                    },
                                    {
                                      "label": "Chhattisgarh",
                                      "value": "CG"
                                    },
                                    {
                                      "label": "Dadra and Nagar Haveli",
                                      "value": "DN"
                                    },
                                    {
                                      "label": "Daman & Diu",
                                      "value": "DD"
                                    },
                                    {
                                      "label": "Delhi",
                                      "value": "DL"
                                    },
                                    {
                                      "label": "Goa",
                                      "value": "GA"
                                    },
                                    {
                                      "label": "Gujarat",
                                      "value": "GJ"
                                    },
                                    {
                                      "label": "Haryana",
                                      "value": "HR"
                                    },
                                    {
                                      "label": "Himachal Pradesh",
                                      "value": "HP"
                                    },
                                    {
                                      "label": "Jammu & Kashmir",
                                      "value": "JK"
                                    },
                                    {
                                      "label": "Jharkhand",
                                      "value": "JH"
                                    },
                                    {
                                      "label": "Karnataka",
                                      "value": "KA"
                                    },
                                    {
                                      "label": "Kerala",
                                      "value": "KL"
                                    },
                                    {
                                      "label": "Lakshadweep",
                                      "value": "LD"
                                    },
                                    {
                                      "label": "Madhya Pradesh",
                                      "value": "MP"
                                    },
                                    {
                                      "label": "Maharashtra",
                                      "value": "MH"
                                    },
                                    {
                                      "label": "Manipur",
                                      "value": "MN"
                                    },
                                    {
                                      "label": "Meghalaya",
                                      "value": "ML"
                                    },
                                    {
                                      "label": "Mizoram",
                                      "value": "MZ"
                                    },
                                    {
                                      "label": "Nagaland",
                                      "value": "NL"
                                    },
                                    {
                                      "label": "Orissa",
                                      "value": "OR"
                                    },
                                    {
                                      "label": "Pondicherry",
                                      "value": "PY"
                                    },
                                    {
                                      "label": "Punjab",
                                      "value": "PB"
                                    },
                                    {
                                      "label": "Rajasthan",
                                      "value": "RJ"
                                    },
                                    {
                                      "label": "Sikkim",
                                      "value": "SK"
                                    },
                                    {
                                      "label": "Tamil Nadu",
                                      "value": "TN"
                                    },
                                    {
                                      "label": "Tripura",
                                      "value": "TR"
                                    },
                                    {
                                      "label": "Uttar Pradesh",
                                      "value": "UP"
                                    },
                                    {
                                      "label": "Uttarakhand",
                                      "value": "UA"
                                    },
                                    {
                                      "label": "West Bengal",
                                      "value": "WB"
                                    },
                                    {
                                      "label": "Others",
                                      "value": "ZZ"
                                    },
                                    {
                                      "label": "Not Applicable",
                                      "value": "XX"
                                    }
                                  ],
                                  "validations": {
                                    "required": true
                                  }
                                },
                                {
                                  "key": "Batch.Report.Account.Branch.BranchDetails.BranchAddress.PinCode",
                                  "type": "text",
                                  "label": "Pincode",
                                  "validations": {
                                    "required": false,
                                    "maxLength": 10
                                  }
                                },
                                {
                                  "key": "Batch.Report.Account.Branch.BranchDetails.BranchAddress.CountryCode",
                                  "type": "select",
                                  "label": "Country Code",
                                  "options": [
                                    {
                                      "label": "Afghanistan",
                                      "value": "AF"
                                    },
                                    {
                                      "label": "Aland Islands",
                                      "value": "AX"
                                    },
                                    {
                                      "label": "Albania",
                                      "value": "AL"
                                    },
                                    {
                                      "label": "Algeria",
                                      "value": "DZ"
                                    },
                                    {
                                      "label": "American Samoa",
                                      "value": "AS"
                                    },
                                    {
                                      "label": "Andorra",
                                      "value": "AD"
                                    },
                                    {
                                      "label": "Angola",
                                      "value": "AO"
                                    },
                                    {
                                      "label": "Anguilla",
                                      "value": "AI"
                                    },
                                    {
                                      "label": "Antarctica",
                                      "value": "AQ"
                                    },
                                    {
                                      "label": "Antigua And Barbuda",
                                      "value": "AG"
                                    },
                                    {
                                      "label": "Argentina",
                                      "value": "AR"
                                    },
                                    {
                                      "label": "Armenia",
                                      "value": "AM"
                                    },
                                    {
                                      "label": "Aruba",
                                      "value": "AW"
                                    },
                                    {
                                      "label": "Australia",
                                      "value": "AU"
                                    },
                                    {
                                      "label": "Austria",
                                      "value": "AT"
                                    },
                                    {
                                      "label": "Azerbaijan",
                                      "value": "AZ"
                                    },
                                    {
                                      "label": "Bahamas",
                                      "value": "BS"
                                    },
                                    {
                                      "label": "Bahrain",
                                      "value": "BH"
                                    },
                                    {
                                      "label": "Bangladesh",
                                      "value": "BD"
                                    },
                                    {
                                      "label": "Barbados",
                                      "value": "BB"
                                    },
                                    {
                                      "label": "Belarus",
                                      "value": "BY"
                                    },
                                    {
                                      "label": "Belgium",
                                      "value": "BE"
                                    },
                                    {
                                      "label": "Belize",
                                      "value": "BZ"
                                    },
                                    {
                                      "label": "Benin",
                                      "value": "BJ"
                                    },
                                    {
                                      "label": "Bermuda",
                                      "value": "BM"
                                    },
                                    {
                                      "label": "Bhutan",
                                      "value": "BT"
                                    },
                                    {
                                      "label": "Bolivia",
                                      "value": "BO"
                                    },
                                    {
                                      "label": "Bosnia And Herzegovina",
                                      "value": "BA"
                                    },
                                    {
                                      "label": "Bonaire, Sint Eustatius and Saba",
                                      "value": "BQ"
                                    },
                                    {
                                      "label": "Botswana",
                                      "value": "BW"
                                    },
                                    {
                                      "label": "Bouvet Island",
                                      "value": "BV"
                                    },
                                    {
                                      "label": "Brazil",
                                      "value": "BR"
                                    },
                                    {
                                      "label": "British Indian Ocean Territory",
                                      "value": "IO"
                                    },
                                    {
                                      "label": "Brunei Darussalam",
                                      "value": "BN"
                                    },
                                    {
                                      "label": "Bulgaria",
                                      "value": "BG"
                                    },
                                    {
                                      "label": "Burkina Faso",
                                      "value": "BF"
                                    },
                                    {
                                      "label": "Burundi",
                                      "value": "BI"
                                    },
                                    {
                                      "label": "Cambodia",
                                      "value": "KH"
                                    },
                                    {
                                      "label": "Cameroon",
                                      "value": "CM"
                                    },
                                    {
                                      "label": "Canada",
                                      "value": "CA"
                                    },
                                    {
                                      "label": "Cape Verde",
                                      "value": "CV"
                                    },
                                    {
                                      "label": "Cayman Islands",
                                      "value": "KY"
                                    },
                                    {
                                      "label": "Central African Republic",
                                      "value": "CF"
                                    },
                                    {
                                      "label": "Chad",
                                      "value": "TD"
                                    },
                                    {
                                      "label": "Chile",
                                      "value": "CL"
                                    },
                                    {
                                      "label": "China",
                                      "value": "CN"
                                    },
                                    {
                                      "label": "Christmas Island",
                                      "value": "CX"
                                    },
                                    {
                                      "label": "Cocos (Keeling) Islands",
                                      "value": "CC"
                                    },
                                    {
                                      "label": "Colombia",
                                      "value": "CO"
                                    },
                                    {
                                      "label": "Comoros",
                                      "value": "KM"
                                    },
                                    {
                                      "label": "Congo",
                                      "value": "CG"
                                    },
                                    {
                                      "label": "Congo, The Democratic Republic Of The",
                                      "value": "CD"
                                    },
                                    {
                                      "label": "Cook Islands",
                                      "value": "CK"
                                    },
                                    {
                                      "label": "Costa Rica",
                                      "value": "CR"
                                    },
                                    {
                                      "label": "Côte D''ivoire",
                                      "value": "CI"
                                    },
                                    {
                                      "label": "Croatia",
                                      "value": "HR"
                                    },
                                    {
                                      "label": "Cuba",
                                      "value": "CU"
                                    },
                                    {
                                      "label": "Curacao",
                                      "value": "CW"
                                    },
                                    {
                                      "label": "Cyprus",
                                      "value": "CY"
                                    },
                                    {
                                      "label": "Czech Republic",
                                      "value": "CZ"
                                    },
                                    {
                                      "label": "Denmark",
                                      "value": "DK"
                                    },
                                    {
                                      "label": "Djibouti",
                                      "value": "DJ"
                                    },
                                    {
                                      "label": "Dominica",
                                      "value": "DM"
                                    },
                                    {
                                      "label": "Dominican Republic",
                                      "value": "DO"
                                    },
                                    {
                                      "label": "Ecuador",
                                      "value": "EC"
                                    },
                                    {
                                      "label": "Egypt",
                                      "value": "EG"
                                    },
                                    {
                                      "label": "El Salvador",
                                      "value": "SV"
                                    },
                                    {
                                      "label": "Equatorial Guinea",
                                      "value": "GQ"
                                    },
                                    {
                                      "label": "Eritrea",
                                      "value": "ER"
                                    },
                                    {
                                      "label": "Estonia",
                                      "value": "EE"
                                    },
                                    {
                                      "label": "Ethiopia",
                                      "value": "ET"
                                    },
                                    {
                                      "label": "Falkland Islands (Malvinas)",
                                      "value": "FK"
                                    },
                                    {
                                      "label": "Faroe Islands",
                                      "value": "FO"
                                    },
                                    {
                                      "label": "Fiji",
                                      "value": "FJ"
                                    },
                                    {
                                      "label": "Finland",
                                      "value": "FI"
                                    },
                                    {
                                      "label": "France",
                                      "value": "FR"
                                    },
                                    {
                                      "label": "French Guiana",
                                      "value": "GF"
                                    },
                                    {
                                      "label": "French Polynesia",
                                      "value": "PF"
                                    },
                                    {
                                      "label": "French Southern Territories",
                                      "value": "TF"
                                    },
                                    {
                                      "label": "Gabon",
                                      "value": "GA"
                                    },
                                    {
                                      "label": "Gambia",
                                      "value": "GM"
                                    },
                                    {
                                      "label": "Georgia",
                                      "value": "GE"
                                    },
                                    {
                                      "label": "Germany",
                                      "value": "DE"
                                    },
                                    {
                                      "label": "Ghana",
                                      "value": "GH"
                                    },
                                    {
                                      "label": "Gibraltar",
                                      "value": "GI"
                                    },
                                    {
                                      "label": "Greece",
                                      "value": "GR"
                                    },
                                    {
                                      "label": "Greenland",
                                      "value": "GL"
                                    },
                                    {
                                      "label": "Grenada",
                                      "value": "GD"
                                    },
                                    {
                                      "label": "Guadeloupe",
                                      "value": "GP"
                                    },
                                    {
                                      "label": "Guam",
                                      "value": "GU"
                                    },
                                    {
                                      "label": "Guatemala",
                                      "value": "GT"
                                    },
                                    {
                                      "label": "Guernsey",
                                      "value": "GG"
                                    },
                                    {
                                      "label": "Guinea",
                                      "value": "GN"
                                    },
                                    {
                                      "label": "Guinea-Bissau",
                                      "value": "GW"
                                    },
                                    {
                                      "label": "Guyana",
                                      "value": "GY"
                                    },
                                    {
                                      "label": "Haiti",
                                      "value": "HT"
                                    },
                                    {
                                      "label": "Heard Island And McDonald Islands",
                                      "value": "HM"
                                    },
                                    {
                                      "label": "Vatican City State",
                                      "value": "VA"
                                    },
                                    {
                                      "label": "Honduras",
                                      "value": "HN"
                                    },
                                    {
                                      "label": "Hong Kong",
                                      "value": "HK"
                                    },
                                    {
                                      "label": "Hungary",
                                      "value": "HU"
                                    },
                                    {
                                      "label": "Iceland",
                                      "value": "IS"
                                    },
                                    {
                                      "label": "India",
                                      "value": "IN"
                                    },
                                    {
                                      "label": "Indonesia",
                                      "value": "ID"
                                    },
                                    {
                                      "label": "Iran, Islamic Republic Of",
                                      "value": "IR"
                                    },
                                    {
                                      "label": "Iraq",
                                      "value": "IQ"
                                    },
                                    {
                                      "label": "Ireland",
                                      "value": "IE"
                                    },
                                    {
                                      "label": "Isle Of Man",
                                      "value": "IM"
                                    },
                                    {
                                      "label": "Israel",
                                      "value": "IL"
                                    },
                                    {
                                      "label": "Italy",
                                      "value": "IT"
                                    },
                                    {
                                      "label": "Jamaica",
                                      "value": "JM"
                                    },
                                    {
                                      "label": "Japan",
                                      "value": "JP"
                                    },
                                    {
                                      "label": "Jersey",
                                      "value": "JE"
                                    },
                                    {
                                      "label": "Jordan",
                                      "value": "JO"
                                    },
                                    {
                                      "label": "Kazakhstan",
                                      "value": "KZ"
                                    },
                                    {
                                      "label": "Kenya",
                                      "value": "KE"
                                    },
                                    {
                                      "label": "Kiribati",
                                      "value": "KI"
                                    },
                                    {
                                      "label": "Korea, Democratic People''s Republic Of",
                                      "value": "KP"
                                    },
                                    {
                                      "label": "Korea, Republic Of",
                                      "value": "KR"
                                    },
                                    {
                                      "label": "Kuwait",
                                      "value": "KW"
                                    },
                                    {
                                      "label": "Kyrgyzstan",
                                      "value": "KG"
                                    },
                                    {
                                      "label": "Lao People''s Democratic Republic",
                                      "value": "LA"
                                    },
                                    {
                                      "label": "Latvia",
                                      "value": "LV"
                                    },
                                    {
                                      "label": "Lebanon",
                                      "value": "LB"
                                    },
                                    {
                                      "label": "Lesotho",
                                      "value": "LS"
                                    },
                                    {
                                      "label": "Liberia",
                                      "value": "LR"
                                    },
                                    {
                                      "label": "Libyan Arab Jamahiriya",
                                      "value": "LY"
                                    },
                                    {
                                      "label": "Liechtenstein",
                                      "value": "LI"
                                    },
                                    {
                                      "label": "Lithuania",
                                      "value": "LT"
                                    },
                                    {
                                      "label": "Luxembourg",
                                      "value": "LU"
                                    },
                                    {
                                      "label": "Macao",
                                      "value": "MO"
                                    },
                                    {
                                      "label": "Macedonia, The Former Yugoslav Republic Of",
                                      "value": "MK"
                                    },
                                    {
                                      "label": "Madagascar",
                                      "value": "MG"
                                    },
                                    {
                                      "label": "Malawi",
                                      "value": "MW"
                                    },
                                    {
                                      "label": "Malaysia",
                                      "value": "MY"
                                    },
                                    {
                                      "label": "Maldives",
                                      "value": "MV"
                                    },
                                    {
                                      "label": "Mali",
                                      "value": "ML"
                                    },
                                    {
                                      "label": "Malta",
                                      "value": "MT"
                                    },
                                    {
                                      "label": "Marshall Islands",
                                      "value": "MH"
                                    },
                                    {
                                      "label": "Martinique",
                                      "value": "MQ"
                                    },
                                    {
                                      "label": "Mauritania",
                                      "value": "MR"
                                    },
                                    {
                                      "label": "Mauritius",
                                      "value": "MU"
                                    },
                                    {
                                      "label": "Mayotte",
                                      "value": "YT"
                                    },
                                    {
                                      "label": "Mexico",
                                      "value": "MX"
                                    },
                                    {
                                      "label": "Micronesia, Federated States Of",
                                      "value": "FM"
                                    },
                                    {
                                      "label": "Moldova, Republic Of",
                                      "value": "MD"
                                    },
                                    {
                                      "label": "Monaco",
                                      "value": "MC"
                                    },
                                    {
                                      "label": "Mongolia",
                                      "value": "MN"
                                    },
                                    {
                                      "label": "Montenegro",
                                      "value": "ME"
                                    },
                                    {
                                      "label": "Montserrat",
                                      "value": "MS"
                                    },
                                    {
                                      "label": "Morocco",
                                      "value": "MA"
                                    },
                                    {
                                      "label": "Mozambique",
                                      "value": "MZ"
                                    },
                                    {
                                      "label": "Myanmar",
                                      "value": "MM"
                                    },
                                    {
                                      "label": "Namibia",
                                      "value": "NA"
                                    },
                                    {
                                      "label": "Nauru",
                                      "value": "NR"
                                    },
                                    {
                                      "label": "Nepal",
                                      "value": "NP"
                                    },
                                    {
                                      "label": "Netherlands",
                                      "value": "NL"
                                    },
                                    {
                                      "label": "Netherlands Antilles",
                                      "value": "AN"
                                    },
                                    {
                                      "label": "New Caledonia",
                                      "value": "NC"
                                    },
                                    {
                                      "label": "New Zealand",
                                      "value": "NZ"
                                    },
                                    {
                                      "label": "Nicaragua",
                                      "value": "NI"
                                    },
                                    {
                                      "label": "Niger",
                                      "value": "NE"
                                    },
                                    {
                                      "label": "Nigeria",
                                      "value": "NG"
                                    },
                                    {
                                      "label": "Niue",
                                      "value": "NU"
                                    },
                                    {
                                      "label": "Norfolk Island",
                                      "value": "NF"
                                    },
                                    {
                                      "label": "Northern Mariana Islands",
                                      "value": "MP"
                                    },
                                    {
                                      "label": "Norway",
                                      "value": "NO"
                                    },
                                    {
                                      "label": "Oman",
                                      "value": "OM"
                                    },
                                    {
                                      "label": "Pakistan",
                                      "value": "PK"
                                    },
                                    {
                                      "label": "Palau",
                                      "value": "PW"
                                    },
                                    {
                                      "label": "Palestinian Territory, Occupied",
                                      "value": "PS"
                                    },
                                    {
                                      "label": "Panama",
                                      "value": "PA"
                                    },
                                    {
                                      "label": "Papua New Guinea",
                                      "value": "PG"
                                    },
                                    {
                                      "label": "Paraguay",
                                      "value": "PY"
                                    },
                                    {
                                      "label": "Peru",
                                      "value": "PE"
                                    },
                                    {
                                      "label": "Philippines",
                                      "value": "PH"
                                    },
                                    {
                                      "label": "Pitcairn",
                                      "value": "PN"
                                    },
                                    {
                                      "label": "Poland",
                                      "value": "PL"
                                    },
                                    {
                                      "label": "Portugal",
                                      "value": "PT"
                                    },
                                    {
                                      "label": "Puerto Rico",
                                      "value": "PR"
                                    },
                                    {
                                      "label": "Qatar",
                                      "value": "QA"
                                    },
                                    {
                                      "label": "Reunion Island",
                                      "value": "RE"
                                    },
                                    {
                                      "label": "Romania",
                                      "value": "RO"
                                    },
                                    {
                                      "label": "Russian Federation",
                                      "value": "RU"
                                    },
                                    {
                                      "label": "Rwanda",
                                      "value": "RW"
                                    },
                                    {
                                      "label": "Saint Barthelemy",
                                      "value": "BL"
                                    },
                                    {
                                      "label": "Saint Helena, Ascension And Tristan da Cunha",
                                      "value": "SH"
                                    },
                                    {
                                      "label": "Saint Kitts And Nevis",
                                      "value": "KN"
                                    },
                                    {
                                      "label": "Saint Lucia",
                                      "value": "LC"
                                    },
                                    {
                                      "label": "Saint Martin",
                                      "value": "MF"
                                    },
                                    {
                                      "label": "Saint Pierre And Miquelon",
                                      "value": "PM"
                                    },
                                    {
                                      "label": "Saint Vincent And The Grenadines",
                                      "value": "VC"
                                    },
                                    {
                                      "label": "Samoa",
                                      "value": "WS"
                                    },
                                    {
                                      "label": "San Marino",
                                      "value": "SM"
                                    },
                                    {
                                      "label": "Sao Tome And Principe",
                                      "value": "ST"
                                    },
                                    {
                                      "label": "Saudi Arabia",
                                      "value": "SA"
                                    },
                                    {
                                      "label": "Senegal",
                                      "value": "SN"
                                    },
                                    {
                                      "label": "Serbia",
                                      "value": "RS"
                                    },
                                    {
                                      "label": "Seychelles",
                                      "value": "SC"
                                    },
                                    {
                                      "label": "Sierra Leone",
                                      "value": "SL"
                                    },
                                    {
                                      "label": "Singapore",
                                      "value": "SG"
                                    },
                                    {
                                      "label": "Sint Marteen",
                                      "value": "SX"
                                    },
                                    {
                                      "label": "Slovakia",
                                      "value": "SK"
                                    },
                                    {
                                      "label": "Slovenia",
                                      "value": "SI"
                                    },
                                    {
                                      "label": "Solomon Islands",
                                      "value": "SB"
                                    },
                                    {
                                      "label": "Somalia",
                                      "value": "SO"
                                    },
                                    {
                                      "label": "South Africa",
                                      "value": "ZA"
                                    },
                                    {
                                      "label": "South Georgia And The South Sandwich Islands",
                                      "value": "GS"
                                    },
                                    {
                                      "label": "South Sudan",
                                      "value": "SS"
                                    },
                                    {
                                      "label": "Spain",
                                      "value": "ES"
                                    },
                                    {
                                      "label": "Sri Lanka",
                                      "value": "LK"
                                    },
                                    {
                                      "label": "Sudan",
                                      "value": "SD"
                                    },
                                    {
                                      "label": "Suriname",
                                      "value": "SR"
                                    },
                                    {
                                      "label": "Svalbard And Jan Mayen Islands",
                                      "value": "SJ"
                                    },
                                    {
                                      "label": "Swaziland",
                                      "value": "SZ"
                                    },
                                    {
                                      "label": "Sweden",
                                      "value": "SE"
                                    },
                                    {
                                      "label": "Switzerland",
                                      "value": "CH"
                                    },
                                    {
                                      "label": "Syrian Arab Republic",
                                      "value": "SY"
                                    },
                                    {
                                      "label": "Taiwan, Province Of China",
                                      "value": "TW"
                                    },
                                    {
                                      "label": "Tajikistan",
                                      "value": "TJ"
                                    },
                                    {
                                      "label": "Tanzania, United Republic Of",
                                      "value": "TZ"
                                    },
                                    {
                                      "label": "Thailand",
                                      "value": "TH"
                                    },
                                    {
                                      "label": "Timor-Leste",
                                      "value": "TL"
                                    },
                                    {
                                      "label": "Togo",
                                      "value": "TG"
                                    },
                                    {
                                      "label": "Tokelau",
                                      "value": "TK"
                                    },
                                    {
                                      "label": "Tonga",
                                      "value": "TO"
                                    },
                                    {
                                      "label": "Trinidad And Tobago",
                                      "value": "TT"
                                    },
                                    {
                                      "label": "Tunisia",
                                      "value": "TN"
                                    },
                                    {
                                      "label": "Turkey",
                                      "value": "TR"
                                    },
                                    {
                                      "label": "Turkmenistan",
                                      "value": "TM"
                                    },
                                    {
                                      "label": "Turks And Caicos Islands",
                                      "value": "TC"
                                    },
                                    {
                                      "label": "Tuvalu",
                                      "value": "TV"
                                    },
                                    {
                                      "label": "Uganda",
                                      "value": "UG"
                                    },
                                    {
                                      "label": "Ukraine",
                                      "value": "UA"
                                    },
                                    {
                                      "label": "United Arab Emirates",
                                      "value": "AE"
                                    },
                                    {
                                      "label": "United Kingdom",
                                      "value": "GB"
                                    },
                                    {
                                      "label": "United States",
                                      "value": "US"
                                    },
                                    {
                                      "label": "United States Minor Outlying Islands",
                                      "value": "UM"
                                    },
                                    {
                                      "label": "Uruguay",
                                      "value": "UY"
                                    },
                                    {
                                      "label": "Uzbekistan",
                                      "value": "UZ"
                                    },
                                    {
                                      "label": "Vanuatu",
                                      "value": "VU"
                                    },
                                    {
                                      "label": "Venezuela, Bolivarian Republic Of",
                                      "value": "VE"
                                    },
                                    {
                                      "label": "Viet Nam",
                                      "value": "VN"
                                    },
                                    {
                                      "label": "Virgin Islands, British",
                                      "value": "VG"
                                    },
                                    {
                                      "label": "Virgin Islands, U.S.",
                                      "value": "VI"
                                    },
                                    {
                                      "label": "Wallis And Futuna",
                                      "value": "WF"
                                    },
                                    {
                                      "label": "Western Sahara",
                                      "value": "EH"
                                    },
                                    {
                                      "label": "Yemen",
                                      "value": "YE"
                                    },
                                    {
                                      "label": "Zambia",
                                      "value": "ZM"
                                    },
                                    {
                                      "label": "Zimbabwe",
                                      "value": "ZW"
                                    },
                                    {
                                      "label": "Not categorised",
                                      "value": "XX"
                                    },
                                    {
                                      "label": "Others",
                                      "value": "ZZ"
                                    }
                                  ],
                                  "validations": {
                                    "required": true
                                  }
                                }
                              ],
                              "colClassName": "mt-4"
                            }
                          },
                          {
                            "section": {
                              "label": "Branch Phone",
                              "fields": [
                                {
                                  "key": "Batch.Report.Account.Branch.BranchDetails.BranchPhone.Telephone",
                                  "type": "text",
                                  "label": "Telephone",
                                  "validations": {
                                    "required": false,
                                    "maxLength": 30
                                  }
                                },
                                {
                                  "key": "Batch.Report.Account.Branch.BranchDetails.BranchPhone.Mobile",
                                  "type": "text",
                                  "label": "Mobile",
                                  "validations": {
                                    "required": false,
                                    "maxLength": 30
                                  }
                                },
                                {
                                  "key": "Batch.Report.Account.Branch.BranchDetails.BranchPhone.Fax",
                                  "type": "text",
                                  "label": "Fax",
                                  "validations": {
                                    "required": false,
                                    "maxLength": 30
                                  }
                                }
                              ],
                              "colClassName": "mt-4"
                            }
                          }
                        ],
                        "colClassName": "mt-4"
                      }
                    }
                  ],
                  "colClassName": "mt-4"
                }
              },
              {
                "section": {
                  "label": "Person Details",
                  "fields": [
                    {
                      "key": "Batch.Report.Account.PersonDetails[].PersonName",
                      "type": "text",
                      "label": "Person Name",
                      "validations": {
                        "required": true,
                        "maxLength": 80
                      }
                    },
                    {
                      "key": "Batch.Report.Account.PersonDetails[].CustomerID",
                      "type": "text",
                      "label": "Customer ID",
                      "validations": {
                        "required": false,
                        "maxLength": 10
                      }
                    },
                    {
                      "key": "Batch.Report.Account.PersonDetails[].RelationFlag",
                      "type": "select",
                      "label": "Relation Flag",
                      "options": [
                        {
                          "label": "Account Holder",
                          "value": "A"
                        },
                        {
                          "label": "Authorised Signatory",
                          "value": "B"
                        },
                        {
                          "label": "Proprietor/Director/Partner/Member of a legal entity",
                          "value": "C"
                        },
                        {
                          "label": "Introducer",
                          "value": "D"
                        },
                        {
                          "label": "Guarantor",
                          "value": "E"
                        },
                        {
                          "label": "Guardian",
                          "value": "F"
                        },
                        {
                          "label": "Nominee",
                          "value": "N"
                        },
                        {
                          "label": "Beneficial Owner",
                          "value": "O"
                        },
                        {
                          "label": "Proposer",
                          "value": "P"
                        },
                        {
                          "label": "Assignee",
                          "value": "G"
                        },
                        {
                          "label": "Life Assured",
                          "value": "L"
                        },
                        {
                          "label": "Beneficiary",
                          "value": "J"
                        },
                        {
                          "label": "Power of Attorney",
                          "value": "H"
                        },
                        {
                          "label": "Others",
                          "value": "Z"
                        },
                        {
                          "label": "Not Categorised",
                          "value": "X"
                        }
                      ],
                      "validations": {
                        "required": true
                      }
                    },
                    {
                      "key": "Batch.Report.Account.PersonDetails[].Email",
                      "type": "text",
                      "label": "Email",
                      "validations": {
                        "regexp": "``",
                        "required": false,
                        "maxLength": 50
                      }
                    },
                    {
                      "key": "Batch.Report.Account.PersonDetails[].PAN",
                      "type": "text",
                      "label": "PAN",
                      "validations": {
                        "required": false,
                        "maxLength": 10
                      }
                    },
                    {
                      "key": "Batch.Report.Account.PersonDetails[].UIN",
                      "type": "text",
                      "label": "UIN",
                      "validations": {
                        "required": false,
                        "maxLength": 30
                      }
                    },
                    {
                      "key": "Batch.Report.Account.PersonDetails[].Choice",
                      "type": "select",
                      "label": "Choice",
                      "options": [
                        {
                          "label": "Individual",
                          "value": "individual"
                        },
                        {
                          "label": "Legal Person",
                          "value": "legalperson"
                        }
                      ],
                      "validations": {
                        "required": true
                      },
                      "conditionalRenderOtherKeys": true
                    },
                    {
                      "section": {
                        "key": "Batch.Report.Account.PersonDetails[].Individual",
                        "label": "Details Of Individual",
                        "fields": [
                          {
                            "key": "Batch.Report.Account.PersonDetails[].Individual.Gender",
                            "type": "select",
                            "label": "Gender",
                            "options": [
                              {
                                "label": "Male",
                                "value": "M"
                              },
                              {
                                "label": "Female",
                                "value": "F"
                              },
                              {
                                "label": "Not Categorised",
                                "value": "X"
                              }
                            ],
                            "validations": {
                              "required": true
                            }
                          },
                          {
                            "key": "Batch.Report.Account.PersonDetails[].Individual.DateOfBirth",
                            "type": "date",
                            "label": "Date Of Birth",
                            "format": "YYYY-MM-DD",
                            "maxDate": "new Date()",
                            "validations": {
                              "required": false
                            }
                          },
                          {
                            "key": "Batch.Report.Account.PersonDetails[].Individual.IdentificationType",
                            "type": "select",
                            "label": "Identification Type",
                            "options": [
                              {
                                "label": "Passport",
                                "value": "A"
                              },
                              {
                                "label": "Election Id Card",
                                "value": "B"
                              },
                              {
                                "label": "Pan Card",
                                "value": "C"
                              },
                              {
                                "label": "ID Card",
                                "value": "D"
                              },
                              {
                                "label": "Driving License",
                                "value": "E"
                              },
                              {
                                "label": "Account Introducer",
                                "value": "F"
                              },
                              {
                                "label": "UIDAI letter",
                                "value": "G"
                              },
                              {
                                "label": "NREGA job card",
                                "value": "H"
                              },
                              {
                                "label": "Others",
                                "value": "Z"
                              }
                            ],
                            "validations": {
                              "required": true
                            }
                          },
                          {
                            "key": "Batch.Report.Account.PersonDetails[].Individual.IdentificationNumber",
                            "type": "text",
                            "label": "Identification Number",
                            "validations": {
                              "required": false,
                              "maxLength": 20,
                              "minLength": 5
                            }
                          },
                          {
                            "key": "Batch.Report.Account.PersonDetails[].Individual.IssuingAuthority",
                            "type": "text",
                            "label": "Issuing Authority",
                            "validations": {
                              "required": false,
                              "maxLength": 20
                            }
                          },
                          {
                            "key": "Batch.Report.Account.PersonDetails[].Individual.PlaceOfIssue",
                            "type": "text",
                            "label": "Place Of Issue",
                            "validations": {
                              "required": false,
                              "maxLength": 20
                            }
                          },
                          {
                            "key": "Batch.Report.Account.PersonDetails[].Individual.Nationality",
                            "type": "select",
                            "label": "Nationality",
                            "options": [
                              {
                                "label": "Afghanistan",
                                "value": "AF"
                              },
                              {
                                "label": "Aland Islands",
                                "value": "AX"
                              },
                              {
                                "label": "Albania",
                                "value": "AL"
                              },
                              {
                                "label": "Algeria",
                                "value": "DZ"
                              },
                              {
                                "label": "American Samoa",
                                "value": "AS"
                              },
                              {
                                "label": "Andorra",
                                "value": "AD"
                              },
                              {
                                "label": "Angola",
                                "value": "AO"
                              },
                              {
                                "label": "Anguilla",
                                "value": "AI"
                              },
                              {
                                "label": "Antarctica",
                                "value": "AQ"
                              },
                              {
                                "label": "Antigua And Barbuda",
                                "value": "AG"
                              },
                              {
                                "label": "Argentina",
                                "value": "AR"
                              },
                              {
                                "label": "Armenia",
                                "value": "AM"
                              },
                              {
                                "label": "Aruba",
                                "value": "AW"
                              },
                              {
                                "label": "Australia",
                                "value": "AU"
                              },
                              {
                                "label": "Austria",
                                "value": "AT"
                              },
                              {
                                "label": "Azerbaijan",
                                "value": "AZ"
                              },
                              {
                                "label": "Bahamas",
                                "value": "BS"
                              },
                              {
                                "label": "Bahrain",
                                "value": "BH"
                              },
                              {
                                "label": "Bangladesh",
                                "value": "BD"
                              },
                              {
                                "label": "Barbados",
                                "value": "BB"
                              },
                              {
                                "label": "Belarus",
                                "value": "BY"
                              },
                              {
                                "label": "Belgium",
                                "value": "BE"
                              },
                              {
                                "label": "Belize",
                                "value": "BZ"
                              },
                              {
                                "label": "Benin",
                                "value": "BJ"
                              },
                              {
                                "label": "Bermuda",
                                "value": "BM"
                              },
                              {
                                "label": "Bhutan",
                                "value": "BT"
                              },
                              {
                                "label": "Bolivia",
                                "value": "BO"
                              },
                              {
                                "label": "Bosnia And Herzegovina",
                                "value": "BA"
                              },
                              {
                                "label": "Bonaire, Sint Eustatius and Saba",
                                "value": "BQ"
                              },
                              {
                                "label": "Botswana",
                                "value": "BW"
                              },
                              {
                                "label": "Bouvet Island",
                                "value": "BV"
                              },
                              {
                                "label": "Brazil",
                                "value": "BR"
                              },
                              {
                                "label": "British Indian Ocean Territory",
                                "value": "IO"
                              },
                              {
                                "label": "Brunei Darussalam",
                                "value": "BN"
                              },
                              {
                                "label": "Bulgaria",
                                "value": "BG"
                              },
                              {
                                "label": "Burkina Faso",
                                "value": "BF"
                              },
                              {
                                "label": "Burundi",
                                "value": "BI"
                              },
                              {
                                "label": "Cambodia",
                                "value": "KH"
                              },
                              {
                                "label": "Cameroon",
                                "value": "CM"
                              },
                              {
                                "label": "Canada",
                                "value": "CA"
                              },
                              {
                                "label": "Cape Verde",
                                "value": "CV"
                              },
                              {
                                "label": "Cayman Islands",
                                "value": "KY"
                              },
                              {
                                "label": "Central African Republic",
                                "value": "CF"
                              },
                              {
                                "label": "Chad",
                                "value": "TD"
                              },
                              {
                                "label": "Chile",
                                "value": "CL"
                              },
                              {
                                "label": "China",
                                "value": "CN"
                              },
                              {
                                "label": "Christmas Island",
                                "value": "CX"
                              },
                              {
                                "label": "Cocos (Keeling) Islands",
                                "value": "CC"
                              },
                              {
                                "label": "Colombia",
                                "value": "CO"
                              },
                              {
                                "label": "Comoros",
                                "value": "KM"
                              },
                              {
                                "label": "Congo",
                                "value": "CG"
                              },
                              {
                                "label": "Congo, The Democratic Republic Of The",
                                "value": "CD"
                              },
                              {
                                "label": "Cook Islands",
                                "value": "CK"
                              },
                              {
                                "label": "Costa Rica",
                                "value": "CR"
                              },
                              {
                                "label": "Côte D''ivoire",
                                "value": "CI"
                              },
                              {
                                "label": "Croatia",
                                "value": "HR"
                              },
                              {
                                "label": "Cuba",
                                "value": "CU"
                              },
                              {
                                "label": "Curacao",
                                "value": "CW"
                              },
                              {
                                "label": "Cyprus",
                                "value": "CY"
                              },
                              {
                                "label": "Czech Republic",
                                "value": "CZ"
                              },
                              {
                                "label": "Denmark",
                                "value": "DK"
                              },
                              {
                                "label": "Djibouti",
                                "value": "DJ"
                              },
                              {
                                "label": "Dominica",
                                "value": "DM"
                              },
                              {
                                "label": "Dominican Republic",
                                "value": "DO"
                              },
                              {
                                "label": "Ecuador",
                                "value": "EC"
                              },
                              {
                                "label": "Egypt",
                                "value": "EG"
                              },
                              {
                                "label": "El Salvador",
                                "value": "SV"
                              },
                              {
                                "label": "Equatorial Guinea",
                                "value": "GQ"
                              },
                              {
                                "label": "Eritrea",
                                "value": "ER"
                              },
                              {
                                "label": "Estonia",
                                "value": "EE"
                              },
                              {
                                "label": "Ethiopia",
                                "value": "ET"
                              },
                              {
                                "label": "Falkland Islands (Malvinas)",
                                "value": "FK"
                              },
                              {
                                "label": "Faroe Islands",
                                "value": "FO"
                              },
                              {
                                "label": "Fiji",
                                "value": "FJ"
                              },
                              {
                                "label": "Finland",
                                "value": "FI"
                              },
                              {
                                "label": "France",
                                "value": "FR"
                              },
                              {
                                "label": "French Guiana",
                                "value": "GF"
                              },
                              {
                                "label": "French Polynesia",
                                "value": "PF"
                              },
                              {
                                "label": "French Southern Territories",
                                "value": "TF"
                              },
                              {
                                "label": "Gabon",
                                "value": "GA"
                              },
                              {
                                "label": "Gambia",
                                "value": "GM"
                              },
                              {
                                "label": "Georgia",
                                "value": "GE"
                              },
                              {
                                "label": "Germany",
                                "value": "DE"
                              },
                              {
                                "label": "Ghana",
                                "value": "GH"
                              },
                              {
                                "label": "Gibraltar",
                                "value": "GI"
                              },
                              {
                                "label": "Greece",
                                "value": "GR"
                              },
                              {
                                "label": "Greenland",
                                "value": "GL"
                              },
                              {
                                "label": "Grenada",
                                "value": "GD"
                              },
                              {
                                "label": "Guadeloupe",
                                "value": "GP"
                              },
                              {
                                "label": "Guam",
                                "value": "GU"
                              },
                              {
                                "label": "Guatemala",
                                "value": "GT"
                              },
                              {
                                "label": "Guernsey",
                                "value": "GG"
                              },
                              {
                                "label": "Guinea",
                                "value": "GN"
                              },
                              {
                                "label": "Guinea-Bissau",
                                "value": "GW"
                              },
                              {
                                "label": "Guyana",
                                "value": "GY"
                              },
                              {
                                "label": "Haiti",
                                "value": "HT"
                              },
                              {
                                "label": "Heard Island And McDonald Islands",
                                "value": "HM"
                              },
                              {
                                "label": "Vatican City State",
                                "value": "VA"
                              },
                              {
                                "label": "Honduras",
                                "value": "HN"
                              },
                              {
                                "label": "Hong Kong",
                                "value": "HK"
                              },
                              {
                                "label": "Hungary",
                                "value": "HU"
                              },
                              {
                                "label": "Iceland",
                                "value": "IS"
                              },
                              {
                                "label": "India",
                                "value": "IN"
                              },
                              {
                                "label": "Indonesia",
                                "value": "ID"
                              },
                              {
                                "label": "Iran, Islamic Republic Of",
                                "value": "IR"
                              },
                              {
                                "label": "Iraq",
                                "value": "IQ"
                              },
                              {
                                "label": "Ireland",
                                "value": "IE"
                              },
                              {
                                "label": "Isle Of Man",
                                "value": "IM"
                              },
                              {
                                "label": "Israel",
                                "value": "IL"
                              },
                              {
                                "label": "Italy",
                                "value": "IT"
                              },
                              {
                                "label": "Jamaica",
                                "value": "JM"
                              },
                              {
                                "label": "Japan",
                                "value": "JP"
                              },
                              {
                                "label": "Jersey",
                                "value": "JE"
                              },
                              {
                                "label": "Jordan",
                                "value": "JO"
                              },
                              {
                                "label": "Kazakhstan",
                                "value": "KZ"
                              },
                              {
                                "label": "Kenya",
                                "value": "KE"
                              },
                              {
                                "label": "Kiribati",
                                "value": "KI"
                              },
                              {
                                "label": "Korea, Democratic People''s Republic Of",
                                "value": "KP"
                              },
                              {
                                "label": "Korea, Republic Of",
                                "value": "KR"
                              },
                              {
                                "label": "Kuwait",
                                "value": "KW"
                              },
                              {
                                "label": "Kyrgyzstan",
                                "value": "KG"
                              },
                              {
                                "label": "Lao People''s Democratic Republic",
                                "value": "LA"
                              },
                              {
                                "label": "Latvia",
                                "value": "LV"
                              },
                              {
                                "label": "Lebanon",
                                "value": "LB"
                              },
                              {
                                "label": "Lesotho",
                                "value": "LS"
                              },
                              {
                                "label": "Liberia",
                                "value": "LR"
                              },
                              {
                                "label": "Libyan Arab Jamahiriya",
                                "value": "LY"
                              },
                              {
                                "label": "Liechtenstein",
                                "value": "LI"
                              },
                              {
                                "label": "Lithuania",
                                "value": "LT"
                              },
                              {
                                "label": "Luxembourg",
                                "value": "LU"
                              },
                              {
                                "label": "Macao",
                                "value": "MO"
                              },
                              {
                                "label": "Macedonia, The Former Yugoslav Republic Of",
                                "value": "MK"
                              },
                              {
                                "label": "Madagascar",
                                "value": "MG"
                              },
                              {
                                "label": "Malawi",
                                "value": "MW"
                              },
                              {
                                "label": "Malaysia",
                                "value": "MY"
                              },
                              {
                                "label": "Maldives",
                                "value": "MV"
                              },
                              {
                                "label": "Mali",
                                "value": "ML"
                              },
                              {
                                "label": "Malta",
                                "value": "MT"
                              },
                              {
                                "label": "Marshall Islands",
                                "value": "MH"
                              },
                              {
                                "label": "Martinique",
                                "value": "MQ"
                              },
                              {
                                "label": "Mauritania",
                                "value": "MR"
                              },
                              {
                                "label": "Mauritius",
                                "value": "MU"
                              },
                              {
                                "label": "Mayotte",
                                "value": "YT"
                              },
                              {
                                "label": "Mexico",
                                "value": "MX"
                              },
                              {
                                "label": "Micronesia, Federated States Of",
                                "value": "FM"
                              },
                              {
                                "label": "Moldova, Republic Of",
                                "value": "MD"
                              },
                              {
                                "label": "Monaco",
                                "value": "MC"
                              },
                              {
                                "label": "Mongolia",
                                "value": "MN"
                              },
                              {
                                "label": "Montenegro",
                                "value": "ME"
                              },
                              {
                                "label": "Montserrat",
                                "value": "MS"
                              },
                              {
                                "label": "Morocco",
                                "value": "MA"
                              },
                              {
                                "label": "Mozambique",
                                "value": "MZ"
                              },
                              {
                                "label": "Myanmar",
                                "value": "MM"
                              },
                              {
                                "label": "Namibia",
                                "value": "NA"
                              },
                              {
                                "label": "Nauru",
                                "value": "NR"
                              },
                              {
                                "label": "Nepal",
                                "value": "NP"
                              },
                              {
                                "label": "Netherlands",
                                "value": "NL"
                              },
                              {
                                "label": "Netherlands Antilles",
                                "value": "AN"
                              },
                              {
                                "label": "New Caledonia",
                                "value": "NC"
                              },
                              {
                                "label": "New Zealand",
                                "value": "NZ"
                              },
                              {
                                "label": "Nicaragua",
                                "value": "NI"
                              },
                              {
                                "label": "Niger",
                                "value": "NE"
                              },
                              {
                                "label": "Nigeria",
                                "value": "NG"
                              },
                              {
                                "label": "Niue",
                                "value": "NU"
                              },
                              {
                                "label": "Norfolk Island",
                                "value": "NF"
                              },
                              {
                                "label": "Northern Mariana Islands",
                                "value": "MP"
                              },
                              {
                                "label": "Norway",
                                "value": "NO"
                              },
                              {
                                "label": "Oman",
                                "value": "OM"
                              },
                              {
                                "label": "Pakistan",
                                "value": "PK"
                              },
                              {
                                "label": "Palau",
                                "value": "PW"
                              },
                              {
                                "label": "Palestinian Territory, Occupied",
                                "value": "PS"
                              },
                              {
                                "label": "Panama",
                                "value": "PA"
                              },
                              {
                                "label": "Papua New Guinea",
                                "value": "PG"
                              },
                              {
                                "label": "Paraguay",
                                "value": "PY"
                              },
                              {
                                "label": "Peru",
                                "value": "PE"
                              },
                              {
                                "label": "Philippines",
                                "value": "PH"
                              },
                              {
                                "label": "Pitcairn",
                                "value": "PN"
                              },
                              {
                                "label": "Poland",
                                "value": "PL"
                              },
                              {
                                "label": "Portugal",
                                "value": "PT"
                              },
                              {
                                "label": "Puerto Rico",
                                "value": "PR"
                              },
                              {
                                "label": "Qatar",
                                "value": "QA"
                              },
                              {
                                "label": "Reunion Island",
                                "value": "RE"
                              },
                              {
                                "label": "Romania",
                                "value": "RO"
                              },
                              {
                                "label": "Russian Federation",
                                "value": "RU"
                              },
                              {
                                "label": "Rwanda",
                                "value": "RW"
                              },
                              {
                                "label": "Saint Barthelemy",
                                "value": "BL"
                              },
                              {
                                "label": "Saint Helena, Ascension And Tristan da Cunha",
                                "value": "SH"
                              },
                              {
                                "label": "Saint Kitts And Nevis",
                                "value": "KN"
                              },
                              {
                                "label": "Saint Lucia",
                                "value": "LC"
                              },
                              {
                                "label": "Saint Martin",
                                "value": "MF"
                              },
                              {
                                "label": "Saint Pierre And Miquelon",
                                "value": "PM"
                              },
                              {
                                "label": "Saint Vincent And The Grenadines",
                                "value": "VC"
                              },
                              {
                                "label": "Samoa",
                                "value": "WS"
                              },
                              {
                                "label": "San Marino",
                                "value": "SM"
                              },
                              {
                                "label": "Sao Tome And Principe",
                                "value": "ST"
                              },
                              {
                                "label": "Saudi Arabia",
                                "value": "SA"
                              },
                              {
                                "label": "Senegal",
                                "value": "SN"
                              },
                              {
                                "label": "Serbia",
                                "value": "RS"
                              },
                              {
                                "label": "Seychelles",
                                "value": "SC"
                              },
                              {
                                "label": "Sierra Leone",
                                "value": "SL"
                              },
                              {
                                "label": "Singapore",
                                "value": "SG"
                              },
                              {
                                "label": "Sint Marteen",
                                "value": "SX"
                              },
                              {
                                "label": "Slovakia",
                                "value": "SK"
                              },
                              {
                                "label": "Slovenia",
                                "value": "SI"
                              },
                              {
                                "label": "Solomon Islands",
                                "value": "SB"
                              },
                              {
                                "label": "Somalia",
                                "value": "SO"
                              },
                              {
                                "label": "South Africa",
                                "value": "ZA"
                              },
                              {
                                "label": "South Georgia And The South Sandwich Islands",
                                "value": "GS"
                              },
                              {
                                "label": "South Sudan",
                                "value": "SS"
                              },
                              {
                                "label": "Spain",
                                "value": "ES"
                              },
                              {
                                "label": "Sri Lanka",
                                "value": "LK"
                              },
                              {
                                "label": "Sudan",
                                "value": "SD"
                              },
                              {
                                "label": "Suriname",
                                "value": "SR"
                              },
                              {
                                "label": "Svalbard And Jan Mayen Islands",
                                "value": "SJ"
                              },
                              {
                                "label": "Swaziland",
                                "value": "SZ"
                              },
                              {
                                "label": "Sweden",
                                "value": "SE"
                              },
                              {
                                "label": "Switzerland",
                                "value": "CH"
                              },
                              {
                                "label": "Syrian Arab Republic",
                                "value": "SY"
                              },
                              {
                                "label": "Taiwan, Province Of China",
                                "value": "TW"
                              },
                              {
                                "label": "Tajikistan",
                                "value": "TJ"
                              },
                              {
                                "label": "Tanzania, United Republic Of",
                                "value": "TZ"
                              },
                              {
                                "label": "Thailand",
                                "value": "TH"
                              },
                              {
                                "label": "Timor-Leste",
                                "value": "TL"
                              },
                              {
                                "label": "Togo",
                                "value": "TG"
                              },
                              {
                                "label": "Tokelau",
                                "value": "TK"
                              },
                              {
                                "label": "Tonga",
                                "value": "TO"
                              },
                              {
                                "label": "Trinidad And Tobago",
                                "value": "TT"
                              },
                              {
                                "label": "Tunisia",
                                "value": "TN"
                              },
                              {
                                "label": "Turkey",
                                "value": "TR"
                              },
                              {
                                "label": "Turkmenistan",
                                "value": "TM"
                              },
                              {
                                "label": "Turks And Caicos Islands",
                                "value": "TC"
                              },
                              {
                                "label": "Tuvalu",
                                "value": "TV"
                              },
                              {
                                "label": "Uganda",
                                "value": "UG"
                              },
                              {
                                "label": "Ukraine",
                                "value": "UA"
                              },
                              {
                                "label": "United Arab Emirates",
                                "value": "AE"
                              },
                              {
                                "label": "United Kingdom",
                                "value": "GB"
                              },
                              {
                                "label": "United States",
                                "value": "US"
                              },
                              {
                                "label": "United States Minor Outlying Islands",
                                "value": "UM"
                              },
                              {
                                "label": "Uruguay",
                                "value": "UY"
                              },
                              {
                                "label": "Uzbekistan",
                                "value": "UZ"
                              },
                              {
                                "label": "Vanuatu",
                                "value": "VU"
                              },
                              {
                                "label": "Venezuela, Bolivarian Republic Of",
                                "value": "VE"
                              },
                              {
                                "label": "Viet Nam",
                                "value": "VN"
                              },
                              {
                                "label": "Virgin Islands, British",
                                "value": "VG"
                              },
                              {
                                "label": "Virgin Islands, U.S.",
                                "value": "VI"
                              },
                              {
                                "label": "Wallis And Futuna",
                                "value": "WF"
                              },
                              {
                                "label": "Western Sahara",
                                "value": "EH"
                              },
                              {
                                "label": "Yemen",
                                "value": "YE"
                              },
                              {
                                "label": "Zambia",
                                "value": "ZM"
                              },
                              {
                                "label": "Zimbabwe",
                                "value": "ZW"
                              },
                              {
                                "label": "Not categorised",
                                "value": "XX"
                              },
                              {
                                "label": "Others",
                                "value": "ZZ"
                              }
                            ],
                            "validations": {
                              "required": true
                            }
                          },
                          {
                            "key": "Batch.Report.Account.PersonDetails[].Individual.PlaceOfWork",
                            "type": "text",
                            "label": "Place Of Work",
                            "validations": {
                              "required": false,
                              "maxLength": 80
                            }
                          },
                          {
                            "key": "Batch.Report.Account.PersonDetails[].Individual.FatherOrSpouse",
                            "type": "text",
                            "label": "Name Of Father/Spouse",
                            "validations": {
                              "required": false,
                              "maxLength": 80
                            }
                          },
                          {
                            "key": "Batch.Report.Account.PersonDetails[].Individual.Occupation",
                            "type": "text",
                            "label": "Occupation",
                            "validations": {
                              "required": false,
                              "maxLength": 50
                            }
                          }
                        ],
                        "colClassName": "mt-4",
                        "renderCondition": "values.Batch.Report.Account.PersonDetails[].Choice===\"individual\""
                      }
                    },
                    {
                      "section": {
                        "key": "Batch.Report.Account.PersonDetails[].LegalPerson",
                        "label": "Details Of Legal Person",
                        "fields": [
                          {
                            "key": "Batch.Report.Account.PersonDetails[].LegalPerson.ConstitutionType",
                            "type": "select",
                            "label": "Constitution Type",
                            "options": [
                              {
                                "label": "Sole Proprietorship",
                                "value": "A"
                              },
                              {
                                "label": "Partnership Firm",
                                "value": "B"
                              },
                              {
                                "label": "HUF",
                                "value": "C"
                              },
                              {
                                "label": "Private Limited Company",
                                "value": "D"
                              },
                              {
                                "label": "Public Limited Company",
                                "value": "E"
                              },
                              {
                                "label": "Society",
                                "value": "F"
                              },
                              {
                                "label": "Association",
                                "value": "G"
                              },
                              {
                                "label": "Trust",
                                "value": "H"
                              },
                              {
                                "label": "Liquidator",
                                "value": "I"
                              },
                              {
                                "label": "LLP",
                                "value": "J"
                              },
                              {
                                "label": "Others",
                                "value": "Z"
                              },
                              {
                                "label": "Not Categorised",
                                "value": "X"
                              }
                            ],
                            "validations": {
                              "required": true
                            }
                          },
                          {
                            "key": "Batch.Report.Account.PersonDetails[].LegalPerson.RegistrationNumber",
                            "type": "text",
                            "label": "Registration Number",
                            "validations": {
                              "required": false,
                              "maxLength": 20
                            }
                          },
                          {
                            "key": "Batch.Report.Account.PersonDetails[].LegalPerson.DateOfIncorporation",
                            "type": "date",
                            "label": "Date Of Incorporation",
                            "format": "YYYY-MM-DD",
                            "maxDate": "new Date()",
                            "validations": {
                              "required": false
                            }
                          },
                          {
                            "key": "Batch.Report.Account.PersonDetails[].LegalPerson.PlaceOfRegistration",
                            "type": "text",
                            "label": "Place Of Registration",
                            "validations": {
                              "required": false,
                              "maxLength": 20
                            }
                          },
                          {
                            "key": "Batch.Report.Account.PersonDetails[].LegalPerson.CountryCode",
                            "type": "select",
                            "label": "Country Code",
                            "options": [
                              {
                                "label": "Afghanistan",
                                "value": "AF"
                              },
                              {
                                "label": "Aland Islands",
                                "value": "AX"
                              },
                              {
                                "label": "Albania",
                                "value": "AL"
                              },
                              {
                                "label": "Algeria",
                                "value": "DZ"
                              },
                              {
                                "label": "American Samoa",
                                "value": "AS"
                              },
                              {
                                "label": "Andorra",
                                "value": "AD"
                              },
                              {
                                "label": "Angola",
                                "value": "AO"
                              },
                              {
                                "label": "Anguilla",
                                "value": "AI"
                              },
                              {
                                "label": "Antarctica",
                                "value": "AQ"
                              },
                              {
                                "label": "Antigua And Barbuda",
                                "value": "AG"
                              },
                              {
                                "label": "Argentina",
                                "value": "AR"
                              },
                              {
                                "label": "Armenia",
                                "value": "AM"
                              },
                              {
                                "label": "Aruba",
                                "value": "AW"
                              },
                              {
                                "label": "Australia",
                                "value": "AU"
                              },
                              {
                                "label": "Austria",
                                "value": "AT"
                              },
                              {
                                "label": "Azerbaijan",
                                "value": "AZ"
                              },
                              {
                                "label": "Bahamas",
                                "value": "BS"
                              },
                              {
                                "label": "Bahrain",
                                "value": "BH"
                              },
                              {
                                "label": "Bangladesh",
                                "value": "BD"
                              },
                              {
                                "label": "Barbados",
                                "value": "BB"
                              },
                              {
                                "label": "Belarus",
                                "value": "BY"
                              },
                              {
                                "label": "Belgium",
                                "value": "BE"
                              },
                              {
                                "label": "Belize",
                                "value": "BZ"
                              },
                              {
                                "label": "Benin",
                                "value": "BJ"
                              },
                              {
                                "label": "Bermuda",
                                "value": "BM"
                              },
                              {
                                "label": "Bhutan",
                                "value": "BT"
                              },
                              {
                                "label": "Bolivia",
                                "value": "BO"
                              },
                              {
                                "label": "Bosnia And Herzegovina",
                                "value": "BA"
                              },
                              {
                                "label": "Bonaire, Sint Eustatius and Saba",
                                "value": "BQ"
                              },
                              {
                                "label": "Botswana",
                                "value": "BW"
                              },
                              {
                                "label": "Bouvet Island",
                                "value": "BV"
                              },
                              {
                                "label": "Brazil",
                                "value": "BR"
                              },
                              {
                                "label": "British Indian Ocean Territory",
                                "value": "IO"
                              },
                              {
                                "label": "Brunei Darussalam",
                                "value": "BN"
                              },
                              {
                                "label": "Bulgaria",
                                "value": "BG"
                              },
                              {
                                "label": "Burkina Faso",
                                "value": "BF"
                              },
                              {
                                "label": "Burundi",
                                "value": "BI"
                              },
                              {
                                "label": "Cambodia",
                                "value": "KH"
                              },
                              {
                                "label": "Cameroon",
                                "value": "CM"
                              },
                              {
                                "label": "Canada",
                                "value": "CA"
                              },
                              {
                                "label": "Cape Verde",
                                "value": "CV"
                              },
                              {
                                "label": "Cayman Islands",
                                "value": "KY"
                              },
                              {
                                "label": "Central African Republic",
                                "value": "CF"
                              },
                              {
                                "label": "Chad",
                                "value": "TD"
                              },
                              {
                                "label": "Chile",
                                "value": "CL"
                              },
                              {
                                "label": "China",
                                "value": "CN"
                              },
                              {
                                "label": "Christmas Island",
                                "value": "CX"
                              },
                              {
                                "label": "Cocos (Keeling) Islands",
                                "value": "CC"
                              },
                              {
                                "label": "Colombia",
                                "value": "CO"
                              },
                              {
                                "label": "Comoros",
                                "value": "KM"
                              },
                              {
                                "label": "Congo",
                                "value": "CG"
                              },
                              {
                                "label": "Congo, The Democratic Republic Of The",
                                "value": "CD"
                              },
                              {
                                "label": "Cook Islands",
                                "value": "CK"
                              },
                              {
                                "label": "Costa Rica",
                                "value": "CR"
                              },
                              {
                                "label": "Côte D''ivoire",
                                "value": "CI"
                              },
                              {
                                "label": "Croatia",
                                "value": "HR"
                              },
                              {
                                "label": "Cuba",
                                "value": "CU"
                              },
                              {
                                "label": "Curacao",
                                "value": "CW"
                              },
                              {
                                "label": "Cyprus",
                                "value": "CY"
                              },
                              {
                                "label": "Czech Republic",
                                "value": "CZ"
                              },
                              {
                                "label": "Denmark",
                                "value": "DK"
                              },
                              {
                                "label": "Djibouti",
                                "value": "DJ"
                              },
                              {
                                "label": "Dominica",
                                "value": "DM"
                              },
                              {
                                "label": "Dominican Republic",
                                "value": "DO"
                              },
                              {
                                "label": "Ecuador",
                                "value": "EC"
                              },
                              {
                                "label": "Egypt",
                                "value": "EG"
                              },
                              {
                                "label": "El Salvador",
                                "value": "SV"
                              },
                              {
                                "label": "Equatorial Guinea",
                                "value": "GQ"
                              },
                              {
                                "label": "Eritrea",
                                "value": "ER"
                              },
                              {
                                "label": "Estonia",
                                "value": "EE"
                              },
                              {
                                "label": "Ethiopia",
                                "value": "ET"
                              },
                              {
                                "label": "Falkland Islands (Malvinas)",
                                "value": "FK"
                              },
                              {
                                "label": "Faroe Islands",
                                "value": "FO"
                              },
                              {
                                "label": "Fiji",
                                "value": "FJ"
                              },
                              {
                                "label": "Finland",
                                "value": "FI"
                              },
                              {
                                "label": "France",
                                "value": "FR"
                              },
                              {
                                "label": "French Guiana",
                                "value": "GF"
                              },
                              {
                                "label": "French Polynesia",
                                "value": "PF"
                              },
                              {
                                "label": "French Southern Territories",
                                "value": "TF"
                              },
                              {
                                "label": "Gabon",
                                "value": "GA"
                              },
                              {
                                "label": "Gambia",
                                "value": "GM"
                              },
                              {
                                "label": "Georgia",
                                "value": "GE"
                              },
                              {
                                "label": "Germany",
                                "value": "DE"
                              },
                              {
                                "label": "Ghana",
                                "value": "GH"
                              },
                              {
                                "label": "Gibraltar",
                                "value": "GI"
                              },
                              {
                                "label": "Greece",
                                "value": "GR"
                              },
                              {
                                "label": "Greenland",
                                "value": "GL"
                              },
                              {
                                "label": "Grenada",
                                "value": "GD"
                              },
                              {
                                "label": "Guadeloupe",
                                "value": "GP"
                              },
                              {
                                "label": "Guam",
                                "value": "GU"
                              },
                              {
                                "label": "Guatemala",
                                "value": "GT"
                              },
                              {
                                "label": "Guernsey",
                                "value": "GG"
                              },
                              {
                                "label": "Guinea",
                                "value": "GN"
                              },
                              {
                                "label": "Guinea-Bissau",
                                "value": "GW"
                              },
                              {
                                "label": "Guyana",
                                "value": "GY"
                              },
                              {
                                "label": "Haiti",
                                "value": "HT"
                              },
                              {
                                "label": "Heard Island And McDonald Islands",
                                "value": "HM"
                              },
                              {
                                "label": "Vatican City State",
                                "value": "VA"
                              },
                              {
                                "label": "Honduras",
                                "value": "HN"
                              },
                              {
                                "label": "Hong Kong",
                                "value": "HK"
                              },
                              {
                                "label": "Hungary",
                                "value": "HU"
                              },
                              {
                                "label": "Iceland",
                                "value": "IS"
                              },
                              {
                                "label": "India",
                                "value": "IN"
                              },
                              {
                                "label": "Indonesia",
                                "value": "ID"
                              },
                              {
                                "label": "Iran, Islamic Republic Of",
                                "value": "IR"
                              },
                              {
                                "label": "Iraq",
                                "value": "IQ"
                              },
                              {
                                "label": "Ireland",
                                "value": "IE"
                              },
                              {
                                "label": "Isle Of Man",
                                "value": "IM"
                              },
                              {
                                "label": "Israel",
                                "value": "IL"
                              },
                              {
                                "label": "Italy",
                                "value": "IT"
                              },
                              {
                                "label": "Jamaica",
                                "value": "JM"
                              },
                              {
                                "label": "Japan",
                                "value": "JP"
                              },
                              {
                                "label": "Jersey",
                                "value": "JE"
                              },
                              {
                                "label": "Jordan",
                                "value": "JO"
                              },
                              {
                                "label": "Kazakhstan",
                                "value": "KZ"
                              },
                              {
                                "label": "Kenya",
                                "value": "KE"
                              },
                              {
                                "label": "Kiribati",
                                "value": "KI"
                              },
                              {
                                "label": "Korea, Democratic People''s Republic Of",
                                "value": "KP"
                              },
                              {
                                "label": "Korea, Republic Of",
                                "value": "KR"
                              },
                              {
                                "label": "Kuwait",
                                "value": "KW"
                              },
                              {
                                "label": "Kyrgyzstan",
                                "value": "KG"
                              },
                              {
                                "label": "Lao People''s Democratic Republic",
                                "value": "LA"
                              },
                              {
                                "label": "Latvia",
                                "value": "LV"
                              },
                              {
                                "label": "Lebanon",
                                "value": "LB"
                              },
                              {
                                "label": "Lesotho",
                                "value": "LS"
                              },
                              {
                                "label": "Liberia",
                                "value": "LR"
                              },
                              {
                                "label": "Libyan Arab Jamahiriya",
                                "value": "LY"
                              },
                              {
                                "label": "Liechtenstein",
                                "value": "LI"
                              },
                              {
                                "label": "Lithuania",
                                "value": "LT"
                              },
                              {
                                "label": "Luxembourg",
                                "value": "LU"
                              },
                              {
                                "label": "Macao",
                                "value": "MO"
                              },
                              {
                                "label": "Macedonia, The Former Yugoslav Republic Of",
                                "value": "MK"
                              },
                              {
                                "label": "Madagascar",
                                "value": "MG"
                              },
                              {
                                "label": "Malawi",
                                "value": "MW"
                              },
                              {
                                "label": "Malaysia",
                                "value": "MY"
                              },
                              {
                                "label": "Maldives",
                                "value": "MV"
                              },
                              {
                                "label": "Mali",
                                "value": "ML"
                              },
                              {
                                "label": "Malta",
                                "value": "MT"
                              },
                              {
                                "label": "Marshall Islands",
                                "value": "MH"
                              },
                              {
                                "label": "Martinique",
                                "value": "MQ"
                              },
                              {
                                "label": "Mauritania",
                                "value": "MR"
                              },
                              {
                                "label": "Mauritius",
                                "value": "MU"
                              },
                              {
                                "label": "Mayotte",
                                "value": "YT"
                              },
                              {
                                "label": "Mexico",
                                "value": "MX"
                              },
                              {
                                "label": "Micronesia, Federated States Of",
                                "value": "FM"
                              },
                              {
                                "label": "Moldova, Republic Of",
                                "value": "MD"
                              },
                              {
                                "label": "Monaco",
                                "value": "MC"
                              },
                              {
                                "label": "Mongolia",
                                "value": "MN"
                              },
                              {
                                "label": "Montenegro",
                                "value": "ME"
                              },
                              {
                                "label": "Montserrat",
                                "value": "MS"
                              },
                              {
                                "label": "Morocco",
                                "value": "MA"
                              },
                              {
                                "label": "Mozambique",
                                "value": "MZ"
                              },
                              {
                                "label": "Myanmar",
                                "value": "MM"
                              },
                              {
                                "label": "Namibia",
                                "value": "NA"
                              },
                              {
                                "label": "Nauru",
                                "value": "NR"
                              },
                              {
                                "label": "Nepal",
                                "value": "NP"
                              },
                              {
                                "label": "Netherlands",
                                "value": "NL"
                              },
                              {
                                "label": "Netherlands Antilles",
                                "value": "AN"
                              },
                              {
                                "label": "New Caledonia",
                                "value": "NC"
                              },
                              {
                                "label": "New Zealand",
                                "value": "NZ"
                              },
                              {
                                "label": "Nicaragua",
                                "value": "NI"
                              },
                              {
                                "label": "Niger",
                                "value": "NE"
                              },
                              {
                                "label": "Nigeria",
                                "value": "NG"
                              },
                              {
                                "label": "Niue",
                                "value": "NU"
                              },
                              {
                                "label": "Norfolk Island",
                                "value": "NF"
                              },
                              {
                                "label": "Northern Mariana Islands",
                                "value": "MP"
                              },
                              {
                                "label": "Norway",
                                "value": "NO"
                              },
                              {
                                "label": "Oman",
                                "value": "OM"
                              },
                              {
                                "label": "Pakistan",
                                "value": "PK"
                              },
                              {
                                "label": "Palau",
                                "value": "PW"
                              },
                              {
                                "label": "Palestinian Territory, Occupied",
                                "value": "PS"
                              },
                              {
                                "label": "Panama",
                                "value": "PA"
                              },
                              {
                                "label": "Papua New Guinea",
                                "value": "PG"
                              },
                              {
                                "label": "Paraguay",
                                "value": "PY"
                              },
                              {
                                "label": "Peru",
                                "value": "PE"
                              },
                              {
                                "label": "Philippines",
                                "value": "PH"
                              },
                              {
                                "label": "Pitcairn",
                                "value": "PN"
                              },
                              {
                                "label": "Poland",
                                "value": "PL"
                              },
                              {
                                "label": "Portugal",
                                "value": "PT"
                              },
                              {
                                "label": "Puerto Rico",
                                "value": "PR"
                              },
                              {
                                "label": "Qatar",
                                "value": "QA"
                              },
                              {
                                "label": "Reunion Island",
                                "value": "RE"
                              },
                              {
                                "label": "Romania",
                                "value": "RO"
                              },
                              {
                                "label": "Russian Federation",
                                "value": "RU"
                              },
                              {
                                "label": "Rwanda",
                                "value": "RW"
                              },
                              {
                                "label": "Saint Barthelemy",
                                "value": "BL"
                              },
                              {
                                "label": "Saint Helena, Ascension And Tristan da Cunha",
                                "value": "SH"
                              },
                              {
                                "label": "Saint Kitts And Nevis",
                                "value": "KN"
                              },
                              {
                                "label": "Saint Lucia",
                                "value": "LC"
                              },
                              {
                                "label": "Saint Martin",
                                "value": "MF"
                              },
                              {
                                "label": "Saint Pierre And Miquelon",
                                "value": "PM"
                              },
                              {
                                "label": "Saint Vincent And The Grenadines",
                                "value": "VC"
                              },
                              {
                                "label": "Samoa",
                                "value": "WS"
                              },
                              {
                                "label": "San Marino",
                                "value": "SM"
                              },
                              {
                                "label": "Sao Tome And Principe",
                                "value": "ST"
                              },
                              {
                                "label": "Saudi Arabia",
                                "value": "SA"
                              },
                              {
                                "label": "Senegal",
                                "value": "SN"
                              },
                              {
                                "label": "Serbia",
                                "value": "RS"
                              },
                              {
                                "label": "Seychelles",
                                "value": "SC"
                              },
                              {
                                "label": "Sierra Leone",
                                "value": "SL"
                              },
                              {
                                "label": "Singapore",
                                "value": "SG"
                              },
                              {
                                "label": "Sint Marteen",
                                "value": "SX"
                              },
                              {
                                "label": "Slovakia",
                                "value": "SK"
                              },
                              {
                                "label": "Slovenia",
                                "value": "SI"
                              },
                              {
                                "label": "Solomon Islands",
                                "value": "SB"
                              },
                              {
                                "label": "Somalia",
                                "value": "SO"
                              },
                              {
                                "label": "South Africa",
                                "value": "ZA"
                              },
                              {
                                "label": "South Georgia And The South Sandwich Islands",
                                "value": "GS"
                              },
                              {
                                "label": "South Sudan",
                                "value": "SS"
                              },
                              {
                                "label": "Spain",
                                "value": "ES"
                              },
                              {
                                "label": "Sri Lanka",
                                "value": "LK"
                              },
                              {
                                "label": "Sudan",
                                "value": "SD"
                              },
                              {
                                "label": "Suriname",
                                "value": "SR"
                              },
                              {
                                "label": "Svalbard And Jan Mayen Islands",
                                "value": "SJ"
                              },
                              {
                                "label": "Swaziland",
                                "value": "SZ"
                              },
                              {
                                "label": "Sweden",
                                "value": "SE"
                              },
                              {
                                "label": "Switzerland",
                                "value": "CH"
                              },
                              {
                                "label": "Syrian Arab Republic",
                                "value": "SY"
                              },
                              {
                                "label": "Taiwan, Province Of China",
                                "value": "TW"
                              },
                              {
                                "label": "Tajikistan",
                                "value": "TJ"
                              },
                              {
                                "label": "Tanzania, United Republic Of",
                                "value": "TZ"
                              },
                              {
                                "label": "Thailand",
                                "value": "TH"
                              },
                              {
                                "label": "Timor-Leste",
                                "value": "TL"
                              },
                              {
                                "label": "Togo",
                                "value": "TG"
                              },
                              {
                                "label": "Tokelau",
                                "value": "TK"
                              },
                              {
                                "label": "Tonga",
                                "value": "TO"
                              },
                              {
                                "label": "Trinidad And Tobago",
                                "value": "TT"
                              },
                              {
                                "label": "Tunisia",
                                "value": "TN"
                              },
                              {
                                "label": "Turkey",
                                "value": "TR"
                              },
                              {
                                "label": "Turkmenistan",
                                "value": "TM"
                              },
                              {
                                "label": "Turks And Caicos Islands",
                                "value": "TC"
                              },
                              {
                                "label": "Tuvalu",
                                "value": "TV"
                              },
                              {
                                "label": "Uganda",
                                "value": "UG"
                              },
                              {
                                "label": "Ukraine",
                                "value": "UA"
                              },
                              {
                                "label": "United Arab Emirates",
                                "value": "AE"
                              },
                              {
                                "label": "United Kingdom",
                                "value": "GB"
                              },
                              {
                                "label": "United States",
                                "value": "US"
                              },
                              {
                                "label": "United States Minor Outlying Islands",
                                "value": "UM"
                              },
                              {
                                "label": "Uruguay",
                                "value": "UY"
                              },
                              {
                                "label": "Uzbekistan",
                                "value": "UZ"
                              },
                              {
                                "label": "Vanuatu",
                                "value": "VU"
                              },
                              {
                                "label": "Venezuela, Bolivarian Republic Of",
                                "value": "VE"
                              },
                              {
                                "label": "Viet Nam",
                                "value": "VN"
                              },
                              {
                                "label": "Virgin Islands, British",
                                "value": "VG"
                              },
                              {
                                "label": "Virgin Islands, U.S.",
                                "value": "VI"
                              },
                              {
                                "label": "Wallis And Futuna",
                                "value": "WF"
                              },
                              {
                                "label": "Western Sahara",
                                "value": "EH"
                              },
                              {
                                "label": "Yemen",
                                "value": "YE"
                              },
                              {
                                "label": "Zambia",
                                "value": "ZM"
                              },
                              {
                                "label": "Zimbabwe",
                                "value": "ZW"
                              },
                              {
                                "label": "Not categorised",
                                "value": "XX"
                              },
                              {
                                "label": "Others",
                                "value": "ZZ"
                              }
                            ],
                            "validations": {
                              "required": true
                            }
                          },
                          {
                            "key": "Batch.Report.Account.PersonDetails[].LegalPerson.NatureOfBusiness",
                            "type": "text",
                            "label": "Nature Of Business",
                            "validations": {
                              "required": false,
                              "maxLength": 50
                            }
                          }
                        ],
                        "colClassName": "mt-4",
                        "renderCondition": "values.Batch.Report.Account.PersonDetails[].Choice===\"legalperson\""
                      }
                    },
                    {
                      "section": {
                        "label": "Person Communication Address",
                        "fields": [
                          {
                            "key": "Batch.Report.Account.PersonDetails[].CommunicationAddress.Address",
                            "type": "text",
                            "label": "Address",
                            "validations": {
                              "required": true,
                              "maxLength": 225,
                              "minLength": 8
                            }
                          },
                          {
                            "key": "Batch.Report.Account.PersonDetails[].CommunicationAddress.City",
                            "type": "text",
                            "label": "City",
                            "validations": {
                              "required": false,
                              "maxLength": 50
                            }
                          },
                          {
                            "key": "Batch.Report.Account.PersonDetails[].CommunicationAddress.StateCode",
                            "type": "select",
                            "label": "State Code",
                            "options": [
                              {
                                "label": "Andaman & Nicobar",
                                "value": "AN"
                              },
                              {
                                "label": "Andhra Pradesh",
                                "value": "AP"
                              },
                              {
                                "label": "Arunachal Pradesh",
                                "value": "AR"
                              },
                              {
                                "label": "Assam",
                                "value": "AS"
                              },
                              {
                                "label": "Bihar",
                                "value": "BR"
                              },
                              {
                                "label": "Chandigarh",
                                "value": "CH"
                              },
                              {
                                "label": "Chhattisgarh",
                                "value": "CG"
                              },
                              {
                                "label": "Dadra and Nagar Haveli",
                                "value": "DN"
                              },
                              {
                                "label": "Daman & Diu",
                                "value": "DD"
                              },
                              {
                                "label": "Delhi",
                                "value": "DL"
                              },
                              {
                                "label": "Goa",
                                "value": "GA"
                              },
                              {
                                "label": "Gujarat",
                                "value": "GJ"
                              },
                              {
                                "label": "Haryana",
                                "value": "HR"
                              },
                              {
                                "label": "Himachal Pradesh",
                                "value": "HP"
                              },
                              {
                                "label": "Jammu & Kashmir",
                                "value": "JK"
                              },
                              {
                                "label": "Jharkhand",
                                "value": "JH"
                              },
                              {
                                "label": "Karnataka",
                                "value": "KA"
                              },
                              {
                                "label": "Kerala",
                                "value": "KL"
                              },
                              {
                                "label": "Lakshadweep",
                                "value": "LD"
                              },
                              {
                                "label": "Madhya Pradesh",
                                "value": "MP"
                              },
                              {
                                "label": "Maharashtra",
                                "value": "MH"
                              },
                              {
                                "label": "Manipur",
                                "value": "MN"
                              },
                              {
                                "label": "Meghalaya",
                                "value": "ML"
                              },
                              {
                                "label": "Mizoram",
                                "value": "MZ"
                              },
                              {
                                "label": "Nagaland",
                                "value": "NL"
                              },
                              {
                                "label": "Orissa",
                                "value": "OR"
                              },
                              {
                                "label": "Pondicherry",
                                "value": "PY"
                              },
                              {
                                "label": "Punjab",
                                "value": "PB"
                              },
                              {
                                "label": "Rajasthan",
                                "value": "RJ"
                              },
                              {
                                "label": "Sikkim",
                                "value": "SK"
                              },
                              {
                                "label": "Tamil Nadu",
                                "value": "TN"
                              },
                              {
                                "label": "Tripura",
                                "value": "TR"
                              },
                              {
                                "label": "Uttar Pradesh",
                                "value": "UP"
                              },
                              {
                                "label": "Uttarakhand",
                                "value": "UA"
                              },
                              {
                                "label": "West Bengal",
                                "value": "WB"
                              },
                              {
                                "label": "Others",
                                "value": "ZZ"
                              },
                              {
                                "label": "Not Applicable",
                                "value": "XX"
                              }
                            ],
                            "validations": {
                              "required": true
                            }
                          },
                          {
                            "key": "Batch.Report.Account.PersonDetails[].CommunicationAddress.PinCode",
                            "type": "text",
                            "label": "Pincode",
                            "validations": {
                              "required": false,
                              "maxLength": 10
                            }
                          },
                          {
                            "key": "Batch.Report.Account.PersonDetails[].CommunicationAddress.CountryCode",
                            "type": "select",
                            "label": "Country Code",
                            "options": [
                              {
                                "label": "Afghanistan",
                                "value": "AF"
                              },
                              {
                                "label": "Aland Islands",
                                "value": "AX"
                              },
                              {
                                "label": "Albania",
                                "value": "AL"
                              },
                              {
                                "label": "Algeria",
                                "value": "DZ"
                              },
                              {
                                "label": "American Samoa",
                                "value": "AS"
                              },
                              {
                                "label": "Andorra",
                                "value": "AD"
                              },
                              {
                                "label": "Angola",
                                "value": "AO"
                              },
                              {
                                "label": "Anguilla",
                                "value": "AI"
                              },
                              {
                                "label": "Antarctica",
                                "value": "AQ"
                              },
                              {
                                "label": "Antigua And Barbuda",
                                "value": "AG"
                              },
                              {
                                "label": "Argentina",
                                "value": "AR"
                              },
                              {
                                "label": "Armenia",
                                "value": "AM"
                              },
                              {
                                "label": "Aruba",
                                "value": "AW"
                              },
                              {
                                "label": "Australia",
                                "value": "AU"
                              },
                              {
                                "label": "Austria",
                                "value": "AT"
                              },
                              {
                                "label": "Azerbaijan",
                                "value": "AZ"
                              },
                              {
                                "label": "Bahamas",
                                "value": "BS"
                              },
                              {
                                "label": "Bahrain",
                                "value": "BH"
                              },
                              {
                                "label": "Bangladesh",
                                "value": "BD"
                              },
                              {
                                "label": "Barbados",
                                "value": "BB"
                              },
                              {
                                "label": "Belarus",
                                "value": "BY"
                              },
                              {
                                "label": "Belgium",
                                "value": "BE"
                              },
                              {
                                "label": "Belize",
                                "value": "BZ"
                              },
                              {
                                "label": "Benin",
                                "value": "BJ"
                              },
                              {
                                "label": "Bermuda",
                                "value": "BM"
                              },
                              {
                                "label": "Bhutan",
                                "value": "BT"
                              },
                              {
                                "label": "Bolivia",
                                "value": "BO"
                              },
                              {
                                "label": "Bosnia And Herzegovina",
                                "value": "BA"
                              },
                              {
                                "label": "Bonaire, Sint Eustatius and Saba",
                                "value": "BQ"
                              },
                              {
                                "label": "Botswana",
                                "value": "BW"
                              },
                              {
                                "label": "Bouvet Island",
                                "value": "BV"
                              },
                              {
                                "label": "Brazil",
                                "value": "BR"
                              },
                              {
                                "label": "British Indian Ocean Territory",
                                "value": "IO"
                              },
                              {
                                "label": "Brunei Darussalam",
                                "value": "BN"
                              },
                              {
                                "label": "Bulgaria",
                                "value": "BG"
                              },
                              {
                                "label": "Burkina Faso",
                                "value": "BF"
                              },
                              {
                                "label": "Burundi",
                                "value": "BI"
                              },
                              {
                                "label": "Cambodia",
                                "value": "KH"
                              },
                              {
                                "label": "Cameroon",
                                "value": "CM"
                              },
                              {
                                "label": "Canada",
                                "value": "CA"
                              },
                              {
                                "label": "Cape Verde",
                                "value": "CV"
                              },
                              {
                                "label": "Cayman Islands",
                                "value": "KY"
                              },
                              {
                                "label": "Central African Republic",
                                "value": "CF"
                              },
                              {
                                "label": "Chad",
                                "value": "TD"
                              },
                              {
                                "label": "Chile",
                                "value": "CL"
                              },
                              {
                                "label": "China",
                                "value": "CN"
                              },
                              {
                                "label": "Christmas Island",
                                "value": "CX"
                              },
                              {
                                "label": "Cocos (Keeling) Islands",
                                "value": "CC"
                              },
                              {
                                "label": "Colombia",
                                "value": "CO"
                              },
                              {
                                "label": "Comoros",
                                "value": "KM"
                              },
                              {
                                "label": "Congo",
                                "value": "CG"
                              },
                              {
                                "label": "Congo, The Democratic Republic Of The",
                                "value": "CD"
                              },
                              {
                                "label": "Cook Islands",
                                "value": "CK"
                              },
                              {
                                "label": "Costa Rica",
                                "value": "CR"
                              },
                              {
                                "label": "Côte D''ivoire",
                                "value": "CI"
                              },
                              {
                                "label": "Croatia",
                                "value": "HR"
                              },
                              {
                                "label": "Cuba",
                                "value": "CU"
                              },
                              {
                                "label": "Curacao",
                                "value": "CW"
                              },
                              {
                                "label": "Cyprus",
                                "value": "CY"
                              },
                              {
                                "label": "Czech Republic",
                                "value": "CZ"
                              },
                              {
                                "label": "Denmark",
                                "value": "DK"
                              },
                              {
                                "label": "Djibouti",
                                "value": "DJ"
                              },
                              {
                                "label": "Dominica",
                                "value": "DM"
                              },
                              {
                                "label": "Dominican Republic",
                                "value": "DO"
                              },
                              {
                                "label": "Ecuador",
                                "value": "EC"
                              },
                              {
                                "label": "Egypt",
                                "value": "EG"
                              },
                              {
                                "label": "El Salvador",
                                "value": "SV"
                              },
                              {
                                "label": "Equatorial Guinea",
                                "value": "GQ"
                              },
                              {
                                "label": "Eritrea",
                                "value": "ER"
                              },
                              {
                                "label": "Estonia",
                                "value": "EE"
                              },
                              {
                                "label": "Ethiopia",
                                "value": "ET"
                              },
                              {
                                "label": "Falkland Islands (Malvinas)",
                                "value": "FK"
                              },
                              {
                                "label": "Faroe Islands",
                                "value": "FO"
                              },
                              {
                                "label": "Fiji",
                                "value": "FJ"
                              },
                              {
                                "label": "Finland",
                                "value": "FI"
                              },
                              {
                                "label": "France",
                                "value": "FR"
                              },
                              {
                                "label": "French Guiana",
                                "value": "GF"
                              },
                              {
                                "label": "French Polynesia",
                                "value": "PF"
                              },
                              {
                                "label": "French Southern Territories",
                                "value": "TF"
                              },
                              {
                                "label": "Gabon",
                                "value": "GA"
                              },
                              {
                                "label": "Gambia",
                                "value": "GM"
                              },
                              {
                                "label": "Georgia",
                                "value": "GE"
                              },
                              {
                                "label": "Germany",
                                "value": "DE"
                              },
                              {
                                "label": "Ghana",
                                "value": "GH"
                              },
                              {
                                "label": "Gibraltar",
                                "value": "GI"
                              },
                              {
                                "label": "Greece",
                                "value": "GR"
                              },
                              {
                                "label": "Greenland",
                                "value": "GL"
                              },
                              {
                                "label": "Grenada",
                                "value": "GD"
                              },
                              {
                                "label": "Guadeloupe",
                                "value": "GP"
                              },
                              {
                                "label": "Guam",
                                "value": "GU"
                              },
                              {
                                "label": "Guatemala",
                                "value": "GT"
                              },
                              {
                                "label": "Guernsey",
                                "value": "GG"
                              },
                              {
                                "label": "Guinea",
                                "value": "GN"
                              },
                              {
                                "label": "Guinea-Bissau",
                                "value": "GW"
                              },
                              {
                                "label": "Guyana",
                                "value": "GY"
                              },
                              {
                                "label": "Haiti",
                                "value": "HT"
                              },
                              {
                                "label": "Heard Island And McDonald Islands",
                                "value": "HM"
                              },
                              {
                                "label": "Vatican City State",
                                "value": "VA"
                              },
                              {
                                "label": "Honduras",
                                "value": "HN"
                              },
                              {
                                "label": "Hong Kong",
                                "value": "HK"
                              },
                              {
                                "label": "Hungary",
                                "value": "HU"
                              },
                              {
                                "label": "Iceland",
                                "value": "IS"
                              },
                              {
                                "label": "India",
                                "value": "IN"
                              },
                              {
                                "label": "Indonesia",
                                "value": "ID"
                              },
                              {
                                "label": "Iran, Islamic Republic Of",
                                "value": "IR"
                              },
                              {
                                "label": "Iraq",
                                "value": "IQ"
                              },
                              {
                                "label": "Ireland",
                                "value": "IE"
                              },
                              {
                                "label": "Isle Of Man",
                                "value": "IM"
                              },
                              {
                                "label": "Israel",
                                "value": "IL"
                              },
                              {
                                "label": "Italy",
                                "value": "IT"
                              },
                              {
                                "label": "Jamaica",
                                "value": "JM"
                              },
                              {
                                "label": "Japan",
                                "value": "JP"
                              },
                              {
                                "label": "Jersey",
                                "value": "JE"
                              },
                              {
                                "label": "Jordan",
                                "value": "JO"
                              },
                              {
                                "label": "Kazakhstan",
                                "value": "KZ"
                              },
                              {
                                "label": "Kenya",
                                "value": "KE"
                              },
                              {
                                "label": "Kiribati",
                                "value": "KI"
                              },
                              {
                                "label": "Korea, Democratic People''s Republic Of",
                                "value": "KP"
                              },
                              {
                                "label": "Korea, Republic Of",
                                "value": "KR"
                              },
                              {
                                "label": "Kuwait",
                                "value": "KW"
                              },
                              {
                                "label": "Kyrgyzstan",
                                "value": "KG"
                              },
                              {
                                "label": "Lao People''s Democratic Republic",
                                "value": "LA"
                              },
                              {
                                "label": "Latvia",
                                "value": "LV"
                              },
                              {
                                "label": "Lebanon",
                                "value": "LB"
                              },
                              {
                                "label": "Lesotho",
                                "value": "LS"
                              },
                              {
                                "label": "Liberia",
                                "value": "LR"
                              },
                              {
                                "label": "Libyan Arab Jamahiriya",
                                "value": "LY"
                              },
                              {
                                "label": "Liechtenstein",
                                "value": "LI"
                              },
                              {
                                "label": "Lithuania",
                                "value": "LT"
                              },
                              {
                                "label": "Luxembourg",
                                "value": "LU"
                              },
                              {
                                "label": "Macao",
                                "value": "MO"
                              },
                              {
                                "label": "Macedonia, The Former Yugoslav Republic Of",
                                "value": "MK"
                              },
                              {
                                "label": "Madagascar",
                                "value": "MG"
                              },
                              {
                                "label": "Malawi",
                                "value": "MW"
                              },
                              {
                                "label": "Malaysia",
                                "value": "MY"
                              },
                              {
                                "label": "Maldives",
                                "value": "MV"
                              },
                              {
                                "label": "Mali",
                                "value": "ML"
                              },
                              {
                                "label": "Malta",
                                "value": "MT"
                              },
                              {
                                "label": "Marshall Islands",
                                "value": "MH"
                              },
                              {
                                "label": "Martinique",
                                "value": "MQ"
                              },
                              {
                                "label": "Mauritania",
                                "value": "MR"
                              },
                              {
                                "label": "Mauritius",
                                "value": "MU"
                              },
                              {
                                "label": "Mayotte",
                                "value": "YT"
                              },
                              {
                                "label": "Mexico",
                                "value": "MX"
                              },
                              {
                                "label": "Micronesia, Federated States Of",
                                "value": "FM"
                              },
                              {
                                "label": "Moldova, Republic Of",
                                "value": "MD"
                              },
                              {
                                "label": "Monaco",
                                "value": "MC"
                              },
                              {
                                "label": "Mongolia",
                                "value": "MN"
                              },
                              {
                                "label": "Montenegro",
                                "value": "ME"
                              },
                              {
                                "label": "Montserrat",
                                "value": "MS"
                              },
                              {
                                "label": "Morocco",
                                "value": "MA"
                              },
                              {
                                "label": "Mozambique",
                                "value": "MZ"
                              },
                              {
                                "label": "Myanmar",
                                "value": "MM"
                              },
                              {
                                "label": "Namibia",
                                "value": "NA"
                              },
                              {
                                "label": "Nauru",
                                "value": "NR"
                              },
                              {
                                "label": "Nepal",
                                "value": "NP"
                              },
                              {
                                "label": "Netherlands",
                                "value": "NL"
                              },
                              {
                                "label": "Netherlands Antilles",
                                "value": "AN"
                              },
                              {
                                "label": "New Caledonia",
                                "value": "NC"
                              },
                              {
                                "label": "New Zealand",
                                "value": "NZ"
                              },
                              {
                                "label": "Nicaragua",
                                "value": "NI"
                              },
                              {
                                "label": "Niger",
                                "value": "NE"
                              },
                              {
                                "label": "Nigeria",
                                "value": "NG"
                              },
                              {
                                "label": "Niue",
                                "value": "NU"
                              },
                              {
                                "label": "Norfolk Island",
                                "value": "NF"
                              },
                              {
                                "label": "Northern Mariana Islands",
                                "value": "MP"
                              },
                              {
                                "label": "Norway",
                                "value": "NO"
                              },
                              {
                                "label": "Oman",
                                "value": "OM"
                              },
                              {
                                "label": "Pakistan",
                                "value": "PK"
                              },
                              {
                                "label": "Palau",
                                "value": "PW"
                              },
                              {
                                "label": "Palestinian Territory, Occupied",
                                "value": "PS"
                              },
                              {
                                "label": "Panama",
                                "value": "PA"
                              },
                              {
                                "label": "Papua New Guinea",
                                "value": "PG"
                              },
                              {
                                "label": "Paraguay",
                                "value": "PY"
                              },
                              {
                                "label": "Peru",
                                "value": "PE"
                              },
                              {
                                "label": "Philippines",
                                "value": "PH"
                              },
                              {
                                "label": "Pitcairn",
                                "value": "PN"
                              },
                              {
                                "label": "Poland",
                                "value": "PL"
                              },
                              {
                                "label": "Portugal",
                                "value": "PT"
                              },
                              {
                                "label": "Puerto Rico",
                                "value": "PR"
                              },
                              {
                                "label": "Qatar",
                                "value": "QA"
                              },
                              {
                                "label": "Reunion Island",
                                "value": "RE"
                              },
                              {
                                "label": "Romania",
                                "value": "RO"
                              },
                              {
                                "label": "Russian Federation",
                                "value": "RU"
                              },
                              {
                                "label": "Rwanda",
                                "value": "RW"
                              },
                              {
                                "label": "Saint Barthelemy",
                                "value": "BL"
                              },
                              {
                                "label": "Saint Helena, Ascension And Tristan da Cunha",
                                "value": "SH"
                              },
                              {
                                "label": "Saint Kitts And Nevis",
                                "value": "KN"
                              },
                              {
                                "label": "Saint Lucia",
                                "value": "LC"
                              },
                              {
                                "label": "Saint Martin",
                                "value": "MF"
                              },
                              {
                                "label": "Saint Pierre And Miquelon",
                                "value": "PM"
                              },
                              {
                                "label": "Saint Vincent And The Grenadines",
                                "value": "VC"
                              },
                              {
                                "label": "Samoa",
                                "value": "WS"
                              },
                              {
                                "label": "San Marino",
                                "value": "SM"
                              },
                              {
                                "label": "Sao Tome And Principe",
                                "value": "ST"
                              },
                              {
                                "label": "Saudi Arabia",
                                "value": "SA"
                              },
                              {
                                "label": "Senegal",
                                "value": "SN"
                              },
                              {
                                "label": "Serbia",
                                "value": "RS"
                              },
                              {
                                "label": "Seychelles",
                                "value": "SC"
                              },
                              {
                                "label": "Sierra Leone",
                                "value": "SL"
                              },
                              {
                                "label": "Singapore",
                                "value": "SG"
                              },
                              {
                                "label": "Sint Marteen",
                                "value": "SX"
                              },
                              {
                                "label": "Slovakia",
                                "value": "SK"
                              },
                              {
                                "label": "Slovenia",
                                "value": "SI"
                              },
                              {
                                "label": "Solomon Islands",
                                "value": "SB"
                              },
                              {
                                "label": "Somalia",
                                "value": "SO"
                              },
                              {
                                "label": "South Africa",
                                "value": "ZA"
                              },
                              {
                                "label": "South Georgia And The South Sandwich Islands",
                                "value": "GS"
                              },
                              {
                                "label": "South Sudan",
                                "value": "SS"
                              },
                              {
                                "label": "Spain",
                                "value": "ES"
                              },
                              {
                                "label": "Sri Lanka",
                                "value": "LK"
                              },
                              {
                                "label": "Sudan",
                                "value": "SD"
                              },
                              {
                                "label": "Suriname",
                                "value": "SR"
                              },
                              {
                                "label": "Svalbard And Jan Mayen Islands",
                                "value": "SJ"
                              },
                              {
                                "label": "Swaziland",
                                "value": "SZ"
                              },
                              {
                                "label": "Sweden",
                                "value": "SE"
                              },
                              {
                                "label": "Switzerland",
                                "value": "CH"
                              },
                              {
                                "label": "Syrian Arab Republic",
                                "value": "SY"
                              },
                              {
                                "label": "Taiwan, Province Of China",
                                "value": "TW"
                              },
                              {
                                "label": "Tajikistan",
                                "value": "TJ"
                              },
                              {
                                "label": "Tanzania, United Republic Of",
                                "value": "TZ"
                              },
                              {
                                "label": "Thailand",
                                "value": "TH"
                              },
                              {
                                "label": "Timor-Leste",
                                "value": "TL"
                              },
                              {
                                "label": "Togo",
                                "value": "TG"
                              },
                              {
                                "label": "Tokelau",
                                "value": "TK"
                              },
                              {
                                "label": "Tonga",
                                "value": "TO"
                              },
                              {
                                "label": "Trinidad And Tobago",
                                "value": "TT"
                              },
                              {
                                "label": "Tunisia",
                                "value": "TN"
                              },
                              {
                                "label": "Turkey",
                                "value": "TR"
                              },
                              {
                                "label": "Turkmenistan",
                                "value": "TM"
                              },
                              {
                                "label": "Turks And Caicos Islands",
                                "value": "TC"
                              },
                              {
                                "label": "Tuvalu",
                                "value": "TV"
                              },
                              {
                                "label": "Uganda",
                                "value": "UG"
                              },
                              {
                                "label": "Ukraine",
                                "value": "UA"
                              },
                              {
                                "label": "United Arab Emirates",
                                "value": "AE"
                              },
                              {
                                "label": "United Kingdom",
                                "value": "GB"
                              },
                              {
                                "label": "United States",
                                "value": "US"
                              },
                              {
                                "label": "United States Minor Outlying Islands",
                                "value": "UM"
                              },
                              {
                                "label": "Uruguay",
                                "value": "UY"
                              },
                              {
                                "label": "Uzbekistan",
                                "value": "UZ"
                              },
                              {
                                "label": "Vanuatu",
                                "value": "VU"
                              },
                              {
                                "label": "Venezuela, Bolivarian Republic Of",
                                "value": "VE"
                              },
                              {
                                "label": "Viet Nam",
                                "value": "VN"
                              },
                              {
                                "label": "Virgin Islands, British",
                                "value": "VG"
                              },
                              {
                                "label": "Virgin Islands, U.S.",
                                "value": "VI"
                              },
                              {
                                "label": "Wallis And Futuna",
                                "value": "WF"
                              },
                              {
                                "label": "Western Sahara",
                                "value": "EH"
                              },
                              {
                                "label": "Yemen",
                                "value": "YE"
                              },
                              {
                                "label": "Zambia",
                                "value": "ZM"
                              },
                              {
                                "label": "Zimbabwe",
                                "value": "ZW"
                              },
                              {
                                "label": "Not categorised",
                                "value": "XX"
                              },
                              {
                                "label": "Others",
                                "value": "ZZ"
                              }
                            ],
                            "validations": {
                              "required": true
                            }
                          }
                        ],
                        "colClassName": "mt-4"
                      }
                    },
                    {
                      "section": {
                        "label": "Person Second Address",
                        "fields": [
                          {
                            "key": "Batch.Report.Account.PersonDetails[].SecondAddress.Address",
                            "type": "text",
                            "label": "Address",
                            "validations": {
                              "required": false,
                              "maxLength": 225
                            }
                          },
                          {
                            "key": "Batch.Report.Account.PersonDetails[].SecondAddress.City",
                            "type": "text",
                            "label": "City",
                            "validations": {
                              "required": false,
                              "maxLength": 50
                            }
                          },
                          {
                            "key": "Batch.Report.Account.PersonDetails[].SecondAddress.StateCode",
                            "type": "select",
                            "label": "State Code",
                            "options": [
                              {
                                "label": "Andaman & Nicobar",
                                "value": "AN"
                              },
                              {
                                "label": "Andhra Pradesh",
                                "value": "AP"
                              },
                              {
                                "label": "Arunachal Pradesh",
                                "value": "AR"
                              },
                              {
                                "label": "Assam",
                                "value": "AS"
                              },
                              {
                                "label": "Bihar",
                                "value": "BR"
                              },
                              {
                                "label": "Chandigarh",
                                "value": "CH"
                              },
                              {
                                "label": "Chhattisgarh",
                                "value": "CG"
                              },
                              {
                                "label": "Dadra and Nagar Haveli",
                                "value": "DN"
                              },
                              {
                                "label": "Daman & Diu",
                                "value": "DD"
                              },
                              {
                                "label": "Delhi",
                                "value": "DL"
                              },
                              {
                                "label": "Goa",
                                "value": "GA"
                              },
                              {
                                "label": "Gujarat",
                                "value": "GJ"
                              },
                              {
                                "label": "Haryana",
                                "value": "HR"
                              },
                              {
                                "label": "Himachal Pradesh",
                                "value": "HP"
                              },
                              {
                                "label": "Jammu & Kashmir",
                                "value": "JK"
                              },
                              {
                                "label": "Jharkhand",
                                "value": "JH"
                              },
                              {
                                "label": "Karnataka",
                                "value": "KA"
                              },
                              {
                                "label": "Kerala",
                                "value": "KL"
                              },
                              {
                                "label": "Lakshadweep",
                                "value": "LD"
                              },
                              {
                                "label": "Madhya Pradesh",
                                "value": "MP"
                              },
                              {
                                "label": "Maharashtra",
                                "value": "MH"
                              },
                              {
                                "label": "Manipur",
                                "value": "MN"
                              },
                              {
                                "label": "Meghalaya",
                                "value": "ML"
                              },
                              {
                                "label": "Mizoram",
                                "value": "MZ"
                              },
                              {
                                "label": "Nagaland",
                                "value": "NL"
                              },
                              {
                                "label": "Orissa",
                                "value": "OR"
                              },
                              {
                                "label": "Pondicherry",
                                "value": "PY"
                              },
                              {
                                "label": "Punjab",
                                "value": "PB"
                              },
                              {
                                "label": "Rajasthan",
                                "value": "RJ"
                              },
                              {
                                "label": "Sikkim",
                                "value": "SK"
                              },
                              {
                                "label": "Tamil Nadu",
                                "value": "TN"
                              },
                              {
                                "label": "Tripura",
                                "value": "TR"
                              },
                              {
                                "label": "Uttar Pradesh",
                                "value": "UP"
                              },
                              {
                                "label": "Uttarakhand",
                                "value": "UA"
                              },
                              {
                                "label": "West Bengal",
                                "value": "WB"
                              },
                              {
                                "label": "Others",
                                "value": "ZZ"
                              },
                              {
                                "label": "Not Applicable",
                                "value": "XX"
                              }
                            ],
                            "validations": {
                              "required": false
                            }
                          },
                          {
                            "key": "Batch.Report.Account.PersonDetails[].SecondAddress.PinCode",
                            "type": "text",
                            "label": "Pincode",
                            "validations": {
                              "required": false,
                              "maxLength": 10
                            }
                          },
                          {
                            "key": "Batch.Report.Account.PersonDetails[].SecondAddress.CountryCode",
                            "type": "select",
                            "label": "Country Code",
                            "options": [
                              {
                                "label": "Afghanistan",
                                "value": "AF"
                              },
                              {
                                "label": "Aland Islands",
                                "value": "AX"
                              },
                              {
                                "label": "Albania",
                                "value": "AL"
                              },
                              {
                                "label": "Algeria",
                                "value": "DZ"
                              },
                              {
                                "label": "American Samoa",
                                "value": "AS"
                              },
                              {
                                "label": "Andorra",
                                "value": "AD"
                              },
                              {
                                "label": "Angola",
                                "value": "AO"
                              },
                              {
                                "label": "Anguilla",
                                "value": "AI"
                              },
                              {
                                "label": "Antarctica",
                                "value": "AQ"
                              },
                              {
                                "label": "Antigua And Barbuda",
                                "value": "AG"
                              },
                              {
                                "label": "Argentina",
                                "value": "AR"
                              },
                              {
                                "label": "Armenia",
                                "value": "AM"
                              },
                              {
                                "label": "Aruba",
                                "value": "AW"
                              },
                              {
                                "label": "Australia",
                                "value": "AU"
                              },
                              {
                                "label": "Austria",
                                "value": "AT"
                              },
                              {
                                "label": "Azerbaijan",
                                "value": "AZ"
                              },
                              {
                                "label": "Bahamas",
                                "value": "BS"
                              },
                              {
                                "label": "Bahrain",
                                "value": "BH"
                              },
                              {
                                "label": "Bangladesh",
                                "value": "BD"
                              },
                              {
                                "label": "Barbados",
                                "value": "BB"
                              },
                              {
                                "label": "Belarus",
                                "value": "BY"
                              },
                              {
                                "label": "Belgium",
                                "value": "BE"
                              },
                              {
                                "label": "Belize",
                                "value": "BZ"
                              },
                              {
                                "label": "Benin",
                                "value": "BJ"
                              },
                              {
                                "label": "Bermuda",
                                "value": "BM"
                              },
                              {
                                "label": "Bhutan",
                                "value": "BT"
                              },
                              {
                                "label": "Bolivia",
                                "value": "BO"
                              },
                              {
                                "label": "Bosnia And Herzegovina",
                                "value": "BA"
                              },
                              {
                                "label": "Bonaire, Sint Eustatius and Saba",
                                "value": "BQ"
                              },
                              {
                                "label": "Botswana",
                                "value": "BW"
                              },
                              {
                                "label": "Bouvet Island",
                                "value": "BV"
                              },
                              {
                                "label": "Brazil",
                                "value": "BR"
                              },
                              {
                                "label": "British Indian Ocean Territory",
                                "value": "IO"
                              },
                              {
                                "label": "Brunei Darussalam",
                                "value": "BN"
                              },
                              {
                                "label": "Bulgaria",
                                "value": "BG"
                              },
                              {
                                "label": "Burkina Faso",
                                "value": "BF"
                              },
                              {
                                "label": "Burundi",
                                "value": "BI"
                              },
                              {
                                "label": "Cambodia",
                                "value": "KH"
                              },
                              {
                                "label": "Cameroon",
                                "value": "CM"
                              },
                              {
                                "label": "Canada",
                                "value": "CA"
                              },
                              {
                                "label": "Cape Verde",
                                "value": "CV"
                              },
                              {
                                "label": "Cayman Islands",
                                "value": "KY"
                              },
                              {
                                "label": "Central African Republic",
                                "value": "CF"
                              },
                              {
                                "label": "Chad",
                                "value": "TD"
                              },
                              {
                                "label": "Chile",
                                "value": "CL"
                              },
                              {
                                "label": "China",
                                "value": "CN"
                              },
                              {
                                "label": "Christmas Island",
                                "value": "CX"
                              },
                              {
                                "label": "Cocos (Keeling) Islands",
                                "value": "CC"
                              },
                              {
                                "label": "Colombia",
                                "value": "CO"
                              },
                              {
                                "label": "Comoros",
                                "value": "KM"
                              },
                              {
                                "label": "Congo",
                                "value": "CG"
                              },
                              {
                                "label": "Congo, The Democratic Republic Of The",
                                "value": "CD"
                              },
                              {
                                "label": "Cook Islands",
                                "value": "CK"
                              },
                              {
                                "label": "Costa Rica",
                                "value": "CR"
                              },
                              {
                                "label": "Côte D''ivoire",
                                "value": "CI"
                              },
                              {
                                "label": "Croatia",
                                "value": "HR"
                              },
                              {
                                "label": "Cuba",
                                "value": "CU"
                              },
                              {
                                "label": "Curacao",
                                "value": "CW"
                              },
                              {
                                "label": "Cyprus",
                                "value": "CY"
                              },
                              {
                                "label": "Czech Republic",
                                "value": "CZ"
                              },
                              {
                                "label": "Denmark",
                                "value": "DK"
                              },
                              {
                                "label": "Djibouti",
                                "value": "DJ"
                              },
                              {
                                "label": "Dominica",
                                "value": "DM"
                              },
                              {
                                "label": "Dominican Republic",
                                "value": "DO"
                              },
                              {
                                "label": "Ecuador",
                                "value": "EC"
                              },
                              {
                                "label": "Egypt",
                                "value": "EG"
                              },
                              {
                                "label": "El Salvador",
                                "value": "SV"
                              },
                              {
                                "label": "Equatorial Guinea",
                                "value": "GQ"
                              },
                              {
                                "label": "Eritrea",
                                "value": "ER"
                              },
                              {
                                "label": "Estonia",
                                "value": "EE"
                              },
                              {
                                "label": "Ethiopia",
                                "value": "ET"
                              },
                              {
                                "label": "Falkland Islands (Malvinas)",
                                "value": "FK"
                              },
                              {
                                "label": "Faroe Islands",
                                "value": "FO"
                              },
                              {
                                "label": "Fiji",
                                "value": "FJ"
                              },
                              {
                                "label": "Finland",
                                "value": "FI"
                              },
                              {
                                "label": "France",
                                "value": "FR"
                              },
                              {
                                "label": "French Guiana",
                                "value": "GF"
                              },
                              {
                                "label": "French Polynesia",
                                "value": "PF"
                              },
                              {
                                "label": "French Southern Territories",
                                "value": "TF"
                              },
                              {
                                "label": "Gabon",
                                "value": "GA"
                              },
                              {
                                "label": "Gambia",
                                "value": "GM"
                              },
                              {
                                "label": "Georgia",
                                "value": "GE"
                              },
                              {
                                "label": "Germany",
                                "value": "DE"
                              },
                              {
                                "label": "Ghana",
                                "value": "GH"
                              },
                              {
                                "label": "Gibraltar",
                                "value": "GI"
                              },
                              {
                                "label": "Greece",
                                "value": "GR"
                              },
                              {
                                "label": "Greenland",
                                "value": "GL"
                              },
                              {
                                "label": "Grenada",
                                "value": "GD"
                              },
                              {
                                "label": "Guadeloupe",
                                "value": "GP"
                              },
                              {
                                "label": "Guam",
                                "value": "GU"
                              },
                              {
                                "label": "Guatemala",
                                "value": "GT"
                              },
                              {
                                "label": "Guernsey",
                                "value": "GG"
                              },
                              {
                                "label": "Guinea",
                                "value": "GN"
                              },
                              {
                                "label": "Guinea-Bissau",
                                "value": "GW"
                              },
                              {
                                "label": "Guyana",
                                "value": "GY"
                              },
                              {
                                "label": "Haiti",
                                "value": "HT"
                              },
                              {
                                "label": "Heard Island And McDonald Islands",
                                "value": "HM"
                              },
                              {
                                "label": "Vatican City State",
                                "value": "VA"
                              },
                              {
                                "label": "Honduras",
                                "value": "HN"
                              },
                              {
                                "label": "Hong Kong",
                                "value": "HK"
                              },
                              {
                                "label": "Hungary",
                                "value": "HU"
                              },
                              {
                                "label": "Iceland",
                                "value": "IS"
                              },
                              {
                                "label": "India",
                                "value": "IN"
                              },
                              {
                                "label": "Indonesia",
                                "value": "ID"
                              },
                              {
                                "label": "Iran, Islamic Republic Of",
                                "value": "IR"
                              },
                              {
                                "label": "Iraq",
                                "value": "IQ"
                              },
                              {
                                "label": "Ireland",
                                "value": "IE"
                              },
                              {
                                "label": "Isle Of Man",
                                "value": "IM"
                              },
                              {
                                "label": "Israel",
                                "value": "IL"
                              },
                              {
                                "label": "Italy",
                                "value": "IT"
                              },
                              {
                                "label": "Jamaica",
                                "value": "JM"
                              },
                              {
                                "label": "Japan",
                                "value": "JP"
                              },
                              {
                                "label": "Jersey",
                                "value": "JE"
                              },
                              {
                                "label": "Jordan",
                                "value": "JO"
                              },
                              {
                                "label": "Kazakhstan",
                                "value": "KZ"
                              },
                              {
                                "label": "Kenya",
                                "value": "KE"
                              },
                              {
                                "label": "Kiribati",
                                "value": "KI"
                              },
                              {
                                "label": "Korea, Democratic People''s Republic Of",
                                "value": "KP"
                              },
                              {
                                "label": "Korea, Republic Of",
                                "value": "KR"
                              },
                              {
                                "label": "Kuwait",
                                "value": "KW"
                              },
                              {
                                "label": "Kyrgyzstan",
                                "value": "KG"
                              },
                              {
                                "label": "Lao People''s Democratic Republic",
                                "value": "LA"
                              },
                              {
                                "label": "Latvia",
                                "value": "LV"
                              },
                              {
                                "label": "Lebanon",
                                "value": "LB"
                              },
                              {
                                "label": "Lesotho",
                                "value": "LS"
                              },
                              {
                                "label": "Liberia",
                                "value": "LR"
                              },
                              {
                                "label": "Libyan Arab Jamahiriya",
                                "value": "LY"
                              },
                              {
                                "label": "Liechtenstein",
                                "value": "LI"
                              },
                              {
                                "label": "Lithuania",
                                "value": "LT"
                              },
                              {
                                "label": "Luxembourg",
                                "value": "LU"
                              },
                              {
                                "label": "Macao",
                                "value": "MO"
                              },
                              {
                                "label": "Macedonia, The Former Yugoslav Republic Of",
                                "value": "MK"
                              },
                              {
                                "label": "Madagascar",
                                "value": "MG"
                              },
                              {
                                "label": "Malawi",
                                "value": "MW"
                              },
                              {
                                "label": "Malaysia",
                                "value": "MY"
                              },
                              {
                                "label": "Maldives",
                                "value": "MV"
                              },
                              {
                                "label": "Mali",
                                "value": "ML"
                              },
                              {
                                "label": "Malta",
                                "value": "MT"
                              },
                              {
                                "label": "Marshall Islands",
                                "value": "MH"
                              },
                              {
                                "label": "Martinique",
                                "value": "MQ"
                              },
                              {
                                "label": "Mauritania",
                                "value": "MR"
                              },
                              {
                                "label": "Mauritius",
                                "value": "MU"
                              },
                              {
                                "label": "Mayotte",
                                "value": "YT"
                              },
                              {
                                "label": "Mexico",
                                "value": "MX"
                              },
                              {
                                "label": "Micronesia, Federated States Of",
                                "value": "FM"
                              },
                              {
                                "label": "Moldova, Republic Of",
                                "value": "MD"
                              },
                              {
                                "label": "Monaco",
                                "value": "MC"
                              },
                              {
                                "label": "Mongolia",
                                "value": "MN"
                              },
                              {
                                "label": "Montenegro",
                                "value": "ME"
                              },
                              {
                                "label": "Montserrat",
                                "value": "MS"
                              },
                              {
                                "label": "Morocco",
                                "value": "MA"
                              },
                              {
                                "label": "Mozambique",
                                "value": "MZ"
                              },
                              {
                                "label": "Myanmar",
                                "value": "MM"
                              },
                              {
                                "label": "Namibia",
                                "value": "NA"
                              },
                              {
                                "label": "Nauru",
                                "value": "NR"
                              },
                              {
                                "label": "Nepal",
                                "value": "NP"
                              },
                              {
                                "label": "Netherlands",
                                "value": "NL"
                              },
                              {
                                "label": "Netherlands Antilles",
                                "value": "AN"
                              },
                              {
                                "label": "New Caledonia",
                                "value": "NC"
                              },
                              {
                                "label": "New Zealand",
                                "value": "NZ"
                              },
                              {
                                "label": "Nicaragua",
                                "value": "NI"
                              },
                              {
                                "label": "Niger",
                                "value": "NE"
                              },
                              {
                                "label": "Nigeria",
                                "value": "NG"
                              },
                              {
                                "label": "Niue",
                                "value": "NU"
                              },
                              {
                                "label": "Norfolk Island",
                                "value": "NF"
                              },
                              {
                                "label": "Northern Mariana Islands",
                                "value": "MP"
                              },
                              {
                                "label": "Norway",
                                "value": "NO"
                              },
                              {
                                "label": "Oman",
                                "value": "OM"
                              },
                              {
                                "label": "Pakistan",
                                "value": "PK"
                              },
                              {
                                "label": "Palau",
                                "value": "PW"
                              },
                              {
                                "label": "Palestinian Territory, Occupied",
                                "value": "PS"
                              },
                              {
                                "label": "Panama",
                                "value": "PA"
                              },
                              {
                                "label": "Papua New Guinea",
                                "value": "PG"
                              },
                              {
                                "label": "Paraguay",
                                "value": "PY"
                              },
                              {
                                "label": "Peru",
                                "value": "PE"
                              },
                              {
                                "label": "Philippines",
                                "value": "PH"
                              },
                              {
                                "label": "Pitcairn",
                                "value": "PN"
                              },
                              {
                                "label": "Poland",
                                "value": "PL"
                              },
                              {
                                "label": "Portugal",
                                "value": "PT"
                              },
                              {
                                "label": "Puerto Rico",
                                "value": "PR"
                              },
                              {
                                "label": "Qatar",
                                "value": "QA"
                              },
                              {
                                "label": "Reunion Island",
                                "value": "RE"
                              },
                              {
                                "label": "Romania",
                                "value": "RO"
                              },
                              {
                                "label": "Russian Federation",
                                "value": "RU"
                              },
                              {
                                "label": "Rwanda",
                                "value": "RW"
                              },
                              {
                                "label": "Saint Barthelemy",
                                "value": "BL"
                              },
                              {
                                "label": "Saint Helena, Ascension And Tristan da Cunha",
                                "value": "SH"
                              },
                              {
                                "label": "Saint Kitts And Nevis",
                                "value": "KN"
                              },
                              {
                                "label": "Saint Lucia",
                                "value": "LC"
                              },
                              {
                                "label": "Saint Martin",
                                "value": "MF"
                              },
                              {
                                "label": "Saint Pierre And Miquelon",
                                "value": "PM"
                              },
                              {
                                "label": "Saint Vincent And The Grenadines",
                                "value": "VC"
                              },
                              {
                                "label": "Samoa",
                                "value": "WS"
                              },
                              {
                                "label": "San Marino",
                                "value": "SM"
                              },
                              {
                                "label": "Sao Tome And Principe",
                                "value": "ST"
                              },
                              {
                                "label": "Saudi Arabia",
                                "value": "SA"
                              },
                              {
                                "label": "Senegal",
                                "value": "SN"
                              },
                              {
                                "label": "Serbia",
                                "value": "RS"
                              },
                              {
                                "label": "Seychelles",
                                "value": "SC"
                              },
                              {
                                "label": "Sierra Leone",
                                "value": "SL"
                              },
                              {
                                "label": "Singapore",
                                "value": "SG"
                              },
                              {
                                "label": "Sint Marteen",
                                "value": "SX"
                              },
                              {
                                "label": "Slovakia",
                                "value": "SK"
                              },
                              {
                                "label": "Slovenia",
                                "value": "SI"
                              },
                              {
                                "label": "Solomon Islands",
                                "value": "SB"
                              },
                              {
                                "label": "Somalia",
                                "value": "SO"
                              },
                              {
                                "label": "South Africa",
                                "value": "ZA"
                              },
                              {
                                "label": "South Georgia And The South Sandwich Islands",
                                "value": "GS"
                              },
                              {
                                "label": "South Sudan",
                                "value": "SS"
                              },
                              {
                                "label": "Spain",
                                "value": "ES"
                              },
                              {
                                "label": "Sri Lanka",
                                "value": "LK"
                              },
                              {
                                "label": "Sudan",
                                "value": "SD"
                              },
                              {
                                "label": "Suriname",
                                "value": "SR"
                              },
                              {
                                "label": "Svalbard And Jan Mayen Islands",
                                "value": "SJ"
                              },
                              {
                                "label": "Swaziland",
                                "value": "SZ"
                              },
                              {
                                "label": "Sweden",
                                "value": "SE"
                              },
                              {
                                "label": "Switzerland",
                                "value": "CH"
                              },
                              {
                                "label": "Syrian Arab Republic",
                                "value": "SY"
                              },
                              {
                                "label": "Taiwan, Province Of China",
                                "value": "TW"
                              },
                              {
                                "label": "Tajikistan",
                                "value": "TJ"
                              },
                              {
                                "label": "Tanzania, United Republic Of",
                                "value": "TZ"
                              },
                              {
                                "label": "Thailand",
                                "value": "TH"
                              },
                              {
                                "label": "Timor-Leste",
                                "value": "TL"
                              },
                              {
                                "label": "Togo",
                                "value": "TG"
                              },
                              {
                                "label": "Tokelau",
                                "value": "TK"
                              },
                              {
                                "label": "Tonga",
                                "value": "TO"
                              },
                              {
                                "label": "Trinidad And Tobago",
                                "value": "TT"
                              },
                              {
                                "label": "Tunisia",
                                "value": "TN"
                              },
                              {
                                "label": "Turkey",
                                "value": "TR"
                              },
                              {
                                "label": "Turkmenistan",
                                "value": "TM"
                              },
                              {
                                "label": "Turks And Caicos Islands",
                                "value": "TC"
                              },
                              {
                                "label": "Tuvalu",
                                "value": "TV"
                              },
                              {
                                "label": "Uganda",
                                "value": "UG"
                              },
                              {
                                "label": "Ukraine",
                                "value": "UA"
                              },
                              {
                                "label": "United Arab Emirates",
                                "value": "AE"
                              },
                              {
                                "label": "United Kingdom",
                                "value": "GB"
                              },
                              {
                                "label": "United States",
                                "value": "US"
                              },
                              {
                                "label": "United States Minor Outlying Islands",
                                "value": "UM"
                              },
                              {
                                "label": "Uruguay",
                                "value": "UY"
                              },
                              {
                                "label": "Uzbekistan",
                                "value": "UZ"
                              },
                              {
                                "label": "Vanuatu",
                                "value": "VU"
                              },
                              {
                                "label": "Venezuela, Bolivarian Republic Of",
                                "value": "VE"
                              },
                              {
                                "label": "Viet Nam",
                                "value": "VN"
                              },
                              {
                                "label": "Virgin Islands, British",
                                "value": "VG"
                              },
                              {
                                "label": "Virgin Islands, U.S.",
                                "value": "VI"
                              },
                              {
                                "label": "Wallis And Futuna",
                                "value": "WF"
                              },
                              {
                                "label": "Western Sahara",
                                "value": "EH"
                              },
                              {
                                "label": "Yemen",
                                "value": "YE"
                              },
                              {
                                "label": "Zambia",
                                "value": "ZM"
                              },
                              {
                                "label": "Zimbabwe",
                                "value": "ZW"
                              },
                              {
                                "label": "Not categorised",
                                "value": "XX"
                              },
                              {
                                "label": "Others",
                                "value": "ZZ"
                              }
                            ],
                            "validations": {
                              "required": false
                            }
                          }
                        ],
                        "colClassName": "mt-4"
                      }
                    },
                    {
                      "section": {
                        "label": "Person Phone",
                        "fields": [
                          {
                            "key": "Batch.Report.Account.PersonDetails[].SecondAddress.Telephone",
                            "type": "text",
                            "label": "Telephone",
                            "validations": {
                              "required": false,
                              "maxLength": 30
                            }
                          },
                          {
                            "key": "Batch.Report.Account.PersonDetails[].SecondAddress.Mobile",
                            "type": "text",
                            "label": "Mobile",
                            "validations": {
                              "required": false,
                              "maxLength": 30
                            }
                          },
                          {
                            "key": "Batch.Report.Account.PersonDetails[].SecondAddress.Fax",
                            "type": "text",
                            "label": "Fax",
                            "validations": {
                              "required": false,
                              "maxLength": 30
                            }
                          }
                        ],
                        "colClassName": "mt-4"
                      }
                    }
                  ],
                  "isArray": true,
                  "arrayKey": "Batch.Report.Account.PersonDetails",
                  "required": true,
                  "colClassName": "mt-4"
                }
              },
              {
                "section": {
                  "label": "Details Of Transaction",
                  "fields": [
                    {
                      "key": "Batch.Report.Account.Transaction[].DateOfTransaction",
                      "type": "date",
                      "label": "Date Of Transaction",
                      "format": "YYYY-MM-DD",
                      "maxDate": "new Date()",
                      "minDate": "`new Date().setFullYear(new Date().getFullYear() - 1)`",
                      "validations": {
                        "required": true
                      }
                    },
                    {
                      "key": "Batch.Report.Account.Transaction[].TransactionID",
                      "type": "text",
                      "label": "Transaction ID",
                      "validations": {
                        "required": false,
                        "maxLength": 20
                      }
                    },
                    {
                      "key": "Batch.Report.Account.Transaction[].TransactionMode",
                      "type": "select",
                      "label": "Transaction Mode",
                      "options": [
                        {
                          "label": "Cheque",
                          "value": "A"
                        },
                        {
                          "label": "Internal Transfer",
                          "value": "B"
                        },
                        {
                          "label": "Cash",
                          "value": "C"
                        },
                        {
                          "label": "Demand Draft/Pay Order",
                          "value": "D"
                        },
                        {
                          "label": "Electronic Fund Transfer",
                          "value": "E"
                        },
                        {
                          "label": "Exchange Based Transaction",
                          "value": "F"
                        },
                        {
                          "label": "Securities Transaction",
                          "value": "G"
                        },
                        {
                          "label": "Switching Transaction",
                          "value": "S"
                        },
                        {
                          "label": "Others",
                          "value": "Z"
                        },
                        {
                          "label": "Not Categorised",
                          "value": "X"
                        }
                      ],
                      "validations": {
                        "required": true
                      }
                    },
                    {
                      "key": "Batch.Report.Account.Transaction[].DebitCredit",
                      "type": "select",
                      "label": "Debit Credit",
                      "options": [
                        {
                          "label": "Debit",
                          "value": "D"
                        },
                        {
                          "label": "Credit",
                          "value": "C"
                        },
                        {
                          "label": "Not Categorised",
                          "value": "X"
                        }
                      ],
                      "validations": {
                        "required": true
                      }
                    },
                    {
                      "key": "Batch.Report.Account.Transaction[].Amount",
                      "type": "text",
                      "label": "Amount",
                      "validations": {
                        "required": true,
                        "maxLength": 20
                      }
                    },
                    {
                      "key": "Batch.Report.Account.Transaction[].Currency",
                      "type": "select",
                      "label": "Currency",
                      "value": "INR",
                      "options": [
                        {
                          "label": "AFA",
                          "value": "AFA"
                        },
                        {
                          "label": "ALL",
                          "value": "ALL"
                        },
                        {
                          "label": "DZD",
                          "value": "DZD"
                        },
                        {
                          "label": "AOR",
                          "value": "AOR"
                        },
                        {
                          "label": "ARS",
                          "value": "ARS"
                        },
                        {
                          "label": "AMD",
                          "value": "AMD"
                        },
                        {
                          "label": "AWG",
                          "value": "AWG"
                        },
                        {
                          "label": "AUD",
                          "value": "AUD"
                        },
                        {
                          "label": "AZN",
                          "value": "AZN"
                        },
                        {
                          "label": "BSD",
                          "value": "BSD"
                        },
                        {
                          "label": "BHD",
                          "value": "BHD"
                        },
                        {
                          "label": "BDT",
                          "value": "BDT"
                        },
                        {
                          "label": "BBD",
                          "value": "BBD"
                        },
                        {
                          "label": "BYR",
                          "value": "BYR"
                        },
                        {
                          "label": "BZD",
                          "value": "BZD"
                        },
                        {
                          "label": "BMD",
                          "value": "BMD"
                        },
                        {
                          "label": "BTN",
                          "value": "BTN"
                        },
                        {
                          "label": "BOB",
                          "value": "BOB"
                        },
                        {
                          "label": "BWP",
                          "value": "BWP"
                        },
                        {
                          "label": "BRL",
                          "value": "BRL"
                        },
                        {
                          "label": "GBP",
                          "value": "GBP"
                        },
                        {
                          "label": "BND",
                          "value": "BND"
                        },
                        {
                          "label": "BGN",
                          "value": "BGN"
                        },
                        {
                          "label": "BIF",
                          "value": "BIF"
                        },
                        {
                          "label": "KHR",
                          "value": "KHR"
                        },
                        {
                          "label": "CAD",
                          "value": "CAD"
                        },
                        {
                          "label": "CVE",
                          "value": "CVE"
                        },
                        {
                          "label": "KYD",
                          "value": "KYD"
                        },
                        {
                          "label": "XOF",
                          "value": "XOF"
                        },
                        {
                          "label": "XAF",
                          "value": "XAF"
                        },
                        {
                          "label": "XPF",
                          "value": "XPF"
                        },
                        {
                          "label": "CLP",
                          "value": "CLP"
                        },
                        {
                          "label": "CNY",
                          "value": "CNY"
                        },
                        {
                          "label": "COP",
                          "value": "COP"
                        },
                        {
                          "label": "KMF",
                          "value": "KMF"
                        },
                        {
                          "label": "CDF",
                          "value": "CDF"
                        },
                        {
                          "label": "CRC",
                          "value": "CRC"
                        },
                        {
                          "label": "HRK",
                          "value": "HRK"
                        },
                        {
                          "label": "CUP",
                          "value": "CUP"
                        },
                        {
                          "label": "CZK",
                          "value": "CZK"
                        },
                        {
                          "label": "DKK",
                          "value": "DKK"
                        },
                        {
                          "label": "DJF",
                          "value": "DJF"
                        },
                        {
                          "label": "DOP",
                          "value": "DOP"
                        },
                        {
                          "label": "XCD",
                          "value": "XCD"
                        },
                        {
                          "label": "EGP",
                          "value": "EGP"
                        },
                        {
                          "label": "SVC",
                          "value": "SVC"
                        },
                        {
                          "label": "ERN",
                          "value": "ERN"
                        },
                        {
                          "label": "EEK",
                          "value": "EEK"
                        },
                        {
                          "label": "ETB",
                          "value": "ETB"
                        },
                        {
                          "label": "EUR",
                          "value": "EUR"
                        },
                        {
                          "label": "FKP",
                          "value": "FKP"
                        },
                        {
                          "label": "FJD",
                          "value": "FJD"
                        },
                        {
                          "label": "GMD",
                          "value": "GMD"
                        },
                        {
                          "label": "GEL",
                          "value": "GEL"
                        },
                        {
                          "label": "GHS",
                          "value": "GHS"
                        },
                        {
                          "label": "GIP",
                          "value": "GIP"
                        },
                        {
                          "label": "XAU",
                          "value": "XAU"
                        },
                        {
                          "label": "XFO",
                          "value": "XFO"
                        },
                        {
                          "label": "GTQ",
                          "value": "GTQ"
                        },
                        {
                          "label": "GNF",
                          "value": "GNF"
                        },
                        {
                          "label": "GYD",
                          "value": "GYD"
                        },
                        {
                          "label": "HTG",
                          "value": "HTG"
                        },
                        {
                          "label": "HNL",
                          "value": "HNL"
                        },
                        {
                          "label": "HKD",
                          "value": "HKD"
                        },
                        {
                          "label": "HUF",
                          "value": "HUF"
                        },
                        {
                          "label": "ISK",
                          "value": "ISK"
                        },
                        {
                          "label": "XDR",
                          "value": "XDR"
                        },
                        {
                          "label": "INR",
                          "value": "INR"
                        },
                        {
                          "label": "IDR",
                          "value": "IDR"
                        },
                        {
                          "label": "IRR",
                          "value": "IRR"
                        },
                        {
                          "label": "IQD",
                          "value": "IQD"
                        },
                        {
                          "label": "ILS",
                          "value": "ILS"
                        },
                        {
                          "label": "JMD",
                          "value": "JMD"
                        },
                        {
                          "label": "JPY",
                          "value": "JPY"
                        },
                        {
                          "label": "JOD",
                          "value": "JOD"
                        },
                        {
                          "label": "KZT",
                          "value": "KZT"
                        },
                        {
                          "label": "KES",
                          "value": "KES"
                        },
                        {
                          "label": "KWD",
                          "value": "KWD"
                        },
                        {
                          "label": "KGS",
                          "value": "KGS"
                        },
                        {
                          "label": "LAK",
                          "value": "LAK"
                        },
                        {
                          "label": "LVL",
                          "value": "LVL"
                        },
                        {
                          "label": "LBP",
                          "value": "LBP"
                        },
                        {
                          "label": "LSL",
                          "value": "LSL"
                        },
                        {
                          "label": "LRD",
                          "value": "LRD"
                        },
                        {
                          "label": "LYD",
                          "value": "LYD"
                        },
                        {
                          "label": "LTL",
                          "value": "LTL"
                        },
                        {
                          "label": "MOP",
                          "value": "MOP"
                        },
                        {
                          "label": "MKD",
                          "value": "MKD"
                        },
                        {
                          "label": "MGA",
                          "value": "MGA"
                        },
                        {
                          "label": "MWK",
                          "value": "MWK"
                        },
                        {
                          "label": "MYR",
                          "value": "MYR"
                        },
                        {
                          "label": "MVR",
                          "value": "MVR"
                        },
                        {
                          "label": "MRO",
                          "value": "MRO"
                        },
                        {
                          "label": "MUR",
                          "value": "MUR"
                        },
                        {
                          "label": "MXN",
                          "value": "MXN"
                        },
                        {
                          "label": "MDL",
                          "value": "MDL"
                        },
                        {
                          "label": "MNT",
                          "value": "MNT"
                        },
                        {
                          "label": "MAD",
                          "value": "MAD"
                        },
                        {
                          "label": "MZN",
                          "value": "MZN"
                        },
                        {
                          "label": "MMK",
                          "value": "MMK"
                        },
                        {
                          "label": "NAD",
                          "value": "NAD"
                        },
                        {
                          "label": "NPR",
                          "value": "NPR"
                        },
                        {
                          "label": "ANG",
                          "value": "ANG"
                        },
                        {
                          "label": "NAF",
                          "value": "NAF"
                        },
                        {
                          "label": "NZD",
                          "value": "NZD"
                        },
                        {
                          "label": "NIO",
                          "value": "NIO"
                        },
                        {
                          "label": "NGN",
                          "value": "NGN"
                        },
                        {
                          "label": "KPW",
                          "value": "KPW"
                        },
                        {
                          "label": "NOK",
                          "value": "NOK"
                        },
                        {
                          "label": "OMR",
                          "value": "OMR"
                        },
                        {
                          "label": "PKR",
                          "value": "PKR"
                        },
                        {
                          "label": "XPD",
                          "value": "XPD"
                        },
                        {
                          "label": "PAB",
                          "value": "PAB"
                        },
                        {
                          "label": "PGK",
                          "value": "PGK"
                        },
                        {
                          "label": "PYG",
                          "value": "PYG"
                        },
                        {
                          "label": "PEN",
                          "value": "PEN"
                        },
                        {
                          "label": "PHP",
                          "value": "PHP"
                        },
                        {
                          "label": "XPT",
                          "value": "XPT"
                        },
                        {
                          "label": "PLN",
                          "value": "PLN"
                        },
                        {
                          "label": "QAR",
                          "value": "QAR"
                        },
                        {
                          "label": "RON",
                          "value": "RON"
                        },
                        {
                          "label": "RUB",
                          "value": "RUB"
                        },
                        {
                          "label": "RWF",
                          "value": "RWF"
                        },
                        {
                          "label": "SHP",
                          "value": "SHP"
                        },
                        {
                          "label": "WST",
                          "value": "WST"
                        },
                        {
                          "label": "STD",
                          "value": "STD"
                        },
                        {
                          "label": "SAR",
                          "value": "SAR"
                        },
                        {
                          "label": "RSD",
                          "value": "RSD"
                        },
                        {
                          "label": "SCR",
                          "value": "SCR"
                        },
                        {
                          "label": "SLL",
                          "value": "SLL"
                        },
                        {
                          "label": "XAG",
                          "value": "XAG"
                        },
                        {
                          "label": "SGD",
                          "value": "SGD"
                        },
                        {
                          "label": "SBD",
                          "value": "SBD"
                        },
                        {
                          "label": "SOS",
                          "value": "SOS"
                        },
                        {
                          "label": "ZAR",
                          "value": "ZAR"
                        },
                        {
                          "label": "KRW",
                          "value": "KRW"
                        },
                        {
                          "label": "SSP",
                          "value": "SSP"
                        },
                        {
                          "label": "LKR",
                          "value": "LKR"
                        },
                        {
                          "label": "SDG",
                          "value": "SDG"
                        },
                        {
                          "label": "SRD",
                          "value": "SRD"
                        },
                        {
                          "label": "SZL",
                          "value": "SZL"
                        },
                        {
                          "label": "SEK",
                          "value": "SEK"
                        },
                        {
                          "label": "CHF",
                          "value": "CHF"
                        },
                        {
                          "label": "SYP",
                          "value": "SYP"
                        },
                        {
                          "label": "TWD",
                          "value": "TWD"
                        },
                        {
                          "label": "TJS",
                          "value": "TJS"
                        },
                        {
                          "label": "TZS",
                          "value": "TZS"
                        },
                        {
                          "label": "THB",
                          "value": "THB"
                        },
                        {
                          "label": "TOP",
                          "value": "TOP"
                        },
                        {
                          "label": "TTD",
                          "value": "TTD"
                        },
                        {
                          "label": "TND",
                          "value": "TND"
                        },
                        {
                          "label": "TRY",
                          "value": "TRY"
                        },
                        {
                          "label": "TMT",
                          "value": "TMT"
                        },
                        {
                          "label": "AED",
                          "value": "AED"
                        },
                        {
                          "label": "UGX",
                          "value": "UGX"
                        },
                        {
                          "label": "XFU",
                          "value": "XFU"
                        },
                        {
                          "label": "UAH",
                          "value": "UAH"
                        },
                        {
                          "label": "UYU",
                          "value": "UYU"
                        },
                        {
                          "label": "USD",
                          "value": "USD"
                        },
                        {
                          "label": "UZS",
                          "value": "UZS"
                        },
                        {
                          "label": "VUV",
                          "value": "VUV"
                        },
                        {
                          "label": "VEF",
                          "value": "VEF"
                        },
                        {
                          "label": "VND",
                          "value": "VND"
                        },
                        {
                          "label": "YER",
                          "value": "YER"
                        },
                        {
                          "label": "ZMK",
                          "value": "ZMK"
                        },
                        {
                          "label": "ZWL",
                          "value": "ZWL"
                        },
                        {
                          "label": "Not Categorised",
                          "value": "XXX"
                        },
                        {
                          "label": "Others",
                          "value": "ZZZ"
                        }
                      ],
                      "validations": {
                        "required": true
                      }
                    },
                    {
                      "key": "Batch.Report.Account.Transaction[].DispositionOfFunds",
                      "type": "select",
                      "label": "Disposition Of Funds",
                      "value": "X",
                      "options": [
                        {
                          "label": "X",
                          "value": "X"
                        }
                      ],
                      "validations": {
                        "required": false
                      }
                    },
                    {
                      "key": "Batch.Report.Account.Transaction[].RelatedAccountNum",
                      "type": "text",
                      "label": "Related Account Number",
                      "validations": {
                        "required": false,
                        "maxLength": 20
                      }
                    },
                    {
                      "key": "Batch.Report.Account.Transaction[].RelatedInstitutionName",
                      "type": "text",
                      "label": "Related Institution Name",
                      "validations": {
                        "required": false,
                        "maxLength": 20
                      }
                    },
                    {
                      "key": "Batch.Report.Account.Transaction[].RelatedInstitutionRefNum",
                      "type": "text",
                      "label": "Related Institution Ref Number",
                      "validations": {
                        "required": false,
                        "maxLength": 20
                      }
                    },
                    {
                      "key": "Batch.Report.Account.Transaction[].Remarks",
                      "type": "textarea",
                      "label": "Remarks",
                      "validations": {
                        "required": false,
                        "maxLength": 50
                      }
                    }
                  ],
                  "isArray": true,
                  "arrayKey": "Batch.Report.Account.Transaction",
                  "required": true,
                  "colClassName": "mt-4"
                }
              },
              {
                "section": {
                  "label": "Product Transaction",
                  "fields": [
                    {
                      "key": "Batch.Report.Account.Transaction[].ProductTransaction.ProductType",
                      "type": "select",
                      "label": "Product Type",
                      "options": [
                        {
                          "label": "Bonds",
                          "value": "BD"
                        },
                        {
                          "label": "Securities",
                          "value": "ST"
                        },
                        {
                          "label": "Certificate of Deposit",
                          "value": "CD"
                        },
                        {
                          "label": "Commercial Paper",
                          "value": "CP"
                        },
                        {
                          "label": "Equity Shares",
                          "value": "EQ"
                        },
                        {
                          "label": "Futures",
                          "value": "FU"
                        },
                        {
                          "label": "Options",
                          "value": "OP"
                        },
                        {
                          "label": "Debt Funds",
                          "value": "DF"
                        },
                        {
                          "label": "Equity Fund",
                          "value": "EF"
                        },
                        {
                          "label": "Hybrid Funds",
                          "value": "HF"
                        },
                        {
                          "label": "Liquid Funds",
                          "value": "LF"
                        },
                        {
                          "label": "MIP Funds",
                          "value": "MF"
                        },
                        {
                          "label": "Exchange Traded Funds",
                          "value": "XF"
                        },
                        {
                          "label": "Commodities",
                          "value": "CO"
                        },
                        {
                          "label": "Insurance Products",
                          "value": "IP"
                        },
                        {
                          "label": "Others",
                          "value": "ZZ"
                        },
                        {
                          "label": "Not Categorised",
                          "value": "XX"
                        }
                      ],
                      "validations": {
                        "required": true
                      }
                    },
                    {
                      "key": "Batch.Report.Account.Transaction[].ProductTransaction.Identifier",
                      "type": "text",
                      "label": "Identifier",
                      "validations": {
                        "required": false,
                        "maxLength": 30
                      }
                    },
                    {
                      "key": "Batch.Report.Account.Transaction[].ProductTransaction.TransactionType",
                      "type": "select",
                      "label": "Transaction Type",
                      "options": [
                        {
                          "label": "Buy/Purchase",
                          "value": "BP"
                        },
                        {
                          "label": "Sale/Redemption",
                          "value": "SR"
                        },
                        {
                          "label": "Annuity payment",
                          "value": "IA"
                        },
                        {
                          "label": "Pension",
                          "value": "IP"
                        },
                        {
                          "label": "Commutation",
                          "value": "IC"
                        },
                        {
                          "label": "Death claim",
                          "value": "ID"
                        },
                        {
                          "label": "Maturity",
                          "value": "IM"
                        },
                        {
                          "label": "Survival benefits",
                          "value": "IB"
                        },
                        {
                          "label": "Free look Cancellation",
                          "value": "IF"
                        },
                        {
                          "label": "Withdrawal",
                          "value": "IW"
                        },
                        {
                          "label": "Surrender",
                          "value": "IS"
                        },
                        {
                          "label": "Assignment",
                          "value": "IG"
                        },
                        {
                          "label": "Decline",
                          "value": "IE"
                        },
                        {
                          "label": "Excess Refund",
                          "value": "IX"
                        },
                        {
                          "label": "Premium Payment",
                          "value": "IR"
                        },
                        {
                          "label": "Loan Repayment",
                          "value": "IL"
                        },
                        {
                          "label": "Dematerialisation/Conversion of Mutual funds units in demat form",
                          "value": "DD"
                        },
                        {
                          "label": "Rematerialisation/Repurchase",
                          "value": "DR"
                        },
                        {
                          "label": "Off Market trade",
                          "value": "DO"
                        },
                        {
                          "label": "Market transfers",
                          "value": "DM"
                        },
                        {
                          "label": "Inter Settlement transfers",
                          "value": "DI"
                        },
                        {
                          "label": "Pledge and Hypothecation",
                          "value": "DP"
                        },
                        {
                          "label": "Corporate action",
                          "value": "DC"
                        },
                        {
                          "label": "Others",
                          "value": "ZZ"
                        },
                        {
                          "label": "Not Categorised",
                          "value": "XX"
                        }
                      ],
                      "validations": {
                        "required": true
                      }
                    },
                    {
                      "key": "Batch.Report.Account.Transaction[].ProductTransaction.Units",
                      "type": "text",
                      "label": "Units",
                      "validations": {
                        "required": false,
                        "maxLength": 20
                      }
                    },
                    {
                      "key": "Batch.Report.Account.Transaction[].ProductTransaction.Rate",
                      "type": "text",
                      "label": "Rate",
                      "validations": {
                        "required": false,
                        "maxLength": 10
                      }
                    }
                  ],
                  "colClassName": "mt-4"
                }
              }
            ],
            "required": true
          }
        }
      ],
      "required": true,
      "colClassName": "mt-4"
    }
  }
]'::jsonb WHERE
ifromid = 1;




INSERT INTO ui.formmaster (ifromid, formattingjson, inputjson, vcformname, actioaftercreation, vcdisplayname) VALUES (2, '{"xmlconfig": {"config": [{"key": "Batch.ReportType", "displayName": "Batch.ReportType"}, {"key": "Batch.ReportFormatType", "displayName": "Batch.ReportFormatType"}, {"key": "Batch.BatchHeader.DataStructureVersion", "displayName": "Batch.BatchHeader.DataStructureVersion"}, {"key": "Batch.BatchHeader.GenerationUtilityVersion", "displayName": "Batch.BatchHeader.GenerationUtilityVersion"}, {"key": "Batch.BatchHeader.DataSource", "displayName": "Batch.BatchHeader.DataSource"}, {"key": "Batch.ReportingEntity.ReportingEntityName", "displayName": "Batch.ReportingEntity.ReportingEntityName"}, {"key": "Batch.ReportingEntity.ReportingEntityCategory", "displayName": "Batch.ReportingEntity.ReportingEntityCategory"}, {"key": "Batch.ReportingEntity.RERegistrationNum", "displayName": "Batch.ReportingEntity.RERegistrationNum"}, {"key": "Batch.ReportingEntity.FIUREID", "displayName": "Batch.ReportingEntity.FIUREID"}, {"key": "Batch.PrincipalOfficer.POName", "displayName": "Batch.PrincipalOfficer.POName"}, {"key": "Batch.PrincipalOfficer.PODesignation", "displayName": "Batch.PrincipalOfficer.PODesignation"}, {"key": "Batch.PrincipalOfficer.POEmail", "displayName": "Batch.PrincipalOfficer.POEmail"}, {"key": "Batch.PrincipalOfficer.POAddress.Address", "displayName": "Batch.PrincipalOfficer.POAddress.Address"}, {"key": "Batch.PrincipalOfficer.POAddress.City", "displayName": "Batch.PrincipalOfficer.POAddress.City"}, {"key": "Batch.PrincipalOfficer.POAddress.StateCode", "displayName": "Batch.PrincipalOfficer.POAddress.StateCode"}, {"key": "Batch.PrincipalOfficer.POAddress.PinCode", "displayName": "Batch.PrincipalOfficer.POAddress.PinCode"}, {"key": "Batch.PrincipalOfficer.POAddress.CountryCode", "displayName": "Batch.PrincipalOfficer.POAddress.CountryCode"}, {"key": "Batch.PrincipalOfficer.POPhone.Telephone", "displayName": "Batch.PrincipalOfficer.POPhone.Telephone"}, {"key": "Batch.PrincipalOfficer.POPhone.Mobile", "displayName": "Batch.PrincipalOfficer.POPhone.Mobile"}, {"key": "Batch.PrincipalOfficer.POPhone.Fax", "displayName": "Batch.PrincipalOfficer.POPhone.Fax"}, {"key": "Batch.BatchDetails.BatchNumber", "displayName": "Batch.BatchDetails.BatchNumber"}, {"key": "Batch.BatchDetails.BatchDate", "displayName": "Batch.BatchDetails.BatchDate"}, {"key": "Batch.BatchDetails.MonthOfReport", "displayName": "Batch.BatchDetails.MonthOfReport"}, {"key": "Batch.BatchDetails.YearOfReport", "displayName": "Batch.BatchDetails.YearOfReport"}, {"key": "Batch.BatchDetails.OperationalMode", "displayName": "Batch.BatchDetails.OperationalMode"}, {"key": "Batch.BatchDetails.BatchType", "displayName": "Batch.BatchDetails.BatchType"}, {"key": "Batch.BatchDetails.OriginalBatchID", "displayName": "Batch.BatchDetails.OriginalBatchID"}, {"key": "Batch.BatchDetails.ReasonOfRevision", "displayName": "Batch.BatchDetails.ReasonOfRevision"}, {"key": "Batch.BatchDetails.PKICertificateNum", "displayName": "Batch.BatchDetails.PKICertificateNum"}, {"key": "Batch.Report.ReportSerialNum", "displayName": "Batch.Report.ReportSerialNum"}, {"key": "Batch.Report.OriginalReportSerialNum", "displayName": "Batch.Report.OriginalReportSerialNum"}, {"key": "Batch.Report.MainPersonName", "displayName": "Batch.Report.MainPersonName"}, {"key": "Batch.Report.SuspicionDetails.SourceOfAlert", "displayName": "Batch.Report.SuspicionDetails.SourceOfAlert"}, {"key": "Batch.Report.SuspicionDetails.AlertIndicator[]", "displayName": "Batch.Report.SuspicionDetails.AlertIndicator[]"}, {"key": "Batch.Report.SuspicionDetails.SuspicionDueToProceedsOfCrime", "displayName": "Batch.Report.SuspicionDetails.SuspicionDueToProceedsOfCrime"}, {"key": "Batch.Report.SuspicionDetails.SuspicionDueToComplexTrans", "displayName": "Batch.Report.SuspicionDetails.SuspicionDueToComplexTrans"}, {"key": "Batch.Report.SuspicionDetails.SuspicionDueToNoEcoRationale", "displayName": "Batch.Report.SuspicionDetails.SuspicionDueToNoEcoRationale"}, {"key": "Batch.Report.SuspicionDetails.SuspicionOfFinancingOfTerrorism", "displayName": "Batch.Report.SuspicionDetails.SuspicionOfFinancingOfTerrorism"}, {"key": "Batch.Report.SuspicionDetails.AttemptedTransaction", "displayName": "Batch.Report.SuspicionDetails.AttemptedTransaction"}, {"key": "Batch.Report.SuspicionDetails.GroundsOfSuspicion", "displayName": "Batch.Report.SuspicionDetails.GroundsOfSuspicion"}, {"key": "Batch.Report.SuspicionDetails.DetailsOfInvestigation", "displayName": "Batch.Report.SuspicionDetails.DetailsOfInvestigation"}, {"key": "Batch.Report.SuspicionDetails.LEAInformed", "displayName": "Batch.Report.SuspicionDetails.LEAInformed"}, {"key": "Batch.Report.SuspicionDetails.LEADetails", "displayName": "Batch.Report.SuspicionDetails.LEADetails"}, {"key": "Batch.Report.SuspicionDetails.PriorityRating", "displayName": "Batch.Report.SuspicionDetails.PriorityRating"}, {"key": "Batch.Report.SuspicionDetails.ReportCoverage", "displayName": "Batch.Report.SuspicionDetails.ReportCoverage"}, {"key": "Batch.Report.SuspicionDetails.AdditionalDocuments", "displayName": "Batch.Report.SuspicionDetails.AdditionalDocuments"}, {"key": "Batch.Report.Transaction[].TrasnactionDate", "displayName": "Batch.Report.Transaction[].TrasnactionDate"}, {"key": "Batch.Report.Transaction[].TrasnactionTime", "displayName": "Batch.Report.Transaction[].TrasnactionTime"}, {"key": "Batch.Report.Transaction[].TransactionRefNum", "displayName": "Batch.Report.Transaction[].TransactionRefNum"}, {"key": "Batch.Report.Transaction[].TransactionType", "displayName": "Batch.Report.Transaction[].TransactionType"}, {"key": "Batch.Report.Transaction[].InstrumentType", "displayName": "Batch.Report.Transaction[].InstrumentType"}, {"key": "Batch.Report.Transaction[].TransactionInstitutionName", "displayName": "Batch.Report.Transaction[].TransactionInstitutionName"}, {"key": "Batch.Report.Transaction[].TransactionInstitutionRefNum", "displayName": "Batch.Report.Transaction[].TransactionInstitutionRefNum"}, {"key": "Batch.Report.Transaction[].TransactionStateCode", "displayName": "Batch.Report.Transaction[].TransactionStateCode"}, {"key": "Batch.Report.Transaction[].TransactionCountryCode", "displayName": "Batch.Report.Transaction[].TransactionCountryCode"}, {"key": "Batch.Report.Transaction[].PaymentInstrumentNum", "displayName": "Batch.Report.Transaction[].PaymentInstrumentNum"}, {"key": "Batch.Report.Transaction[].PaymentInstrumentIssueInstitutionName", "displayName": "Batch.Report.Transaction[].PaymentInstrumentIssueInstitutionName"}, {"key": "Batch.Report.Transaction[].InstrumentIssueInstitutionRefNum", "displayName": "Batch.Report.Transaction[].InstrumentIssueInstitutionRefNum"}, {"key": "Batch.Report.Transaction[].InstrumentCountryCode", "displayName": "Batch.Report.Transaction[].InstrumentCountryCode"}, {"key": "Batch.Report.Transaction[].AmountRupees", "displayName": "Batch.Report.Transaction[].AmountRupees"}, {"key": "Batch.Report.Transaction[].AmountForeignCurrency", "displayName": "Batch.Report.Transaction[].AmountForeignCurrency"}, {"key": "Batch.Report.Transaction[].CurrencyOfTransaction", "displayName": "Batch.Report.Transaction[].CurrencyOfTransaction"}, {"key": "Batch.Report.Transaction[].PurposeOfTransaction", "displayName": "Batch.Report.Transaction[].PurposeOfTransaction"}, {"key": "Batch.Report.Transaction[].PurposeCode", "displayName": "Batch.Report.Transaction[].PurposeCode"}, {"key": "Batch.Report.Transaction[].RiskRating", "displayName": "Batch.Report.Transaction[].RiskRating"}, {"key": "Batch.Report.Transaction[].AccountNumber", "displayName": "Batch.Report.Transaction[].AccountNumber"}, {"key": "Batch.Report.Transaction[].AccountWithInstitutionName", "displayName": "Batch.Report.Transaction[].AccountWithInstitutionName"}, {"key": "Batch.Report.Transaction[].AccountWithInstitutionRefNum", "displayName": "Batch.Report.Transaction[].AccountWithInstitutionRefNum"}, {"key": "Batch.Report.Transaction[].RelatedInstitutionName", "displayName": "Batch.Report.Transaction[].RelatedInstitutionName"}, {"key": "Batch.Report.Transaction[].InstitutionRelationFlag", "displayName": "Batch.Report.Transaction[].InstitutionRelationFlag"}, {"key": "Batch.Report.Transaction[].RelatedInstitutionRefNum", "displayName": "Batch.Report.Transaction[].RelatedInstitutionRefNum"}, {"key": "Batch.Report.Transaction[].Remarks", "displayName": "Batch.Report.Transaction[].Remarks"}, {"key": "Batch.Report.Transaction[].CustomerDetails.CustomerName", "displayName": "Batch.Report.Transaction[].CustomerDetails.CustomerName"}, {"key": "Batch.Report.Transaction[].CustomerDetails.CustomerId", "displayName": "Batch.Report.Transaction[].CustomerDetails.CustomerId"}, {"key": "Batch.Report.Transaction[].CustomerDetails.Occupation", "displayName": "Batch.Report.Transaction[].CustomerDetails.Occupation"}, {"key": "Batch.Report.Transaction[].CustomerDetails.DateOfBirth", "displayName": "Batch.Report.Transaction[].CustomerDetails.DateOfBirth"}, {"key": "Batch.Report.Transaction[].CustomerDetails.Gender", "displayName": "Batch.Report.Transaction[].CustomerDetails.Gender"}, {"key": "Batch.Report.Transaction[].CustomerDetails.Nationality", "displayName": "Batch.Report.Transaction[].CustomerDetails.Nationality"}, {"key": "Batch.Report.Transaction[].CustomerDetails.IdentificationType", "displayName": "Batch.Report.Transaction[].CustomerDetails.IdentificationType"}, {"key": "Batch.Report.Transaction[].CustomerDetails.IdentificationNumber", "displayName": "Batch.Report.Transaction[].CustomerDetails.IdentificationNumber"}, {"key": "Batch.Report.Transaction[].CustomerDetails.IssuingAuthority", "displayName": "Batch.Report.Transaction[].CustomerDetails.IssuingAuthority"}, {"key": "Batch.Report.Transaction[].CustomerDetails.PlaceOfIssue", "displayName": "Batch.Report.Transaction[].CustomerDetails.PlaceOfIssue"}, {"key": "Batch.Report.Transaction[].CustomerDetails.PAN", "displayName": "Batch.Report.Transaction[].CustomerDetails.PAN"}, {"key": "Batch.Report.Transaction[].CustomerDetails.UIN", "displayName": "Batch.Report.Transaction[].CustomerDetails.UIN"}, {"key": "Batch.Report.Transaction[].CustomerDetails.Email", "displayName": "Batch.Report.Transaction[].CustomerDetails.Email"}, {"key": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.Address", "displayName": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.Address"}, {"key": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.City", "displayName": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.City"}, {"key": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.StateCode", "displayName": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.StateCode"}, {"key": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.PinCode", "displayName": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.PinCode"}, {"key": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.CountryCode", "displayName": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.CountryCode"}, {"key": "Batch.Report.Transaction[].CustomerDetails.Phone.Telephone", "displayName": "Batch.Report.Transaction[].CustomerDetails.Phone.Telephone"}, {"key": "Batch.Report.Transaction[].CustomerDetails.Phone.Mobile", "displayName": "Batch.Report.Transaction[].CustomerDetails.Phone.Mobile"}, {"key": "Batch.Report.Transaction[].CustomerDetails.Phone.Fax", "displayName": "Batch.Report.Transaction[].CustomerDetails.Phone.Fax"}, {"key": "Batch.Report.Branch.InstitutionName", "displayName": "Batch.Report.Branch.InstitutionName"}, {"key": "Batch.Report.Branch.InstitutionBranchName", "displayName": "Batch.Report.Branch.InstitutionBranchName"}, {"key": "Batch.Report.Branch.InstitutionRefNum", "displayName": "Batch.Report.Branch.InstitutionRefNum"}, {"key": "Batch.Report.Branch.ReportingRole", "displayName": "Batch.Report.Branch.ReportingRole"}, {"key": "Batch.Report.Branch.BIC", "displayName": "Batch.Report.Branch.BIC"}, {"key": "Batch.Report.Branch.BranchAddress.Address", "displayName": "Batch.Report.Branch.BranchAddress.Address"}, {"key": "Batch.Report.Branch.BranchAddress.City", "displayName": "Batch.Report.Branch.BranchAddress.City"}, {"key": "Batch.Report.Branch.BranchAddress.StateCode", "displayName": "Batch.Report.Branch.BranchAddress.StateCode"}, {"key": "Batch.Report.Branch.BranchAddress.PinCode", "displayName": "Batch.Report.Branch.BranchAddress.PinCode"}, {"key": "Batch.Report.Branch.BranchAddress.CountryCode", "displayName": "Batch.Report.Branch.BranchAddress.CountryCode"}, {"key": "Batch.Report.Branch.Phone.Telephone", "displayName": "Batch.Report.Branch.Phone.Telephone"}, {"key": "Batch.Report.Branch.Phone.Mobile", "displayName": "Batch.Report.Branch.Phone.Mobile"}, {"key": "Batch.Report.Branch.Phone.Fax", "displayName": "Batch.Report.Branch.Phone.Fax"}, {"key": "Batch.Report.Branch.Email", "displayName": "Batch.Report.Branch.Email"}, {"key": "Batch.Report.Branch.Remarks", "displayName": "Batch.Report.Branch.Remarks"}, {"key": "Batch.Report.PaymentInstrument[].InstrumentRefNum", "displayName": "Batch.Report.PaymentInstrument[].InstrumentRefNum"}, {"key": "Batch.Report.PaymentInstrument[].IssueInstitutionRefNum", "displayName": "Batch.Report.PaymentInstrument[].IssueInstitutionRefNum"}, {"key": "Batch.Report.PaymentInstrument[].InstrumentIssueInstitutionName", "displayName": "Batch.Report.PaymentInstrument[].InstrumentIssueInstitutionName"}, {"key": "Batch.Report.PaymentInstrument[].InstrumentHolderName", "displayName": "Batch.Report.PaymentInstrument[].InstrumentHolderName"}, {"key": "Batch.Report.PaymentInstrument[].RelationshipBeginningDate", "displayName": "Batch.Report.PaymentInstrument[].RelationshipBeginningDate"}, {"key": "Batch.Report.PaymentInstrument[].CumulativePurchaseTurnover", "displayName": "Batch.Report.PaymentInstrument[].CumulativePurchaseTurnover"}, {"key": "Batch.Report.PaymentInstrument[].Remarks", "displayName": "Batch.Report.PaymentInstrument[].Remarks"}, {"key": "Batch.Report.RelatedPersons[].PersonName", "displayName": "Batch.Report.RelatedPersons[].PersonName"}, {"key": "Batch.Report.RelatedPersons[].CustomerID", "displayName": "Batch.Report.RelatedPersons[].CustomerID"}, {"key": "Batch.Report.RelatedPersons[].RelationFlag", "displayName": "Batch.Report.RelatedPersons[].RelationFlag"}, {"key": "Batch.Report.RelatedPersons[].PAN", "displayName": "Batch.Report.RelatedPersons[].PAN"}, {"key": "Batch.Report.RelatedPersons[].UIN", "displayName": "Batch.Report.RelatedPersons[].UIN"}, {"key": "Batch.Report.RelatedPersons[].Choice", "displayName": "Batch.Report.RelatedPersons[].Choice"}, {"key": "Batch.Report.RelatedPersons[].Individual.Gender", "displayName": "Batch.Report.RelatedPersons[].Individual.Gender"}, {"key": "Batch.Report.RelatedPersons[].Individual.DateOfBirth", "displayName": "Batch.Report.RelatedPersons[].Individual.DateOfBirth"}, {"key": "Batch.Report.RelatedPersons[].Individual.IdentificationType", "displayName": "Batch.Report.RelatedPersons[].Individual.IdentificationType"}, {"key": "Batch.Report.RelatedPersons[].Individual.IdentificationNumber", "displayName": "Batch.Report.RelatedPersons[].Individual.IdentificationNumber"}, {"key": "Batch.Report.RelatedPersons[].Individual.IssuingAuthority", "displayName": "Batch.Report.RelatedPersons[].Individual.IssuingAuthority"}, {"key": "Batch.Report.RelatedPersons[].Individual.PlaceOfIssue", "displayName": "Batch.Report.RelatedPersons[].Individual.PlaceOfIssue"}, {"key": "Batch.Report.RelatedPersons[].Individual.Nationality", "displayName": "Batch.Report.RelatedPersons[].Individual.Nationality"}, {"key": "Batch.Report.RelatedPersons[].Individual.PlaceOfWork", "displayName": "Batch.Report.RelatedPersons[].Individual.PlaceOfWork"}, {"key": "Batch.Report.RelatedPersons[].Individual.FatherOrSpouse", "displayName": "Batch.Report.RelatedPersons[].Individual.FatherOrSpouse"}, {"key": "Batch.Report.RelatedPersons[].Individual.Occupation", "displayName": "Batch.Report.RelatedPersons[].Individual.Occupation"}, {"key": "Batch.Report.RelatedPersons[].LegalPerson.ConstitutionType", "displayName": "Batch.Report.RelatedPersons[].LegalPerson.ConstitutionType"}, {"key": "Batch.Report.RelatedPersons[].LegalPerson.RegistrationNumber", "displayName": "Batch.Report.RelatedPersons[].LegalPerson.RegistrationNumber"}, {"key": "Batch.Report.RelatedPersons[].LegalPerson.DateOfIncorporation", "displayName": "Batch.Report.RelatedPersons[].LegalPerson.DateOfIncorporation"}, {"key": "Batch.Report.RelatedPersons[].LegalPerson.PlaceOfRegistration", "displayName": "Batch.Report.RelatedPersons[].LegalPerson.PlaceOfRegistration"}, {"key": "Batch.Report.RelatedPersons[].LegalPerson.CountryCode", "displayName": "Batch.Report.RelatedPersons[].LegalPerson.CountryCode"}, {"key": "Batch.Report.RelatedPersons[].LegalPerson.NatureOfBusiness", "displayName": "Batch.Report.RelatedPersons[].LegalPerson.NatureOfBusiness"}, {"key": "Batch.Report.RelatedPersons[].CommunicationAddress.Address", "displayName": "Batch.Report.RelatedPersons[].CommunicationAddress.Address"}, {"key": "Batch.Report.RelatedPersons[].CommunicationAddress.City", "displayName": "Batch.Report.RelatedPersons[].CommunicationAddress.City"}, {"key": "Batch.Report.RelatedPersons[].CommunicationAddress.StateCode", "displayName": "Batch.Report.RelatedPersons[].CommunicationAddress.StateCode"}, {"key": "Batch.Report.RelatedPersons[].CommunicationAddress.PinCode", "displayName": "Batch.Report.RelatedPersons[].CommunicationAddress.PinCode"}, {"key": "Batch.Report.RelatedPersons[].CommunicationAddress.CountryCode", "displayName": "Batch.Report.RelatedPersons[].CommunicationAddress.CountryCode"}, {"key": "Batch.Report.RelatedPersons[].Phone.Telephone", "displayName": "Batch.Report.RelatedPersons[].Phone.Telephone"}, {"key": "Batch.Report.RelatedPersons[].Phone.Mobile", "displayName": "Batch.Report.RelatedPersons[].Phone.Mobile"}, {"key": "Batch.Report.RelatedPersons[].Phone.Fax", "displayName": "Batch.Report.RelatedPersons[].Phone.Fax"}, {"key": "Batch.Report.RelatedPersons[].Email", "displayName": "Batch.Report.RelatedPersons[].Email"}, {"key": "Batch.Report.RelatedPersons[].SecondAddress.Address", "displayName": "Batch.Report.RelatedPersons[].SecondAddress.Address"}, {"key": "Batch.Report.RelatedPersons[].SecondAddress.City", "displayName": "Batch.Report.RelatedPersons[].SecondAddress.City"}, {"key": "Batch.Report.RelatedPersons[].SecondAddress.StateCode", "displayName": "Batch.Report.RelatedPersons[].SecondAddress.StateCode"}, {"key": "Batch.Report.RelatedPersons[].SecondAddress.PinCode", "displayName": "Batch.Report.RelatedPersons[].SecondAddress.PinCode"}, {"key": "Batch.Report.RelatedPersons[].SecondAddress.CountryCode", "displayName": "Batch.Report.RelatedPersons[].SecondAddress.CountryCode"}, {"key": "Batch.ReportType", "displayName": "Batch.ReportType"}, {"key": "Batch.ReportFormatType", "displayName": "Batch.ReportFormatType"}, {"key": "Batch.BatchHeader.DataStructureVersion", "displayName": "Batch.BatchHeader.DataStructureVersion"}, {"key": "Batch.BatchHeader.GenerationUtilityVersion", "displayName": "Batch.BatchHeader.GenerationUtilityVersion"}, {"key": "Batch.BatchHeader.DataSource", "displayName": "Batch.BatchHeader.DataSource"}, {"key": "Batch.ReportingEntity.ReportingEntityName", "displayName": "Batch.ReportingEntity.ReportingEntityName"}, {"key": "Batch.ReportingEntity.ReportingEntityCategory", "displayName": "Batch.ReportingEntity.ReportingEntityCategory"}, {"key": "Batch.ReportingEntity.RERegistrationNum", "displayName": "Batch.ReportingEntity.RERegistrationNum"}, {"key": "Batch.ReportingEntity.FIUREID", "displayName": "Batch.ReportingEntity.FIUREID"}, {"key": "Batch.PrincipalOfficer.POName", "displayName": "Batch.PrincipalOfficer.POName"}, {"key": "Batch.PrincipalOfficer.PODesignation", "displayName": "Batch.PrincipalOfficer.PODesignation"}, {"key": "Batch.PrincipalOfficer.POEmail", "displayName": "Batch.PrincipalOfficer.POEmail"}, {"key": "Batch.PrincipalOfficer.POAddress.Address", "displayName": "Batch.PrincipalOfficer.POAddress.Address"}, {"key": "Batch.PrincipalOfficer.POAddress.City", "displayName": "Batch.PrincipalOfficer.POAddress.City"}, {"key": "Batch.PrincipalOfficer.POAddress.StateCode", "displayName": "Batch.PrincipalOfficer.POAddress.StateCode"}, {"key": "Batch.PrincipalOfficer.POAddress.PinCode", "displayName": "Batch.PrincipalOfficer.POAddress.PinCode"}, {"key": "Batch.PrincipalOfficer.POAddress.CountryCode", "displayName": "Batch.PrincipalOfficer.POAddress.CountryCode"}, {"key": "Batch.PrincipalOfficer.POPhone.Telephone", "displayName": "Batch.PrincipalOfficer.POPhone.Telephone"}, {"key": "Batch.PrincipalOfficer.POPhone.Mobile", "displayName": "Batch.PrincipalOfficer.POPhone.Mobile"}, {"key": "Batch.PrincipalOfficer.POPhone.Fax", "displayName": "Batch.PrincipalOfficer.POPhone.Fax"}, {"key": "Batch.BatchDetails.BatchNumber", "displayName": "Batch.BatchDetails.BatchNumber"}, {"key": "Batch.BatchDetails.BatchDate", "displayName": "Batch.BatchDetails.BatchDate"}, {"key": "Batch.BatchDetails.MonthOfReport", "displayName": "Batch.BatchDetails.MonthOfReport"}, {"key": "Batch.BatchDetails.YearOfReport", "displayName": "Batch.BatchDetails.YearOfReport"}, {"key": "Batch.BatchDetails.OperationalMode", "displayName": "Batch.BatchDetails.OperationalMode"}, {"key": "Batch.BatchDetails.BatchType", "displayName": "Batch.BatchDetails.BatchType"}, {"key": "Batch.BatchDetails.OriginalBatchID", "displayName": "Batch.BatchDetails.OriginalBatchID"}, {"key": "Batch.BatchDetails.ReasonOfRevision", "displayName": "Batch.BatchDetails.ReasonOfRevision"}, {"key": "Batch.BatchDetails.PKICertificateNum", "displayName": "Batch.BatchDetails.PKICertificateNum"}, {"key": "Batch.Report.ReportSerialNum", "displayName": "Batch.Report.ReportSerialNum"}, {"key": "Batch.Report.OriginalReportSerialNum", "displayName": "Batch.Report.OriginalReportSerialNum"}, {"key": "Batch.Report.MainPersonName", "displayName": "Batch.Report.MainPersonName"}, {"key": "Batch.Report.SuspicionDetails.SourceOfAlert", "displayName": "Batch.Report.SuspicionDetails.SourceOfAlert"}, {"key": "Batch.Report.SuspicionDetails.AlertIndicator[]", "displayName": "Batch.Report.SuspicionDetails.AlertIndicator[]"}, {"key": "Batch.Report.SuspicionDetails.SuspicionDueToProceedsOfCrime", "displayName": "Batch.Report.SuspicionDetails.SuspicionDueToProceedsOfCrime"}, {"key": "Batch.Report.SuspicionDetails.SuspicionDueToComplexTrans", "displayName": "Batch.Report.SuspicionDetails.SuspicionDueToComplexTrans"}, {"key": "Batch.Report.SuspicionDetails.SuspicionDueToNoEcoRationale", "displayName": "Batch.Report.SuspicionDetails.SuspicionDueToNoEcoRationale"}, {"key": "Batch.Report.SuspicionDetails.SuspicionOfFinancingOfTerrorism", "displayName": "Batch.Report.SuspicionDetails.SuspicionOfFinancingOfTerrorism"}, {"key": "Batch.Report.SuspicionDetails.AttemptedTransaction", "displayName": "Batch.Report.SuspicionDetails.AttemptedTransaction"}, {"key": "Batch.Report.SuspicionDetails.GroundsOfSuspicion", "displayName": "Batch.Report.SuspicionDetails.GroundsOfSuspicion"}, {"key": "Batch.Report.SuspicionDetails.DetailsOfInvestigation", "displayName": "Batch.Report.SuspicionDetails.DetailsOfInvestigation"}, {"key": "Batch.Report.SuspicionDetails.LEAInformed", "displayName": "Batch.Report.SuspicionDetails.LEAInformed"}, {"key": "Batch.Report.SuspicionDetails.LEADetails", "displayName": "Batch.Report.SuspicionDetails.LEADetails"}, {"key": "Batch.Report.SuspicionDetails.PriorityRating", "displayName": "Batch.Report.SuspicionDetails.PriorityRating"}, {"key": "Batch.Report.SuspicionDetails.ReportCoverage", "displayName": "Batch.Report.SuspicionDetails.ReportCoverage"}, {"key": "Batch.Report.SuspicionDetails.AdditionalDocuments", "displayName": "Batch.Report.SuspicionDetails.AdditionalDocuments"}, {"key": "Batch.Report.Transaction[].TrasnactionDate", "displayName": "Batch.Report.Transaction[].TrasnactionDate"}, {"key": "Batch.Report.Transaction[].TrasnactionTime", "displayName": "Batch.Report.Transaction[].TrasnactionTime"}, {"key": "Batch.Report.Transaction[].TransactionRefNum", "displayName": "Batch.Report.Transaction[].TransactionRefNum"}, {"key": "Batch.Report.Transaction[].TransactionType", "displayName": "Batch.Report.Transaction[].TransactionType"}, {"key": "Batch.Report.Transaction[].InstrumentType", "displayName": "Batch.Report.Transaction[].InstrumentType"}, {"key": "Batch.Report.Transaction[].TransactionInstitutionName", "displayName": "Batch.Report.Transaction[].TransactionInstitutionName"}, {"key": "Batch.Report.Transaction[].TransactionInstitutionRefNum", "displayName": "Batch.Report.Transaction[].TransactionInstitutionRefNum"}, {"key": "Batch.Report.Transaction[].TransactionStateCode", "displayName": "Batch.Report.Transaction[].TransactionStateCode"}, {"key": "Batch.Report.Transaction[].TransactionCountryCode", "displayName": "Batch.Report.Transaction[].TransactionCountryCode"}, {"key": "Batch.Report.Transaction[].PaymentInstrumentNum", "displayName": "Batch.Report.Transaction[].PaymentInstrumentNum"}, {"key": "Batch.Report.Transaction[].PaymentInstrumentIssueInstitutionName", "displayName": "Batch.Report.Transaction[].PaymentInstrumentIssueInstitutionName"}, {"key": "Batch.Report.Transaction[].InstrumentIssueInstitutionRefNum", "displayName": "Batch.Report.Transaction[].InstrumentIssueInstitutionRefNum"}, {"key": "Batch.Report.Transaction[].InstrumentCountryCode", "displayName": "Batch.Report.Transaction[].InstrumentCountryCode"}, {"key": "Batch.Report.Transaction[].AmountRupees", "displayName": "Batch.Report.Transaction[].AmountRupees"}, {"key": "Batch.Report.Transaction[].AmountForeignCurrency", "displayName": "Batch.Report.Transaction[].AmountForeignCurrency"}, {"key": "Batch.Report.Transaction[].CurrencyOfTransaction", "displayName": "Batch.Report.Transaction[].CurrencyOfTransaction"}, {"key": "Batch.Report.Transaction[].PurposeOfTransaction", "displayName": "Batch.Report.Transaction[].PurposeOfTransaction"}, {"key": "Batch.Report.Transaction[].PurposeCode", "displayName": "Batch.Report.Transaction[].PurposeCode"}, {"key": "Batch.Report.Transaction[].RiskRating", "displayName": "Batch.Report.Transaction[].RiskRating"}, {"key": "Batch.Report.Transaction[].AccountNumber", "displayName": "Batch.Report.Transaction[].AccountNumber"}, {"key": "Batch.Report.Transaction[].AccountWithInstitutionName", "displayName": "Batch.Report.Transaction[].AccountWithInstitutionName"}, {"key": "Batch.Report.Transaction[].AccountWithInstitutionRefNum", "displayName": "Batch.Report.Transaction[].AccountWithInstitutionRefNum"}, {"key": "Batch.Report.Transaction[].RelatedInstitutionName", "displayName": "Batch.Report.Transaction[].RelatedInstitutionName"}, {"key": "Batch.Report.Transaction[].InstitutionRelationFlag", "displayName": "Batch.Report.Transaction[].InstitutionRelationFlag"}, {"key": "Batch.Report.Transaction[].RelatedInstitutionRefNum", "displayName": "Batch.Report.Transaction[].RelatedInstitutionRefNum"}, {"key": "Batch.Report.Transaction[].Remarks", "displayName": "Batch.Report.Transaction[].Remarks"}, {"key": "Batch.Report.Transaction[].CustomerDetails.CustomerName", "displayName": "Batch.Report.Transaction[].CustomerDetails.CustomerName"}, {"key": "Batch.Report.Transaction[].CustomerDetails.CustomerId", "displayName": "Batch.Report.Transaction[].CustomerDetails.CustomerId"}, {"key": "Batch.Report.Transaction[].CustomerDetails.Occupation", "displayName": "Batch.Report.Transaction[].CustomerDetails.Occupation"}, {"key": "Batch.Report.Transaction[].CustomerDetails.DateOfBirth", "displayName": "Batch.Report.Transaction[].CustomerDetails.DateOfBirth"}, {"key": "Batch.Report.Transaction[].CustomerDetails.Gender", "displayName": "Batch.Report.Transaction[].CustomerDetails.Gender"}, {"key": "Batch.Report.Transaction[].CustomerDetails.Nationality", "displayName": "Batch.Report.Transaction[].CustomerDetails.Nationality"}, {"key": "Batch.Report.Transaction[].CustomerDetails.IdentificationType", "displayName": "Batch.Report.Transaction[].CustomerDetails.IdentificationType"}, {"key": "Batch.Report.Transaction[].CustomerDetails.IdentificationNumber", "displayName": "Batch.Report.Transaction[].CustomerDetails.IdentificationNumber"}, {"key": "Batch.Report.Transaction[].CustomerDetails.IssuingAuthority", "displayName": "Batch.Report.Transaction[].CustomerDetails.IssuingAuthority"}, {"key": "Batch.Report.Transaction[].CustomerDetails.PlaceOfIssue", "displayName": "Batch.Report.Transaction[].CustomerDetails.PlaceOfIssue"}, {"key": "Batch.Report.Transaction[].CustomerDetails.PAN", "displayName": "Batch.Report.Transaction[].CustomerDetails.PAN"}, {"key": "Batch.Report.Transaction[].CustomerDetails.UIN", "displayName": "Batch.Report.Transaction[].CustomerDetails.UIN"}, {"key": "Batch.Report.Transaction[].CustomerDetails.Email", "displayName": "Batch.Report.Transaction[].CustomerDetails.Email"}, {"key": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.Address", "displayName": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.Address"}, {"key": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.City", "displayName": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.City"}, {"key": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.StateCode", "displayName": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.StateCode"}, {"key": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.PinCode", "displayName": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.PinCode"}, {"key": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.CountryCode", "displayName": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.CountryCode"}, {"key": "Batch.Report.Transaction[].CustomerDetails.Phone.Telephone", "displayName": "Batch.Report.Transaction[].CustomerDetails.Phone.Telephone"}, {"key": "Batch.Report.Transaction[].CustomerDetails.Phone.Mobile", "displayName": "Batch.Report.Transaction[].CustomerDetails.Phone.Mobile"}, {"key": "Batch.Report.Transaction[].CustomerDetails.Phone.Fax", "displayName": "Batch.Report.Transaction[].CustomerDetails.Phone.Fax"}, {"key": "Batch.Report.Branch.InstitutionName", "displayName": "Batch.Report.Branch.InstitutionName"}, {"key": "Batch.Report.Branch.InstitutionBranchName", "displayName": "Batch.Report.Branch.InstitutionBranchName"}, {"key": "Batch.Report.Branch.InstitutionRefNum", "displayName": "Batch.Report.Branch.InstitutionRefNum"}, {"key": "Batch.Report.Branch.ReportingRole", "displayName": "Batch.Report.Branch.ReportingRole"}, {"key": "Batch.Report.Branch.BIC", "displayName": "Batch.Report.Branch.BIC"}, {"key": "Batch.Report.Branch.BranchAddress.Address", "displayName": "Batch.Report.Branch.BranchAddress.Address"}, {"key": "Batch.Report.Branch.BranchAddress.City", "displayName": "Batch.Report.Branch.BranchAddress.City"}, {"key": "Batch.Report.Branch.BranchAddress.StateCode", "displayName": "Batch.Report.Branch.BranchAddress.StateCode"}, {"key": "Batch.Report.Branch.BranchAddress.PinCode", "displayName": "Batch.Report.Branch.BranchAddress.PinCode"}, {"key": "Batch.Report.Branch.BranchAddress.CountryCode", "displayName": "Batch.Report.Branch.BranchAddress.CountryCode"}, {"key": "Batch.Report.Branch.Phone.Telephone", "displayName": "Batch.Report.Branch.Phone.Telephone"}, {"key": "Batch.Report.Branch.Phone.Mobile", "displayName": "Batch.Report.Branch.Phone.Mobile"}, {"key": "Batch.Report.Branch.Phone.Fax", "displayName": "Batch.Report.Branch.Phone.Fax"}, {"key": "Batch.Report.Branch.Email", "displayName": "Batch.Report.Branch.Email"}, {"key": "Batch.Report.Branch.Remarks", "displayName": "Batch.Report.Branch.Remarks"}, {"key": "Batch.Report.PaymentInstrument[].InstrumentRefNum", "displayName": "Batch.Report.PaymentInstrument[].InstrumentRefNum"}, {"key": "Batch.Report.PaymentInstrument[].IssueInstitutionRefNum", "displayName": "Batch.Report.PaymentInstrument[].IssueInstitutionRefNum"}, {"key": "Batch.Report.PaymentInstrument[].InstrumentIssueInstitutionName", "displayName": "Batch.Report.PaymentInstrument[].InstrumentIssueInstitutionName"}, {"key": "Batch.Report.PaymentInstrument[].InstrumentHolderName", "displayName": "Batch.Report.PaymentInstrument[].InstrumentHolderName"}, {"key": "Batch.Report.PaymentInstrument[].RelationshipBeginningDate", "displayName": "Batch.Report.PaymentInstrument[].RelationshipBeginningDate"}, {"key": "Batch.Report.PaymentInstrument[].CumulativePurchaseTurnover", "displayName": "Batch.Report.PaymentInstrument[].CumulativePurchaseTurnover"}, {"key": "Batch.Report.PaymentInstrument[].Remarks", "displayName": "Batch.Report.PaymentInstrument[].Remarks"}, {"key": "Batch.Report.RelatedPersons[].PersonName", "displayName": "Batch.Report.RelatedPersons[].PersonName"}, {"key": "Batch.Report.RelatedPersons[].CustomerID", "displayName": "Batch.Report.RelatedPersons[].CustomerID"}, {"key": "Batch.Report.RelatedPersons[].RelationFlag", "displayName": "Batch.Report.RelatedPersons[].RelationFlag"}, {"key": "Batch.Report.RelatedPersons[].PAN", "displayName": "Batch.Report.RelatedPersons[].PAN"}, {"key": "Batch.Report.RelatedPersons[].UIN", "displayName": "Batch.Report.RelatedPersons[].UIN"}, {"key": "Batch.Report.RelatedPersons[].Choice", "displayName": "Batch.Report.RelatedPersons[].Choice"}, {"key": "Batch.Report.RelatedPersons[].Individual.Gender", "displayName": "Batch.Report.RelatedPersons[].Individual.Gender"}, {"key": "Batch.Report.RelatedPersons[].Individual.DateOfBirth", "displayName": "Batch.Report.RelatedPersons[].Individual.DateOfBirth"}, {"key": "Batch.Report.RelatedPersons[].Individual.IdentificationType", "displayName": "Batch.Report.RelatedPersons[].Individual.IdentificationType"}, {"key": "Batch.Report.RelatedPersons[].Individual.IdentificationNumber", "displayName": "Batch.Report.RelatedPersons[].Individual.IdentificationNumber"}, {"key": "Batch.Report.RelatedPersons[].Individual.IssuingAuthority", "displayName": "Batch.Report.RelatedPersons[].Individual.IssuingAuthority"}, {"key": "Batch.Report.RelatedPersons[].Individual.PlaceOfIssue", "displayName": "Batch.Report.RelatedPersons[].Individual.PlaceOfIssue"}, {"key": "Batch.Report.RelatedPersons[].Individual.Nationality", "displayName": "Batch.Report.RelatedPersons[].Individual.Nationality"}, {"key": "Batch.Report.RelatedPersons[].Individual.PlaceOfWork", "displayName": "Batch.Report.RelatedPersons[].Individual.PlaceOfWork"}, {"key": "Batch.Report.RelatedPersons[].Individual.FatherOrSpouse", "displayName": "Batch.Report.RelatedPersons[].Individual.FatherOrSpouse"}, {"key": "Batch.Report.RelatedPersons[].Individual.Occupation", "displayName": "Batch.Report.RelatedPersons[].Individual.Occupation"}, {"key": "Batch.Report.RelatedPersons[].LegalPerson.ConstitutionType", "displayName": "Batch.Report.RelatedPersons[].LegalPerson.ConstitutionType"}, {"key": "Batch.Report.RelatedPersons[].LegalPerson.RegistrationNumber", "displayName": "Batch.Report.RelatedPersons[].LegalPerson.RegistrationNumber"}, {"key": "Batch.Report.RelatedPersons[].LegalPerson.DateOfIncorporation", "displayName": "Batch.Report.RelatedPersons[].LegalPerson.DateOfIncorporation"}, {"key": "Batch.Report.RelatedPersons[].LegalPerson.PlaceOfRegistration", "displayName": "Batch.Report.RelatedPersons[].LegalPerson.PlaceOfRegistration"}, {"key": "Batch.Report.RelatedPersons[].LegalPerson.CountryCode", "displayName": "Batch.Report.RelatedPersons[].LegalPerson.CountryCode"}, {"key": "Batch.Report.RelatedPersons[].LegalPerson.NatureOfBusiness", "displayName": "Batch.Report.RelatedPersons[].LegalPerson.NatureOfBusiness"}, {"key": "Batch.Report.RelatedPersons[].CommunicationAddress.Address", "displayName": "Batch.Report.RelatedPersons[].CommunicationAddress.Address"}, {"key": "Batch.Report.RelatedPersons[].CommunicationAddress.City", "displayName": "Batch.Report.RelatedPersons[].CommunicationAddress.City"}, {"key": "Batch.Report.RelatedPersons[].CommunicationAddress.StateCode", "displayName": "Batch.Report.RelatedPersons[].CommunicationAddress.StateCode"}, {"key": "Batch.Report.RelatedPersons[].CommunicationAddress.PinCode", "displayName": "Batch.Report.RelatedPersons[].CommunicationAddress.PinCode"}, {"key": "Batch.Report.RelatedPersons[].CommunicationAddress.CountryCode", "displayName": "Batch.Report.RelatedPersons[].CommunicationAddress.CountryCode"}, {"key": "Batch.Report.RelatedPersons[].Phone.Telephone", "displayName": "Batch.Report.RelatedPersons[].Phone.Telephone"}, {"key": "Batch.Report.RelatedPersons[].Phone.Mobile", "displayName": "Batch.Report.RelatedPersons[].Phone.Mobile"}, {"key": "Batch.Report.RelatedPersons[].Phone.Fax", "displayName": "Batch.Report.RelatedPersons[].Phone.Fax"}, {"key": "Batch.Report.RelatedPersons[].Email", "displayName": "Batch.Report.RelatedPersons[].Email"}, {"key": "Batch.Report.RelatedPersons[].SecondAddress.Address", "displayName": "Batch.Report.RelatedPersons[].SecondAddress.Address"}, {"key": "Batch.Report.RelatedPersons[].SecondAddress.City", "displayName": "Batch.Report.RelatedPersons[].SecondAddress.City"}, {"key": "Batch.Report.RelatedPersons[].SecondAddress.StateCode", "displayName": "Batch.Report.RelatedPersons[].SecondAddress.StateCode"}, {"key": "Batch.Report.RelatedPersons[].SecondAddress.PinCode", "displayName": "Batch.Report.RelatedPersons[].SecondAddress.PinCode"}, {"key": "Batch.Report.RelatedPersons[].SecondAddress.CountryCode", "displayName": "Batch.Report.RelatedPersons[].SecondAddress.CountryCode"}, {"key": "Batch.ReportType", "displayName": "Batch.ReportType"}, {"key": "Batch.ReportFormatType", "displayName": "Batch.ReportFormatType"}, {"key": "Batch.BatchHeader.DataStructureVersion", "displayName": "Batch.BatchHeader.DataStructureVersion"}, {"key": "Batch.BatchHeader.GenerationUtilityVersion", "displayName": "Batch.BatchHeader.GenerationUtilityVersion"}, {"key": "Batch.BatchHeader.DataSource", "displayName": "Batch.BatchHeader.DataSource"}, {"key": "Batch.ReportingEntity.ReportingEntityName", "displayName": "Batch.ReportingEntity.ReportingEntityName"}, {"key": "Batch.ReportingEntity.ReportingEntityCategory", "displayName": "Batch.ReportingEntity.ReportingEntityCategory"}, {"key": "Batch.ReportingEntity.RERegistrationNum", "displayName": "Batch.ReportingEntity.RERegistrationNum"}, {"key": "Batch.ReportingEntity.FIUREID", "displayName": "Batch.ReportingEntity.FIUREID"}, {"key": "Batch.PrincipalOfficer.POName", "displayName": "Batch.PrincipalOfficer.POName"}, {"key": "Batch.PrincipalOfficer.PODesignation", "displayName": "Batch.PrincipalOfficer.PODesignation"}, {"key": "Batch.PrincipalOfficer.POEmail", "displayName": "Batch.PrincipalOfficer.POEmail"}, {"key": "Batch.PrincipalOfficer.POAddress.Address", "displayName": "Batch.PrincipalOfficer.POAddress.Address"}, {"key": "Batch.PrincipalOfficer.POAddress.City", "displayName": "Batch.PrincipalOfficer.POAddress.City"}, {"key": "Batch.PrincipalOfficer.POAddress.StateCode", "displayName": "Batch.PrincipalOfficer.POAddress.StateCode"}, {"key": "Batch.PrincipalOfficer.POAddress.PinCode", "displayName": "Batch.PrincipalOfficer.POAddress.PinCode"}, {"key": "Batch.PrincipalOfficer.POAddress.CountryCode", "displayName": "Batch.PrincipalOfficer.POAddress.CountryCode"}, {"key": "Batch.PrincipalOfficer.POPhone.Telephone", "displayName": "Batch.PrincipalOfficer.POPhone.Telephone"}, {"key": "Batch.PrincipalOfficer.POPhone.Mobile", "displayName": "Batch.PrincipalOfficer.POPhone.Mobile"}, {"key": "Batch.PrincipalOfficer.POPhone.Fax", "displayName": "Batch.PrincipalOfficer.POPhone.Fax"}, {"key": "Batch.BatchDetails.BatchNumber", "displayName": "Batch.BatchDetails.BatchNumber"}, {"key": "Batch.BatchDetails.BatchDate", "displayName": "Batch.BatchDetails.BatchDate"}, {"key": "Batch.BatchDetails.MonthOfReport", "displayName": "Batch.BatchDetails.MonthOfReport"}, {"key": "Batch.BatchDetails.YearOfReport", "displayName": "Batch.BatchDetails.YearOfReport"}, {"key": "Batch.BatchDetails.OperationalMode", "displayName": "Batch.BatchDetails.OperationalMode"}, {"key": "Batch.BatchDetails.BatchType", "displayName": "Batch.BatchDetails.BatchType"}, {"key": "Batch.BatchDetails.OriginalBatchID", "displayName": "Batch.BatchDetails.OriginalBatchID"}, {"key": "Batch.BatchDetails.ReasonOfRevision", "displayName": "Batch.BatchDetails.ReasonOfRevision"}, {"key": "Batch.BatchDetails.PKICertificateNum", "displayName": "Batch.BatchDetails.PKICertificateNum"}, {"key": "Batch.Report.ReportSerialNum", "displayName": "Batch.Report.ReportSerialNum"}, {"key": "Batch.Report.OriginalReportSerialNum", "displayName": "Batch.Report.OriginalReportSerialNum"}, {"key": "Batch.Report.MainPersonName", "displayName": "Batch.Report.MainPersonName"}, {"key": "Batch.Report.SuspicionDetails.SourceOfAlert", "displayName": "Batch.Report.SuspicionDetails.SourceOfAlert"}, {"key": "Batch.Report.SuspicionDetails.AlertIndicator[]", "displayName": "Batch.Report.SuspicionDetails.AlertIndicator[]"}, {"key": "Batch.Report.SuspicionDetails.SuspicionDueToProceedsOfCrime", "displayName": "Batch.Report.SuspicionDetails.SuspicionDueToProceedsOfCrime"}, {"key": "Batch.Report.SuspicionDetails.SuspicionDueToComplexTrans", "displayName": "Batch.Report.SuspicionDetails.SuspicionDueToComplexTrans"}, {"key": "Batch.Report.SuspicionDetails.SuspicionDueToNoEcoRationale", "displayName": "Batch.Report.SuspicionDetails.SuspicionDueToNoEcoRationale"}, {"key": "Batch.Report.SuspicionDetails.SuspicionOfFinancingOfTerrorism", "displayName": "Batch.Report.SuspicionDetails.SuspicionOfFinancingOfTerrorism"}, {"key": "Batch.Report.SuspicionDetails.AttemptedTransaction", "displayName": "Batch.Report.SuspicionDetails.AttemptedTransaction"}, {"key": "Batch.Report.SuspicionDetails.GroundsOfSuspicion", "displayName": "Batch.Report.SuspicionDetails.GroundsOfSuspicion"}, {"key": "Batch.Report.SuspicionDetails.DetailsOfInvestigation", "displayName": "Batch.Report.SuspicionDetails.DetailsOfInvestigation"}, {"key": "Batch.Report.SuspicionDetails.LEAInformed", "displayName": "Batch.Report.SuspicionDetails.LEAInformed"}, {"key": "Batch.Report.SuspicionDetails.LEADetails", "displayName": "Batch.Report.SuspicionDetails.LEADetails"}, {"key": "Batch.Report.SuspicionDetails.PriorityRating", "displayName": "Batch.Report.SuspicionDetails.PriorityRating"}, {"key": "Batch.Report.SuspicionDetails.ReportCoverage", "displayName": "Batch.Report.SuspicionDetails.ReportCoverage"}, {"key": "Batch.Report.SuspicionDetails.AdditionalDocuments", "displayName": "Batch.Report.SuspicionDetails.AdditionalDocuments"}, {"key": "Batch.Report.Transaction[].TrasnactionDate", "displayName": "Batch.Report.Transaction[].TrasnactionDate"}, {"key": "Batch.Report.Transaction[].TrasnactionTime", "displayName": "Batch.Report.Transaction[].TrasnactionTime"}, {"key": "Batch.Report.Transaction[].TransactionRefNum", "displayName": "Batch.Report.Transaction[].TransactionRefNum"}, {"key": "Batch.Report.Transaction[].TransactionType", "displayName": "Batch.Report.Transaction[].TransactionType"}, {"key": "Batch.Report.Transaction[].InstrumentType", "displayName": "Batch.Report.Transaction[].InstrumentType"}, {"key": "Batch.Report.Transaction[].TransactionInstitutionName", "displayName": "Batch.Report.Transaction[].TransactionInstitutionName"}, {"key": "Batch.Report.Transaction[].TransactionInstitutionRefNum", "displayName": "Batch.Report.Transaction[].TransactionInstitutionRefNum"}, {"key": "Batch.Report.Transaction[].TransactionStateCode", "displayName": "Batch.Report.Transaction[].TransactionStateCode"}, {"key": "Batch.Report.Transaction[].TransactionCountryCode", "displayName": "Batch.Report.Transaction[].TransactionCountryCode"}, {"key": "Batch.Report.Transaction[].PaymentInstrumentNum", "displayName": "Batch.Report.Transaction[].PaymentInstrumentNum"}, {"key": "Batch.Report.Transaction[].PaymentInstrumentIssueInstitutionName", "displayName": "Batch.Report.Transaction[].PaymentInstrumentIssueInstitutionName"}, {"key": "Batch.Report.Transaction[].InstrumentIssueInstitutionRefNum", "displayName": "Batch.Report.Transaction[].InstrumentIssueInstitutionRefNum"}, {"key": "Batch.Report.Transaction[].InstrumentCountryCode", "displayName": "Batch.Report.Transaction[].InstrumentCountryCode"}, {"key": "Batch.Report.Transaction[].AmountRupees", "displayName": "Batch.Report.Transaction[].AmountRupees"}, {"key": "Batch.Report.Transaction[].AmountForeignCurrency", "displayName": "Batch.Report.Transaction[].AmountForeignCurrency"}, {"key": "Batch.Report.Transaction[].CurrencyOfTransaction", "displayName": "Batch.Report.Transaction[].CurrencyOfTransaction"}, {"key": "Batch.Report.Transaction[].PurposeOfTransaction", "displayName": "Batch.Report.Transaction[].PurposeOfTransaction"}, {"key": "Batch.Report.Transaction[].PurposeCode", "displayName": "Batch.Report.Transaction[].PurposeCode"}, {"key": "Batch.Report.Transaction[].RiskRating", "displayName": "Batch.Report.Transaction[].RiskRating"}, {"key": "Batch.Report.Transaction[].AccountNumber", "displayName": "Batch.Report.Transaction[].AccountNumber"}, {"key": "Batch.Report.Transaction[].AccountWithInstitutionName", "displayName": "Batch.Report.Transaction[].AccountWithInstitutionName"}, {"key": "Batch.Report.Transaction[].AccountWithInstitutionRefNum", "displayName": "Batch.Report.Transaction[].AccountWithInstitutionRefNum"}, {"key": "Batch.Report.Transaction[].RelatedInstitutionName", "displayName": "Batch.Report.Transaction[].RelatedInstitutionName"}, {"key": "Batch.Report.Transaction[].InstitutionRelationFlag", "displayName": "Batch.Report.Transaction[].InstitutionRelationFlag"}, {"key": "Batch.Report.Transaction[].RelatedInstitutionRefNum", "displayName": "Batch.Report.Transaction[].RelatedInstitutionRefNum"}, {"key": "Batch.Report.Transaction[].Remarks", "displayName": "Batch.Report.Transaction[].Remarks"}, {"key": "Batch.Report.Transaction[].CustomerDetails.CustomerName", "displayName": "Batch.Report.Transaction[].CustomerDetails.CustomerName"}, {"key": "Batch.Report.Transaction[].CustomerDetails.CustomerId", "displayName": "Batch.Report.Transaction[].CustomerDetails.CustomerId"}, {"key": "Batch.Report.Transaction[].CustomerDetails.Occupation", "displayName": "Batch.Report.Transaction[].CustomerDetails.Occupation"}, {"key": "Batch.Report.Transaction[].CustomerDetails.DateOfBirth", "displayName": "Batch.Report.Transaction[].CustomerDetails.DateOfBirth"}, {"key": "Batch.Report.Transaction[].CustomerDetails.Gender", "displayName": "Batch.Report.Transaction[].CustomerDetails.Gender"}, {"key": "Batch.Report.Transaction[].CustomerDetails.Nationality", "displayName": "Batch.Report.Transaction[].CustomerDetails.Nationality"}, {"key": "Batch.Report.Transaction[].CustomerDetails.IdentificationType", "displayName": "Batch.Report.Transaction[].CustomerDetails.IdentificationType"}, {"key": "Batch.Report.Transaction[].CustomerDetails.IdentificationNumber", "displayName": "Batch.Report.Transaction[].CustomerDetails.IdentificationNumber"}, {"key": "Batch.Report.Transaction[].CustomerDetails.IssuingAuthority", "displayName": "Batch.Report.Transaction[].CustomerDetails.IssuingAuthority"}, {"key": "Batch.Report.Transaction[].CustomerDetails.PlaceOfIssue", "displayName": "Batch.Report.Transaction[].CustomerDetails.PlaceOfIssue"}, {"key": "Batch.Report.Transaction[].CustomerDetails.PAN", "displayName": "Batch.Report.Transaction[].CustomerDetails.PAN"}, {"key": "Batch.Report.Transaction[].CustomerDetails.UIN", "displayName": "Batch.Report.Transaction[].CustomerDetails.UIN"}, {"key": "Batch.Report.Transaction[].CustomerDetails.Email", "displayName": "Batch.Report.Transaction[].CustomerDetails.Email"}, {"key": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.Address", "displayName": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.Address"}, {"key": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.City", "displayName": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.City"}, {"key": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.StateCode", "displayName": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.StateCode"}, {"key": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.PinCode", "displayName": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.PinCode"}, {"key": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.CountryCode", "displayName": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.CountryCode"}, {"key": "Batch.Report.Transaction[].CustomerDetails.Phone.Telephone", "displayName": "Batch.Report.Transaction[].CustomerDetails.Phone.Telephone"}, {"key": "Batch.Report.Transaction[].CustomerDetails.Phone.Mobile", "displayName": "Batch.Report.Transaction[].CustomerDetails.Phone.Mobile"}, {"key": "Batch.Report.Transaction[].CustomerDetails.Phone.Fax", "displayName": "Batch.Report.Transaction[].CustomerDetails.Phone.Fax"}, {"key": "Batch.Report.Branch.InstitutionName", "displayName": "Batch.Report.Branch.InstitutionName"}, {"key": "Batch.Report.Branch.InstitutionBranchName", "displayName": "Batch.Report.Branch.InstitutionBranchName"}, {"key": "Batch.Report.Branch.InstitutionRefNum", "displayName": "Batch.Report.Branch.InstitutionRefNum"}, {"key": "Batch.Report.Branch.ReportingRole", "displayName": "Batch.Report.Branch.ReportingRole"}, {"key": "Batch.Report.Branch.BIC", "displayName": "Batch.Report.Branch.BIC"}, {"key": "Batch.Report.Branch.BranchAddress.Address", "displayName": "Batch.Report.Branch.BranchAddress.Address"}, {"key": "Batch.Report.Branch.BranchAddress.City", "displayName": "Batch.Report.Branch.BranchAddress.City"}, {"key": "Batch.Report.Branch.BranchAddress.StateCode", "displayName": "Batch.Report.Branch.BranchAddress.StateCode"}, {"key": "Batch.Report.Branch.BranchAddress.PinCode", "displayName": "Batch.Report.Branch.BranchAddress.PinCode"}, {"key": "Batch.Report.Branch.BranchAddress.CountryCode", "displayName": "Batch.Report.Branch.BranchAddress.CountryCode"}, {"key": "Batch.Report.Branch.Phone.Telephone", "displayName": "Batch.Report.Branch.Phone.Telephone"}, {"key": "Batch.Report.Branch.Phone.Mobile", "displayName": "Batch.Report.Branch.Phone.Mobile"}, {"key": "Batch.Report.Branch.Phone.Fax", "displayName": "Batch.Report.Branch.Phone.Fax"}, {"key": "Batch.Report.Branch.Email", "displayName": "Batch.Report.Branch.Email"}, {"key": "Batch.Report.Branch.Remarks", "displayName": "Batch.Report.Branch.Remarks"}, {"key": "Batch.Report.PaymentInstrument[].InstrumentRefNum", "displayName": "Batch.Report.PaymentInstrument[].InstrumentRefNum"}, {"key": "Batch.Report.PaymentInstrument[].IssueInstitutionRefNum", "displayName": "Batch.Report.PaymentInstrument[].IssueInstitutionRefNum"}, {"key": "Batch.Report.PaymentInstrument[].InstrumentIssueInstitutionName", "displayName": "Batch.Report.PaymentInstrument[].InstrumentIssueInstitutionName"}, {"key": "Batch.Report.PaymentInstrument[].InstrumentHolderName", "displayName": "Batch.Report.PaymentInstrument[].InstrumentHolderName"}, {"key": "Batch.Report.PaymentInstrument[].RelationshipBeginningDate", "displayName": "Batch.Report.PaymentInstrument[].RelationshipBeginningDate"}, {"key": "Batch.Report.PaymentInstrument[].CumulativePurchaseTurnover", "displayName": "Batch.Report.PaymentInstrument[].CumulativePurchaseTurnover"}, {"key": "Batch.Report.PaymentInstrument[].Remarks", "displayName": "Batch.Report.PaymentInstrument[].Remarks"}, {"key": "Batch.Report.RelatedPersons[].PersonName", "displayName": "Batch.Report.RelatedPersons[].PersonName"}, {"key": "Batch.Report.RelatedPersons[].CustomerID", "displayName": "Batch.Report.RelatedPersons[].CustomerID"}, {"key": "Batch.Report.RelatedPersons[].RelationFlag", "displayName": "Batch.Report.RelatedPersons[].RelationFlag"}, {"key": "Batch.Report.RelatedPersons[].PAN", "displayName": "Batch.Report.RelatedPersons[].PAN"}, {"key": "Batch.Report.RelatedPersons[].UIN", "displayName": "Batch.Report.RelatedPersons[].UIN"}, {"key": "Batch.Report.RelatedPersons[].Choice", "displayName": "Batch.Report.RelatedPersons[].Choice"}, {"key": "Batch.Report.RelatedPersons[].Individual.Gender", "displayName": "Batch.Report.RelatedPersons[].Individual.Gender"}, {"key": "Batch.Report.RelatedPersons[].Individual.DateOfBirth", "displayName": "Batch.Report.RelatedPersons[].Individual.DateOfBirth"}, {"key": "Batch.Report.RelatedPersons[].Individual.IdentificationType", "displayName": "Batch.Report.RelatedPersons[].Individual.IdentificationType"}, {"key": "Batch.Report.RelatedPersons[].Individual.IdentificationNumber", "displayName": "Batch.Report.RelatedPersons[].Individual.IdentificationNumber"}, {"key": "Batch.Report.RelatedPersons[].Individual.IssuingAuthority", "displayName": "Batch.Report.RelatedPersons[].Individual.IssuingAuthority"}, {"key": "Batch.Report.RelatedPersons[].Individual.PlaceOfIssue", "displayName": "Batch.Report.RelatedPersons[].Individual.PlaceOfIssue"}, {"key": "Batch.Report.RelatedPersons[].Individual.Nationality", "displayName": "Batch.Report.RelatedPersons[].Individual.Nationality"}, {"key": "Batch.Report.RelatedPersons[].Individual.PlaceOfWork", "displayName": "Batch.Report.RelatedPersons[].Individual.PlaceOfWork"}, {"key": "Batch.Report.RelatedPersons[].Individual.FatherOrSpouse", "displayName": "Batch.Report.RelatedPersons[].Individual.FatherOrSpouse"}, {"key": "Batch.Report.RelatedPersons[].Individual.Occupation", "displayName": "Batch.Report.RelatedPersons[].Individual.Occupation"}, {"key": "Batch.Report.RelatedPersons[].LegalPerson.ConstitutionType", "displayName": "Batch.Report.RelatedPersons[].LegalPerson.ConstitutionType"}, {"key": "Batch.Report.RelatedPersons[].LegalPerson.RegistrationNumber", "displayName": "Batch.Report.RelatedPersons[].LegalPerson.RegistrationNumber"}, {"key": "Batch.Report.RelatedPersons[].LegalPerson.DateOfIncorporation", "displayName": "Batch.Report.RelatedPersons[].LegalPerson.DateOfIncorporation"}, {"key": "Batch.Report.RelatedPersons[].LegalPerson.PlaceOfRegistration", "displayName": "Batch.Report.RelatedPersons[].LegalPerson.PlaceOfRegistration"}, {"key": "Batch.Report.RelatedPersons[].LegalPerson.CountryCode", "displayName": "Batch.Report.RelatedPersons[].LegalPerson.CountryCode"}, {"key": "Batch.Report.RelatedPersons[].LegalPerson.NatureOfBusiness", "displayName": "Batch.Report.RelatedPersons[].LegalPerson.NatureOfBusiness"}, {"key": "Batch.Report.RelatedPersons[].CommunicationAddress.Address", "displayName": "Batch.Report.RelatedPersons[].CommunicationAddress.Address"}, {"key": "Batch.Report.RelatedPersons[].CommunicationAddress.City", "displayName": "Batch.Report.RelatedPersons[].CommunicationAddress.City"}, {"key": "Batch.Report.RelatedPersons[].CommunicationAddress.StateCode", "displayName": "Batch.Report.RelatedPersons[].CommunicationAddress.StateCode"}, {"key": "Batch.Report.RelatedPersons[].CommunicationAddress.PinCode", "displayName": "Batch.Report.RelatedPersons[].CommunicationAddress.PinCode"}, {"key": "Batch.Report.RelatedPersons[].CommunicationAddress.CountryCode", "displayName": "Batch.Report.RelatedPersons[].CommunicationAddress.CountryCode"}, {"key": "Batch.Report.RelatedPersons[].Phone.Telephone", "displayName": "Batch.Report.RelatedPersons[].Phone.Telephone"}, {"key": "Batch.Report.RelatedPersons[].Phone.Mobile", "displayName": "Batch.Report.RelatedPersons[].Phone.Mobile"}, {"key": "Batch.Report.RelatedPersons[].Phone.Fax", "displayName": "Batch.Report.RelatedPersons[].Phone.Fax"}, {"key": "Batch.Report.RelatedPersons[].Email", "displayName": "Batch.Report.RelatedPersons[].Email"}, {"key": "Batch.Report.RelatedPersons[].SecondAddress.Address", "displayName": "Batch.Report.RelatedPersons[].SecondAddress.Address"}, {"key": "Batch.Report.RelatedPersons[].SecondAddress.City", "displayName": "Batch.Report.RelatedPersons[].SecondAddress.City"}, {"key": "Batch.Report.RelatedPersons[].SecondAddress.StateCode", "displayName": "Batch.Report.RelatedPersons[].SecondAddress.StateCode"}, {"key": "Batch.Report.RelatedPersons[].SecondAddress.PinCode", "displayName": "Batch.Report.RelatedPersons[].SecondAddress.PinCode"}, {"key": "Batch.Report.RelatedPersons[].SecondAddress.CountryCode", "displayName": "Batch.Report.RelatedPersons[].SecondAddress.CountryCode"}, {"key": "Batch.ReportType", "displayName": "Batch.ReportType"}, {"key": "Batch.ReportFormatType", "displayName": "Batch.ReportFormatType"}, {"key": "Batch.BatchHeader.DataStructureVersion", "displayName": "Batch.BatchHeader.DataStructureVersion"}, {"key": "Batch.BatchHeader.GenerationUtilityVersion", "displayName": "Batch.BatchHeader.GenerationUtilityVersion"}, {"key": "Batch.BatchHeader.DataSource", "displayName": "Batch.BatchHeader.DataSource"}, {"key": "Batch.ReportingEntity.ReportingEntityName", "displayName": "Batch.ReportingEntity.ReportingEntityName"}, {"key": "Batch.ReportingEntity.ReportingEntityCategory", "displayName": "Batch.ReportingEntity.ReportingEntityCategory"}, {"key": "Batch.ReportingEntity.RERegistrationNum", "displayName": "Batch.ReportingEntity.RERegistrationNum"}, {"key": "Batch.ReportingEntity.FIUREID", "displayName": "Batch.ReportingEntity.FIUREID"}, {"key": "Batch.PrincipalOfficer.POName", "displayName": "Batch.PrincipalOfficer.POName"}, {"key": "Batch.PrincipalOfficer.PODesignation", "displayName": "Batch.PrincipalOfficer.PODesignation"}, {"key": "Batch.PrincipalOfficer.POEmail", "displayName": "Batch.PrincipalOfficer.POEmail"}, {"key": "Batch.PrincipalOfficer.POAddress.Address", "displayName": "Batch.PrincipalOfficer.POAddress.Address"}, {"key": "Batch.PrincipalOfficer.POAddress.City", "displayName": "Batch.PrincipalOfficer.POAddress.City"}, {"key": "Batch.PrincipalOfficer.POAddress.StateCode", "displayName": "Batch.PrincipalOfficer.POAddress.StateCode"}, {"key": "Batch.PrincipalOfficer.POAddress.PinCode", "displayName": "Batch.PrincipalOfficer.POAddress.PinCode"}, {"key": "Batch.PrincipalOfficer.POAddress.CountryCode", "displayName": "Batch.PrincipalOfficer.POAddress.CountryCode"}, {"key": "Batch.PrincipalOfficer.POPhone.Telephone", "displayName": "Batch.PrincipalOfficer.POPhone.Telephone"}, {"key": "Batch.PrincipalOfficer.POPhone.Mobile", "displayName": "Batch.PrincipalOfficer.POPhone.Mobile"}, {"key": "Batch.PrincipalOfficer.POPhone.Fax", "displayName": "Batch.PrincipalOfficer.POPhone.Fax"}, {"key": "Batch.BatchDetails.BatchNumber", "displayName": "Batch.BatchDetails.BatchNumber"}, {"key": "Batch.BatchDetails.BatchDate", "displayName": "Batch.BatchDetails.BatchDate"}, {"key": "Batch.BatchDetails.MonthOfReport", "displayName": "Batch.BatchDetails.MonthOfReport"}, {"key": "Batch.BatchDetails.YearOfReport", "displayName": "Batch.BatchDetails.YearOfReport"}, {"key": "Batch.BatchDetails.OperationalMode", "displayName": "Batch.BatchDetails.OperationalMode"}, {"key": "Batch.BatchDetails.BatchType", "displayName": "Batch.BatchDetails.BatchType"}, {"key": "Batch.BatchDetails.OriginalBatchID", "displayName": "Batch.BatchDetails.OriginalBatchID"}, {"key": "Batch.BatchDetails.ReasonOfRevision", "displayName": "Batch.BatchDetails.ReasonOfRevision"}, {"key": "Batch.BatchDetails.PKICertificateNum", "displayName": "Batch.BatchDetails.PKICertificateNum"}, {"key": "Batch.Report.ReportSerialNum", "displayName": "Batch.Report.ReportSerialNum"}, {"key": "Batch.Report.OriginalReportSerialNum", "displayName": "Batch.Report.OriginalReportSerialNum"}, {"key": "Batch.Report.MainPersonName", "displayName": "Batch.Report.MainPersonName"}, {"key": "Batch.Report.SuspicionDetails.SourceOfAlert", "displayName": "Batch.Report.SuspicionDetails.SourceOfAlert"}, {"key": "Batch.Report.SuspicionDetails.AlertIndicator[]", "displayName": "Batch.Report.SuspicionDetails.AlertIndicator[]"}, {"key": "Batch.Report.SuspicionDetails.SuspicionDueToProceedsOfCrime", "displayName": "Batch.Report.SuspicionDetails.SuspicionDueToProceedsOfCrime"}, {"key": "Batch.Report.SuspicionDetails.SuspicionDueToComplexTrans", "displayName": "Batch.Report.SuspicionDetails.SuspicionDueToComplexTrans"}, {"key": "Batch.Report.SuspicionDetails.SuspicionDueToNoEcoRationale", "displayName": "Batch.Report.SuspicionDetails.SuspicionDueToNoEcoRationale"}, {"key": "Batch.Report.SuspicionDetails.SuspicionOfFinancingOfTerrorism", "displayName": "Batch.Report.SuspicionDetails.SuspicionOfFinancingOfTerrorism"}, {"key": "Batch.Report.SuspicionDetails.AttemptedTransaction", "displayName": "Batch.Report.SuspicionDetails.AttemptedTransaction"}, {"key": "Batch.Report.SuspicionDetails.GroundsOfSuspicion", "displayName": "Batch.Report.SuspicionDetails.GroundsOfSuspicion"}, {"key": "Batch.Report.SuspicionDetails.DetailsOfInvestigation", "displayName": "Batch.Report.SuspicionDetails.DetailsOfInvestigation"}, {"key": "Batch.Report.SuspicionDetails.LEAInformed", "displayName": "Batch.Report.SuspicionDetails.LEAInformed"}, {"key": "Batch.Report.SuspicionDetails.LEADetails", "displayName": "Batch.Report.SuspicionDetails.LEADetails"}, {"key": "Batch.Report.SuspicionDetails.PriorityRating", "displayName": "Batch.Report.SuspicionDetails.PriorityRating"}, {"key": "Batch.Report.SuspicionDetails.ReportCoverage", "displayName": "Batch.Report.SuspicionDetails.ReportCoverage"}, {"key": "Batch.Report.SuspicionDetails.AdditionalDocuments", "displayName": "Batch.Report.SuspicionDetails.AdditionalDocuments"}, {"key": "Batch.Report.Transaction[].TrasnactionDate", "displayName": "Batch.Report.Transaction[].TrasnactionDate"}, {"key": "Batch.Report.Transaction[].TrasnactionTime", "displayName": "Batch.Report.Transaction[].TrasnactionTime"}, {"key": "Batch.Report.Transaction[].TransactionRefNum", "displayName": "Batch.Report.Transaction[].TransactionRefNum"}, {"key": "Batch.Report.Transaction[].TransactionType", "displayName": "Batch.Report.Transaction[].TransactionType"}, {"key": "Batch.Report.Transaction[].InstrumentType", "displayName": "Batch.Report.Transaction[].InstrumentType"}, {"key": "Batch.Report.Transaction[].TransactionInstitutionName", "displayName": "Batch.Report.Transaction[].TransactionInstitutionName"}, {"key": "Batch.Report.Transaction[].TransactionInstitutionRefNum", "displayName": "Batch.Report.Transaction[].TransactionInstitutionRefNum"}, {"key": "Batch.Report.Transaction[].TransactionStateCode", "displayName": "Batch.Report.Transaction[].TransactionStateCode"}, {"key": "Batch.Report.Transaction[].TransactionCountryCode", "displayName": "Batch.Report.Transaction[].TransactionCountryCode"}, {"key": "Batch.Report.Transaction[].PaymentInstrumentNum", "displayName": "Batch.Report.Transaction[].PaymentInstrumentNum"}, {"key": "Batch.Report.Transaction[].PaymentInstrumentIssueInstitutionName", "displayName": "Batch.Report.Transaction[].PaymentInstrumentIssueInstitutionName"}, {"key": "Batch.Report.Transaction[].InstrumentIssueInstitutionRefNum", "displayName": "Batch.Report.Transaction[].InstrumentIssueInstitutionRefNum"}, {"key": "Batch.Report.Transaction[].InstrumentCountryCode", "displayName": "Batch.Report.Transaction[].InstrumentCountryCode"}, {"key": "Batch.Report.Transaction[].AmountRupees", "displayName": "Batch.Report.Transaction[].AmountRupees"}, {"key": "Batch.Report.Transaction[].AmountForeignCurrency", "displayName": "Batch.Report.Transaction[].AmountForeignCurrency"}, {"key": "Batch.Report.Transaction[].CurrencyOfTransaction", "displayName": "Batch.Report.Transaction[].CurrencyOfTransaction"}, {"key": "Batch.Report.Transaction[].PurposeOfTransaction", "displayName": "Batch.Report.Transaction[].PurposeOfTransaction"}, {"key": "Batch.Report.Transaction[].PurposeCode", "displayName": "Batch.Report.Transaction[].PurposeCode"}, {"key": "Batch.Report.Transaction[].RiskRating", "displayName": "Batch.Report.Transaction[].RiskRating"}, {"key": "Batch.Report.Transaction[].AccountNumber", "displayName": "Batch.Report.Transaction[].AccountNumber"}, {"key": "Batch.Report.Transaction[].AccountWithInstitutionName", "displayName": "Batch.Report.Transaction[].AccountWithInstitutionName"}, {"key": "Batch.Report.Transaction[].AccountWithInstitutionRefNum", "displayName": "Batch.Report.Transaction[].AccountWithInstitutionRefNum"}, {"key": "Batch.Report.Transaction[].RelatedInstitutionName", "displayName": "Batch.Report.Transaction[].RelatedInstitutionName"}, {"key": "Batch.Report.Transaction[].InstitutionRelationFlag", "displayName": "Batch.Report.Transaction[].InstitutionRelationFlag"}, {"key": "Batch.Report.Transaction[].RelatedInstitutionRefNum", "displayName": "Batch.Report.Transaction[].RelatedInstitutionRefNum"}, {"key": "Batch.Report.Transaction[].Remarks", "displayName": "Batch.Report.Transaction[].Remarks"}, {"key": "Batch.Report.Transaction[].CustomerDetails.CustomerName", "displayName": "Batch.Report.Transaction[].CustomerDetails.CustomerName"}, {"key": "Batch.Report.Transaction[].CustomerDetails.CustomerId", "displayName": "Batch.Report.Transaction[].CustomerDetails.CustomerId"}, {"key": "Batch.Report.Transaction[].CustomerDetails.Occupation", "displayName": "Batch.Report.Transaction[].CustomerDetails.Occupation"}, {"key": "Batch.Report.Transaction[].CustomerDetails.DateOfBirth", "displayName": "Batch.Report.Transaction[].CustomerDetails.DateOfBirth"}, {"key": "Batch.Report.Transaction[].CustomerDetails.Gender", "displayName": "Batch.Report.Transaction[].CustomerDetails.Gender"}, {"key": "Batch.Report.Transaction[].CustomerDetails.Nationality", "displayName": "Batch.Report.Transaction[].CustomerDetails.Nationality"}, {"key": "Batch.Report.Transaction[].CustomerDetails.IdentificationType", "displayName": "Batch.Report.Transaction[].CustomerDetails.IdentificationType"}, {"key": "Batch.Report.Transaction[].CustomerDetails.IdentificationNumber", "displayName": "Batch.Report.Transaction[].CustomerDetails.IdentificationNumber"}, {"key": "Batch.Report.Transaction[].CustomerDetails.IssuingAuthority", "displayName": "Batch.Report.Transaction[].CustomerDetails.IssuingAuthority"}, {"key": "Batch.Report.Transaction[].CustomerDetails.PlaceOfIssue", "displayName": "Batch.Report.Transaction[].CustomerDetails.PlaceOfIssue"}, {"key": "Batch.Report.Transaction[].CustomerDetails.PAN", "displayName": "Batch.Report.Transaction[].CustomerDetails.PAN"}, {"key": "Batch.Report.Transaction[].CustomerDetails.UIN", "displayName": "Batch.Report.Transaction[].CustomerDetails.UIN"}, {"key": "Batch.Report.Transaction[].CustomerDetails.Email", "displayName": "Batch.Report.Transaction[].CustomerDetails.Email"}, {"key": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.Address", "displayName": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.Address"}, {"key": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.City", "displayName": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.City"}, {"key": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.StateCode", "displayName": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.StateCode"}, {"key": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.PinCode", "displayName": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.PinCode"}, {"key": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.CountryCode", "displayName": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.CountryCode"}, {"key": "Batch.Report.Transaction[].CustomerDetails.Phone.Telephone", "displayName": "Batch.Report.Transaction[].CustomerDetails.Phone.Telephone"}, {"key": "Batch.Report.Transaction[].CustomerDetails.Phone.Mobile", "displayName": "Batch.Report.Transaction[].CustomerDetails.Phone.Mobile"}, {"key": "Batch.Report.Transaction[].CustomerDetails.Phone.Fax", "displayName": "Batch.Report.Transaction[].CustomerDetails.Phone.Fax"}, {"key": "Batch.Report.Branch.InstitutionName", "displayName": "Batch.Report.Branch.InstitutionName"}, {"key": "Batch.Report.Branch.InstitutionBranchName", "displayName": "Batch.Report.Branch.InstitutionBranchName"}, {"key": "Batch.Report.Branch.InstitutionRefNum", "displayName": "Batch.Report.Branch.InstitutionRefNum"}, {"key": "Batch.Report.Branch.ReportingRole", "displayName": "Batch.Report.Branch.ReportingRole"}, {"key": "Batch.Report.Branch.BIC", "displayName": "Batch.Report.Branch.BIC"}, {"key": "Batch.Report.Branch.BranchAddress.Address", "displayName": "Batch.Report.Branch.BranchAddress.Address"}, {"key": "Batch.Report.Branch.BranchAddress.City", "displayName": "Batch.Report.Branch.BranchAddress.City"}, {"key": "Batch.Report.Branch.BranchAddress.StateCode", "displayName": "Batch.Report.Branch.BranchAddress.StateCode"}, {"key": "Batch.Report.Branch.BranchAddress.PinCode", "displayName": "Batch.Report.Branch.BranchAddress.PinCode"}, {"key": "Batch.Report.Branch.BranchAddress.CountryCode", "displayName": "Batch.Report.Branch.BranchAddress.CountryCode"}, {"key": "Batch.Report.Branch.Phone.Telephone", "displayName": "Batch.Report.Branch.Phone.Telephone"}, {"key": "Batch.Report.Branch.Phone.Mobile", "displayName": "Batch.Report.Branch.Phone.Mobile"}, {"key": "Batch.Report.Branch.Phone.Fax", "displayName": "Batch.Report.Branch.Phone.Fax"}, {"key": "Batch.Report.Branch.Email", "displayName": "Batch.Report.Branch.Email"}, {"key": "Batch.Report.Branch.Remarks", "displayName": "Batch.Report.Branch.Remarks"}, {"key": "Batch.Report.PaymentInstrument[].InstrumentRefNum", "displayName": "Batch.Report.PaymentInstrument[].InstrumentRefNum"}, {"key": "Batch.Report.PaymentInstrument[].IssueInstitutionRefNum", "displayName": "Batch.Report.PaymentInstrument[].IssueInstitutionRefNum"}, {"key": "Batch.Report.PaymentInstrument[].InstrumentIssueInstitutionName", "displayName": "Batch.Report.PaymentInstrument[].InstrumentIssueInstitutionName"}, {"key": "Batch.Report.PaymentInstrument[].InstrumentHolderName", "displayName": "Batch.Report.PaymentInstrument[].InstrumentHolderName"}, {"key": "Batch.Report.PaymentInstrument[].RelationshipBeginningDate", "displayName": "Batch.Report.PaymentInstrument[].RelationshipBeginningDate"}, {"key": "Batch.Report.PaymentInstrument[].CumulativePurchaseTurnover", "displayName": "Batch.Report.PaymentInstrument[].CumulativePurchaseTurnover"}, {"key": "Batch.Report.PaymentInstrument[].Remarks", "displayName": "Batch.Report.PaymentInstrument[].Remarks"}, {"key": "Batch.Report.RelatedPersons[].PersonName", "displayName": "Batch.Report.RelatedPersons[].PersonName"}, {"key": "Batch.Report.RelatedPersons[].CustomerID", "displayName": "Batch.Report.RelatedPersons[].CustomerID"}, {"key": "Batch.Report.RelatedPersons[].RelationFlag", "displayName": "Batch.Report.RelatedPersons[].RelationFlag"}, {"key": "Batch.Report.RelatedPersons[].PAN", "displayName": "Batch.Report.RelatedPersons[].PAN"}, {"key": "Batch.Report.RelatedPersons[].UIN", "displayName": "Batch.Report.RelatedPersons[].UIN"}, {"key": "Batch.Report.RelatedPersons[].Choice", "displayName": "Batch.Report.RelatedPersons[].Choice"}, {"key": "Batch.Report.RelatedPersons[].Individual.Gender", "displayName": "Batch.Report.RelatedPersons[].Individual.Gender"}, {"key": "Batch.Report.RelatedPersons[].Individual.DateOfBirth", "displayName": "Batch.Report.RelatedPersons[].Individual.DateOfBirth"}, {"key": "Batch.Report.RelatedPersons[].Individual.IdentificationType", "displayName": "Batch.Report.RelatedPersons[].Individual.IdentificationType"}, {"key": "Batch.Report.RelatedPersons[].Individual.IdentificationNumber", "displayName": "Batch.Report.RelatedPersons[].Individual.IdentificationNumber"}, {"key": "Batch.Report.RelatedPersons[].Individual.IssuingAuthority", "displayName": "Batch.Report.RelatedPersons[].Individual.IssuingAuthority"}, {"key": "Batch.Report.RelatedPersons[].Individual.PlaceOfIssue", "displayName": "Batch.Report.RelatedPersons[].Individual.PlaceOfIssue"}, {"key": "Batch.Report.RelatedPersons[].Individual.Nationality", "displayName": "Batch.Report.RelatedPersons[].Individual.Nationality"}, {"key": "Batch.Report.RelatedPersons[].Individual.PlaceOfWork", "displayName": "Batch.Report.RelatedPersons[].Individual.PlaceOfWork"}, {"key": "Batch.Report.RelatedPersons[].Individual.FatherOrSpouse", "displayName": "Batch.Report.RelatedPersons[].Individual.FatherOrSpouse"}, {"key": "Batch.Report.RelatedPersons[].Individual.Occupation", "displayName": "Batch.Report.RelatedPersons[].Individual.Occupation"}, {"key": "Batch.Report.RelatedPersons[].LegalPerson.ConstitutionType", "displayName": "Batch.Report.RelatedPersons[].LegalPerson.ConstitutionType"}, {"key": "Batch.Report.RelatedPersons[].LegalPerson.RegistrationNumber", "displayName": "Batch.Report.RelatedPersons[].LegalPerson.RegistrationNumber"}, {"key": "Batch.Report.RelatedPersons[].LegalPerson.DateOfIncorporation", "displayName": "Batch.Report.RelatedPersons[].LegalPerson.DateOfIncorporation"}, {"key": "Batch.Report.RelatedPersons[].LegalPerson.PlaceOfRegistration", "displayName": "Batch.Report.RelatedPersons[].LegalPerson.PlaceOfRegistration"}, {"key": "Batch.Report.RelatedPersons[].LegalPerson.CountryCode", "displayName": "Batch.Report.RelatedPersons[].LegalPerson.CountryCode"}, {"key": "Batch.Report.RelatedPersons[].LegalPerson.NatureOfBusiness", "displayName": "Batch.Report.RelatedPersons[].LegalPerson.NatureOfBusiness"}, {"key": "Batch.Report.RelatedPersons[].CommunicationAddress.Address", "displayName": "Batch.Report.RelatedPersons[].CommunicationAddress.Address"}, {"key": "Batch.Report.RelatedPersons[].CommunicationAddress.City", "displayName": "Batch.Report.RelatedPersons[].CommunicationAddress.City"}, {"key": "Batch.Report.RelatedPersons[].CommunicationAddress.StateCode", "displayName": "Batch.Report.RelatedPersons[].CommunicationAddress.StateCode"}, {"key": "Batch.Report.RelatedPersons[].CommunicationAddress.PinCode", "displayName": "Batch.Report.RelatedPersons[].CommunicationAddress.PinCode"}, {"key": "Batch.Report.RelatedPersons[].CommunicationAddress.CountryCode", "displayName": "Batch.Report.RelatedPersons[].CommunicationAddress.CountryCode"}, {"key": "Batch.Report.RelatedPersons[].Phone.Telephone", "displayName": "Batch.Report.RelatedPersons[].Phone.Telephone"}, {"key": "Batch.Report.RelatedPersons[].Phone.Mobile", "displayName": "Batch.Report.RelatedPersons[].Phone.Mobile"}, {"key": "Batch.Report.RelatedPersons[].Phone.Fax", "displayName": "Batch.Report.RelatedPersons[].Phone.Fax"}, {"key": "Batch.Report.RelatedPersons[].Email", "displayName": "Batch.Report.RelatedPersons[].Email"}, {"key": "Batch.Report.RelatedPersons[].SecondAddress.Address", "displayName": "Batch.Report.RelatedPersons[].SecondAddress.Address"}, {"key": "Batch.Report.RelatedPersons[].SecondAddress.City", "displayName": "Batch.Report.RelatedPersons[].SecondAddress.City"}, {"key": "Batch.Report.RelatedPersons[].SecondAddress.StateCode", "displayName": "Batch.Report.RelatedPersons[].SecondAddress.StateCode"}, {"key": "Batch.Report.RelatedPersons[].SecondAddress.PinCode", "displayName": "Batch.Report.RelatedPersons[].SecondAddress.PinCode"}, {"key": "Batch.Report.RelatedPersons[].SecondAddress.CountryCode", "displayName": "Batch.Report.RelatedPersons[].SecondAddress.CountryCode"}, {"key": "Batch.ReportType", "displayName": "Batch.ReportType"}, {"key": "Batch.ReportFormatType", "displayName": "Batch.ReportFormatType"}, {"key": "Batch.BatchHeader.DataStructureVersion", "displayName": "Batch.BatchHeader.DataStructureVersion"}, {"key": "Batch.BatchHeader.GenerationUtilityVersion", "displayName": "Batch.BatchHeader.GenerationUtilityVersion"}, {"key": "Batch.BatchHeader.DataSource", "displayName": "Batch.BatchHeader.DataSource"}, {"key": "Batch.ReportingEntity.ReportingEntityName", "displayName": "Batch.ReportingEntity.ReportingEntityName"}, {"key": "Batch.ReportingEntity.ReportingEntityCategory", "displayName": "Batch.ReportingEntity.ReportingEntityCategory"}, {"key": "Batch.ReportingEntity.RERegistrationNum", "displayName": "Batch.ReportingEntity.RERegistrationNum"}, {"key": "Batch.ReportingEntity.FIUREID", "displayName": "Batch.ReportingEntity.FIUREID"}, {"key": "Batch.PrincipalOfficer.POName", "displayName": "Batch.PrincipalOfficer.POName"}, {"key": "Batch.PrincipalOfficer.PODesignation", "displayName": "Batch.PrincipalOfficer.PODesignation"}, {"key": "Batch.PrincipalOfficer.POEmail", "displayName": "Batch.PrincipalOfficer.POEmail"}, {"key": "Batch.PrincipalOfficer.POAddress.Address", "displayName": "Batch.PrincipalOfficer.POAddress.Address"}, {"key": "Batch.PrincipalOfficer.POAddress.City", "displayName": "Batch.PrincipalOfficer.POAddress.City"}, {"key": "Batch.PrincipalOfficer.POAddress.StateCode", "displayName": "Batch.PrincipalOfficer.POAddress.StateCode"}, {"key": "Batch.PrincipalOfficer.POAddress.PinCode", "displayName": "Batch.PrincipalOfficer.POAddress.PinCode"}, {"key": "Batch.PrincipalOfficer.POAddress.CountryCode", "displayName": "Batch.PrincipalOfficer.POAddress.CountryCode"}, {"key": "Batch.PrincipalOfficer.POPhone.Telephone", "displayName": "Batch.PrincipalOfficer.POPhone.Telephone"}, {"key": "Batch.PrincipalOfficer.POPhone.Mobile", "displayName": "Batch.PrincipalOfficer.POPhone.Mobile"}, {"key": "Batch.PrincipalOfficer.POPhone.Fax", "displayName": "Batch.PrincipalOfficer.POPhone.Fax"}, {"key": "Batch.BatchDetails.BatchNumber", "displayName": "Batch.BatchDetails.BatchNumber"}, {"key": "Batch.BatchDetails.BatchDate", "displayName": "Batch.BatchDetails.BatchDate"}, {"key": "Batch.BatchDetails.MonthOfReport", "displayName": "Batch.BatchDetails.MonthOfReport"}, {"key": "Batch.BatchDetails.YearOfReport", "displayName": "Batch.BatchDetails.YearOfReport"}, {"key": "Batch.BatchDetails.OperationalMode", "displayName": "Batch.BatchDetails.OperationalMode"}, {"key": "Batch.BatchDetails.BatchType", "displayName": "Batch.BatchDetails.BatchType"}, {"key": "Batch.BatchDetails.OriginalBatchID", "displayName": "Batch.BatchDetails.OriginalBatchID"}, {"key": "Batch.BatchDetails.ReasonOfRevision", "displayName": "Batch.BatchDetails.ReasonOfRevision"}, {"key": "Batch.BatchDetails.PKICertificateNum", "displayName": "Batch.BatchDetails.PKICertificateNum"}, {"key": "Batch.Report.ReportSerialNum", "displayName": "Batch.Report.ReportSerialNum"}, {"key": "Batch.Report.OriginalReportSerialNum", "displayName": "Batch.Report.OriginalReportSerialNum"}, {"key": "Batch.Report.MainPersonName", "displayName": "Batch.Report.MainPersonName"}, {"key": "Batch.Report.SuspicionDetails.SourceOfAlert", "displayName": "Batch.Report.SuspicionDetails.SourceOfAlert"}, {"key": "Batch.Report.SuspicionDetails.AlertIndicator[]", "displayName": "Batch.Report.SuspicionDetails.AlertIndicator[]"}, {"key": "Batch.Report.SuspicionDetails.SuspicionDueToProceedsOfCrime", "displayName": "Batch.Report.SuspicionDetails.SuspicionDueToProceedsOfCrime"}, {"key": "Batch.Report.SuspicionDetails.SuspicionDueToComplexTrans", "displayName": "Batch.Report.SuspicionDetails.SuspicionDueToComplexTrans"}, {"key": "Batch.Report.SuspicionDetails.SuspicionDueToNoEcoRationale", "displayName": "Batch.Report.SuspicionDetails.SuspicionDueToNoEcoRationale"}, {"key": "Batch.Report.SuspicionDetails.SuspicionOfFinancingOfTerrorism", "displayName": "Batch.Report.SuspicionDetails.SuspicionOfFinancingOfTerrorism"}, {"key": "Batch.Report.SuspicionDetails.AttemptedTransaction", "displayName": "Batch.Report.SuspicionDetails.AttemptedTransaction"}, {"key": "Batch.Report.SuspicionDetails.GroundsOfSuspicion", "displayName": "Batch.Report.SuspicionDetails.GroundsOfSuspicion"}, {"key": "Batch.Report.SuspicionDetails.DetailsOfInvestigation", "displayName": "Batch.Report.SuspicionDetails.DetailsOfInvestigation"}, {"key": "Batch.Report.SuspicionDetails.LEAInformed", "displayName": "Batch.Report.SuspicionDetails.LEAInformed"}, {"key": "Batch.Report.SuspicionDetails.LEADetails", "displayName": "Batch.Report.SuspicionDetails.LEADetails"}, {"key": "Batch.Report.SuspicionDetails.PriorityRating", "displayName": "Batch.Report.SuspicionDetails.PriorityRating"}, {"key": "Batch.Report.SuspicionDetails.ReportCoverage", "displayName": "Batch.Report.SuspicionDetails.ReportCoverage"}, {"key": "Batch.Report.SuspicionDetails.AdditionalDocuments", "displayName": "Batch.Report.SuspicionDetails.AdditionalDocuments"}, {"key": "Batch.Report.Transaction[].TrasnactionDate", "displayName": "Batch.Report.Transaction[].TrasnactionDate"}, {"key": "Batch.Report.Transaction[].TrasnactionTime", "displayName": "Batch.Report.Transaction[].TrasnactionTime"}, {"key": "Batch.Report.Transaction[].TransactionRefNum", "displayName": "Batch.Report.Transaction[].TransactionRefNum"}, {"key": "Batch.Report.Transaction[].TransactionType", "displayName": "Batch.Report.Transaction[].TransactionType"}, {"key": "Batch.Report.Transaction[].InstrumentType", "displayName": "Batch.Report.Transaction[].InstrumentType"}, {"key": "Batch.Report.Transaction[].TransactionInstitutionName", "displayName": "Batch.Report.Transaction[].TransactionInstitutionName"}, {"key": "Batch.Report.Transaction[].TransactionInstitutionRefNum", "displayName": "Batch.Report.Transaction[].TransactionInstitutionRefNum"}, {"key": "Batch.Report.Transaction[].TransactionStateCode", "displayName": "Batch.Report.Transaction[].TransactionStateCode"}, {"key": "Batch.Report.Transaction[].TransactionCountryCode", "displayName": "Batch.Report.Transaction[].TransactionCountryCode"}, {"key": "Batch.Report.Transaction[].PaymentInstrumentNum", "displayName": "Batch.Report.Transaction[].PaymentInstrumentNum"}, {"key": "Batch.Report.Transaction[].PaymentInstrumentIssueInstitutionName", "displayName": "Batch.Report.Transaction[].PaymentInstrumentIssueInstitutionName"}, {"key": "Batch.Report.Transaction[].InstrumentIssueInstitutionRefNum", "displayName": "Batch.Report.Transaction[].InstrumentIssueInstitutionRefNum"}, {"key": "Batch.Report.Transaction[].InstrumentCountryCode", "displayName": "Batch.Report.Transaction[].InstrumentCountryCode"}, {"key": "Batch.Report.Transaction[].AmountRupees", "displayName": "Batch.Report.Transaction[].AmountRupees"}, {"key": "Batch.Report.Transaction[].AmountForeignCurrency", "displayName": "Batch.Report.Transaction[].AmountForeignCurrency"}, {"key": "Batch.Report.Transaction[].CurrencyOfTransaction", "displayName": "Batch.Report.Transaction[].CurrencyOfTransaction"}, {"key": "Batch.Report.Transaction[].PurposeOfTransaction", "displayName": "Batch.Report.Transaction[].PurposeOfTransaction"}, {"key": "Batch.Report.Transaction[].PurposeCode", "displayName": "Batch.Report.Transaction[].PurposeCode"}, {"key": "Batch.Report.Transaction[].RiskRating", "displayName": "Batch.Report.Transaction[].RiskRating"}, {"key": "Batch.Report.Transaction[].AccountNumber", "displayName": "Batch.Report.Transaction[].AccountNumber"}, {"key": "Batch.Report.Transaction[].AccountWithInstitutionName", "displayName": "Batch.Report.Transaction[].AccountWithInstitutionName"}, {"key": "Batch.Report.Transaction[].AccountWithInstitutionRefNum", "displayName": "Batch.Report.Transaction[].AccountWithInstitutionRefNum"}, {"key": "Batch.Report.Transaction[].RelatedInstitutionName", "displayName": "Batch.Report.Transaction[].RelatedInstitutionName"}, {"key": "Batch.Report.Transaction[].InstitutionRelationFlag", "displayName": "Batch.Report.Transaction[].InstitutionRelationFlag"}, {"key": "Batch.Report.Transaction[].RelatedInstitutionRefNum", "displayName": "Batch.Report.Transaction[].RelatedInstitutionRefNum"}, {"key": "Batch.Report.Transaction[].Remarks", "displayName": "Batch.Report.Transaction[].Remarks"}, {"key": "Batch.Report.Transaction[].CustomerDetails.CustomerName", "displayName": "Batch.Report.Transaction[].CustomerDetails.CustomerName"}, {"key": "Batch.Report.Transaction[].CustomerDetails.CustomerId", "displayName": "Batch.Report.Transaction[].CustomerDetails.CustomerId"}, {"key": "Batch.Report.Transaction[].CustomerDetails.Occupation", "displayName": "Batch.Report.Transaction[].CustomerDetails.Occupation"}, {"key": "Batch.Report.Transaction[].CustomerDetails.DateOfBirth", "displayName": "Batch.Report.Transaction[].CustomerDetails.DateOfBirth"}, {"key": "Batch.Report.Transaction[].CustomerDetails.Gender", "displayName": "Batch.Report.Transaction[].CustomerDetails.Gender"}, {"key": "Batch.Report.Transaction[].CustomerDetails.Nationality", "displayName": "Batch.Report.Transaction[].CustomerDetails.Nationality"}, {"key": "Batch.Report.Transaction[].CustomerDetails.IdentificationType", "displayName": "Batch.Report.Transaction[].CustomerDetails.IdentificationType"}, {"key": "Batch.Report.Transaction[].CustomerDetails.IdentificationNumber", "displayName": "Batch.Report.Transaction[].CustomerDetails.IdentificationNumber"}, {"key": "Batch.Report.Transaction[].CustomerDetails.IssuingAuthority", "displayName": "Batch.Report.Transaction[].CustomerDetails.IssuingAuthority"}, {"key": "Batch.Report.Transaction[].CustomerDetails.PlaceOfIssue", "displayName": "Batch.Report.Transaction[].CustomerDetails.PlaceOfIssue"}, {"key": "Batch.Report.Transaction[].CustomerDetails.PAN", "displayName": "Batch.Report.Transaction[].CustomerDetails.PAN"}, {"key": "Batch.Report.Transaction[].CustomerDetails.UIN", "displayName": "Batch.Report.Transaction[].CustomerDetails.UIN"}, {"key": "Batch.Report.Transaction[].CustomerDetails.Email", "displayName": "Batch.Report.Transaction[].CustomerDetails.Email"}, {"key": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.Address", "displayName": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.Address"}, {"key": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.City", "displayName": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.City"}, {"key": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.StateCode", "displayName": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.StateCode"}, {"key": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.PinCode", "displayName": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.PinCode"}, {"key": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.CountryCode", "displayName": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.CountryCode"}, {"key": "Batch.Report.Transaction[].CustomerDetails.Phone.Telephone", "displayName": "Batch.Report.Transaction[].CustomerDetails.Phone.Telephone"}, {"key": "Batch.Report.Transaction[].CustomerDetails.Phone.Mobile", "displayName": "Batch.Report.Transaction[].CustomerDetails.Phone.Mobile"}, {"key": "Batch.Report.Transaction[].CustomerDetails.Phone.Fax", "displayName": "Batch.Report.Transaction[].CustomerDetails.Phone.Fax"}, {"key": "Batch.Report.Branch.InstitutionName", "displayName": "Batch.Report.Branch.InstitutionName"}, {"key": "Batch.Report.Branch.InstitutionBranchName", "displayName": "Batch.Report.Branch.InstitutionBranchName"}, {"key": "Batch.Report.Branch.InstitutionRefNum", "displayName": "Batch.Report.Branch.InstitutionRefNum"}, {"key": "Batch.Report.Branch.ReportingRole", "displayName": "Batch.Report.Branch.ReportingRole"}, {"key": "Batch.Report.Branch.BIC", "displayName": "Batch.Report.Branch.BIC"}, {"key": "Batch.Report.Branch.BranchAddress.Address", "displayName": "Batch.Report.Branch.BranchAddress.Address"}, {"key": "Batch.Report.Branch.BranchAddress.City", "displayName": "Batch.Report.Branch.BranchAddress.City"}, {"key": "Batch.Report.Branch.BranchAddress.StateCode", "displayName": "Batch.Report.Branch.BranchAddress.StateCode"}, {"key": "Batch.Report.Branch.BranchAddress.PinCode", "displayName": "Batch.Report.Branch.BranchAddress.PinCode"}, {"key": "Batch.Report.Branch.BranchAddress.CountryCode", "displayName": "Batch.Report.Branch.BranchAddress.CountryCode"}, {"key": "Batch.Report.Branch.Phone.Telephone", "displayName": "Batch.Report.Branch.Phone.Telephone"}, {"key": "Batch.Report.Branch.Phone.Mobile", "displayName": "Batch.Report.Branch.Phone.Mobile"}, {"key": "Batch.Report.Branch.Phone.Fax", "displayName": "Batch.Report.Branch.Phone.Fax"}, {"key": "Batch.Report.Branch.Email", "displayName": "Batch.Report.Branch.Email"}, {"key": "Batch.Report.Branch.Remarks", "displayName": "Batch.Report.Branch.Remarks"}, {"key": "Batch.Report.PaymentInstrument[].InstrumentRefNum", "displayName": "Batch.Report.PaymentInstrument[].InstrumentRefNum"}, {"key": "Batch.Report.PaymentInstrument[].IssueInstitutionRefNum", "displayName": "Batch.Report.PaymentInstrument[].IssueInstitutionRefNum"}, {"key": "Batch.Report.PaymentInstrument[].InstrumentIssueInstitutionName", "displayName": "Batch.Report.PaymentInstrument[].InstrumentIssueInstitutionName"}, {"key": "Batch.Report.PaymentInstrument[].InstrumentHolderName", "displayName": "Batch.Report.PaymentInstrument[].InstrumentHolderName"}, {"key": "Batch.Report.PaymentInstrument[].RelationshipBeginningDate", "displayName": "Batch.Report.PaymentInstrument[].RelationshipBeginningDate"}, {"key": "Batch.Report.PaymentInstrument[].CumulativePurchaseTurnover", "displayName": "Batch.Report.PaymentInstrument[].CumulativePurchaseTurnover"}, {"key": "Batch.Report.PaymentInstrument[].Remarks", "displayName": "Batch.Report.PaymentInstrument[].Remarks"}, {"key": "Batch.Report.RelatedPersons[].PersonName", "displayName": "Batch.Report.RelatedPersons[].PersonName"}, {"key": "Batch.Report.RelatedPersons[].CustomerID", "displayName": "Batch.Report.RelatedPersons[].CustomerID"}, {"key": "Batch.Report.RelatedPersons[].RelationFlag", "displayName": "Batch.Report.RelatedPersons[].RelationFlag"}, {"key": "Batch.Report.RelatedPersons[].PAN", "displayName": "Batch.Report.RelatedPersons[].PAN"}, {"key": "Batch.Report.RelatedPersons[].UIN", "displayName": "Batch.Report.RelatedPersons[].UIN"}, {"key": "Batch.Report.RelatedPersons[].Choice", "displayName": "Batch.Report.RelatedPersons[].Choice"}, {"key": "Batch.Report.RelatedPersons[].Individual.Gender", "displayName": "Batch.Report.RelatedPersons[].Individual.Gender"}, {"key": "Batch.Report.RelatedPersons[].Individual.DateOfBirth", "displayName": "Batch.Report.RelatedPersons[].Individual.DateOfBirth"}, {"key": "Batch.Report.RelatedPersons[].Individual.IdentificationType", "displayName": "Batch.Report.RelatedPersons[].Individual.IdentificationType"}, {"key": "Batch.Report.RelatedPersons[].Individual.IdentificationNumber", "displayName": "Batch.Report.RelatedPersons[].Individual.IdentificationNumber"}, {"key": "Batch.Report.RelatedPersons[].Individual.IssuingAuthority", "displayName": "Batch.Report.RelatedPersons[].Individual.IssuingAuthority"}, {"key": "Batch.Report.RelatedPersons[].Individual.PlaceOfIssue", "displayName": "Batch.Report.RelatedPersons[].Individual.PlaceOfIssue"}, {"key": "Batch.Report.RelatedPersons[].Individual.Nationality", "displayName": "Batch.Report.RelatedPersons[].Individual.Nationality"}, {"key": "Batch.Report.RelatedPersons[].Individual.PlaceOfWork", "displayName": "Batch.Report.RelatedPersons[].Individual.PlaceOfWork"}, {"key": "Batch.Report.RelatedPersons[].Individual.FatherOrSpouse", "displayName": "Batch.Report.RelatedPersons[].Individual.FatherOrSpouse"}, {"key": "Batch.Report.RelatedPersons[].Individual.Occupation", "displayName": "Batch.Report.RelatedPersons[].Individual.Occupation"}, {"key": "Batch.Report.RelatedPersons[].LegalPerson.ConstitutionType", "displayName": "Batch.Report.RelatedPersons[].LegalPerson.ConstitutionType"}, {"key": "Batch.Report.RelatedPersons[].LegalPerson.RegistrationNumber", "displayName": "Batch.Report.RelatedPersons[].LegalPerson.RegistrationNumber"}, {"key": "Batch.Report.RelatedPersons[].LegalPerson.DateOfIncorporation", "displayName": "Batch.Report.RelatedPersons[].LegalPerson.DateOfIncorporation"}, {"key": "Batch.Report.RelatedPersons[].LegalPerson.PlaceOfRegistration", "displayName": "Batch.Report.RelatedPersons[].LegalPerson.PlaceOfRegistration"}, {"key": "Batch.Report.RelatedPersons[].LegalPerson.CountryCode", "displayName": "Batch.Report.RelatedPersons[].LegalPerson.CountryCode"}, {"key": "Batch.Report.RelatedPersons[].LegalPerson.NatureOfBusiness", "displayName": "Batch.Report.RelatedPersons[].LegalPerson.NatureOfBusiness"}, {"key": "Batch.Report.RelatedPersons[].CommunicationAddress.Address", "displayName": "Batch.Report.RelatedPersons[].CommunicationAddress.Address"}, {"key": "Batch.Report.RelatedPersons[].CommunicationAddress.City", "displayName": "Batch.Report.RelatedPersons[].CommunicationAddress.City"}, {"key": "Batch.Report.RelatedPersons[].CommunicationAddress.StateCode", "displayName": "Batch.Report.RelatedPersons[].CommunicationAddress.StateCode"}, {"key": "Batch.Report.RelatedPersons[].CommunicationAddress.PinCode", "displayName": "Batch.Report.RelatedPersons[].CommunicationAddress.PinCode"}, {"key": "Batch.Report.RelatedPersons[].CommunicationAddress.CountryCode", "displayName": "Batch.Report.RelatedPersons[].CommunicationAddress.CountryCode"}, {"key": "Batch.Report.RelatedPersons[].Phone.Telephone", "displayName": "Batch.Report.RelatedPersons[].Phone.Telephone"}, {"key": "Batch.Report.RelatedPersons[].Phone.Mobile", "displayName": "Batch.Report.RelatedPersons[].Phone.Mobile"}, {"key": "Batch.Report.RelatedPersons[].Phone.Fax", "displayName": "Batch.Report.RelatedPersons[].Phone.Fax"}, {"key": "Batch.Report.RelatedPersons[].Email", "displayName": "Batch.Report.RelatedPersons[].Email"}, {"key": "Batch.Report.RelatedPersons[].SecondAddress.Address", "displayName": "Batch.Report.RelatedPersons[].SecondAddress.Address"}, {"key": "Batch.Report.RelatedPersons[].SecondAddress.City", "displayName": "Batch.Report.RelatedPersons[].SecondAddress.City"}, {"key": "Batch.Report.RelatedPersons[].SecondAddress.StateCode", "displayName": "Batch.Report.RelatedPersons[].SecondAddress.StateCode"}, {"key": "Batch.Report.RelatedPersons[].SecondAddress.PinCode", "displayName": "Batch.Report.RelatedPersons[].SecondAddress.PinCode"}, {"key": "Batch.Report.RelatedPersons[].SecondAddress.CountryCode", "displayName": "Batch.Report.RelatedPersons[].SecondAddress.CountryCode"}, {"key": "Batch.ReportType", "displayName": "Batch.ReportType"}, {"key": "Batch.ReportFormatType", "displayName": "Batch.ReportFormatType"}, {"key": "Batch.BatchHeader.DataStructureVersion", "displayName": "Batch.BatchHeader.DataStructureVersion"}, {"key": "Batch.BatchHeader.GenerationUtilityVersion", "displayName": "Batch.BatchHeader.GenerationUtilityVersion"}, {"key": "Batch.BatchHeader.DataSource", "displayName": "Batch.BatchHeader.DataSource"}, {"key": "Batch.ReportingEntity.ReportingEntityName", "displayName": "Batch.ReportingEntity.ReportingEntityName"}, {"key": "Batch.ReportingEntity.ReportingEntityCategory", "displayName": "Batch.ReportingEntity.ReportingEntityCategory"}, {"key": "Batch.ReportingEntity.RERegistrationNum", "displayName": "Batch.ReportingEntity.RERegistrationNum"}, {"key": "Batch.ReportingEntity.FIUREID", "displayName": "Batch.ReportingEntity.FIUREID"}, {"key": "Batch.PrincipalOfficer.POName", "displayName": "Batch.PrincipalOfficer.POName"}, {"key": "Batch.PrincipalOfficer.PODesignation", "displayName": "Batch.PrincipalOfficer.PODesignation"}, {"key": "Batch.PrincipalOfficer.POEmail", "displayName": "Batch.PrincipalOfficer.POEmail"}, {"key": "Batch.PrincipalOfficer.POAddress.Address", "displayName": "Batch.PrincipalOfficer.POAddress.Address"}, {"key": "Batch.PrincipalOfficer.POAddress.City", "displayName": "Batch.PrincipalOfficer.POAddress.City"}, {"key": "Batch.PrincipalOfficer.POAddress.StateCode", "displayName": "Batch.PrincipalOfficer.POAddress.StateCode"}, {"key": "Batch.PrincipalOfficer.POAddress.PinCode", "displayName": "Batch.PrincipalOfficer.POAddress.PinCode"}, {"key": "Batch.PrincipalOfficer.POAddress.CountryCode", "displayName": "Batch.PrincipalOfficer.POAddress.CountryCode"}, {"key": "Batch.PrincipalOfficer.POPhone.Telephone", "displayName": "Batch.PrincipalOfficer.POPhone.Telephone"}, {"key": "Batch.PrincipalOfficer.POPhone.Mobile", "displayName": "Batch.PrincipalOfficer.POPhone.Mobile"}, {"key": "Batch.PrincipalOfficer.POPhone.Fax", "displayName": "Batch.PrincipalOfficer.POPhone.Fax"}, {"key": "Batch.BatchDetails.BatchNumber", "displayName": "Batch.BatchDetails.BatchNumber"}, {"key": "Batch.BatchDetails.BatchDate", "displayName": "Batch.BatchDetails.BatchDate"}, {"key": "Batch.BatchDetails.MonthOfReport", "displayName": "Batch.BatchDetails.MonthOfReport"}, {"key": "Batch.BatchDetails.YearOfReport", "displayName": "Batch.BatchDetails.YearOfReport"}, {"key": "Batch.BatchDetails.OperationalMode", "displayName": "Batch.BatchDetails.OperationalMode"}, {"key": "Batch.BatchDetails.BatchType", "displayName": "Batch.BatchDetails.BatchType"}, {"key": "Batch.BatchDetails.OriginalBatchID", "displayName": "Batch.BatchDetails.OriginalBatchID"}, {"key": "Batch.BatchDetails.ReasonOfRevision", "displayName": "Batch.BatchDetails.ReasonOfRevision"}, {"key": "Batch.BatchDetails.PKICertificateNum", "displayName": "Batch.BatchDetails.PKICertificateNum"}, {"key": "Batch.Report.ReportSerialNum", "displayName": "Batch.Report.ReportSerialNum"}, {"key": "Batch.Report.OriginalReportSerialNum", "displayName": "Batch.Report.OriginalReportSerialNum"}, {"key": "Batch.Report.MainPersonName", "displayName": "Batch.Report.MainPersonName"}, {"key": "Batch.Report.SuspicionDetails.SourceOfAlert", "displayName": "Batch.Report.SuspicionDetails.SourceOfAlert"}, {"key": "Batch.Report.SuspicionDetails.AlertIndicator[]", "displayName": "Batch.Report.SuspicionDetails.AlertIndicator[]"}, {"key": "Batch.Report.SuspicionDetails.SuspicionDueToProceedsOfCrime", "displayName": "Batch.Report.SuspicionDetails.SuspicionDueToProceedsOfCrime"}, {"key": "Batch.Report.SuspicionDetails.SuspicionDueToComplexTrans", "displayName": "Batch.Report.SuspicionDetails.SuspicionDueToComplexTrans"}, {"key": "Batch.Report.SuspicionDetails.SuspicionDueToNoEcoRationale", "displayName": "Batch.Report.SuspicionDetails.SuspicionDueToNoEcoRationale"}, {"key": "Batch.Report.SuspicionDetails.SuspicionOfFinancingOfTerrorism", "displayName": "Batch.Report.SuspicionDetails.SuspicionOfFinancingOfTerrorism"}, {"key": "Batch.Report.SuspicionDetails.AttemptedTransaction", "displayName": "Batch.Report.SuspicionDetails.AttemptedTransaction"}, {"key": "Batch.Report.SuspicionDetails.GroundsOfSuspicion", "displayName": "Batch.Report.SuspicionDetails.GroundsOfSuspicion"}, {"key": "Batch.Report.SuspicionDetails.DetailsOfInvestigation", "displayName": "Batch.Report.SuspicionDetails.DetailsOfInvestigation"}, {"key": "Batch.Report.SuspicionDetails.LEAInformed", "displayName": "Batch.Report.SuspicionDetails.LEAInformed"}, {"key": "Batch.Report.SuspicionDetails.LEADetails", "displayName": "Batch.Report.SuspicionDetails.LEADetails"}, {"key": "Batch.Report.SuspicionDetails.PriorityRating", "displayName": "Batch.Report.SuspicionDetails.PriorityRating"}, {"key": "Batch.Report.SuspicionDetails.ReportCoverage", "displayName": "Batch.Report.SuspicionDetails.ReportCoverage"}, {"key": "Batch.Report.SuspicionDetails.AdditionalDocuments", "displayName": "Batch.Report.SuspicionDetails.AdditionalDocuments"}, {"key": "Batch.Report.Transaction[].TrasnactionDate", "displayName": "Batch.Report.Transaction[].TrasnactionDate"}, {"key": "Batch.Report.Transaction[].TrasnactionTime", "displayName": "Batch.Report.Transaction[].TrasnactionTime"}, {"key": "Batch.Report.Transaction[].TransactionRefNum", "displayName": "Batch.Report.Transaction[].TransactionRefNum"}, {"key": "Batch.Report.Transaction[].TransactionType", "displayName": "Batch.Report.Transaction[].TransactionType"}, {"key": "Batch.Report.Transaction[].InstrumentType", "displayName": "Batch.Report.Transaction[].InstrumentType"}, {"key": "Batch.Report.Transaction[].TransactionInstitutionName", "displayName": "Batch.Report.Transaction[].TransactionInstitutionName"}, {"key": "Batch.Report.Transaction[].TransactionInstitutionRefNum", "displayName": "Batch.Report.Transaction[].TransactionInstitutionRefNum"}, {"key": "Batch.Report.Transaction[].TransactionStateCode", "displayName": "Batch.Report.Transaction[].TransactionStateCode"}, {"key": "Batch.Report.Transaction[].TransactionCountryCode", "displayName": "Batch.Report.Transaction[].TransactionCountryCode"}, {"key": "Batch.Report.Transaction[].PaymentInstrumentNum", "displayName": "Batch.Report.Transaction[].PaymentInstrumentNum"}, {"key": "Batch.Report.Transaction[].PaymentInstrumentIssueInstitutionName", "displayName": "Batch.Report.Transaction[].PaymentInstrumentIssueInstitutionName"}, {"key": "Batch.Report.Transaction[].InstrumentIssueInstitutionRefNum", "displayName": "Batch.Report.Transaction[].InstrumentIssueInstitutionRefNum"}, {"key": "Batch.Report.Transaction[].InstrumentCountryCode", "displayName": "Batch.Report.Transaction[].InstrumentCountryCode"}, {"key": "Batch.Report.Transaction[].AmountRupees", "displayName": "Batch.Report.Transaction[].AmountRupees"}, {"key": "Batch.Report.Transaction[].AmountForeignCurrency", "displayName": "Batch.Report.Transaction[].AmountForeignCurrency"}, {"key": "Batch.Report.Transaction[].CurrencyOfTransaction", "displayName": "Batch.Report.Transaction[].CurrencyOfTransaction"}, {"key": "Batch.Report.Transaction[].PurposeOfTransaction", "displayName": "Batch.Report.Transaction[].PurposeOfTransaction"}, {"key": "Batch.Report.Transaction[].PurposeCode", "displayName": "Batch.Report.Transaction[].PurposeCode"}, {"key": "Batch.Report.Transaction[].RiskRating", "displayName": "Batch.Report.Transaction[].RiskRating"}, {"key": "Batch.Report.Transaction[].AccountNumber", "displayName": "Batch.Report.Transaction[].AccountNumber"}, {"key": "Batch.Report.Transaction[].AccountWithInstitutionName", "displayName": "Batch.Report.Transaction[].AccountWithInstitutionName"}, {"key": "Batch.Report.Transaction[].AccountWithInstitutionRefNum", "displayName": "Batch.Report.Transaction[].AccountWithInstitutionRefNum"}, {"key": "Batch.Report.Transaction[].RelatedInstitutionName", "displayName": "Batch.Report.Transaction[].RelatedInstitutionName"}, {"key": "Batch.Report.Transaction[].InstitutionRelationFlag", "displayName": "Batch.Report.Transaction[].InstitutionRelationFlag"}, {"key": "Batch.Report.Transaction[].RelatedInstitutionRefNum", "displayName": "Batch.Report.Transaction[].RelatedInstitutionRefNum"}, {"key": "Batch.Report.Transaction[].Remarks", "displayName": "Batch.Report.Transaction[].Remarks"}, {"key": "Batch.Report.Transaction[].CustomerDetails.CustomerName", "displayName": "Batch.Report.Transaction[].CustomerDetails.CustomerName"}, {"key": "Batch.Report.Transaction[].CustomerDetails.CustomerId", "displayName": "Batch.Report.Transaction[].CustomerDetails.CustomerId"}, {"key": "Batch.Report.Transaction[].CustomerDetails.Occupation", "displayName": "Batch.Report.Transaction[].CustomerDetails.Occupation"}, {"key": "Batch.Report.Transaction[].CustomerDetails.DateOfBirth", "displayName": "Batch.Report.Transaction[].CustomerDetails.DateOfBirth"}, {"key": "Batch.Report.Transaction[].CustomerDetails.Gender", "displayName": "Batch.Report.Transaction[].CustomerDetails.Gender"}, {"key": "Batch.Report.Transaction[].CustomerDetails.Nationality", "displayName": "Batch.Report.Transaction[].CustomerDetails.Nationality"}, {"key": "Batch.Report.Transaction[].CustomerDetails.IdentificationType", "displayName": "Batch.Report.Transaction[].CustomerDetails.IdentificationType"}, {"key": "Batch.Report.Transaction[].CustomerDetails.IdentificationNumber", "displayName": "Batch.Report.Transaction[].CustomerDetails.IdentificationNumber"}, {"key": "Batch.Report.Transaction[].CustomerDetails.IssuingAuthority", "displayName": "Batch.Report.Transaction[].CustomerDetails.IssuingAuthority"}, {"key": "Batch.Report.Transaction[].CustomerDetails.PlaceOfIssue", "displayName": "Batch.Report.Transaction[].CustomerDetails.PlaceOfIssue"}, {"key": "Batch.Report.Transaction[].CustomerDetails.PAN", "displayName": "Batch.Report.Transaction[].CustomerDetails.PAN"}, {"key": "Batch.Report.Transaction[].CustomerDetails.UIN", "displayName": "Batch.Report.Transaction[].CustomerDetails.UIN"}, {"key": "Batch.Report.Transaction[].CustomerDetails.Email", "displayName": "Batch.Report.Transaction[].CustomerDetails.Email"}, {"key": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.Address", "displayName": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.Address"}, {"key": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.City", "displayName": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.City"}, {"key": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.StateCode", "displayName": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.StateCode"}, {"key": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.PinCode", "displayName": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.PinCode"}, {"key": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.CountryCode", "displayName": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.CountryCode"}, {"key": "Batch.Report.Transaction[].CustomerDetails.Phone.Telephone", "displayName": "Batch.Report.Transaction[].CustomerDetails.Phone.Telephone"}, {"key": "Batch.Report.Transaction[].CustomerDetails.Phone.Mobile", "displayName": "Batch.Report.Transaction[].CustomerDetails.Phone.Mobile"}, {"key": "Batch.Report.Transaction[].CustomerDetails.Phone.Fax", "displayName": "Batch.Report.Transaction[].CustomerDetails.Phone.Fax"}, {"key": "Batch.Report.Branch.InstitutionName", "displayName": "Batch.Report.Branch.InstitutionName"}, {"key": "Batch.Report.Branch.InstitutionBranchName", "displayName": "Batch.Report.Branch.InstitutionBranchName"}, {"key": "Batch.Report.Branch.InstitutionRefNum", "displayName": "Batch.Report.Branch.InstitutionRefNum"}, {"key": "Batch.Report.Branch.ReportingRole", "displayName": "Batch.Report.Branch.ReportingRole"}, {"key": "Batch.Report.Branch.BIC", "displayName": "Batch.Report.Branch.BIC"}, {"key": "Batch.Report.Branch.BranchAddress.Address", "displayName": "Batch.Report.Branch.BranchAddress.Address"}, {"key": "Batch.Report.Branch.BranchAddress.City", "displayName": "Batch.Report.Branch.BranchAddress.City"}, {"key": "Batch.Report.Branch.BranchAddress.StateCode", "displayName": "Batch.Report.Branch.BranchAddress.StateCode"}, {"key": "Batch.Report.Branch.BranchAddress.PinCode", "displayName": "Batch.Report.Branch.BranchAddress.PinCode"}, {"key": "Batch.Report.Branch.BranchAddress.CountryCode", "displayName": "Batch.Report.Branch.BranchAddress.CountryCode"}, {"key": "Batch.Report.Branch.Phone.Telephone", "displayName": "Batch.Report.Branch.Phone.Telephone"}, {"key": "Batch.Report.Branch.Phone.Mobile", "displayName": "Batch.Report.Branch.Phone.Mobile"}, {"key": "Batch.Report.Branch.Phone.Fax", "displayName": "Batch.Report.Branch.Phone.Fax"}, {"key": "Batch.Report.Branch.Email", "displayName": "Batch.Report.Branch.Email"}, {"key": "Batch.Report.Branch.Remarks", "displayName": "Batch.Report.Branch.Remarks"}, {"key": "Batch.Report.PaymentInstrument[].InstrumentRefNum", "displayName": "Batch.Report.PaymentInstrument[].InstrumentRefNum"}, {"key": "Batch.Report.PaymentInstrument[].IssueInstitutionRefNum", "displayName": "Batch.Report.PaymentInstrument[].IssueInstitutionRefNum"}, {"key": "Batch.Report.PaymentInstrument[].InstrumentIssueInstitutionName", "displayName": "Batch.Report.PaymentInstrument[].InstrumentIssueInstitutionName"}, {"key": "Batch.Report.PaymentInstrument[].InstrumentHolderName", "displayName": "Batch.Report.PaymentInstrument[].InstrumentHolderName"}, {"key": "Batch.Report.PaymentInstrument[].RelationshipBeginningDate", "displayName": "Batch.Report.PaymentInstrument[].RelationshipBeginningDate"}, {"key": "Batch.Report.PaymentInstrument[].CumulativePurchaseTurnover", "displayName": "Batch.Report.PaymentInstrument[].CumulativePurchaseTurnover"}, {"key": "Batch.Report.PaymentInstrument[].Remarks", "displayName": "Batch.Report.PaymentInstrument[].Remarks"}, {"key": "Batch.Report.RelatedPersons[].PersonName", "displayName": "Batch.Report.RelatedPersons[].PersonName"}, {"key": "Batch.Report.RelatedPersons[].CustomerID", "displayName": "Batch.Report.RelatedPersons[].CustomerID"}, {"key": "Batch.Report.RelatedPersons[].RelationFlag", "displayName": "Batch.Report.RelatedPersons[].RelationFlag"}, {"key": "Batch.Report.RelatedPersons[].PAN", "displayName": "Batch.Report.RelatedPersons[].PAN"}, {"key": "Batch.Report.RelatedPersons[].UIN", "displayName": "Batch.Report.RelatedPersons[].UIN"}, {"key": "Batch.Report.RelatedPersons[].Choice", "displayName": "Batch.Report.RelatedPersons[].Choice"}, {"key": "Batch.Report.RelatedPersons[].Individual.Gender", "displayName": "Batch.Report.RelatedPersons[].Individual.Gender"}, {"key": "Batch.Report.RelatedPersons[].Individual.DateOfBirth", "displayName": "Batch.Report.RelatedPersons[].Individual.DateOfBirth"}, {"key": "Batch.Report.RelatedPersons[].Individual.IdentificationType", "displayName": "Batch.Report.RelatedPersons[].Individual.IdentificationType"}, {"key": "Batch.Report.RelatedPersons[].Individual.IdentificationNumber", "displayName": "Batch.Report.RelatedPersons[].Individual.IdentificationNumber"}, {"key": "Batch.Report.RelatedPersons[].Individual.IssuingAuthority", "displayName": "Batch.Report.RelatedPersons[].Individual.IssuingAuthority"}, {"key": "Batch.Report.RelatedPersons[].Individual.PlaceOfIssue", "displayName": "Batch.Report.RelatedPersons[].Individual.PlaceOfIssue"}, {"key": "Batch.Report.RelatedPersons[].Individual.Nationality", "displayName": "Batch.Report.RelatedPersons[].Individual.Nationality"}, {"key": "Batch.Report.RelatedPersons[].Individual.PlaceOfWork", "displayName": "Batch.Report.RelatedPersons[].Individual.PlaceOfWork"}, {"key": "Batch.Report.RelatedPersons[].Individual.FatherOrSpouse", "displayName": "Batch.Report.RelatedPersons[].Individual.FatherOrSpouse"}, {"key": "Batch.Report.RelatedPersons[].Individual.Occupation", "displayName": "Batch.Report.RelatedPersons[].Individual.Occupation"}, {"key": "Batch.Report.RelatedPersons[].LegalPerson.ConstitutionType", "displayName": "Batch.Report.RelatedPersons[].LegalPerson.ConstitutionType"}, {"key": "Batch.Report.RelatedPersons[].LegalPerson.RegistrationNumber", "displayName": "Batch.Report.RelatedPersons[].LegalPerson.RegistrationNumber"}, {"key": "Batch.Report.RelatedPersons[].LegalPerson.DateOfIncorporation", "displayName": "Batch.Report.RelatedPersons[].LegalPerson.DateOfIncorporation"}, {"key": "Batch.Report.RelatedPersons[].LegalPerson.PlaceOfRegistration", "displayName": "Batch.Report.RelatedPersons[].LegalPerson.PlaceOfRegistration"}, {"key": "Batch.Report.RelatedPersons[].LegalPerson.CountryCode", "displayName": "Batch.Report.RelatedPersons[].LegalPerson.CountryCode"}, {"key": "Batch.Report.RelatedPersons[].LegalPerson.NatureOfBusiness", "displayName": "Batch.Report.RelatedPersons[].LegalPerson.NatureOfBusiness"}, {"key": "Batch.Report.RelatedPersons[].CommunicationAddress.Address", "displayName": "Batch.Report.RelatedPersons[].CommunicationAddress.Address"}, {"key": "Batch.Report.RelatedPersons[].CommunicationAddress.City", "displayName": "Batch.Report.RelatedPersons[].CommunicationAddress.City"}, {"key": "Batch.Report.RelatedPersons[].CommunicationAddress.StateCode", "displayName": "Batch.Report.RelatedPersons[].CommunicationAddress.StateCode"}, {"key": "Batch.Report.RelatedPersons[].CommunicationAddress.PinCode", "displayName": "Batch.Report.RelatedPersons[].CommunicationAddress.PinCode"}, {"key": "Batch.Report.RelatedPersons[].CommunicationAddress.CountryCode", "displayName": "Batch.Report.RelatedPersons[].CommunicationAddress.CountryCode"}, {"key": "Batch.Report.RelatedPersons[].Phone.Telephone", "displayName": "Batch.Report.RelatedPersons[].Phone.Telephone"}, {"key": "Batch.Report.RelatedPersons[].Phone.Mobile", "displayName": "Batch.Report.RelatedPersons[].Phone.Mobile"}, {"key": "Batch.Report.RelatedPersons[].Phone.Fax", "displayName": "Batch.Report.RelatedPersons[].Phone.Fax"}, {"key": "Batch.Report.RelatedPersons[].Email", "displayName": "Batch.Report.RelatedPersons[].Email"}, {"key": "Batch.Report.RelatedPersons[].SecondAddress.Address", "displayName": "Batch.Report.RelatedPersons[].SecondAddress.Address"}, {"key": "Batch.Report.RelatedPersons[].SecondAddress.City", "displayName": "Batch.Report.RelatedPersons[].SecondAddress.City"}, {"key": "Batch.Report.RelatedPersons[].SecondAddress.StateCode", "displayName": "Batch.Report.RelatedPersons[].SecondAddress.StateCode"}, {"key": "Batch.Report.RelatedPersons[].SecondAddress.PinCode", "displayName": "Batch.Report.RelatedPersons[].SecondAddress.PinCode"}, {"key": "Batch.Report.RelatedPersons[].SecondAddress.CountryCode", "displayName": "Batch.Report.RelatedPersons[].SecondAddress.CountryCode"}]}}', '[{"section": {"label": "Details of Batch", "fields": [{"key": "Batch.ReportType", "type": "select", "label": "Report Type", "value": "STR", "options": [{"label": "Suspicious Transaction Report", "value": "STR"}], "isDisabled": true, "validations": {"required": true}}, {"key": "Batch.ReportFormatType", "type": "select", "label": "Report Format Type", "value": "TRF", "options": [{"label": "Transaction based reporting format ", "value": "TRF"}], "isDisabled": true, "validations": {"required": true}}], "colClassName": "mt-4"}}, {"section": {"label": "Batch Header", "fields": [{"key": "Batch.BatchHeader.DataStructureVersion", "type": "select", "label": "Data Structure Version", "options": [{"label": "Version 1.0", "value": "1"}, {"label": "Version 2.0", "value": "2"}], "validations": {"required": true}}, {"key": "Batch.BatchHeader.GenerationUtilityVersion", "type": "text", "label": "Generation Utility Version", "validations": {"required": false, "maxLength": 5}}, {"key": "Batch.BatchHeader.DataSource", "type": "select", "label": "Data Source", "options": [{"label": "PDF file", "value": "pdf"}, {"label": "RGU file", "value": "rgu"}, {"label": "Text file", "value": "txt"}, {"label": "XML file", "value": "xml"}], "validations": {"required": true}}], "validations": {"required": true}, "colClassName": "mt-4"}}, {"section": {"key": "Batch.ReportingEntity", "label": "Reporting Entity", "fields": [{"key": "Batch.ReportingEntity.ReportingEntityName", "type": "text", "label": "Reporting Entity Name", "validations": {"required": true, "maxLength": 80}}, {"key": "Batch.ReportingEntity.ReportingEntityCategory", "type": "select", "label": "Reporting Entity Category", "options": [{"label": "Public Sector Banks", "value": "BAPUB"}, {"label": "Private Sector Banks", "value": "BAPVT"}, {"label": "Foreign Banks", "value": "BAFOR"}, {"label": "Regional Rural Banks", "value": "BARRB"}, {"label": "Local Area Banks", "value": "BALAB"}, {"label": "Scheduled Urban Cooperative Banks", "value": "BASUC"}, {"label": "Non Scheduled Urban Cooperative Banks", "value": "BANUC"}, {"label": "State Cooperative Banks", "value": "BASCO"}, {"label": "District Cooperative Banks", "value": "BADCB"}, {"label": "Other Banking Companies", "value": "BAOTH"}, {"label": "Life Insurance Companies", "value": "FIINL"}, {"label": "Non Life Insurance Companies", "value": "FIINN"}, {"label": "Housing Finance Companies", "value": "FIHFC"}, {"label": "Authorised Dealer Category I", "value": "FIAD1"}, {"label": "Authorised Dealer Category II", "value": "FIAD2"}, {"label": "Authorised Dealer Category III", "value": "FIAD3"}, {"label": "Full Fledged Money Changer (FFMC)", "value": "FIFFM"}, {"label": "Money Transfer Service Principal", "value": "FIMTP"}, {"label": "Money Transfer Service Agent", "value": "FIMTA"}, {"label": "Card System Operators", "value": "FICSO"}, {"label": "Central Counter Party", "value": "FICCP"}, {"label": "All India Financial Institutions", "value": "FIAFI"}, {"label": "Hire Purchase Companies", "value": "FIHPC"}, {"label": "Chit Fund Companies", "value": "FICFC"}, {"label": "NBFC Accepting Deposits", "value": "FINBA"}, {"label": "NBFC not Accepting Deposits", "value": "FINBN"}, {"label": "Other Financial Institutions", "value": "FIOTH"}, {"label": "Casinos", "value": "CASIN"}, {"label": "Collective Investment or MF Schemes", "value": "INCOL"}, {"label": "Depositories", "value": "INDEP"}, {"label": "Depository Participants", "value": "INDPP"}, {"label": "Share Brokers", "value": "INBRO"}, {"label": "Derivative Members", "value": "INBDS"}, {"label": "Share Transfer Agents", "value": "INSTA"}, {"label": "Registrars and Transfer Agents", "value": "INRTA"}, {"label": "Merchant Bankers", "value": "INMER"}, {"label": "Underwriters", "value": "INUND"}, {"label": "Bankers to an Issue", "value": "INBAN"}, {"label": "Registrars to Issue", "value": "INREG"}, {"label": "Portfolio Managers", "value": "INPOM"}, {"label": "Investment Advisors", "value": "INADV"}, {"label": "Trustees to Trust Deeds", "value": "INTRU"}, {"label": "Credit Rating Agencies", "value": "INCRE"}, {"label": "Domestic Venture Capital Funds", "value": "INVCD"}, {"label": "Custodian of Securities", "value": "INCUS"}, {"label": "Foreign Institutional Investors", "value": "INFII"}, {"label": "Foreign Venture Capital Funds", "value": "INVCF"}, {"label": "Commodity Broker", "value": "INCOM"}, {"label": "Sub Brokers", "value": "INSBR"}, {"label": "Other Intermediaries", "value": "INOTH"}, {"label": "Regulators - Reserve Bank of India", "value": "RGRBI"}, {"label": "Others", "value": "ZZZZZ"}, {"label": "Not Categorised", "value": "XXXXX"}], "validations": {"required": true}}, {"key": "Batch.ReportingEntity.RERegistrationNum", "type": "text", "label": "Reporting Entity Registration Number", "validations": {"required": false, "maxLength": 12}}, {"key": "Batch.ReportingEntity.FIUREID", "type": "text", "label": "Reporting Entity FIUREID", "validations": {"length": 10, "required": true}}]}}, {"section": {"label": "Principal Officer", "fields": [{"key": "Batch.PrincipalOfficer.POName", "type": "text", "label": "PO Name", "validations": {"required": true, "maxLength": 80}}, {"key": "Batch.PrincipalOfficer.PODesignation", "type": "text", "label": "PO Designation", "validations": {"required": true, "maxLength": 80}}, {"key": "Batch.PrincipalOfficer.POEmail", "type": "text", "label": "PO Email", "validations": {"regexp": "``", "required": true, "maxLength": 50, "minLength": 6}}, {"section": {"label": "Principal Officer Address", "fields": [{"key": "Batch.PrincipalOfficer.POAddress.Address", "type": "text", "label": "Address", "validations": {"required": true, "maxLength": 225, "minLength": 8}}, {"key": "Batch.PrincipalOfficer.POAddress.City", "type": "text", "label": "City", "validations": {"required": false, "maxLength": 50}}, {"key": "Batch.PrincipalOfficer.POAddress.StateCode", "type": "select", "label": "State Code", "options": [{"label": "Andaman & Nicobar", "value": "AN"}, {"label": "Andhra Pradesh", "value": "AP"}, {"label": "Arunachal Pradesh", "value": "AR"}, {"label": "Assam", "value": "AS"}, {"label": "Bihar", "value": "BR"}, {"label": "Chandigarh", "value": "CH"}, {"label": "Chhattisgarh", "value": "CG"}, {"label": "Dadra and Nagar Haveli", "value": "DN"}, {"label": "Daman & Diu", "value": "DD"}, {"label": "Delhi", "value": "DL"}, {"label": "Goa", "value": "GA"}, {"label": "Gujarat", "value": "GJ"}, {"label": "Haryana", "value": "HR"}, {"label": "Himachal Pradesh", "value": "HP"}, {"label": "Jammu & Kashmir", "value": "JK"}, {"label": "Jharkhand", "value": "JH"}, {"label": "Karnataka", "value": "KA"}, {"label": "Kerala", "value": "KL"}, {"label": "Lakshadweep", "value": "LD"}, {"label": "Madhya Pradesh", "value": "MP"}, {"label": "Maharashtra", "value": "MH"}, {"label": "Manipur", "value": "MN"}, {"label": "Meghalaya", "value": "ML"}, {"label": "Mizoram", "value": "MZ"}, {"label": "Nagaland", "value": "NL"}, {"label": "Orissa", "value": "OR"}, {"label": "Pondicherry", "value": "PY"}, {"label": "Punjab", "value": "PB"}, {"label": "Rajasthan", "value": "RJ"}, {"label": "Sikkim", "value": "SK"}, {"label": "Tamil Nadu", "value": "TN"}, {"label": "Tripura", "value": "TR"}, {"label": "Uttar Pradesh", "value": "UP"}, {"label": "Uttarakhand", "value": "UA"}, {"label": "West Bengal", "value": "WB"}, {"label": "Others", "value": "ZZ"}, {"label": "Not Applicable", "value": "XX"}], "validations": {"required": true}}, {"key": "Batch.PrincipalOfficer.POAddress.PinCode", "type": "text", "label": "Pincode", "validations": {"required": false, "maxLength": 10}}, {"key": "Batch.PrincipalOfficer.POAddress.CountryCode", "type": "select", "label": "Country Code", "options": [{"label": "Afghanistan", "value": "AF"}, {"label": "Aland Islands", "value": "AX"}, {"label": "Albania", "value": "AL"}, {"label": "Algeria", "value": "DZ"}, {"label": "American Samoa", "value": "AS"}, {"label": "Andorra", "value": "AD"}, {"label": "Angola", "value": "AO"}, {"label": "Anguilla", "value": "AI"}, {"label": "Antarctica", "value": "AQ"}, {"label": "Antigua And Barbuda", "value": "AG"}, {"label": "Argentina", "value": "AR"}, {"label": "Armenia", "value": "AM"}, {"label": "Aruba", "value": "AW"}, {"label": "Australia", "value": "AU"}, {"label": "Austria", "value": "AT"}, {"label": "Azerbaijan", "value": "AZ"}, {"label": "Bahamas", "value": "BS"}, {"label": "Bahrain", "value": "BH"}, {"label": "Bangladesh", "value": "BD"}, {"label": "Barbados", "value": "BB"}, {"label": "Belarus", "value": "BY"}, {"label": "Belgium", "value": "BE"}, {"label": "Belize", "value": "BZ"}, {"label": "Benin", "value": "BJ"}, {"label": "Bermuda", "value": "BM"}, {"label": "Bhutan", "value": "BT"}, {"label": "Bolivia", "value": "BO"}, {"label": "Bosnia And Herzegovina", "value": "BA"}, {"label": "Bonaire, Sint Eustatius and Saba", "value": "BQ"}, {"label": "Botswana", "value": "BW"}, {"label": "Bouvet Island", "value": "BV"}, {"label": "Brazil", "value": "BR"}, {"label": "British Indian Ocean Territory", "value": "IO"}, {"label": "Brunei Darussalam", "value": "BN"}, {"label": "Bulgaria", "value": "BG"}, {"label": "Burkina Faso", "value": "BF"}, {"label": "Burundi", "value": "BI"}, {"label": "Cambodia", "value": "KH"}, {"label": "Cameroon", "value": "CM"}, {"label": "Canada", "value": "CA"}, {"label": "Cape Verde", "value": "CV"}, {"label": "Cayman Islands", "value": "KY"}, {"label": "Central African Republic", "value": "CF"}, {"label": "Chad", "value": "TD"}, {"label": "Chile", "value": "CL"}, {"label": "China", "value": "CN"}, {"label": "Christmas Island", "value": "CX"}, {"label": "Cocos (Keeling) Islands", "value": "CC"}, {"label": "Colombia", "value": "CO"}, {"label": "Comoros", "value": "KM"}, {"label": "Congo", "value": "CG"}, {"label": "Congo, The Democratic Republic Of The", "value": "CD"}, {"label": "Cook Islands", "value": "CK"}, {"label": "Costa Rica", "value": "CR"}, {"label": "Côte D''ivoire", "value": "CI"}, {"label": "Croatia", "value": "HR"}, {"label": "Cuba", "value": "CU"}, {"label": "Curacao", "value": "CW"}, {"label": "Cyprus", "value": "CY"}, {"label": "Czech Republic", "value": "CZ"}, {"label": "Denmark", "value": "DK"}, {"label": "Djibouti", "value": "DJ"}, {"label": "Dominica", "value": "DM"}, {"label": "Dominican Republic", "value": "DO"}, {"label": "Ecuador", "value": "EC"}, {"label": "Egypt", "value": "EG"}, {"label": "El Salvador", "value": "SV"}, {"label": "Equatorial Guinea", "value": "GQ"}, {"label": "Eritrea", "value": "ER"}, {"label": "Estonia", "value": "EE"}, {"label": "Ethiopia", "value": "ET"}, {"label": "Falkland Islands (Malvinas)", "value": "FK"}, {"label": "Faroe Islands", "value": "FO"}, {"label": "Fiji", "value": "FJ"}, {"label": "Finland", "value": "FI"}, {"label": "France", "value": "FR"}, {"label": "French Guiana", "value": "GF"}, {"label": "French Polynesia", "value": "PF"}, {"label": "French Southern Territories", "value": "TF"}, {"label": "Gabon", "value": "GA"}, {"label": "Gambia", "value": "GM"}, {"label": "Georgia", "value": "GE"}, {"label": "Germany", "value": "DE"}, {"label": "Ghana", "value": "GH"}, {"label": "Gibraltar", "value": "GI"}, {"label": "Greece", "value": "GR"}, {"label": "Greenland", "value": "GL"}, {"label": "Grenada", "value": "GD"}, {"label": "Guadeloupe", "value": "GP"}, {"label": "Guam", "value": "GU"}, {"label": "Guatemala", "value": "GT"}, {"label": "Guernsey", "value": "GG"}, {"label": "Guinea", "value": "GN"}, {"label": "Guinea-Bissau", "value": "GW"}, {"label": "Guyana", "value": "GY"}, {"label": "Haiti", "value": "HT"}, {"label": "Heard Island And McDonald Islands", "value": "HM"}, {"label": "Vatican City State", "value": "VA"}, {"label": "Honduras", "value": "HN"}, {"label": "Hong Kong", "value": "HK"}, {"label": "Hungary", "value": "HU"}, {"label": "Iceland", "value": "IS"}, {"label": "India", "value": "IN"}, {"label": "Indonesia", "value": "ID"}, {"label": "Iran, Islamic Republic Of", "value": "IR"}, {"label": "Iraq", "value": "IQ"}, {"label": "Ireland", "value": "IE"}, {"label": "Isle Of Man", "value": "IM"}, {"label": "Israel", "value": "IL"}, {"label": "Italy", "value": "IT"}, {"label": "Jamaica", "value": "JM"}, {"label": "Japan", "value": "JP"}, {"label": "Jersey", "value": "JE"}, {"label": "Jordan", "value": "JO"}, {"label": "Kazakhstan", "value": "KZ"}, {"label": "Kenya", "value": "KE"}, {"label": "Kiribati", "value": "KI"}, {"label": "Korea, Democratic People''s Republic Of", "value": "KP"}, {"label": "Korea, Republic Of", "value": "KR"}, {"label": "Kuwait", "value": "KW"}, {"label": "Kyrgyzstan", "value": "KG"}, {"label": "Lao People''s Democratic Republic", "value": "LA"}, {"label": "Latvia", "value": "LV"}, {"label": "Lebanon", "value": "LB"}, {"label": "Lesotho", "value": "LS"}, {"label": "Liberia", "value": "LR"}, {"label": "Libyan Arab Jamahiriya", "value": "LY"}, {"label": "Liechtenstein", "value": "LI"}, {"label": "Lithuania", "value": "LT"}, {"label": "Luxembourg", "value": "LU"}, {"label": "Macao", "value": "MO"}, {"label": "Macedonia, The Former Yugoslav Republic Of", "value": "MK"}, {"label": "Madagascar", "value": "MG"}, {"label": "Malawi", "value": "MW"}, {"label": "Malaysia", "value": "MY"}, {"label": "Maldives", "value": "MV"}, {"label": "Mali", "value": "ML"}, {"label": "Malta", "value": "MT"}, {"label": "Marshall Islands", "value": "MH"}, {"label": "Martinique", "value": "MQ"}, {"label": "Mauritania", "value": "MR"}, {"label": "Mauritius", "value": "MU"}, {"label": "Mayotte", "value": "YT"}, {"label": "Mexico", "value": "MX"}, {"label": "Micronesia, Federated States Of", "value": "FM"}, {"label": "Moldova, Republic Of", "value": "MD"}, {"label": "Monaco", "value": "MC"}, {"label": "Mongolia", "value": "MN"}, {"label": "Montenegro", "value": "ME"}, {"label": "Montserrat", "value": "MS"}, {"label": "Morocco", "value": "MA"}, {"label": "Mozambique", "value": "MZ"}, {"label": "Myanmar", "value": "MM"}, {"label": "Namibia", "value": "NA"}, {"label": "Nauru", "value": "NR"}, {"label": "Nepal", "value": "NP"}, {"label": "Netherlands", "value": "NL"}, {"label": "Netherlands Antilles", "value": "AN"}, {"label": "New Caledonia", "value": "NC"}, {"label": "New Zealand", "value": "NZ"}, {"label": "Nicaragua", "value": "NI"}, {"label": "Niger", "value": "NE"}, {"label": "Nigeria", "value": "NG"}, {"label": "Niue", "value": "NU"}, {"label": "Norfolk Island", "value": "NF"}, {"label": "Northern Mariana Islands", "value": "MP"}, {"label": "Norway", "value": "NO"}, {"label": "Oman", "value": "OM"}, {"label": "Pakistan", "value": "PK"}, {"label": "Palau", "value": "PW"}, {"label": "Palestinian Territory, Occupied", "value": "PS"}, {"label": "Panama", "value": "PA"}, {"label": "Papua New Guinea", "value": "PG"}, {"label": "Paraguay", "value": "PY"}, {"label": "Peru", "value": "PE"}, {"label": "Philippines", "value": "PH"}, {"label": "Pitcairn", "value": "PN"}, {"label": "Poland", "value": "PL"}, {"label": "Portugal", "value": "PT"}, {"label": "Puerto Rico", "value": "PR"}, {"label": "Qatar", "value": "QA"}, {"label": "Reunion Island", "value": "RE"}, {"label": "Romania", "value": "RO"}, {"label": "Russian Federation", "value": "RU"}, {"label": "Rwanda", "value": "RW"}, {"label": "Saint Barthelemy", "value": "BL"}, {"label": "Saint Helena, Ascension And Tristan da Cunha", "value": "SH"}, {"label": "Saint Kitts And Nevis", "value": "KN"}, {"label": "Saint Lucia", "value": "LC"}, {"label": "Saint Martin", "value": "MF"}, {"label": "Saint Pierre And Miquelon", "value": "PM"}, {"label": "Saint Vincent And The Grenadines", "value": "VC"}, {"label": "Samoa", "value": "WS"}, {"label": "San Marino", "value": "SM"}, {"label": "Sao Tome And Principe", "value": "ST"}, {"label": "Saudi Arabia", "value": "SA"}, {"label": "Senegal", "value": "SN"}, {"label": "Serbia", "value": "RS"}, {"label": "Seychelles", "value": "SC"}, {"label": "Sierra Leone", "value": "SL"}, {"label": "Singapore", "value": "SG"}, {"label": "Sint Marteen", "value": "SX"}, {"label": "Slovakia", "value": "SK"}, {"label": "Slovenia", "value": "SI"}, {"label": "Solomon Islands", "value": "SB"}, {"label": "Somalia", "value": "SO"}, {"label": "South Africa", "value": "ZA"}, {"label": "South Georgia And The South Sandwich Islands", "value": "GS"}, {"label": "South Sudan", "value": "SS"}, {"label": "Spain", "value": "ES"}, {"label": "Sri Lanka", "value": "LK"}, {"label": "Sudan", "value": "SD"}, {"label": "Suriname", "value": "SR"}, {"label": "Svalbard And Jan Mayen Islands", "value": "SJ"}, {"label": "Swaziland", "value": "SZ"}, {"label": "Sweden", "value": "SE"}, {"label": "Switzerland", "value": "CH"}, {"label": "Syrian Arab Republic", "value": "SY"}, {"label": "Taiwan, Province Of China", "value": "TW"}, {"label": "Tajikistan", "value": "TJ"}, {"label": "Tanzania, United Republic Of", "value": "TZ"}, {"label": "Thailand", "value": "TH"}, {"label": "Timor-Leste", "value": "TL"}, {"label": "Togo", "value": "TG"}, {"label": "Tokelau", "value": "TK"}, {"label": "Tonga", "value": "TO"}, {"label": "Trinidad And Tobago", "value": "TT"}, {"label": "Tunisia", "value": "TN"}, {"label": "Turkey", "value": "TR"}, {"label": "Turkmenistan", "value": "TM"}, {"label": "Turks And Caicos Islands", "value": "TC"}, {"label": "Tuvalu", "value": "TV"}, {"label": "Uganda", "value": "UG"}, {"label": "Ukraine", "value": "UA"}, {"label": "United Arab Emirates", "value": "AE"}, {"label": "United Kingdom", "value": "GB"}, {"label": "United States", "value": "US"}, {"label": "United States Minor Outlying Islands", "value": "UM"}, {"label": "Uruguay", "value": "UY"}, {"label": "Uzbekistan", "value": "UZ"}, {"label": "Vanuatu", "value": "VU"}, {"label": "Venezuela, Bolivarian Republic Of", "value": "VE"}, {"label": "Viet Nam", "value": "VN"}, {"label": "Virgin Islands, British", "value": "VG"}, {"label": "Virgin Islands, U.S.", "value": "VI"}, {"label": "Wallis And Futuna", "value": "WF"}, {"label": "Western Sahara", "value": "EH"}, {"label": "Yemen", "value": "YE"}, {"label": "Zambia", "value": "ZM"}, {"label": "Zimbabwe", "value": "ZW"}, {"label": "Not categorised", "value": "XX"}, {"label": "Others", "value": "ZZ"}], "validations": {"required": true}}], "colClassName": "mt-4"}}, {"section": {"label": "Principal Officer Phone", "fields": [{"key": "Batch.PrincipalOfficer.POPhone.Telephone", "type": "text", "label": "Telephone", "validations": {"required": false, "maxLength": 30, "minLength": 6}}, {"key": "Batch.PrincipalOfficer.POPhone.Mobile", "type": "text", "label": "Mobile", "validations": {"required": false, "maxLength": 30, "minLength": 6}}, {"key": "Batch.PrincipalOfficer.POPhone.Fax", "type": "text", "label": "Fax", "validations": {"required": false, "maxLength": 30, "minLength": 6}}], "colClassName": "mt-4"}}], "colClassName": "mt-4"}}, {"section": {"label": "Batch Details Report", "fields": [{"key": "Batch.BatchDetails.BatchNumber", "type": "text", "label": "Batch Number", "validations": {"required": true, "maxLength": 11}}, {"key": "Batch.BatchDetails.BatchDate", "type": "date", "label": "Batch Date", "format": "YYYY-MM-DD", "maxDate": "new Date()", "minDate": "`new Date().setFullYear(new Date().getFullYear() - 1)`", "validations": {"required": true}}, {"key": "Batch.BatchDetails.MonthOfReport", "type": "select", "label": "Month of Report", "options": [{"label": "January", "value": "01"}, {"label": "February", "value": "02"}, {"label": "March", "value": "03"}, {"label": "April", "value": "04"}, {"label": "May", "value": "05"}, {"label": "June", "value": "06"}, {"label": "July", "value": "07"}, {"label": "August", "value": "08"}, {"label": "September", "value": "09"}, {"label": "October", "value": "10"}, {"label": "November", "value": "11"}, {"label": "December", "value": "12"}, {"label": "Not Applicable", "value": "NA"}], "validations": {"required": true}}, {"key": "Batch.BatchDetails.YearOfReport", "type": "select", "label": "Year of Report", "options": [{"label": "2005", "value": "2005"}, {"label": "2006", "value": "2006"}, {"label": "2007", "value": "2007"}, {"label": "2008", "value": "2008"}, {"label": "2009", "value": "2009"}, {"label": "2010", "value": "2010"}, {"label": "2011", "value": "2011"}, {"label": "2012", "value": "2012"}, {"label": "2013", "value": "2013"}, {"label": "2014", "value": "2014"}, {"label": "2015", "value": "2015"}, {"label": "2016", "value": "2016"}, {"label": "2017", "value": "2017"}, {"label": "2018", "value": "2018"}, {"label": "2019", "value": "2019"}, {"label": "2020", "value": "2020"}, {"label": "2021", "value": "2021"}, {"label": "2022", "value": "2022"}, {"label": "2023", "value": "2023"}, {"label": "Not Applicable", "value": "NA"}], "validations": {"required": true}}, {"key": "Batch.BatchDetails.OperationalMode", "type": "select", "label": "Operational Mode", "options": [{"label": "Production Mode", "value": "P"}, {"label": "Test Mode", "value": "T"}], "validations": {"required": true}}, {"key": "Batch.BatchDetails.BatchType", "type": "select", "label": "Batch Type", "options": [{"label": "New Report", "value": "N"}, {"label": "Replacement Report", "value": "R"}, {"label": "Deletion Report", "value": "D"}], "validations": {"required": true}}, {"key": "Batch.BatchDetails.OriginalBatchID", "type": "text", "label": "Original Batch ID", "validations": {"required": true, "maxLength": 10}}, {"key": "Batch.BatchDetails.ReasonOfRevision", "type": "select", "label": "Reason of Revision", "options": [{"label": "Acknowledgement of original batch had many fatal, non fatal or probable errors which are being resolved", "value": "A"}, {"label": "Operational errors in original batch have been identified and reports are being revised or deleted suo moto", "value": "B"}, {"label": "The replacement report is on account of additional information being submitted", "value": "C"}, {"label": "Not applicable as this is a new batch", "value": "N"}, {"label": "Other reason", "value": "Z"}], "validations": {"required": true}}, {"key": "Batch.BatchDetails.PKICertificateNum", "type": "text", "label": "PKI Certificate Number", "validations": {"required": false, "maxLength": 10}}], "colClassName": "mt-4"}}, {"section": {"label": "Details of Batch/Report", "fields": [{"key": "Batch.Report.ReportSerialNum", "type": "text", "label": "Report Serial Number", "validations": {"required": true, "maxLength": 8}}, {"key": "Batch.Report.OriginalReportSerialNum", "type": "text", "label": "Original Report Serial Number", "validations": {"required": true, "maxLength": 8}}, {"key": "Batch.Report.MainPersonName", "type": "text", "label": "Main Person Name", "validations": {"required": false, "maxLength": 80}}, {"section": {"label": "Suspicious Details", "fields": [{"key": "Batch.Report.SuspicionDetails.SourceOfAlert", "type": "select", "label": "Source Of Alert", "options": [{"label": "Customer Verification", "value": "CV"}, {"label": "Watch List", "value": "WL"}, {"label": "Media Reports", "value": "MR"}, {"label": "Typology", "value": "TY"}, {"label": "Transaction Monitoring", "value": "TM"}, {"label": "Risk Management System", "value": "RM"}, {"label": "Law Enforcement Agency Query", "value": "LQ"}, {"label": "Employee Initiated", "value": "EI"}, {"label": "Public Complaint", "value": "PC"}, {"label": "Business Associates", "value": "BA"}, {"label": "Others", "value": "ZZ"}, {"label": "Not Categorised", "value": "XX"}], "validations": {"required": true}}, {"section": {"label": "Alert Indicator", "fields": [{"key": "Batch.Report.SuspicionDetails.AlertIndicator[]", "type": "text", "label": "Alert Indicator", "validations": {"required": false, "maxLength": 100}}], "isArray": true, "arrayKey": "Batch.Report.SuspicionDetails.AlertIndicator", "required": false, "addArrayLabel": "Alert Indicator"}}, {"key": "Batch.Report.SuspicionDetails.SuspicionDueToProceedsOfCrime", "type": "select", "label": "Suspicious Due To Proceeds Of Crime", "options": [{"label": "Yes", "value": "Y"}, {"label": "No", "value": "N"}, {"label": "Not Categorised", "value": "X"}], "validations": {"required": true}}, {"key": "Batch.Report.SuspicionDetails.SuspicionDueToComplexTrans", "type": "select", "label": "Suspicious Due To Complex Trans", "options": [{"label": "Yes", "value": "Y"}, {"label": "No", "value": "N"}, {"label": "Not Categorised", "value": "X"}], "validations": {"required": true}}, {"key": "Batch.Report.SuspicionDetails.SuspicionDueToNoEcoRationale", "type": "select", "label": "Suspicious Due To No Eco Rationale", "options": [{"label": "Yes", "value": "Y"}, {"label": "No", "value": "N"}, {"label": "Not Categorised", "value": "X"}], "validations": {"required": true}}, {"key": "Batch.Report.SuspicionDetails.SuspicionOfFinancingOfTerrorism", "type": "select", "label": "Suspicious Of Financing Of Terrorism", "options": [{"label": "Yes", "value": "Y"}, {"label": "No", "value": "N"}, {"label": "Not Categorised", "value": "X"}], "validations": {"required": true}}, {"key": "Batch.Report.SuspicionDetails.AttemptedTransaction", "type": "select", "label": "Attempted Transaction", "options": [{"label": "Yes", "value": "Y"}, {"label": "No", "value": "N"}, {"label": "Not Categorised", "value": "X"}], "validations": {"required": true}}, {"sm": 12, "key": "Batch.Report.SuspicionDetails.GroundsOfSuspicion", "type": "textarea", "label": "Grounds Of Suspicion", "validations": {"required": true, "maxLength": 4000}, "colClassName": "mt-3"}, {"sm": 12, "key": "Batch.Report.SuspicionDetails.DetailsOfInvestigation", "type": "textarea", "label": "Details Of Investigation", "validations": {"required": false, "maxLength": 4000}}, {"key": "Batch.Report.SuspicionDetails.LEAInformed", "type": "select", "label": "LEA Informed", "options": [{"label": "Information received ", "value": "R"}, {"label": "Information sent", "value": "S"}, {"label": "No correspondence sent or received", "value": "N "}, {"label": "Not categorised", "value": "X "}], "validations": {"required": true}}, {"key": "Batch.Report.SuspicionDetails.LEADetails", "type": "textarea", "label": "LEA Details", "validations": {"required": false, "maxLength": 250}}, {"key": "Batch.Report.SuspicionDetails.PriorityRating", "type": "select", "label": "Priority Rating", "options": [{"label": "Very High Priority ", "value": "P1 "}, {"label": "High Priority", "value": "P2  "}, {"label": "Normal Priority", "value": "P3"}, {"label": "Not categorised", "value": "XX "}], "validations": {"required": true}}, {"key": "Batch.Report.SuspicionDetails.ReportCoverage", "type": "select", "label": "Report Coverage", "options": [{"label": "Complete", "value": "C "}, {"label": "Partial", "value": "P "}, {"label": "Not Categorised", "value": "X "}], "validations": {"required": true}}, {"key": "Batch.Report.SuspicionDetails.AdditionalDocuments", "type": "select", "label": "Additional Documents", "options": [{"label": "Yes", "value": "Y"}, {"label": "No", "value": "N"}, {"label": "Not Categorised", "value": "X"}], "validations": {"required": true}}], "colClassName": "mt-4"}}, {"section": {"label": "Details Of Transaction", "fields": [{"key": "Batch.Report.Transaction[].TrasnactionDate", "type": "date", "label": "Date Of Transaction", "format": "YYYY-MM-DDDD", "maxDate": "new Date()", "minDate": "`new Date().setFullYear(new Date().getFullYear() - 1)`", "validations": {"required": true}}, {"key": "Batch.Report.Transaction[].TrasnactionTime", "type": "time", "label": "Time Of Transaction", "format": "HH:MM:SS", "maxDate": "new Date()", "minDate": "`new Date().setFullYear(new Date().getFullYear() - 1)`", "validations": {"required": false}}, {"key": "Batch.Report.Transaction[].TransactionRefNum", "type": "text", "label": "Transaction Ref Number", "validations": {"required": false, "maxLength": 20}}, {"key": "Batch.Report.Transaction[].TransactionType", "type": "select", "label": "Transaction Type", "options": [{"label": "Purchase", "value": "P"}, {"label": "Redemption", "value": "R"}], "validations": {"required": true}}, {"key": "Batch.Report.Transaction[].InstrumentType", "type": "select", "label": "Instrument Type", "options": [{"label": "Currency Note", "value": "A"}, {"label": "Travelers Cheque", "value": "B"}, {"label": "Demand Draft/Pay order", "value": "C"}, {"label": "Money Order", "value": "D"}, {"label": "Wire Transfers/TT", "value": "E"}, {"label": "Money Transfer", "value": "F"}, {"label": "Credit Card", "value": "G"}, {"label": "Debit Card", "value": "H"}, {"label": "Smart Card", "value": "I"}, {"label": "Prepaid Card", "value": "J"}, {"label": "Gift Card", "value": "K"}, {"label": "Cheque", "value": "L"}, {"label": "Others", "value": "Z"}, {"label": "Not Categorised", "value": "X"}], "validations": {"required": true}}, {"key": "Batch.Report.Transaction[].TransactionInstitutionName", "type": "text", "label": "Transaction Institution Name", "validations": {"required": true, "maxLength": 80}}, {"key": "Batch.Report.Transaction[].TransactionInstitutionRefNum", "type": "text", "label": "Transaction Institution Ref Num", "validations": {"required": true, "maxLength": 20}}, {"key": "Batch.Report.Transaction[].TransactionStateCode", "type": "select", "label": "State Code", "options": [{"label": "Andaman & Nicobar", "value": "AN"}, {"label": "Andhra Pradesh", "value": "AP"}, {"label": "Arunachal Pradesh", "value": "AR"}, {"label": "Assam", "value": "AS"}, {"label": "Bihar", "value": "BR"}, {"label": "Chandigarh", "value": "CH"}, {"label": "Chhattisgarh", "value": "CG"}, {"label": "Dadra and Nagar Haveli", "value": "DN"}, {"label": "Daman & Diu", "value": "DD"}, {"label": "Delhi", "value": "DL"}, {"label": "Goa", "value": "GA"}, {"label": "Gujarat", "value": "GJ"}, {"label": "Haryana", "value": "HR"}, {"label": "Himachal Pradesh", "value": "HP"}, {"label": "Jammu & Kashmir", "value": "JK"}, {"label": "Jharkhand", "value": "JH"}, {"label": "Karnataka", "value": "KA"}, {"label": "Kerala", "value": "KL"}, {"label": "Lakshadweep", "value": "LD"}, {"label": "Madhya Pradesh", "value": "MP"}, {"label": "Maharashtra", "value": "MH"}, {"label": "Manipur", "value": "MN"}, {"label": "Meghalaya", "value": "ML"}, {"label": "Mizoram", "value": "MZ"}, {"label": "Nagaland", "value": "NL"}, {"label": "Orissa", "value": "OR"}, {"label": "Pondicherry", "value": "PY"}, {"label": "Punjab", "value": "PB"}, {"label": "Rajasthan", "value": "RJ"}, {"label": "Sikkim", "value": "SK"}, {"label": "Tamil Nadu", "value": "TN"}, {"label": "Tripura", "value": "TR"}, {"label": "Uttar Pradesh", "value": "UP"}, {"label": "Uttarakhand", "value": "UA"}, {"label": "West Bengal", "value": "WB"}, {"label": "Others", "value": "ZZ"}, {"label": "Not Applicable", "value": "XX"}], "validations": {"required": true}}, {"key": "Batch.Report.Transaction[].TransactionCountryCode", "type": "select", "label": "Country Code", "options": [{"label": "Afghanistan", "value": "AF"}, {"label": "Aland Islands", "value": "AX"}, {"label": "Albania", "value": "AL"}, {"label": "Algeria", "value": "DZ"}, {"label": "American Samoa", "value": "AS"}, {"label": "Andorra", "value": "AD"}, {"label": "Angola", "value": "AO"}, {"label": "Anguilla", "value": "AI"}, {"label": "Antarctica", "value": "AQ"}, {"label": "Antigua And Barbuda", "value": "AG"}, {"label": "Argentina", "value": "AR"}, {"label": "Armenia", "value": "AM"}, {"label": "Aruba", "value": "AW"}, {"label": "Australia", "value": "AU"}, {"label": "Austria", "value": "AT"}, {"label": "Azerbaijan", "value": "AZ"}, {"label": "Bahamas", "value": "BS"}, {"label": "Bahrain", "value": "BH"}, {"label": "Bangladesh", "value": "BD"}, {"label": "Barbados", "value": "BB"}, {"label": "Belarus", "value": "BY"}, {"label": "Belgium", "value": "BE"}, {"label": "Belize", "value": "BZ"}, {"label": "Benin", "value": "BJ"}, {"label": "Bermuda", "value": "BM"}, {"label": "Bhutan", "value": "BT"}, {"label": "Bolivia", "value": "BO"}, {"label": "Bosnia And Herzegovina", "value": "BA"}, {"label": "Bonaire, Sint Eustatius and Saba", "value": "BQ"}, {"label": "Botswana", "value": "BW"}, {"label": "Bouvet Island", "value": "BV"}, {"label": "Brazil", "value": "BR"}, {"label": "British Indian Ocean Territory", "value": "IO"}, {"label": "Brunei Darussalam", "value": "BN"}, {"label": "Bulgaria", "value": "BG"}, {"label": "Burkina Faso", "value": "BF"}, {"label": "Burundi", "value": "BI"}, {"label": "Cambodia", "value": "KH"}, {"label": "Cameroon", "value": "CM"}, {"label": "Canada", "value": "CA"}, {"label": "Cape Verde", "value": "CV"}, {"label": "Cayman Islands", "value": "KY"}, {"label": "Central African Republic", "value": "CF"}, {"label": "Chad", "value": "TD"}, {"label": "Chile", "value": "CL"}, {"label": "China", "value": "CN"}, {"label": "Christmas Island", "value": "CX"}, {"label": "Cocos (Keeling) Islands", "value": "CC"}, {"label": "Colombia", "value": "CO"}, {"label": "Comoros", "value": "KM"}, {"label": "Congo", "value": "CG"}, {"label": "Congo, The Democratic Republic Of The", "value": "CD"}, {"label": "Cook Islands", "value": "CK"}, {"label": "Costa Rica", "value": "CR"}, {"label": "Côte D''ivoire", "value": "CI"}, {"label": "Croatia", "value": "HR"}, {"label": "Cuba", "value": "CU"}, {"label": "Curacao", "value": "CW"}, {"label": "Cyprus", "value": "CY"}, {"label": "Czech Republic", "value": "CZ"}, {"label": "Denmark", "value": "DK"}, {"label": "Djibouti", "value": "DJ"}, {"label": "Dominica", "value": "DM"}, {"label": "Dominican Republic", "value": "DO"}, {"label": "Ecuador", "value": "EC"}, {"label": "Egypt", "value": "EG"}, {"label": "El Salvador", "value": "SV"}, {"label": "Equatorial Guinea", "value": "GQ"}, {"label": "Eritrea", "value": "ER"}, {"label": "Estonia", "value": "EE"}, {"label": "Ethiopia", "value": "ET"}, {"label": "Falkland Islands (Malvinas)", "value": "FK"}, {"label": "Faroe Islands", "value": "FO"}, {"label": "Fiji", "value": "FJ"}, {"label": "Finland", "value": "FI"}, {"label": "France", "value": "FR"}, {"label": "French Guiana", "value": "GF"}, {"label": "French Polynesia", "value": "PF"}, {"label": "French Southern Territories", "value": "TF"}, {"label": "Gabon", "value": "GA"}, {"label": "Gambia", "value": "GM"}, {"label": "Georgia", "value": "GE"}, {"label": "Germany", "value": "DE"}, {"label": "Ghana", "value": "GH"}, {"label": "Gibraltar", "value": "GI"}, {"label": "Greece", "value": "GR"}, {"label": "Greenland", "value": "GL"}, {"label": "Grenada", "value": "GD"}, {"label": "Guadeloupe", "value": "GP"}, {"label": "Guam", "value": "GU"}, {"label": "Guatemala", "value": "GT"}, {"label": "Guernsey", "value": "GG"}, {"label": "Guinea", "value": "GN"}, {"label": "Guinea-Bissau", "value": "GW"}, {"label": "Guyana", "value": "GY"}, {"label": "Haiti", "value": "HT"}, {"label": "Heard Island And McDonald Islands", "value": "HM"}, {"label": "Vatican City State", "value": "VA"}, {"label": "Honduras", "value": "HN"}, {"label": "Hong Kong", "value": "HK"}, {"label": "Hungary", "value": "HU"}, {"label": "Iceland", "value": "IS"}, {"label": "India", "value": "IN"}, {"label": "Indonesia", "value": "ID"}, {"label": "Iran, Islamic Republic Of", "value": "IR"}, {"label": "Iraq", "value": "IQ"}, {"label": "Ireland", "value": "IE"}, {"label": "Isle Of Man", "value": "IM"}, {"label": "Israel", "value": "IL"}, {"label": "Italy", "value": "IT"}, {"label": "Jamaica", "value": "JM"}, {"label": "Japan", "value": "JP"}, {"label": "Jersey", "value": "JE"}, {"label": "Jordan", "value": "JO"}, {"label": "Kazakhstan", "value": "KZ"}, {"label": "Kenya", "value": "KE"}, {"label": "Kiribati", "value": "KI"}, {"label": "Korea, Democratic People''s Republic Of", "value": "KP"}, {"label": "Korea, Republic Of", "value": "KR"}, {"label": "Kuwait", "value": "KW"}, {"label": "Kyrgyzstan", "value": "KG"}, {"label": "Lao People''s Democratic Republic", "value": "LA"}, {"label": "Latvia", "value": "LV"}, {"label": "Lebanon", "value": "LB"}, {"label": "Lesotho", "value": "LS"}, {"label": "Liberia", "value": "LR"}, {"label": "Libyan Arab Jamahiriya", "value": "LY"}, {"label": "Liechtenstein", "value": "LI"}, {"label": "Lithuania", "value": "LT"}, {"label": "Luxembourg", "value": "LU"}, {"label": "Macao", "value": "MO"}, {"label": "Macedonia, The Former Yugoslav Republic Of", "value": "MK"}, {"label": "Madagascar", "value": "MG"}, {"label": "Malawi", "value": "MW"}, {"label": "Malaysia", "value": "MY"}, {"label": "Maldives", "value": "MV"}, {"label": "Mali", "value": "ML"}, {"label": "Malta", "value": "MT"}, {"label": "Marshall Islands", "value": "MH"}, {"label": "Martinique", "value": "MQ"}, {"label": "Mauritania", "value": "MR"}, {"label": "Mauritius", "value": "MU"}, {"label": "Mayotte", "value": "YT"}, {"label": "Mexico", "value": "MX"}, {"label": "Micronesia, Federated States Of", "value": "FM"}, {"label": "Moldova, Republic Of", "value": "MD"}, {"label": "Monaco", "value": "MC"}, {"label": "Mongolia", "value": "MN"}, {"label": "Montenegro", "value": "ME"}, {"label": "Montserrat", "value": "MS"}, {"label": "Morocco", "value": "MA"}, {"label": "Mozambique", "value": "MZ"}, {"label": "Myanmar", "value": "MM"}, {"label": "Namibia", "value": "NA"}, {"label": "Nauru", "value": "NR"}, {"label": "Nepal", "value": "NP"}, {"label": "Netherlands", "value": "NL"}, {"label": "Netherlands Antilles", "value": "AN"}, {"label": "New Caledonia", "value": "NC"}, {"label": "New Zealand", "value": "NZ"}, {"label": "Nicaragua", "value": "NI"}, {"label": "Niger", "value": "NE"}, {"label": "Nigeria", "value": "NG"}, {"label": "Niue", "value": "NU"}, {"label": "Norfolk Island", "value": "NF"}, {"label": "Northern Mariana Islands", "value": "MP"}, {"label": "Norway", "value": "NO"}, {"label": "Oman", "value": "OM"}, {"label": "Pakistan", "value": "PK"}, {"label": "Palau", "value": "PW"}, {"label": "Palestinian Territory, Occupied", "value": "PS"}, {"label": "Panama", "value": "PA"}, {"label": "Papua New Guinea", "value": "PG"}, {"label": "Paraguay", "value": "PY"}, {"label": "Peru", "value": "PE"}, {"label": "Philippines", "value": "PH"}, {"label": "Pitcairn", "value": "PN"}, {"label": "Poland", "value": "PL"}, {"label": "Portugal", "value": "PT"}, {"label": "Puerto Rico", "value": "PR"}, {"label": "Qatar", "value": "QA"}, {"label": "Reunion Island", "value": "RE"}, {"label": "Romania", "value": "RO"}, {"label": "Russian Federation", "value": "RU"}, {"label": "Rwanda", "value": "RW"}, {"label": "Saint Barthelemy", "value": "BL"}, {"label": "Saint Helena, Ascension And Tristan da Cunha", "value": "SH"}, {"label": "Saint Kitts And Nevis", "value": "KN"}, {"label": "Saint Lucia", "value": "LC"}, {"label": "Saint Martin", "value": "MF"}, {"label": "Saint Pierre And Miquelon", "value": "PM"}, {"label": "Saint Vincent And The Grenadines", "value": "VC"}, {"label": "Samoa", "value": "WS"}, {"label": "San Marino", "value": "SM"}, {"label": "Sao Tome And Principe", "value": "ST"}, {"label": "Saudi Arabia", "value": "SA"}, {"label": "Senegal", "value": "SN"}, {"label": "Serbia", "value": "RS"}, {"label": "Seychelles", "value": "SC"}, {"label": "Sierra Leone", "value": "SL"}, {"label": "Singapore", "value": "SG"}, {"label": "Sint Marteen", "value": "SX"}, {"label": "Slovakia", "value": "SK"}, {"label": "Slovenia", "value": "SI"}, {"label": "Solomon Islands", "value": "SB"}, {"label": "Somalia", "value": "SO"}, {"label": "South Africa", "value": "ZA"}, {"label": "South Georgia And The South Sandwich Islands", "value": "GS"}, {"label": "South Sudan", "value": "SS"}, {"label": "Spain", "value": "ES"}, {"label": "Sri Lanka", "value": "LK"}, {"label": "Sudan", "value": "SD"}, {"label": "Suriname", "value": "SR"}, {"label": "Svalbard And Jan Mayen Islands", "value": "SJ"}, {"label": "Swaziland", "value": "SZ"}, {"label": "Sweden", "value": "SE"}, {"label": "Switzerland", "value": "CH"}, {"label": "Syrian Arab Republic", "value": "SY"}, {"label": "Taiwan, Province Of China", "value": "TW"}, {"label": "Tajikistan", "value": "TJ"}, {"label": "Tanzania, United Republic Of", "value": "TZ"}, {"label": "Thailand", "value": "TH"}, {"label": "Timor-Leste", "value": "TL"}, {"label": "Togo", "value": "TG"}, {"label": "Tokelau", "value": "TK"}, {"label": "Tonga", "value": "TO"}, {"label": "Trinidad And Tobago", "value": "TT"}, {"label": "Tunisia", "value": "TN"}, {"label": "Turkey", "value": "TR"}, {"label": "Turkmenistan", "value": "TM"}, {"label": "Turks And Caicos Islands", "value": "TC"}, {"label": "Tuvalu", "value": "TV"}, {"label": "Uganda", "value": "UG"}, {"label": "Ukraine", "value": "UA"}, {"label": "United Arab Emirates", "value": "AE"}, {"label": "United Kingdom", "value": "GB"}, {"label": "United States", "value": "US"}, {"label": "United States Minor Outlying Islands", "value": "UM"}, {"label": "Uruguay", "value": "UY"}, {"label": "Uzbekistan", "value": "UZ"}, {"label": "Vanuatu", "value": "VU"}, {"label": "Venezuela, Bolivarian Republic Of", "value": "VE"}, {"label": "Viet Nam", "value": "VN"}, {"label": "Virgin Islands, British", "value": "VG"}, {"label": "Virgin Islands, U.S.", "value": "VI"}, {"label": "Wallis And Futuna", "value": "WF"}, {"label": "Western Sahara", "value": "EH"}, {"label": "Yemen", "value": "YE"}, {"label": "Zambia", "value": "ZM"}, {"label": "Zimbabwe", "value": "ZW"}, {"label": "Not categorised", "value": "XX"}, {"label": "Others", "value": "ZZ"}], "validations": {"required": true}}, {"key": "Batch.Report.Transaction[].PaymentInstrumentNum", "type": "text", "label": "Payment Instrument Num", "validations": {"required": false, "maxLength": 20}}, {"key": "Batch.Report.Transaction[].PaymentInstrumentIssueInstitutionName", "type": "text", "label": "Payment Instrument Issue Institution Name", "validations": {"required": false, "maxLength": 80}}, {"key": "Batch.Report.Transaction[].InstrumentIssueInstitutionRefNum", "type": "text", "label": "Instrument Issue Institution Ref Num", "validations": {"required": false, "maxLength": 20}}, {"key": "Batch.Report.Transaction[].InstrumentCountryCode", "type": "select", "label": "Instrument Country Code", "options": [{"label": "Afghanistan", "value": "AF"}, {"label": "Aland Islands", "value": "AX"}, {"label": "Albania", "value": "AL"}, {"label": "Algeria", "value": "DZ"}, {"label": "American Samoa", "value": "AS"}, {"label": "Andorra", "value": "AD"}, {"label": "Angola", "value": "AO"}, {"label": "Anguilla", "value": "AI"}, {"label": "Antarctica", "value": "AQ"}, {"label": "Antigua And Barbuda", "value": "AG"}, {"label": "Argentina", "value": "AR"}, {"label": "Armenia", "value": "AM"}, {"label": "Aruba", "value": "AW"}, {"label": "Australia", "value": "AU"}, {"label": "Austria", "value": "AT"}, {"label": "Azerbaijan", "value": "AZ"}, {"label": "Bahamas", "value": "BS"}, {"label": "Bahrain", "value": "BH"}, {"label": "Bangladesh", "value": "BD"}, {"label": "Barbados", "value": "BB"}, {"label": "Belarus", "value": "BY"}, {"label": "Belgium", "value": "BE"}, {"label": "Belize", "value": "BZ"}, {"label": "Benin", "value": "BJ"}, {"label": "Bermuda", "value": "BM"}, {"label": "Bhutan", "value": "BT"}, {"label": "Bolivia", "value": "BO"}, {"label": "Bosnia And Herzegovina", "value": "BA"}, {"label": "Bonaire, Sint Eustatius and Saba", "value": "BQ"}, {"label": "Botswana", "value": "BW"}, {"label": "Bouvet Island", "value": "BV"}, {"label": "Brazil", "value": "BR"}, {"label": "British Indian Ocean Territory", "value": "IO"}, {"label": "Brunei Darussalam", "value": "BN"}, {"label": "Bulgaria", "value": "BG"}, {"label": "Burkina Faso", "value": "BF"}, {"label": "Burundi", "value": "BI"}, {"label": "Cambodia", "value": "KH"}, {"label": "Cameroon", "value": "CM"}, {"label": "Canada", "value": "CA"}, {"label": "Cape Verde", "value": "CV"}, {"label": "Cayman Islands", "value": "KY"}, {"label": "Central African Republic", "value": "CF"}, {"label": "Chad", "value": "TD"}, {"label": "Chile", "value": "CL"}, {"label": "China", "value": "CN"}, {"label": "Christmas Island", "value": "CX"}, {"label": "Cocos (Keeling) Islands", "value": "CC"}, {"label": "Colombia", "value": "CO"}, {"label": "Comoros", "value": "KM"}, {"label": "Congo", "value": "CG"}, {"label": "Congo, The Democratic Republic Of The", "value": "CD"}, {"label": "Cook Islands", "value": "CK"}, {"label": "Costa Rica", "value": "CR"}, {"label": "Côte D''ivoire", "value": "CI"}, {"label": "Croatia", "value": "HR"}, {"label": "Cuba", "value": "CU"}, {"label": "Curacao", "value": "CW"}, {"label": "Cyprus", "value": "CY"}, {"label": "Czech Republic", "value": "CZ"}, {"label": "Denmark", "value": "DK"}, {"label": "Djibouti", "value": "DJ"}, {"label": "Dominica", "value": "DM"}, {"label": "Dominican Republic", "value": "DO"}, {"label": "Ecuador", "value": "EC"}, {"label": "Egypt", "value": "EG"}, {"label": "El Salvador", "value": "SV"}, {"label": "Equatorial Guinea", "value": "GQ"}, {"label": "Eritrea", "value": "ER"}, {"label": "Estonia", "value": "EE"}, {"label": "Ethiopia", "value": "ET"}, {"label": "Falkland Islands (Malvinas)", "value": "FK"}, {"label": "Faroe Islands", "value": "FO"}, {"label": "Fiji", "value": "FJ"}, {"label": "Finland", "value": "FI"}, {"label": "France", "value": "FR"}, {"label": "French Guiana", "value": "GF"}, {"label": "French Polynesia", "value": "PF"}, {"label": "French Southern Territories", "value": "TF"}, {"label": "Gabon", "value": "GA"}, {"label": "Gambia", "value": "GM"}, {"label": "Georgia", "value": "GE"}, {"label": "Germany", "value": "DE"}, {"label": "Ghana", "value": "GH"}, {"label": "Gibraltar", "value": "GI"}, {"label": "Greece", "value": "GR"}, {"label": "Greenland", "value": "GL"}, {"label": "Grenada", "value": "GD"}, {"label": "Guadeloupe", "value": "GP"}, {"label": "Guam", "value": "GU"}, {"label": "Guatemala", "value": "GT"}, {"label": "Guernsey", "value": "GG"}, {"label": "Guinea", "value": "GN"}, {"label": "Guinea-Bissau", "value": "GW"}, {"label": "Guyana", "value": "GY"}, {"label": "Haiti", "value": "HT"}, {"label": "Heard Island And McDonald Islands", "value": "HM"}, {"label": "Vatican City State", "value": "VA"}, {"label": "Honduras", "value": "HN"}, {"label": "Hong Kong", "value": "HK"}, {"label": "Hungary", "value": "HU"}, {"label": "Iceland", "value": "IS"}, {"label": "India", "value": "IN"}, {"label": "Indonesia", "value": "ID"}, {"label": "Iran, Islamic Republic Of", "value": "IR"}, {"label": "Iraq", "value": "IQ"}, {"label": "Ireland", "value": "IE"}, {"label": "Isle Of Man", "value": "IM"}, {"label": "Israel", "value": "IL"}, {"label": "Italy", "value": "IT"}, {"label": "Jamaica", "value": "JM"}, {"label": "Japan", "value": "JP"}, {"label": "Jersey", "value": "JE"}, {"label": "Jordan", "value": "JO"}, {"label": "Kazakhstan", "value": "KZ"}, {"label": "Kenya", "value": "KE"}, {"label": "Kiribati", "value": "KI"}, {"label": "Korea, Democratic People''s Republic Of", "value": "KP"}, {"label": "Korea, Republic Of", "value": "KR"}, {"label": "Kuwait", "value": "KW"}, {"label": "Kyrgyzstan", "value": "KG"}, {"label": "Lao People''s Democratic Republic", "value": "LA"}, {"label": "Latvia", "value": "LV"}, {"label": "Lebanon", "value": "LB"}, {"label": "Lesotho", "value": "LS"}, {"label": "Liberia", "value": "LR"}, {"label": "Libyan Arab Jamahiriya", "value": "LY"}, {"label": "Liechtenstein", "value": "LI"}, {"label": "Lithuania", "value": "LT"}, {"label": "Luxembourg", "value": "LU"}, {"label": "Macao", "value": "MO"}, {"label": "Macedonia, The Former Yugoslav Republic Of", "value": "MK"}, {"label": "Madagascar", "value": "MG"}, {"label": "Malawi", "value": "MW"}, {"label": "Malaysia", "value": "MY"}, {"label": "Maldives", "value": "MV"}, {"label": "Mali", "value": "ML"}, {"label": "Malta", "value": "MT"}, {"label": "Marshall Islands", "value": "MH"}, {"label": "Martinique", "value": "MQ"}, {"label": "Mauritania", "value": "MR"}, {"label": "Mauritius", "value": "MU"}, {"label": "Mayotte", "value": "YT"}, {"label": "Mexico", "value": "MX"}, {"label": "Micronesia, Federated States Of", "value": "FM"}, {"label": "Moldova, Republic Of", "value": "MD"}, {"label": "Monaco", "value": "MC"}, {"label": "Mongolia", "value": "MN"}, {"label": "Montenegro", "value": "ME"}, {"label": "Montserrat", "value": "MS"}, {"label": "Morocco", "value": "MA"}, {"label": "Mozambique", "value": "MZ"}, {"label": "Myanmar", "value": "MM"}, {"label": "Namibia", "value": "NA"}, {"label": "Nauru", "value": "NR"}, {"label": "Nepal", "value": "NP"}, {"label": "Netherlands", "value": "NL"}, {"label": "Netherlands Antilles", "value": "AN"}, {"label": "New Caledonia", "value": "NC"}, {"label": "New Zealand", "value": "NZ"}, {"label": "Nicaragua", "value": "NI"}, {"label": "Niger", "value": "NE"}, {"label": "Nigeria", "value": "NG"}, {"label": "Niue", "value": "NU"}, {"label": "Norfolk Island", "value": "NF"}, {"label": "Northern Mariana Islands", "value": "MP"}, {"label": "Norway", "value": "NO"}, {"label": "Oman", "value": "OM"}, {"label": "Pakistan", "value": "PK"}, {"label": "Palau", "value": "PW"}, {"label": "Palestinian Territory, Occupied", "value": "PS"}, {"label": "Panama", "value": "PA"}, {"label": "Papua New Guinea", "value": "PG"}, {"label": "Paraguay", "value": "PY"}, {"label": "Peru", "value": "PE"}, {"label": "Philippines", "value": "PH"}, {"label": "Pitcairn", "value": "PN"}, {"label": "Poland", "value": "PL"}, {"label": "Portugal", "value": "PT"}, {"label": "Puerto Rico", "value": "PR"}, {"label": "Qatar", "value": "QA"}, {"label": "Reunion Island", "value": "RE"}, {"label": "Romania", "value": "RO"}, {"label": "Russian Federation", "value": "RU"}, {"label": "Rwanda", "value": "RW"}, {"label": "Saint Barthelemy", "value": "BL"}, {"label": "Saint Helena, Ascension And Tristan da Cunha", "value": "SH"}, {"label": "Saint Kitts And Nevis", "value": "KN"}, {"label": "Saint Lucia", "value": "LC"}, {"label": "Saint Martin", "value": "MF"}, {"label": "Saint Pierre And Miquelon", "value": "PM"}, {"label": "Saint Vincent And The Grenadines", "value": "VC"}, {"label": "Samoa", "value": "WS"}, {"label": "San Marino", "value": "SM"}, {"label": "Sao Tome And Principe", "value": "ST"}, {"label": "Saudi Arabia", "value": "SA"}, {"label": "Senegal", "value": "SN"}, {"label": "Serbia", "value": "RS"}, {"label": "Seychelles", "value": "SC"}, {"label": "Sierra Leone", "value": "SL"}, {"label": "Singapore", "value": "SG"}, {"label": "Sint Marteen", "value": "SX"}, {"label": "Slovakia", "value": "SK"}, {"label": "Slovenia", "value": "SI"}, {"label": "Solomon Islands", "value": "SB"}, {"label": "Somalia", "value": "SO"}, {"label": "South Africa", "value": "ZA"}, {"label": "South Georgia And The South Sandwich Islands", "value": "GS"}, {"label": "South Sudan", "value": "SS"}, {"label": "Spain", "value": "ES"}, {"label": "Sri Lanka", "value": "LK"}, {"label": "Sudan", "value": "SD"}, {"label": "Suriname", "value": "SR"}, {"label": "Svalbard And Jan Mayen Islands", "value": "SJ"}, {"label": "Swaziland", "value": "SZ"}, {"label": "Sweden", "value": "SE"}, {"label": "Switzerland", "value": "CH"}, {"label": "Syrian Arab Republic", "value": "SY"}, {"label": "Taiwan, Province Of China", "value": "TW"}, {"label": "Tajikistan", "value": "TJ"}, {"label": "Tanzania, United Republic Of", "value": "TZ"}, {"label": "Thailand", "value": "TH"}, {"label": "Timor-Leste", "value": "TL"}, {"label": "Togo", "value": "TG"}, {"label": "Tokelau", "value": "TK"}, {"label": "Tonga", "value": "TO"}, {"label": "Trinidad And Tobago", "value": "TT"}, {"label": "Tunisia", "value": "TN"}, {"label": "Turkey", "value": "TR"}, {"label": "Turkmenistan", "value": "TM"}, {"label": "Turks And Caicos Islands", "value": "TC"}, {"label": "Tuvalu", "value": "TV"}, {"label": "Uganda", "value": "UG"}, {"label": "Ukraine", "value": "UA"}, {"label": "United Arab Emirates", "value": "AE"}, {"label": "United Kingdom", "value": "GB"}, {"label": "United States", "value": "US"}, {"label": "United States Minor Outlying Islands", "value": "UM"}, {"label": "Uruguay", "value": "UY"}, {"label": "Uzbekistan", "value": "UZ"}, {"label": "Vanuatu", "value": "VU"}, {"label": "Venezuela, Bolivarian Republic Of", "value": "VE"}, {"label": "Viet Nam", "value": "VN"}, {"label": "Virgin Islands, British", "value": "VG"}, {"label": "Virgin Islands, U.S.", "value": "VI"}, {"label": "Wallis And Futuna", "value": "WF"}, {"label": "Western Sahara", "value": "EH"}, {"label": "Yemen", "value": "YE"}, {"label": "Zambia", "value": "ZM"}, {"label": "Zimbabwe", "value": "ZW"}, {"label": "Not categorised", "value": "XX"}, {"label": "Others", "value": "ZZ"}], "validations": {"required": false}}, {"key": "Batch.Report.Transaction[].AmountRupees", "type": "text", "label": "Amount Rupees", "validations": {"required": true, "maxLength": 20}}, {"key": "Batch.Report.Transaction[].AmountForeignCurrency", "type": "text", "label": "Amount Foreign Currency", "validations": {"required": false, "maxLength": 20}}, {"key": "Batch.Report.Transaction[].CurrencyOfTransaction", "type": "select", "label": "Currency Of Transaction", "options": [{"label": "Afghanistan Afghani", "value": "AFA"}, {"label": "Albanian Lek", "value": "ALL"}, {"label": "Algerian Dinar", "value": "DZD"}, {"label": "Angolan Kwanza", "value": "AOR"}, {"label": "Argentine Peso", "value": "ARS"}, {"label": "Armenian Dram", "value": "AMD"}, {"label": "Aruban Guilder", "value": "AWG"}, {"label": "Australian Dollar", "value": "AUD"}, {"label": "Azerbaijani an New Manat", "value": "AZN"}, {"label": "Bahamian Dollar", "value": "BSD"}, {"label": "Bahraini Dinar", "value": "BHD"}, {"label": "Bangladeshi Taka", "value": "BDT"}, {"label": "Barbados Dollar", "value": "BBD"}, {"label": "Belarusian Ruble", "value": "BYR"}, {"label": "Belize Dollar", "value": "BZD"}, {"label": "Bermudian Dollar", "value": "BMD"}, {"label": "Bhutan Ngultrum", "value": "BTN"}, {"label": "Bolivian Boliviano", "value": "BOB"}, {"label": "Botswana Pula", "value": "BWP"}, {"label": "Brazilian Real", "value": "BRL"}, {"label": "British Pound", "value": "GBP"}, {"label": "Brunei Dollar", "value": "BND"}, {"label": "Bulgarian Lev", "value": "BGN"}, {"label": "Burundi Franc", "value": "BIF"}, {"label": "Cambodian Riel", "value": "KHR"}, {"label": "Canadian Dollar", "value": "CAD"}, {"label": "Cape Verde Escudo", "value": "CVE"}, {"label": "Cayman Islands Dollar", "value": "KYD"}, {"label": "CFA Franc BCEAO", "value": "XOF"}, {"label": "CFA Franc BEAC", "value": "XAF"}, {"label": "CFP Franc", "value": "XPF"}, {"label": "Chilean Peso", "value": "CLP"}, {"label": "Chinese Yuan Renminbi", "value": "CNY"}, {"label": "Colombian Peso", "value": "COP"}, {"label": "Comoros Franc", "value": "KMF"}, {"label": "Congolese Franc", "value": "CDF"}, {"label": "Costa Rican Colon", "value": "CRC"}, {"label": "Croatian Kuna", "value": "HRK"}, {"label": "Cuban Peso", "value": "CUP"}, {"label": "Czech Koruna", "value": "CZK"}, {"label": "Danish Kroner", "value": "DKK"}, {"label": "Djibouti Franc", "value": "DJF"}, {"label": "Dominican Peso", "value": "DOP"}, {"label": "East Caribbean Dollar", "value": "XCD"}, {"label": "Egyptian Pound", "value": "EGP"}, {"label": "El Salvador Colon", "value": "SVC"}, {"label": "Eritrean nakfa", "value": "ERN"}, {"label": "Estonian Kroon", "value": "EEK"}, {"label": "Ethiopian Birr", "value": "ETB"}, {"label": "EU Euro", "value": "EUR"}, {"label": "Falkland Islands Pound", "value": "FKP"}, {"label": "Fiji Dollar", "value": "FJD"}, {"label": "Gambian Dalasi", "value": "GMD"}, {"label": "Georgian Lari", "value": "GEL"}, {"label": "Ghanaian New Cedi", "value": "GHS"}, {"label": "Gibraltar Pound", "value": "GIP"}, {"label": "Gold (Ounce)", "value": "XAU"}, {"label": "Gold Franc", "value": "XFO"}, {"label": "Guatemalan Quetzal", "value": "GTQ"}, {"label": "Guinean Franc", "value": "GNF"}, {"label": "Guyana Dollar", "value": "GYD"}, {"label": "Haitian Gourde", "value": "HTG"}, {"label": "Honduran Lempira", "value": "HNL"}, {"label": "Hong Kong SAR Dollar", "value": "HKD"}, {"label": "Hungarian Forint", "value": "HUF"}, {"label": "Icelandic Krona", "value": "ISK"}, {"label": "IMF Special Drawing Right", "value": "XDR"}, {"label": "Indian Rupee", "value": "INR"}, {"label": "Indonesian Rupiah", "value": "IDR"}, {"label": "Iranian Rial", "value": "IRR"}, {"label": "Iraqi Dinar", "value": "IQD"}, {"label": "Israeli New Shekel", "value": "ILS"}, {"label": "Jamaican Dollar", "value": "JMD"}, {"label": "Japanese Yen", "value": "JPY"}, {"label": "Jordanian Dinar", "value": "JOD"}, {"label": "Kazakhstani Tenge", "value": "KZT"}, {"label": "Kenyan Shilling", "value": "KES"}, {"label": "Kuwaiti Dinar", "value": "KWD"}, {"label": "Kyrgyz Som", "value": "KGS"}, {"label": "Lao Kip", "value": "LAK"}, {"label": "Latvian Lats", "value": "LVL"}, {"label": "Lebanese Pound", "value": "LBP"}, {"label": "Lesotho Loti", "value": "LSL"}, {"label": "Liberian Dollar", "value": "LRD"}, {"label": "Libyan Dinar", "value": "LYD"}, {"label": "Lithuanian Lit as", "value": "LTL"}, {"label": "Macao Patacas", "value": "MOP"}, {"label": "Macedonian Denary", "value": "MKD"}, {"label": "Malagasy Ariary", "value": "MGA"}, {"label": "Malawi Kwacha", "value": "MWK"}, {"label": "Malaysian Ringgit", "value": "MYR"}, {"label": "Maldivian Rufiyaa", "value": "MVR"}, {"label": "Mauritanian Ouguiya", "value": "MRO"}, {"label": "Mauritius Rupee", "value": "MUR"}, {"label": "Mexican Peso", "value": "MXN"}, {"label": "Moldovan Leu", "value": "MDL"}, {"label": "Mongolian Tugrik", "value": "MNT"}, {"label": "Moroccan Dirham", "value": "MAD"}, {"label": "Mozambique New Metical", "value": "MZN"}, {"label": "Myanmar Kyat", "value": "MMK"}, {"label": "Namibian Dollar", "value": "NAD"}, {"label": "Nepalese Rupee", "value": "NPR"}, {"label": "Netherlands Antillean Guilder", "value": "ANG"}, {"label": "Netherlands Antillean Florin", "value": "NAF"}, {"label": "New Zealand Dollar", "value": "NZD"}, {"label": "Nicaraguan Cordoba Oro", "value": "NIO"}, {"label": "Nigerian Naira", "value": "NGN"}, {"label": "North Korean Won", "value": "KPW"}, {"label": "Norwegian Kroner", "value": "NOK"}, {"label": "Omani Rial", "value": "OMR"}, {"label": "Pakistani Rupee", "value": "PKR"}, {"label": "Palladium (Ounce)", "value": "XPD"}, {"label": "Panamanian Balboa", "value": "PAB"}, {"label": "Papua New Guinea Kina", "value": "PGK"}, {"label": "Paraguayan Guarani", "value": "PYG"}, {"label": "Peruvian Nuevo Sol", "value": "PEN"}, {"label": "Philippine Peso", "value": "PHP"}, {"label": "Platinum (Ounce)", "value": "XPT"}, {"label": "Polish Zloty", "value": "PLN"}, {"label": "Qatari Rial", "value": "QAR"}, {"label": "Romanian New Leu", "value": "RON"}, {"label": "Russian Ruble", "value": "RUB"}, {"label": "Rwandan Franc", "value": "RWF"}, {"label": "Saint Helena Pound", "value": "SHP"}, {"label": "Samoan tala", "value": "WST"}, {"label": "Sao Tome And Principe Dobra", "value": "STD"}, {"label": "Saudi Riyal", "value": "SAR"}, {"label": "Serbian Dinar", "value": "RSD"}, {"label": "Seychelles Rupee", "value": "SCR"}, {"label": "Sierra Leone", "value": "SLL"}, {"label": "Silver (Ounce)", "value": "XAG"}, {"label": "Singapore Dollar", "value": "SGD"}, {"label": "Solomon Islands Dollar", "value": "SBD"}, {"label": "Somali Shilling", "value": "SOS"}, {"label": "South African Rand", "value": "ZAR"}, {"label": "South Korean Won", "value": "KRW"}, {"label": "South Sudanese Pound", "value": "SSP"}, {"label": "Sri Lanka Rupee", "value": "LKR"}, {"label": "Sudanese Pound", "value": "SDG"}, {"label": "Suriname Dollar", "value": "SRD"}, {"label": "Swaziland Lilangeni", "value": "SZL"}, {"label": "Swedish Krona", "value": "SEK"}, {"label": "Swiss Franc", "value": "CHF"}, {"label": "Syrian Pound", "value": "SYP"}, {"label": "Taiwan New Dollar", "value": "TWD"}, {"label": "Tajik Somoni", "value": "TJS"}, {"label": "Tanzanian Shilling", "value": "TZS"}, {"label": "Thai Baht", "value": "THB"}, {"label": "Tongan Pa''anga", "value": "TOP"}, {"label": "Trinidad And Tobago Dollar", "value": "TTD"}, {"label": "Tunisian Dinar", "value": "TND"}, {"label": "Turkish Lira", "value": "TRY"}, {"label": "Turkmen New Man at", "value": "TMT"}, {"label": "UAE Dirham", "value": "AED"}, {"label": "Uganda New Shilling", "value": "UGX"}, {"label": "UIC Franc", "value": "XFU"}, {"label": "Ukrainian Hryvnia", "value": "UAH"}, {"label": "Peso Uruguayo", "value": "UYU"}, {"label": "US Dollar", "value": "USD"}, {"label": "Uzbekistani Sum", "value": "UZS"}, {"label": "Vanuatu Vatu", "value": "VUV"}, {"label": "Venezuelan Bolivar Fuertes", "value": "VEF"}, {"label": "Vietnamese Dong", "value": "VND"}, {"label": "Yemeni Rial", "value": "YER"}, {"label": "Zambian Kwacha", "value": "ZMK"}, {"label": "Zimbabwe Dollar", "value": "ZWL"}, {"label": "Not Categorised", "value": "XXX"}, {"label": "Others", "value": "ZZZ"}], "validations": {"required": false}}, {"key": "Batch.Report.Transaction[].PurposeOfTransaction", "type": "text", "label": "Purpose Of Transaction", "validations": {"required": true, "maxLength": 100}}, {"key": "Batch.Report.Transaction[].PurposeCode", "type": "text", "label": "Purpose Code", "validations": {"required": true, "maxLength": 5}}, {"key": "Batch.Report.Transaction[].RiskRating", "type": "select", "label": "Risk Rating", "options": [{"label": "High Risk Transaction", "value": "T1"}, {"label": "Medium Risk Transaction", "value": "T2"}, {"label": "Low Risk Transaction", "value": "T3"}, {"label": "Not Categorised", "value": "XX"}], "validations": {"required": true}}, {"key": "Batch.Report.Transaction[].AccountNumber", "type": "text", "label": "Account Number", "validations": {"required": false, "maxLength": 20}}, {"key": "Batch.Report.Transaction[].AccountWithInstitutionName", "type": "text", "label": "Account With Institution Name", "validations": {"required": false, "maxLength": 80}}, {"key": "Batch.Report.Transaction[].AccountWithInstitutionRefNum", "type": "text", "label": "Account With Institution Ref Num", "validations": {"required": false, "maxLength": 20}}, {"key": "Batch.Report.Transaction[].RelatedInstitutionName", "type": "text", "label": "Related Institution Name", "validations": {"required": false, "maxLength": 80}}, {"key": "Batch.Report.Transaction[].InstitutionRelationFlag", "type": "select", "label": "Institution Relation Flag", "options": [{"label": "Acquirer Institution", "value": "D"}, {"label": "Sender’s Correspondent Institution", "value": "E"}, {"label": "Receiver’s Correspondent Institution", "value": "F"}, {"label": "Others", "value": "Z"}, {"label": "Not categorised", "value": "X"}], "validations": {"required": false}}, {"key": "Batch.Report.Transaction[].RelatedInstitutionRefNum", "type": "text", "label": "Related Institution Ref Num", "validations": {"required": false, "maxLength": 20}}, {"key": "Batch.Report.Transaction[].Remarks", "type": "text", "label": "Remarks", "validations": {"required": false, "maxLength": 50}}, {"section": {"label": "Customer Detials", "fields": [{"key": "Batch.Report.Transaction[].CustomerDetails.CustomerName", "type": "text", "label": "Customer Name", "validations": {"required": true, "maxLength": 80}}, {"key": "Batch.Report.Transaction[].CustomerDetails.CustomerId", "type": "text", "label": "CustomerID", "validations": {"required": false, "maxLength": 10}}, {"key": "Batch.Report.Transaction[].CustomerDetails.Occupation", "type": "text", "label": "Occupation", "validations": {"required": false, "maxLength": 50}}, {"key": "Batch.Report.Transaction[].CustomerDetails.DateOfBirth", "type": "date", "label": "Date Of Birth", "format": "YYYY-MM-DDDD", "validations": {"required": false}}, {"key": "Batch.Report.Transaction[].CustomerDetails.Gender", "type": "select", "label": "Gender", "options": [{"label": "Male", "value": "M"}, {"label": "Female", "value": "F"}, {"label": "Not Categorised", "value": "X"}], "validations": {"required": false}}, {"key": "Batch.Report.Transaction[].CustomerDetails.Nationality", "type": "select", "label": "Nationality", "options": [{"label": "Afghanistan", "value": "AF"}, {"label": "Aland Islands", "value": "AX"}, {"label": "Albania", "value": "AL"}, {"label": "Algeria", "value": "DZ"}, {"label": "American Samoa", "value": "AS"}, {"label": "Andorra", "value": "AD"}, {"label": "Angola", "value": "AO"}, {"label": "Anguilla", "value": "AI"}, {"label": "Antarctica", "value": "AQ"}, {"label": "Antigua And Barbuda", "value": "AG"}, {"label": "Argentina", "value": "AR"}, {"label": "Armenia", "value": "AM"}, {"label": "Aruba", "value": "AW"}, {"label": "Australia", "value": "AU"}, {"label": "Austria", "value": "AT"}, {"label": "Azerbaijan", "value": "AZ"}, {"label": "Bahamas", "value": "BS"}, {"label": "Bahrain", "value": "BH"}, {"label": "Bangladesh", "value": "BD"}, {"label": "Barbados", "value": "BB"}, {"label": "Belarus", "value": "BY"}, {"label": "Belgium", "value": "BE"}, {"label": "Belize", "value": "BZ"}, {"label": "Benin", "value": "BJ"}, {"label": "Bermuda", "value": "BM"}, {"label": "Bhutan", "value": "BT"}, {"label": "Bolivia", "value": "BO"}, {"label": "Bosnia And Herzegovina", "value": "BA"}, {"label": "Bonaire, Sint Eustatius and Saba", "value": "BQ"}, {"label": "Botswana", "value": "BW"}, {"label": "Bouvet Island", "value": "BV"}, {"label": "Brazil", "value": "BR"}, {"label": "British Indian Ocean Territory", "value": "IO"}, {"label": "Brunei Darussalam", "value": "BN"}, {"label": "Bulgaria", "value": "BG"}, {"label": "Burkina Faso", "value": "BF"}, {"label": "Burundi", "value": "BI"}, {"label": "Cambodia", "value": "KH"}, {"label": "Cameroon", "value": "CM"}, {"label": "Canada", "value": "CA"}, {"label": "Cape Verde", "value": "CV"}, {"label": "Cayman Islands", "value": "KY"}, {"label": "Central African Republic", "value": "CF"}, {"label": "Chad", "value": "TD"}, {"label": "Chile", "value": "CL"}, {"label": "China", "value": "CN"}, {"label": "Christmas Island", "value": "CX"}, {"label": "Cocos (Keeling) Islands", "value": "CC"}, {"label": "Colombia", "value": "CO"}, {"label": "Comoros", "value": "KM"}, {"label": "Congo", "value": "CG"}, {"label": "Congo, The Democratic Republic Of The", "value": "CD"}, {"label": "Cook Islands", "value": "CK"}, {"label": "Costa Rica", "value": "CR"}, {"label": "Côte D''ivoire", "value": "CI"}, {"label": "Croatia", "value": "HR"}, {"label": "Cuba", "value": "CU"}, {"label": "Curacao", "value": "CW"}, {"label": "Cyprus", "value": "CY"}, {"label": "Czech Republic", "value": "CZ"}, {"label": "Denmark", "value": "DK"}, {"label": "Djibouti", "value": "DJ"}, {"label": "Dominica", "value": "DM"}, {"label": "Dominican Republic", "value": "DO"}, {"label": "Ecuador", "value": "EC"}, {"label": "Egypt", "value": "EG"}, {"label": "El Salvador", "value": "SV"}, {"label": "Equatorial Guinea", "value": "GQ"}, {"label": "Eritrea", "value": "ER"}, {"label": "Estonia", "value": "EE"}, {"label": "Ethiopia", "value": "ET"}, {"label": "Falkland Islands (Malvinas)", "value": "FK"}, {"label": "Faroe Islands", "value": "FO"}, {"label": "Fiji", "value": "FJ"}, {"label": "Finland", "value": "FI"}, {"label": "France", "value": "FR"}, {"label": "French Guiana", "value": "GF"}, {"label": "French Polynesia", "value": "PF"}, {"label": "French Southern Territories", "value": "TF"}, {"label": "Gabon", "value": "GA"}, {"label": "Gambia", "value": "GM"}, {"label": "Georgia", "value": "GE"}, {"label": "Germany", "value": "DE"}, {"label": "Ghana", "value": "GH"}, {"label": "Gibraltar", "value": "GI"}, {"label": "Greece", "value": "GR"}, {"label": "Greenland", "value": "GL"}, {"label": "Grenada", "value": "GD"}, {"label": "Guadeloupe", "value": "GP"}, {"label": "Guam", "value": "GU"}, {"label": "Guatemala", "value": "GT"}, {"label": "Guernsey", "value": "GG"}, {"label": "Guinea", "value": "GN"}, {"label": "Guinea-Bissau", "value": "GW"}, {"label": "Guyana", "value": "GY"}, {"label": "Haiti", "value": "HT"}, {"label": "Heard Island And McDonald Islands", "value": "HM"}, {"label": "Vatican City State", "value": "VA"}, {"label": "Honduras", "value": "HN"}, {"label": "Hong Kong", "value": "HK"}, {"label": "Hungary", "value": "HU"}, {"label": "Iceland", "value": "IS"}, {"label": "India", "value": "IN"}, {"label": "Indonesia", "value": "ID"}, {"label": "Iran, Islamic Republic Of", "value": "IR"}, {"label": "Iraq", "value": "IQ"}, {"label": "Ireland", "value": "IE"}, {"label": "Isle Of Man", "value": "IM"}, {"label": "Israel", "value": "IL"}, {"label": "Italy", "value": "IT"}, {"label": "Jamaica", "value": "JM"}, {"label": "Japan", "value": "JP"}, {"label": "Jersey", "value": "JE"}, {"label": "Jordan", "value": "JO"}, {"label": "Kazakhstan", "value": "KZ"}, {"label": "Kenya", "value": "KE"}, {"label": "Kiribati", "value": "KI"}, {"label": "Korea, Democratic People''s Republic Of", "value": "KP"}, {"label": "Korea, Republic Of", "value": "KR"}, {"label": "Kuwait", "value": "KW"}, {"label": "Kyrgyzstan", "value": "KG"}, {"label": "Lao People''s Democratic Republic", "value": "LA"}, {"label": "Latvia", "value": "LV"}, {"label": "Lebanon", "value": "LB"}, {"label": "Lesotho", "value": "LS"}, {"label": "Liberia", "value": "LR"}, {"label": "Libyan Arab Jamahiriya", "value": "LY"}, {"label": "Liechtenstein", "value": "LI"}, {"label": "Lithuania", "value": "LT"}, {"label": "Luxembourg", "value": "LU"}, {"label": "Macao", "value": "MO"}, {"label": "Macedonia, The Former Yugoslav Republic Of", "value": "MK"}, {"label": "Madagascar", "value": "MG"}, {"label": "Malawi", "value": "MW"}, {"label": "Malaysia", "value": "MY"}, {"label": "Maldives", "value": "MV"}, {"label": "Mali", "value": "ML"}, {"label": "Malta", "value": "MT"}, {"label": "Marshall Islands", "value": "MH"}, {"label": "Martinique", "value": "MQ"}, {"label": "Mauritania", "value": "MR"}, {"label": "Mauritius", "value": "MU"}, {"label": "Mayotte", "value": "YT"}, {"label": "Mexico", "value": "MX"}, {"label": "Micronesia, Federated States Of", "value": "FM"}, {"label": "Moldova, Republic Of", "value": "MD"}, {"label": "Monaco", "value": "MC"}, {"label": "Mongolia", "value": "MN"}, {"label": "Montenegro", "value": "ME"}, {"label": "Montserrat", "value": "MS"}, {"label": "Morocco", "value": "MA"}, {"label": "Mozambique", "value": "MZ"}, {"label": "Myanmar", "value": "MM"}, {"label": "Namibia", "value": "NA"}, {"label": "Nauru", "value": "NR"}, {"label": "Nepal", "value": "NP"}, {"label": "Netherlands", "value": "NL"}, {"label": "Netherlands Antilles", "value": "AN"}, {"label": "New Caledonia", "value": "NC"}, {"label": "New Zealand", "value": "NZ"}, {"label": "Nicaragua", "value": "NI"}, {"label": "Niger", "value": "NE"}, {"label": "Nigeria", "value": "NG"}, {"label": "Niue", "value": "NU"}, {"label": "Norfolk Island", "value": "NF"}, {"label": "Northern Mariana Islands", "value": "MP"}, {"label": "Norway", "value": "NO"}, {"label": "Oman", "value": "OM"}, {"label": "Pakistan", "value": "PK"}, {"label": "Palau", "value": "PW"}, {"label": "Palestinian Territory, Occupied", "value": "PS"}, {"label": "Panama", "value": "PA"}, {"label": "Papua New Guinea", "value": "PG"}, {"label": "Paraguay", "value": "PY"}, {"label": "Peru", "value": "PE"}, {"label": "Philippines", "value": "PH"}, {"label": "Pitcairn", "value": "PN"}, {"label": "Poland", "value": "PL"}, {"label": "Portugal", "value": "PT"}, {"label": "Puerto Rico", "value": "PR"}, {"label": "Qatar", "value": "QA"}, {"label": "Reunion Island", "value": "RE"}, {"label": "Romania", "value": "RO"}, {"label": "Russian Federation", "value": "RU"}, {"label": "Rwanda", "value": "RW"}, {"label": "Saint Barthelemy", "value": "BL"}, {"label": "Saint Helena, Ascension And Tristan da Cunha", "value": "SH"}, {"label": "Saint Kitts And Nevis", "value": "KN"}, {"label": "Saint Lucia", "value": "LC"}, {"label": "Saint Martin", "value": "MF"}, {"label": "Saint Pierre And Miquelon", "value": "PM"}, {"label": "Saint Vincent And The Grenadines", "value": "VC"}, {"label": "Samoa", "value": "WS"}, {"label": "San Marino", "value": "SM"}, {"label": "Sao Tome And Principe", "value": "ST"}, {"label": "Saudi Arabia", "value": "SA"}, {"label": "Senegal", "value": "SN"}, {"label": "Serbia", "value": "RS"}, {"label": "Seychelles", "value": "SC"}, {"label": "Sierra Leone", "value": "SL"}, {"label": "Singapore", "value": "SG"}, {"label": "Sint Marteen", "value": "SX"}, {"label": "Slovakia", "value": "SK"}, {"label": "Slovenia", "value": "SI"}, {"label": "Solomon Islands", "value": "SB"}, {"label": "Somalia", "value": "SO"}, {"label": "South Africa", "value": "ZA"}, {"label": "South Georgia And The South Sandwich Islands", "value": "GS"}, {"label": "South Sudan", "value": "SS"}, {"label": "Spain", "value": "ES"}, {"label": "Sri Lanka", "value": "LK"}, {"label": "Sudan", "value": "SD"}, {"label": "Suriname", "value": "SR"}, {"label": "Svalbard And Jan Mayen Islands", "value": "SJ"}, {"label": "Swaziland", "value": "SZ"}, {"label": "Sweden", "value": "SE"}, {"label": "Switzerland", "value": "CH"}, {"label": "Syrian Arab Republic", "value": "SY"}, {"label": "Taiwan, Province Of China", "value": "TW"}, {"label": "Tajikistan", "value": "TJ"}, {"label": "Tanzania, United Republic Of", "value": "TZ"}, {"label": "Thailand", "value": "TH"}, {"label": "Timor-Leste", "value": "TL"}, {"label": "Togo", "value": "TG"}, {"label": "Tokelau", "value": "TK"}, {"label": "Tonga", "value": "TO"}, {"label": "Trinidad And Tobago", "value": "TT"}, {"label": "Tunisia", "value": "TN"}, {"label": "Turkey", "value": "TR"}, {"label": "Turkmenistan", "value": "TM"}, {"label": "Turks And Caicos Islands", "value": "TC"}, {"label": "Tuvalu", "value": "TV"}, {"label": "Uganda", "value": "UG"}, {"label": "Ukraine", "value": "UA"}, {"label": "United Arab Emirates", "value": "AE"}, {"label": "United Kingdom", "value": "GB"}, {"label": "United States", "value": "US"}, {"label": "United States Minor Outlying Islands", "value": "UM"}, {"label": "Uruguay", "value": "UY"}, {"label": "Uzbekistan", "value": "UZ"}, {"label": "Vanuatu", "value": "VU"}, {"label": "Venezuela, Bolivarian Republic Of", "value": "VE"}, {"label": "Viet Nam", "value": "VN"}, {"label": "Virgin Islands, British", "value": "VG"}, {"label": "Virgin Islands, U.S.", "value": "VI"}, {"label": "Wallis And Futuna", "value": "WF"}, {"label": "Western Sahara", "value": "EH"}, {"label": "Yemen", "value": "YE"}, {"label": "Zambia", "value": "ZM"}, {"label": "Zimbabwe", "value": "ZW"}, {"label": "Not categorised", "value": "XX"}, {"label": "Others", "value": "ZZ"}], "validations": {"required": false}}, {"key": "Batch.Report.Transaction[].CustomerDetails.IdentificationType", "type": "select", "label": "Identification Type", "options": [{"label": "Passport", "value": "A"}, {"label": "Election Id Card", "value": "B"}, {"label": "Pan Card", "value": "C"}, {"label": "ID Card", "value": "D"}, {"label": "Driving License", "value": "E"}, {"label": "Account Introducer", "value": "F"}, {"label": "UIDAI letter", "value": "G"}, {"label": "NREGA job card", "value": "H"}, {"label": "Others", "value": "Z"}], "validations": {"required": false}}, {"key": "Batch.Report.Transaction[].CustomerDetails.IdentificationNumber", "type": "text", "label": "Identification Number", "validations": {"required": false, "maxLength": 20}}, {"key": "Batch.Report.Transaction[].CustomerDetails.IssuingAuthority", "type": "text", "label": "Issuing Authority", "validations": {"required": false, "maxLength": 20}}, {"key": "Batch.Report.Transaction[].CustomerDetails.PlaceOfIssue", "type": "text", "label": "Place Of Issue", "validations": {"required": false, "maxLength": 20}}, {"key": "Batch.Report.Transaction[].CustomerDetails.PAN", "type": "text", "label": "PAN", "validations": {"required": false, "maxLength": 10}}, {"key": "Batch.Report.Transaction[].CustomerDetails.UIN", "type": "text", "label": "UIN", "validations": {"required": false, "maxLength": 30}}, {"key": "Batch.Report.Transaction[].CustomerDetails.Email", "type": "text", "label": "Email", "validations": {"required": false, "maxLength": 50}}, {"section": {"label": "Customer Address", "fields": [{"key": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.Address", "type": "text", "label": "Address", "validations": {"required": true, "maxLength": 225, "minLength": 8}}, {"key": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.City", "type": "text", "label": "City", "validations": {"required": false, "maxLength": 50}}, {"key": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.StateCode", "type": "select", "label": "State Code", "options": [{"label": "Andaman & Nicobar", "value": "AN"}, {"label": "Andhra Pradesh", "value": "AP"}, {"label": "Arunachal Pradesh", "value": "AR"}, {"label": "Assam", "value": "AS"}, {"label": "Bihar", "value": "BR"}, {"label": "Chandigarh", "value": "CH"}, {"label": "Chhattisgarh", "value": "CG"}, {"label": "Dadra and Nagar Haveli", "value": "DN"}, {"label": "Daman & Diu", "value": "DD"}, {"label": "Delhi", "value": "DL"}, {"label": "Goa", "value": "GA"}, {"label": "Gujarat", "value": "GJ"}, {"label": "Haryana", "value": "HR"}, {"label": "Himachal Pradesh", "value": "HP"}, {"label": "Jammu & Kashmir", "value": "JK"}, {"label": "Jharkhand", "value": "JH"}, {"label": "Karnataka", "value": "KA"}, {"label": "Kerala", "value": "KL"}, {"label": "Lakshadweep", "value": "LD"}, {"label": "Madhya Pradesh", "value": "MP"}, {"label": "Maharashtra", "value": "MH"}, {"label": "Manipur", "value": "MN"}, {"label": "Meghalaya", "value": "ML"}, {"label": "Mizoram", "value": "MZ"}, {"label": "Nagaland", "value": "NL"}, {"label": "Orissa", "value": "OR"}, {"label": "Pondicherry", "value": "PY"}, {"label": "Punjab", "value": "PB"}, {"label": "Rajasthan", "value": "RJ"}, {"label": "Sikkim", "value": "SK"}, {"label": "Tamil Nadu", "value": "TN"}, {"label": "Tripura", "value": "TR"}, {"label": "Uttar Pradesh", "value": "UP"}, {"label": "Uttarakhand", "value": "UA"}, {"label": "West Bengal", "value": "WB"}, {"label": "Others", "value": "ZZ"}, {"label": "Not Applicable", "value": "XX"}], "validations": {"required": true}}, {"key": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.PinCode", "type": "text", "label": "Pincode", "validations": {"required": false, "maxLength": 10}}, {"key": "Batch.Report.Transaction[].CustomerDetails.CustomerAddress.CountryCode", "type": "select", "label": "Country Code", "options": [{"label": "Afghanistan", "value": "AF"}, {"label": "Aland Islands", "value": "AX"}, {"label": "Albania", "value": "AL"}, {"label": "Algeria", "value": "DZ"}, {"label": "American Samoa", "value": "AS"}, {"label": "Andorra", "value": "AD"}, {"label": "Angola", "value": "AO"}, {"label": "Anguilla", "value": "AI"}, {"label": "Antarctica", "value": "AQ"}, {"label": "Antigua And Barbuda", "value": "AG"}, {"label": "Argentina", "value": "AR"}, {"label": "Armenia", "value": "AM"}, {"label": "Aruba", "value": "AW"}, {"label": "Australia", "value": "AU"}, {"label": "Austria", "value": "AT"}, {"label": "Azerbaijan", "value": "AZ"}, {"label": "Bahamas", "value": "BS"}, {"label": "Bahrain", "value": "BH"}, {"label": "Bangladesh", "value": "BD"}, {"label": "Barbados", "value": "BB"}, {"label": "Belarus", "value": "BY"}, {"label": "Belgium", "value": "BE"}, {"label": "Belize", "value": "BZ"}, {"label": "Benin", "value": "BJ"}, {"label": "Bermuda", "value": "BM"}, {"label": "Bhutan", "value": "BT"}, {"label": "Bolivia", "value": "BO"}, {"label": "Bosnia And Herzegovina", "value": "BA"}, {"label": "Bonaire, Sint Eustatius and Saba", "value": "BQ"}, {"label": "Botswana", "value": "BW"}, {"label": "Bouvet Island", "value": "BV"}, {"label": "Brazil", "value": "BR"}, {"label": "British Indian Ocean Territory", "value": "IO"}, {"label": "Brunei Darussalam", "value": "BN"}, {"label": "Bulgaria", "value": "BG"}, {"label": "Burkina Faso", "value": "BF"}, {"label": "Burundi", "value": "BI"}, {"label": "Cambodia", "value": "KH"}, {"label": "Cameroon", "value": "CM"}, {"label": "Canada", "value": "CA"}, {"label": "Cape Verde", "value": "CV"}, {"label": "Cayman Islands", "value": "KY"}, {"label": "Central African Republic", "value": "CF"}, {"label": "Chad", "value": "TD"}, {"label": "Chile", "value": "CL"}, {"label": "China", "value": "CN"}, {"label": "Christmas Island", "value": "CX"}, {"label": "Cocos (Keeling) Islands", "value": "CC"}, {"label": "Colombia", "value": "CO"}, {"label": "Comoros", "value": "KM"}, {"label": "Congo", "value": "CG"}, {"label": "Congo, The Democratic Republic Of The", "value": "CD"}, {"label": "Cook Islands", "value": "CK"}, {"label": "Costa Rica", "value": "CR"}, {"label": "Côte D''ivoire", "value": "CI"}, {"label": "Croatia", "value": "HR"}, {"label": "Cuba", "value": "CU"}, {"label": "Curacao", "value": "CW"}, {"label": "Cyprus", "value": "CY"}, {"label": "Czech Republic", "value": "CZ"}, {"label": "Denmark", "value": "DK"}, {"label": "Djibouti", "value": "DJ"}, {"label": "Dominica", "value": "DM"}, {"label": "Dominican Republic", "value": "DO"}, {"label": "Ecuador", "value": "EC"}, {"label": "Egypt", "value": "EG"}, {"label": "El Salvador", "value": "SV"}, {"label": "Equatorial Guinea", "value": "GQ"}, {"label": "Eritrea", "value": "ER"}, {"label": "Estonia", "value": "EE"}, {"label": "Ethiopia", "value": "ET"}, {"label": "Falkland Islands (Malvinas)", "value": "FK"}, {"label": "Faroe Islands", "value": "FO"}, {"label": "Fiji", "value": "FJ"}, {"label": "Finland", "value": "FI"}, {"label": "France", "value": "FR"}, {"label": "French Guiana", "value": "GF"}, {"label": "French Polynesia", "value": "PF"}, {"label": "French Southern Territories", "value": "TF"}, {"label": "Gabon", "value": "GA"}, {"label": "Gambia", "value": "GM"}, {"label": "Georgia", "value": "GE"}, {"label": "Germany", "value": "DE"}, {"label": "Ghana", "value": "GH"}, {"label": "Gibraltar", "value": "GI"}, {"label": "Greece", "value": "GR"}, {"label": "Greenland", "value": "GL"}, {"label": "Grenada", "value": "GD"}, {"label": "Guadeloupe", "value": "GP"}, {"label": "Guam", "value": "GU"}, {"label": "Guatemala", "value": "GT"}, {"label": "Guernsey", "value": "GG"}, {"label": "Guinea", "value": "GN"}, {"label": "Guinea-Bissau", "value": "GW"}, {"label": "Guyana", "value": "GY"}, {"label": "Haiti", "value": "HT"}, {"label": "Heard Island And McDonald Islands", "value": "HM"}, {"label": "Vatican City State", "value": "VA"}, {"label": "Honduras", "value": "HN"}, {"label": "Hong Kong", "value": "HK"}, {"label": "Hungary", "value": "HU"}, {"label": "Iceland", "value": "IS"}, {"label": "India", "value": "IN"}, {"label": "Indonesia", "value": "ID"}, {"label": "Iran, Islamic Republic Of", "value": "IR"}, {"label": "Iraq", "value": "IQ"}, {"label": "Ireland", "value": "IE"}, {"label": "Isle Of Man", "value": "IM"}, {"label": "Israel", "value": "IL"}, {"label": "Italy", "value": "IT"}, {"label": "Jamaica", "value": "JM"}, {"label": "Japan", "value": "JP"}, {"label": "Jersey", "value": "JE"}, {"label": "Jordan", "value": "JO"}, {"label": "Kazakhstan", "value": "KZ"}, {"label": "Kenya", "value": "KE"}, {"label": "Kiribati", "value": "KI"}, {"label": "Korea, Democratic People''s Republic Of", "value": "KP"}, {"label": "Korea, Republic Of", "value": "KR"}, {"label": "Kuwait", "value": "KW"}, {"label": "Kyrgyzstan", "value": "KG"}, {"label": "Lao People''s Democratic Republic", "value": "LA"}, {"label": "Latvia", "value": "LV"}, {"label": "Lebanon", "value": "LB"}, {"label": "Lesotho", "value": "LS"}, {"label": "Liberia", "value": "LR"}, {"label": "Libyan Arab Jamahiriya", "value": "LY"}, {"label": "Liechtenstein", "value": "LI"}, {"label": "Lithuania", "value": "LT"}, {"label": "Luxembourg", "value": "LU"}, {"label": "Macao", "value": "MO"}, {"label": "Macedonia, The Former Yugoslav Republic Of", "value": "MK"}, {"label": "Madagascar", "value": "MG"}, {"label": "Malawi", "value": "MW"}, {"label": "Malaysia", "value": "MY"}, {"label": "Maldives", "value": "MV"}, {"label": "Mali", "value": "ML"}, {"label": "Malta", "value": "MT"}, {"label": "Marshall Islands", "value": "MH"}, {"label": "Martinique", "value": "MQ"}, {"label": "Mauritania", "value": "MR"}, {"label": "Mauritius", "value": "MU"}, {"label": "Mayotte", "value": "YT"}, {"label": "Mexico", "value": "MX"}, {"label": "Micronesia, Federated States Of", "value": "FM"}, {"label": "Moldova, Republic Of", "value": "MD"}, {"label": "Monaco", "value": "MC"}, {"label": "Mongolia", "value": "MN"}, {"label": "Montenegro", "value": "ME"}, {"label": "Montserrat", "value": "MS"}, {"label": "Morocco", "value": "MA"}, {"label": "Mozambique", "value": "MZ"}, {"label": "Myanmar", "value": "MM"}, {"label": "Namibia", "value": "NA"}, {"label": "Nauru", "value": "NR"}, {"label": "Nepal", "value": "NP"}, {"label": "Netherlands", "value": "NL"}, {"label": "Netherlands Antilles", "value": "AN"}, {"label": "New Caledonia", "value": "NC"}, {"label": "New Zealand", "value": "NZ"}, {"label": "Nicaragua", "value": "NI"}, {"label": "Niger", "value": "NE"}, {"label": "Nigeria", "value": "NG"}, {"label": "Niue", "value": "NU"}, {"label": "Norfolk Island", "value": "NF"}, {"label": "Northern Mariana Islands", "value": "MP"}, {"label": "Norway", "value": "NO"}, {"label": "Oman", "value": "OM"}, {"label": "Pakistan", "value": "PK"}, {"label": "Palau", "value": "PW"}, {"label": "Palestinian Territory, Occupied", "value": "PS"}, {"label": "Panama", "value": "PA"}, {"label": "Papua New Guinea", "value": "PG"}, {"label": "Paraguay", "value": "PY"}, {"label": "Peru", "value": "PE"}, {"label": "Philippines", "value": "PH"}, {"label": "Pitcairn", "value": "PN"}, {"label": "Poland", "value": "PL"}, {"label": "Portugal", "value": "PT"}, {"label": "Puerto Rico", "value": "PR"}, {"label": "Qatar", "value": "QA"}, {"label": "Reunion Island", "value": "RE"}, {"label": "Romania", "value": "RO"}, {"label": "Russian Federation", "value": "RU"}, {"label": "Rwanda", "value": "RW"}, {"label": "Saint Barthelemy", "value": "BL"}, {"label": "Saint Helena, Ascension And Tristan da Cunha", "value": "SH"}, {"label": "Saint Kitts And Nevis", "value": "KN"}, {"label": "Saint Lucia", "value": "LC"}, {"label": "Saint Martin", "value": "MF"}, {"label": "Saint Pierre And Miquelon", "value": "PM"}, {"label": "Saint Vincent And The Grenadines", "value": "VC"}, {"label": "Samoa", "value": "WS"}, {"label": "San Marino", "value": "SM"}, {"label": "Sao Tome And Principe", "value": "ST"}, {"label": "Saudi Arabia", "value": "SA"}, {"label": "Senegal", "value": "SN"}, {"label": "Serbia", "value": "RS"}, {"label": "Seychelles", "value": "SC"}, {"label": "Sierra Leone", "value": "SL"}, {"label": "Singapore", "value": "SG"}, {"label": "Sint Marteen", "value": "SX"}, {"label": "Slovakia", "value": "SK"}, {"label": "Slovenia", "value": "SI"}, {"label": "Solomon Islands", "value": "SB"}, {"label": "Somalia", "value": "SO"}, {"label": "South Africa", "value": "ZA"}, {"label": "South Georgia And The South Sandwich Islands", "value": "GS"}, {"label": "South Sudan", "value": "SS"}, {"label": "Spain", "value": "ES"}, {"label": "Sri Lanka", "value": "LK"}, {"label": "Sudan", "value": "SD"}, {"label": "Suriname", "value": "SR"}, {"label": "Svalbard And Jan Mayen Islands", "value": "SJ"}, {"label": "Swaziland", "value": "SZ"}, {"label": "Sweden", "value": "SE"}, {"label": "Switzerland", "value": "CH"}, {"label": "Syrian Arab Republic", "value": "SY"}, {"label": "Taiwan, Province Of China", "value": "TW"}, {"label": "Tajikistan", "value": "TJ"}, {"label": "Tanzania, United Republic Of", "value": "TZ"}, {"label": "Thailand", "value": "TH"}, {"label": "Timor-Leste", "value": "TL"}, {"label": "Togo", "value": "TG"}, {"label": "Tokelau", "value": "TK"}, {"label": "Tonga", "value": "TO"}, {"label": "Trinidad And Tobago", "value": "TT"}, {"label": "Tunisia", "value": "TN"}, {"label": "Turkey", "value": "TR"}, {"label": "Turkmenistan", "value": "TM"}, {"label": "Turks And Caicos Islands", "value": "TC"}, {"label": "Tuvalu", "value": "TV"}, {"label": "Uganda", "value": "UG"}, {"label": "Ukraine", "value": "UA"}, {"label": "United Arab Emirates", "value": "AE"}, {"label": "United Kingdom", "value": "GB"}, {"label": "United States", "value": "US"}, {"label": "United States Minor Outlying Islands", "value": "UM"}, {"label": "Uruguay", "value": "UY"}, {"label": "Uzbekistan", "value": "UZ"}, {"label": "Vanuatu", "value": "VU"}, {"label": "Venezuela, Bolivarian Republic Of", "value": "VE"}, {"label": "Viet Nam", "value": "VN"}, {"label": "Virgin Islands, British", "value": "VG"}, {"label": "Virgin Islands, U.S.", "value": "VI"}, {"label": "Wallis And Futuna", "value": "WF"}, {"label": "Western Sahara", "value": "EH"}, {"label": "Yemen", "value": "YE"}, {"label": "Zambia", "value": "ZM"}, {"label": "Zimbabwe", "value": "ZW"}, {"label": "Not categorised", "value": "XX"}, {"label": "Others", "value": "ZZ"}], "validations": {"required": true}}], "colClassName": "mt-4"}}, {"section": {"label": "Customer Phone", "fields": [{"key": "Batch.Report.Transaction[].CustomerDetails.Phone.Telephone", "type": "text", "label": "Telephone", "validations": {"required": false, "maxLength": 30, "minLength": 6}}, {"key": "Batch.Report.Transaction[].CustomerDetails.Phone.Mobile", "type": "text", "label": "Mobile", "validations": {"required": false, "maxLength": 30, "minLength": 6}}, {"key": "Batch.Report.Transaction[].CustomerDetails.Phone.Fax", "type": "text", "label": "Fax", "validations": {"required": false, "maxLength": 30, "minLength": 6}}], "colClassName": "mt-4"}}], "colClassName": "mt-4"}}], "isArray": true, "arrayKey": "Batch.Report.Transaction", "required": true, "colClassName": "mt-4"}}, {"section": {"label": "Branch", "fields": [{"key": "Batch.Report.Branch.InstitutionName", "type": "text", "label": "Institution Name", "validations": {"required": true, "maxLength": 80}}, {"key": "Batch.Report.Branch.InstitutionBranchName", "type": "text", "label": "Institution Branch Name", "validations": {"required": false, "maxLength": 80}}, {"key": "Batch.Report.Branch.InstitutionRefNum", "type": "text", "label": "Institution Ref Num", "validations": {"required": true, "maxLength": 20}}, {"key": "Batch.Report.Branch.ReportingRole", "type": "select", "label": "Reporting Role", "options": [{"label": "Reporting entity itself", "value": "A"}, {"label": "Other than reporting entity", "value": "B"}, {"label": "Not categorised", "value": "X"}], "validations": {"required": true}}, {"key": "Batch.Report.Branch.BIC", "type": "text", "label": "Bank identification code", "validations": {"required": false, "maxLength": 11}}, {"section": {"label": "Branch Address", "fields": [{"key": "Batch.Report.Branch.BranchAddress.Address", "type": "text", "label": "Address", "validations": {"required": true, "maxLength": 225, "minLength": 8}}, {"key": "Batch.Report.Branch.BranchAddress.City", "type": "text", "label": "City", "validations": {"required": false, "maxLength": 50}}, {"key": "Batch.Report.Branch.BranchAddress.StateCode", "type": "select", "label": "State Code", "options": [{"label": "Andaman & Nicobar", "value": "AN"}, {"label": "Andhra Pradesh", "value": "AP"}, {"label": "Arunachal Pradesh", "value": "AR"}, {"label": "Assam", "value": "AS"}, {"label": "Bihar", "value": "BR"}, {"label": "Chandigarh", "value": "CH"}, {"label": "Chhattisgarh", "value": "CG"}, {"label": "Dadra and Nagar Haveli", "value": "DN"}, {"label": "Daman & Diu", "value": "DD"}, {"label": "Delhi", "value": "DL"}, {"label": "Goa", "value": "GA"}, {"label": "Gujarat", "value": "GJ"}, {"label": "Haryana", "value": "HR"}, {"label": "Himachal Pradesh", "value": "HP"}, {"label": "Jammu & Kashmir", "value": "JK"}, {"label": "Jharkhand", "value": "JH"}, {"label": "Karnataka", "value": "KA"}, {"label": "Kerala", "value": "KL"}, {"label": "Lakshadweep", "value": "LD"}, {"label": "Madhya Pradesh", "value": "MP"}, {"label": "Maharashtra", "value": "MH"}, {"label": "Manipur", "value": "MN"}, {"label": "Meghalaya", "value": "ML"}, {"label": "Mizoram", "value": "MZ"}, {"label": "Nagaland", "value": "NL"}, {"label": "Orissa", "value": "OR"}, {"label": "Pondicherry", "value": "PY"}, {"label": "Punjab", "value": "PB"}, {"label": "Rajasthan", "value": "RJ"}, {"label": "Sikkim", "value": "SK"}, {"label": "Tamil Nadu", "value": "TN"}, {"label": "Tripura", "value": "TR"}, {"label": "Uttar Pradesh", "value": "UP"}, {"label": "Uttarakhand", "value": "UA"}, {"label": "West Bengal", "value": "WB"}, {"label": "Others", "value": "ZZ"}, {"label": "Not Applicable", "value": "XX"}], "validations": {"required": true}}, {"key": "Batch.Report.Branch.BranchAddress.PinCode", "type": "text", "label": "Pincode", "validations": {"required": false, "maxLength": 10}}, {"key": "Batch.Report.Branch.BranchAddress.CountryCode", "type": "select", "label": "Country Code", "options": [{"label": "Afghanistan", "value": "AF"}, {"label": "Aland Islands", "value": "AX"}, {"label": "Albania", "value": "AL"}, {"label": "Algeria", "value": "DZ"}, {"label": "American Samoa", "value": "AS"}, {"label": "Andorra", "value": "AD"}, {"label": "Angola", "value": "AO"}, {"label": "Anguilla", "value": "AI"}, {"label": "Antarctica", "value": "AQ"}, {"label": "Antigua And Barbuda", "value": "AG"}, {"label": "Argentina", "value": "AR"}, {"label": "Armenia", "value": "AM"}, {"label": "Aruba", "value": "AW"}, {"label": "Australia", "value": "AU"}, {"label": "Austria", "value": "AT"}, {"label": "Azerbaijan", "value": "AZ"}, {"label": "Bahamas", "value": "BS"}, {"label": "Bahrain", "value": "BH"}, {"label": "Bangladesh", "value": "BD"}, {"label": "Barbados", "value": "BB"}, {"label": "Belarus", "value": "BY"}, {"label": "Belgium", "value": "BE"}, {"label": "Belize", "value": "BZ"}, {"label": "Benin", "value": "BJ"}, {"label": "Bermuda", "value": "BM"}, {"label": "Bhutan", "value": "BT"}, {"label": "Bolivia", "value": "BO"}, {"label": "Bosnia And Herzegovina", "value": "BA"}, {"label": "Bonaire, Sint Eustatius and Saba", "value": "BQ"}, {"label": "Botswana", "value": "BW"}, {"label": "Bouvet Island", "value": "BV"}, {"label": "Brazil", "value": "BR"}, {"label": "British Indian Ocean Territory", "value": "IO"}, {"label": "Brunei Darussalam", "value": "BN"}, {"label": "Bulgaria", "value": "BG"}, {"label": "Burkina Faso", "value": "BF"}, {"label": "Burundi", "value": "BI"}, {"label": "Cambodia", "value": "KH"}, {"label": "Cameroon", "value": "CM"}, {"label": "Canada", "value": "CA"}, {"label": "Cape Verde", "value": "CV"}, {"label": "Cayman Islands", "value": "KY"}, {"label": "Central African Republic", "value": "CF"}, {"label": "Chad", "value": "TD"}, {"label": "Chile", "value": "CL"}, {"label": "China", "value": "CN"}, {"label": "Christmas Island", "value": "CX"}, {"label": "Cocos (Keeling) Islands", "value": "CC"}, {"label": "Colombia", "value": "CO"}, {"label": "Comoros", "value": "KM"}, {"label": "Congo", "value": "CG"}, {"label": "Congo, The Democratic Republic Of The", "value": "CD"}, {"label": "Cook Islands", "value": "CK"}, {"label": "Costa Rica", "value": "CR"}, {"label": "Côte D''ivoire", "value": "CI"}, {"label": "Croatia", "value": "HR"}, {"label": "Cuba", "value": "CU"}, {"label": "Curacao", "value": "CW"}, {"label": "Cyprus", "value": "CY"}, {"label": "Czech Republic", "value": "CZ"}, {"label": "Denmark", "value": "DK"}, {"label": "Djibouti", "value": "DJ"}, {"label": "Dominica", "value": "DM"}, {"label": "Dominican Republic", "value": "DO"}, {"label": "Ecuador", "value": "EC"}, {"label": "Egypt", "value": "EG"}, {"label": "El Salvador", "value": "SV"}, {"label": "Equatorial Guinea", "value": "GQ"}, {"label": "Eritrea", "value": "ER"}, {"label": "Estonia", "value": "EE"}, {"label": "Ethiopia", "value": "ET"}, {"label": "Falkland Islands (Malvinas)", "value": "FK"}, {"label": "Faroe Islands", "value": "FO"}, {"label": "Fiji", "value": "FJ"}, {"label": "Finland", "value": "FI"}, {"label": "France", "value": "FR"}, {"label": "French Guiana", "value": "GF"}, {"label": "French Polynesia", "value": "PF"}, {"label": "French Southern Territories", "value": "TF"}, {"label": "Gabon", "value": "GA"}, {"label": "Gambia", "value": "GM"}, {"label": "Georgia", "value": "GE"}, {"label": "Germany", "value": "DE"}, {"label": "Ghana", "value": "GH"}, {"label": "Gibraltar", "value": "GI"}, {"label": "Greece", "value": "GR"}, {"label": "Greenland", "value": "GL"}, {"label": "Grenada", "value": "GD"}, {"label": "Guadeloupe", "value": "GP"}, {"label": "Guam", "value": "GU"}, {"label": "Guatemala", "value": "GT"}, {"label": "Guernsey", "value": "GG"}, {"label": "Guinea", "value": "GN"}, {"label": "Guinea-Bissau", "value": "GW"}, {"label": "Guyana", "value": "GY"}, {"label": "Haiti", "value": "HT"}, {"label": "Heard Island And McDonald Islands", "value": "HM"}, {"label": "Vatican City State", "value": "VA"}, {"label": "Honduras", "value": "HN"}, {"label": "Hong Kong", "value": "HK"}, {"label": "Hungary", "value": "HU"}, {"label": "Iceland", "value": "IS"}, {"label": "India", "value": "IN"}, {"label": "Indonesia", "value": "ID"}, {"label": "Iran, Islamic Republic Of", "value": "IR"}, {"label": "Iraq", "value": "IQ"}, {"label": "Ireland", "value": "IE"}, {"label": "Isle Of Man", "value": "IM"}, {"label": "Israel", "value": "IL"}, {"label": "Italy", "value": "IT"}, {"label": "Jamaica", "value": "JM"}, {"label": "Japan", "value": "JP"}, {"label": "Jersey", "value": "JE"}, {"label": "Jordan", "value": "JO"}, {"label": "Kazakhstan", "value": "KZ"}, {"label": "Kenya", "value": "KE"}, {"label": "Kiribati", "value": "KI"}, {"label": "Korea, Democratic People''s Republic Of", "value": "KP"}, {"label": "Korea, Republic Of", "value": "KR"}, {"label": "Kuwait", "value": "KW"}, {"label": "Kyrgyzstan", "value": "KG"}, {"label": "Lao People''s Democratic Republic", "value": "LA"}, {"label": "Latvia", "value": "LV"}, {"label": "Lebanon", "value": "LB"}, {"label": "Lesotho", "value": "LS"}, {"label": "Liberia", "value": "LR"}, {"label": "Libyan Arab Jamahiriya", "value": "LY"}, {"label": "Liechtenstein", "value": "LI"}, {"label": "Lithuania", "value": "LT"}, {"label": "Luxembourg", "value": "LU"}, {"label": "Macao", "value": "MO"}, {"label": "Macedonia, The Former Yugoslav Republic Of", "value": "MK"}, {"label": "Madagascar", "value": "MG"}, {"label": "Malawi", "value": "MW"}, {"label": "Malaysia", "value": "MY"}, {"label": "Maldives", "value": "MV"}, {"label": "Mali", "value": "ML"}, {"label": "Malta", "value": "MT"}, {"label": "Marshall Islands", "value": "MH"}, {"label": "Martinique", "value": "MQ"}, {"label": "Mauritania", "value": "MR"}, {"label": "Mauritius", "value": "MU"}, {"label": "Mayotte", "value": "YT"}, {"label": "Mexico", "value": "MX"}, {"label": "Micronesia, Federated States Of", "value": "FM"}, {"label": "Moldova, Republic Of", "value": "MD"}, {"label": "Monaco", "value": "MC"}, {"label": "Mongolia", "value": "MN"}, {"label": "Montenegro", "value": "ME"}, {"label": "Montserrat", "value": "MS"}, {"label": "Morocco", "value": "MA"}, {"label": "Mozambique", "value": "MZ"}, {"label": "Myanmar", "value": "MM"}, {"label": "Namibia", "value": "NA"}, {"label": "Nauru", "value": "NR"}, {"label": "Nepal", "value": "NP"}, {"label": "Netherlands", "value": "NL"}, {"label": "Netherlands Antilles", "value": "AN"}, {"label": "New Caledonia", "value": "NC"}, {"label": "New Zealand", "value": "NZ"}, {"label": "Nicaragua", "value": "NI"}, {"label": "Niger", "value": "NE"}, {"label": "Nigeria", "value": "NG"}, {"label": "Niue", "value": "NU"}, {"label": "Norfolk Island", "value": "NF"}, {"label": "Northern Mariana Islands", "value": "MP"}, {"label": "Norway", "value": "NO"}, {"label": "Oman", "value": "OM"}, {"label": "Pakistan", "value": "PK"}, {"label": "Palau", "value": "PW"}, {"label": "Palestinian Territory, Occupied", "value": "PS"}, {"label": "Panama", "value": "PA"}, {"label": "Papua New Guinea", "value": "PG"}, {"label": "Paraguay", "value": "PY"}, {"label": "Peru", "value": "PE"}, {"label": "Philippines", "value": "PH"}, {"label": "Pitcairn", "value": "PN"}, {"label": "Poland", "value": "PL"}, {"label": "Portugal", "value": "PT"}, {"label": "Puerto Rico", "value": "PR"}, {"label": "Qatar", "value": "QA"}, {"label": "Reunion Island", "value": "RE"}, {"label": "Romania", "value": "RO"}, {"label": "Russian Federation", "value": "RU"}, {"label": "Rwanda", "value": "RW"}, {"label": "Saint Barthelemy", "value": "BL"}, {"label": "Saint Helena, Ascension And Tristan da Cunha", "value": "SH"}, {"label": "Saint Kitts And Nevis", "value": "KN"}, {"label": "Saint Lucia", "value": "LC"}, {"label": "Saint Martin", "value": "MF"}, {"label": "Saint Pierre And Miquelon", "value": "PM"}, {"label": "Saint Vincent And The Grenadines", "value": "VC"}, {"label": "Samoa", "value": "WS"}, {"label": "San Marino", "value": "SM"}, {"label": "Sao Tome And Principe", "value": "ST"}, {"label": "Saudi Arabia", "value": "SA"}, {"label": "Senegal", "value": "SN"}, {"label": "Serbia", "value": "RS"}, {"label": "Seychelles", "value": "SC"}, {"label": "Sierra Leone", "value": "SL"}, {"label": "Singapore", "value": "SG"}, {"label": "Sint Marteen", "value": "SX"}, {"label": "Slovakia", "value": "SK"}, {"label": "Slovenia", "value": "SI"}, {"label": "Solomon Islands", "value": "SB"}, {"label": "Somalia", "value": "SO"}, {"label": "South Africa", "value": "ZA"}, {"label": "South Georgia And The South Sandwich Islands", "value": "GS"}, {"label": "South Sudan", "value": "SS"}, {"label": "Spain", "value": "ES"}, {"label": "Sri Lanka", "value": "LK"}, {"label": "Sudan", "value": "SD"}, {"label": "Suriname", "value": "SR"}, {"label": "Svalbard And Jan Mayen Islands", "value": "SJ"}, {"label": "Swaziland", "value": "SZ"}, {"label": "Sweden", "value": "SE"}, {"label": "Switzerland", "value": "CH"}, {"label": "Syrian Arab Republic", "value": "SY"}, {"label": "Taiwan, Province Of China", "value": "TW"}, {"label": "Tajikistan", "value": "TJ"}, {"label": "Tanzania, United Republic Of", "value": "TZ"}, {"label": "Thailand", "value": "TH"}, {"label": "Timor-Leste", "value": "TL"}, {"label": "Togo", "value": "TG"}, {"label": "Tokelau", "value": "TK"}, {"label": "Tonga", "value": "TO"}, {"label": "Trinidad And Tobago", "value": "TT"}, {"label": "Tunisia", "value": "TN"}, {"label": "Turkey", "value": "TR"}, {"label": "Turkmenistan", "value": "TM"}, {"label": "Turks And Caicos Islands", "value": "TC"}, {"label": "Tuvalu", "value": "TV"}, {"label": "Uganda", "value": "UG"}, {"label": "Ukraine", "value": "UA"}, {"label": "United Arab Emirates", "value": "AE"}, {"label": "United Kingdom", "value": "GB"}, {"label": "United States", "value": "US"}, {"label": "United States Minor Outlying Islands", "value": "UM"}, {"label": "Uruguay", "value": "UY"}, {"label": "Uzbekistan", "value": "UZ"}, {"label": "Vanuatu", "value": "VU"}, {"label": "Venezuela, Bolivarian Republic Of", "value": "VE"}, {"label": "Viet Nam", "value": "VN"}, {"label": "Virgin Islands, British", "value": "VG"}, {"label": "Virgin Islands, U.S.", "value": "VI"}, {"label": "Wallis And Futuna", "value": "WF"}, {"label": "Western Sahara", "value": "EH"}, {"label": "Yemen", "value": "YE"}, {"label": "Zambia", "value": "ZM"}, {"label": "Zimbabwe", "value": "ZW"}, {"label": "Not categorised", "value": "XX"}, {"label": "Others", "value": "ZZ"}], "validations": {"required": true}}], "colClassName": "mt-4"}}, {"section": {"label": "Phone", "fields": [{"key": "Batch.Report.Branch.Phone.Telephone", "type": "text", "label": "Telephone", "validations": {"required": false, "maxLength": 30, "minLength": 6}}, {"key": "Batch.Report.Branch.Phone.Mobile", "type": "text", "label": "Mobile", "validations": {"required": false, "maxLength": 30, "minLength": 6}}, {"key": "Batch.Report.Branch.Phone.Fax", "type": "text", "label": "Fax", "validations": {"required": false, "maxLength": 30, "minLength": 6}}], "colClassName": "mt-4"}}, {"key": "Batch.Report.Branch.Email", "type": "text", "label": "Email", "validations": {"regexp": "``", "required": false, "maxLength": 50, "minLength": 6}}, {"key": "Batch.Report.Branch.Remarks", "type": "textarea", "label": "Remarks", "validations": {"required": false, "maxLength": 50}}], "required": true, "colClassName": "mt-4"}}, {"section": {"label": "Payment Instrument", "fields": [{"key": "Batch.Report.PaymentInstrument[].InstrumentRefNum", "type": "text", "label": "Instrument Ref Num", "validations": {"required": true, "maxLength": 20}}, {"key": "Batch.Report.PaymentInstrument[].IssueInstitutionRefNum", "type": "text", "label": "Issue Institution Ref Num", "validations": {"required": false, "maxLength": 20}}, {"key": "Batch.Report.PaymentInstrument[].InstrumentIssueInstitutionName", "type": "text", "label": "Instrument Issue Institution Name", "validations": {"required": false, "maxLength": 80}}, {"key": "Batch.Report.PaymentInstrument[].InstrumentHolderName", "type": "text", "label": "Instrument Holder Name", "validations": {"required": false, "maxLength": 80}}, {"key": "Batch.Report.PaymentInstrument[].RelationshipBeginningDate", "type": "date", "label": "Relationship Beginning Date", "format": "YYYY-MM-DDDD", "maxDate": "new Date()", "minDate": "`new Date().setFullYear(new Date().getFullYear() - 1)`", "validations": {"required": false}}, {"key": "Batch.Report.PaymentInstrument[].CumulativePurchaseTurnover", "type": "text", "label": "Cumulative Purchase Turnover", "validations": {"required": false, "maxLength": 20}}, {"key": "Batch.Report.PaymentInstrument[].Remarks", "type": "textarea", "label": "Remarks", "validations": {"required": false, "maxLength": 20}}], "isArray": true, "arrayKey": "Batch.Report.PaymentInstrument", "required": true, "colClassName": "mt-4"}}, {"section": {"label": "Related Persons", "fields": [{"key": "Batch.Report.RelatedPersons[].PersonName", "type": "text", "label": "Person Name", "validations": {"required": true, "maxLength": 80}}, {"key": "Batch.Report.RelatedPersons[].CustomerID", "type": "text", "label": "Customer ID", "validations": {"required": false, "maxLength": 10}}, {"key": "Batch.Report.RelatedPersons[].RelationFlag", "type": "select", "label": "Relation Flag", "options": [{"label": "Account Holder", "value": "A"}, {"label": "Authorised Signatory", "value": "B"}, {"label": "Proprietor/Director/Partner/Member of a legal entity", "value": "C"}, {"label": "Introducer", "value": "D"}, {"label": "Guarantor", "value": "E"}, {"label": "Guardian", "value": "F"}, {"label": "Nominee", "value": "N"}, {"label": "Beneficial Owner", "value": "O"}, {"label": "Proposer", "value": "P"}, {"label": "Assignee", "value": "G"}, {"label": "Life", "value": "L"}, {"label": "Beneficiary", "value": "J"}, {"label": "Power of Attorney", "value": "H"}, {"label": "Others", "value": "Z"}, {"label": "Not categorised", "value": "X"}], "validations": {"required": true}}, {"key": "Batch.Report.RelatedPersons[].PAN", "type": "text", "label": "PAN", "validations": {"required": false, "maxLength": 10}}, {"key": "Batch.Report.RelatedPersons[].UIN", "type": "text", "label": "UIN", "validations": {"required": false, "maxLength": 30}}, {"key": "Batch.Report.RelatedPersons[].Choice", "type": "select", "label": "Choice", "options": [{"label": "Individual", "value": "individual"}, {"label": "Legal Person", "value": "legalperson"}], "validations": {"required": true}, "conditionalRenderOtherKeys": true}, {"section": {"key": "Batch.Report.RelatedPersons[].Individual", "label": "Details Of Individual", "fields": [{"key": "Batch.Report.RelatedPersons[].Individual.Gender", "type": "select", "label": "Gender", "options": [{"label": "Male", "value": "M"}, {"label": "Female", "value": "F"}, {"label": "Not Categorised", "value": "X"}], "validations": {"required": true}}, {"key": "Batch.Report.RelatedPersons[].Individual.DateOfBirth", "type": "date", "label": "Date Of Birth", "format": "YYYY-MM-DDDD", "maxDate": "new Date()", "validations": {"required": false}}, {"key": "Batch.Report.RelatedPersons[].Individual.IdentificationType", "type": "select", "label": "Identification Type", "options": [{"label": "Passport", "value": "A"}, {"label": "Election Id Card", "value": "B"}, {"label": "Pan Card", "value": "C"}, {"label": "ID Card", "value": "D"}, {"label": "Driving License", "value": "E"}, {"label": "Account Introducer", "value": "F"}, {"label": "UIDAI letter", "value": "G"}, {"label": "NREGA job card", "value": "H"}, {"label": "Others", "value": "Z"}], "validations": {"required": true}}, {"key": "Batch.Report.RelatedPersons[].Individual.IdentificationNumber", "type": "text", "label": "Identification Number", "validations": {"required": false, "maxLength": 20, "minLength": 5}}, {"key": "Batch.Report.RelatedPersons[].Individual.IssuingAuthority", "type": "text", "label": "Issuing Authority", "validations": {"required": false, "maxLength": 20}}, {"key": "Batch.Report.RelatedPersons[].Individual.PlaceOfIssue", "type": "text", "label": "Place Of Issue", "validations": {"required": false, "maxLength": 20}}, {"key": "Batch.Report.RelatedPersons[].Individual.Nationality", "type": "select", "label": "Nationality", "options": [{"label": "Afghanistan", "value": "AF"}, {"label": "Aland Islands", "value": "AX"}, {"label": "Albania", "value": "AL"}, {"label": "Algeria", "value": "DZ"}, {"label": "American Samoa", "value": "AS"}, {"label": "Andorra", "value": "AD"}, {"label": "Angola", "value": "AO"}, {"label": "Anguilla", "value": "AI"}, {"label": "Antarctica", "value": "AQ"}, {"label": "Antigua And Barbuda", "value": "AG"}, {"label": "Argentina", "value": "AR"}, {"label": "Armenia", "value": "AM"}, {"label": "Aruba", "value": "AW"}, {"label": "Australia", "value": "AU"}, {"label": "Austria", "value": "AT"}, {"label": "Azerbaijan", "value": "AZ"}, {"label": "Bahamas", "value": "BS"}, {"label": "Bahrain", "value": "BH"}, {"label": "Bangladesh", "value": "BD"}, {"label": "Barbados", "value": "BB"}, {"label": "Belarus", "value": "BY"}, {"label": "Belgium", "value": "BE"}, {"label": "Belize", "value": "BZ"}, {"label": "Benin", "value": "BJ"}, {"label": "Bermuda", "value": "BM"}, {"label": "Bhutan", "value": "BT"}, {"label": "Bolivia", "value": "BO"}, {"label": "Bosnia And Herzegovina", "value": "BA"}, {"label": "Bonaire, Sint Eustatius and Saba", "value": "BQ"}, {"label": "Botswana", "value": "BW"}, {"label": "Bouvet Island", "value": "BV"}, {"label": "Brazil", "value": "BR"}, {"label": "British Indian Ocean Territory", "value": "IO"}, {"label": "Brunei Darussalam", "value": "BN"}, {"label": "Bulgaria", "value": "BG"}, {"label": "Burkina Faso", "value": "BF"}, {"label": "Burundi", "value": "BI"}, {"label": "Cambodia", "value": "KH"}, {"label": "Cameroon", "value": "CM"}, {"label": "Canada", "value": "CA"}, {"label": "Cape Verde", "value": "CV"}, {"label": "Cayman Islands", "value": "KY"}, {"label": "Central African Republic", "value": "CF"}, {"label": "Chad", "value": "TD"}, {"label": "Chile", "value": "CL"}, {"label": "China", "value": "CN"}, {"label": "Christmas Island", "value": "CX"}, {"label": "Cocos (Keeling) Islands", "value": "CC"}, {"label": "Colombia", "value": "CO"}, {"label": "Comoros", "value": "KM"}, {"label": "Congo", "value": "CG"}, {"label": "Congo, The Democratic Republic Of The", "value": "CD"}, {"label": "Cook Islands", "value": "CK"}, {"label": "Costa Rica", "value": "CR"}, {"label": "Côte D''ivoire", "value": "CI"}, {"label": "Croatia", "value": "HR"}, {"label": "Cuba", "value": "CU"}, {"label": "Curacao", "value": "CW"}, {"label": "Cyprus", "value": "CY"}, {"label": "Czech Republic", "value": "CZ"}, {"label": "Denmark", "value": "DK"}, {"label": "Djibouti", "value": "DJ"}, {"label": "Dominica", "value": "DM"}, {"label": "Dominican Republic", "value": "DO"}, {"label": "Ecuador", "value": "EC"}, {"label": "Egypt", "value": "EG"}, {"label": "El Salvador", "value": "SV"}, {"label": "Equatorial Guinea", "value": "GQ"}, {"label": "Eritrea", "value": "ER"}, {"label": "Estonia", "value": "EE"}, {"label": "Ethiopia", "value": "ET"}, {"label": "Falkland Islands (Malvinas)", "value": "FK"}, {"label": "Faroe Islands", "value": "FO"}, {"label": "Fiji", "value": "FJ"}, {"label": "Finland", "value": "FI"}, {"label": "France", "value": "FR"}, {"label": "French Guiana", "value": "GF"}, {"label": "French Polynesia", "value": "PF"}, {"label": "French Southern Territories", "value": "TF"}, {"label": "Gabon", "value": "GA"}, {"label": "Gambia", "value": "GM"}, {"label": "Georgia", "value": "GE"}, {"label": "Germany", "value": "DE"}, {"label": "Ghana", "value": "GH"}, {"label": "Gibraltar", "value": "GI"}, {"label": "Greece", "value": "GR"}, {"label": "Greenland", "value": "GL"}, {"label": "Grenada", "value": "GD"}, {"label": "Guadeloupe", "value": "GP"}, {"label": "Guam", "value": "GU"}, {"label": "Guatemala", "value": "GT"}, {"label": "Guernsey", "value": "GG"}, {"label": "Guinea", "value": "GN"}, {"label": "Guinea-Bissau", "value": "GW"}, {"label": "Guyana", "value": "GY"}, {"label": "Haiti", "value": "HT"}, {"label": "Heard Island And McDonald Islands", "value": "HM"}, {"label": "Vatican City State", "value": "VA"}, {"label": "Honduras", "value": "HN"}, {"label": "Hong Kong", "value": "HK"}, {"label": "Hungary", "value": "HU"}, {"label": "Iceland", "value": "IS"}, {"label": "India", "value": "IN"}, {"label": "Indonesia", "value": "ID"}, {"label": "Iran, Islamic Republic Of", "value": "IR"}, {"label": "Iraq", "value": "IQ"}, {"label": "Ireland", "value": "IE"}, {"label": "Isle Of Man", "value": "IM"}, {"label": "Israel", "value": "IL"}, {"label": "Italy", "value": "IT"}, {"label": "Jamaica", "value": "JM"}, {"label": "Japan", "value": "JP"}, {"label": "Jersey", "value": "JE"}, {"label": "Jordan", "value": "JO"}, {"label": "Kazakhstan", "value": "KZ"}, {"label": "Kenya", "value": "KE"}, {"label": "Kiribati", "value": "KI"}, {"label": "Korea, Democratic People''s Republic Of", "value": "KP"}, {"label": "Korea, Republic Of", "value": "KR"}, {"label": "Kuwait", "value": "KW"}, {"label": "Kyrgyzstan", "value": "KG"}, {"label": "Lao People''s Democratic Republic", "value": "LA"}, {"label": "Latvia", "value": "LV"}, {"label": "Lebanon", "value": "LB"}, {"label": "Lesotho", "value": "LS"}, {"label": "Liberia", "value": "LR"}, {"label": "Libyan Arab Jamahiriya", "value": "LY"}, {"label": "Liechtenstein", "value": "LI"}, {"label": "Lithuania", "value": "LT"}, {"label": "Luxembourg", "value": "LU"}, {"label": "Macao", "value": "MO"}, {"label": "Macedonia, The Former Yugoslav Republic Of", "value": "MK"}, {"label": "Madagascar", "value": "MG"}, {"label": "Malawi", "value": "MW"}, {"label": "Malaysia", "value": "MY"}, {"label": "Maldives", "value": "MV"}, {"label": "Mali", "value": "ML"}, {"label": "Malta", "value": "MT"}, {"label": "Marshall Islands", "value": "MH"}, {"label": "Martinique", "value": "MQ"}, {"label": "Mauritania", "value": "MR"}, {"label": "Mauritius", "value": "MU"}, {"label": "Mayotte", "value": "YT"}, {"label": "Mexico", "value": "MX"}, {"label": "Micronesia, Federated States Of", "value": "FM"}, {"label": "Moldova, Republic Of", "value": "MD"}, {"label": "Monaco", "value": "MC"}, {"label": "Mongolia", "value": "MN"}, {"label": "Montenegro", "value": "ME"}, {"label": "Montserrat", "value": "MS"}, {"label": "Morocco", "value": "MA"}, {"label": "Mozambique", "value": "MZ"}, {"label": "Myanmar", "value": "MM"}, {"label": "Namibia", "value": "NA"}, {"label": "Nauru", "value": "NR"}, {"label": "Nepal", "value": "NP"}, {"label": "Netherlands", "value": "NL"}, {"label": "Netherlands Antilles", "value": "AN"}, {"label": "New Caledonia", "value": "NC"}, {"label": "New Zealand", "value": "NZ"}, {"label": "Nicaragua", "value": "NI"}, {"label": "Niger", "value": "NE"}, {"label": "Nigeria", "value": "NG"}, {"label": "Niue", "value": "NU"}, {"label": "Norfolk Island", "value": "NF"}, {"label": "Northern Mariana Islands", "value": "MP"}, {"label": "Norway", "value": "NO"}, {"label": "Oman", "value": "OM"}, {"label": "Pakistan", "value": "PK"}, {"label": "Palau", "value": "PW"}, {"label": "Palestinian Territory, Occupied", "value": "PS"}, {"label": "Panama", "value": "PA"}, {"label": "Papua New Guinea", "value": "PG"}, {"label": "Paraguay", "value": "PY"}, {"label": "Peru", "value": "PE"}, {"label": "Philippines", "value": "PH"}, {"label": "Pitcairn", "value": "PN"}, {"label": "Poland", "value": "PL"}, {"label": "Portugal", "value": "PT"}, {"label": "Puerto Rico", "value": "PR"}, {"label": "Qatar", "value": "QA"}, {"label": "Reunion Island", "value": "RE"}, {"label": "Romania", "value": "RO"}, {"label": "Russian Federation", "value": "RU"}, {"label": "Rwanda", "value": "RW"}, {"label": "Saint Barthelemy", "value": "BL"}, {"label": "Saint Helena, Ascension And Tristan da Cunha", "value": "SH"}, {"label": "Saint Kitts And Nevis", "value": "KN"}, {"label": "Saint Lucia", "value": "LC"}, {"label": "Saint Martin", "value": "MF"}, {"label": "Saint Pierre And Miquelon", "value": "PM"}, {"label": "Saint Vincent And The Grenadines", "value": "VC"}, {"label": "Samoa", "value": "WS"}, {"label": "San Marino", "value": "SM"}, {"label": "Sao Tome And Principe", "value": "ST"}, {"label": "Saudi Arabia", "value": "SA"}, {"label": "Senegal", "value": "SN"}, {"label": "Serbia", "value": "RS"}, {"label": "Seychelles", "value": "SC"}, {"label": "Sierra Leone", "value": "SL"}, {"label": "Singapore", "value": "SG"}, {"label": "Sint Marteen", "value": "SX"}, {"label": "Slovakia", "value": "SK"}, {"label": "Slovenia", "value": "SI"}, {"label": "Solomon Islands", "value": "SB"}, {"label": "Somalia", "value": "SO"}, {"label": "South Africa", "value": "ZA"}, {"label": "South Georgia And The South Sandwich Islands", "value": "GS"}, {"label": "South Sudan", "value": "SS"}, {"label": "Spain", "value": "ES"}, {"label": "Sri Lanka", "value": "LK"}, {"label": "Sudan", "value": "SD"}, {"label": "Suriname", "value": "SR"}, {"label": "Svalbard And Jan Mayen Islands", "value": "SJ"}, {"label": "Swaziland", "value": "SZ"}, {"label": "Sweden", "value": "SE"}, {"label": "Switzerland", "value": "CH"}, {"label": "Syrian Arab Republic", "value": "SY"}, {"label": "Taiwan, Province Of China", "value": "TW"}, {"label": "Tajikistan", "value": "TJ"}, {"label": "Tanzania, United Republic Of", "value": "TZ"}, {"label": "Thailand", "value": "TH"}, {"label": "Timor-Leste", "value": "TL"}, {"label": "Togo", "value": "TG"}, {"label": "Tokelau", "value": "TK"}, {"label": "Tonga", "value": "TO"}, {"label": "Trinidad And Tobago", "value": "TT"}, {"label": "Tunisia", "value": "TN"}, {"label": "Turkey", "value": "TR"}, {"label": "Turkmenistan", "value": "TM"}, {"label": "Turks And Caicos Islands", "value": "TC"}, {"label": "Tuvalu", "value": "TV"}, {"label": "Uganda", "value": "UG"}, {"label": "Ukraine", "value": "UA"}, {"label": "United Arab Emirates", "value": "AE"}, {"label": "United Kingdom", "value": "GB"}, {"label": "United States", "value": "US"}, {"label": "United States Minor Outlying Islands", "value": "UM"}, {"label": "Uruguay", "value": "UY"}, {"label": "Uzbekistan", "value": "UZ"}, {"label": "Vanuatu", "value": "VU"}, {"label": "Venezuela, Bolivarian Republic Of", "value": "VE"}, {"label": "Viet Nam", "value": "VN"}, {"label": "Virgin Islands, British", "value": "VG"}, {"label": "Virgin Islands, U.S.", "value": "VI"}, {"label": "Wallis And Futuna", "value": "WF"}, {"label": "Western Sahara", "value": "EH"}, {"label": "Yemen", "value": "YE"}, {"label": "Zambia", "value": "ZM"}, {"label": "Zimbabwe", "value": "ZW"}, {"label": "Not categorised", "value": "XX"}, {"label": "Others", "value": "ZZ"}], "validations": {"required": true}}, {"key": "Batch.Report.RelatedPersons[].Individual.PlaceOfWork", "type": "text", "label": "Place Of Work", "validations": {"required": false, "maxLength": 80}}, {"key": "Batch.Report.RelatedPersons[].Individual.FatherOrSpouse", "type": "text", "label": "Name Of Father/Spouse", "validations": {"required": false, "maxLength": 80}}, {"key": "Batch.Report.RelatedPersons[].Individual.Occupation", "type": "text", "label": "Occupation", "validations": {"required": false, "maxLength": 50}}], "colClassName": "mt-4", "renderCondition": "values.Batch.Report.RelatedPersons[].Choice===\"individual\""}}, {"section": {"key": "Batch.Report.RelatedPersons[].LegalPerson", "label": "Details Of Legal Person", "fields": [{"key": "Batch.Report.RelatedPersons[].LegalPerson.ConstitutionType", "type": "select", "label": "Constitution Type", "options": [{"label": "Sole Proprietorship", "value": "A"}, {"label": "Partnership Firm", "value": "B"}, {"label": "HUF", "value": "C"}, {"label": "Private Limited Company", "value": "D"}, {"label": "Public Limited Company", "value": "E"}, {"label": "Society", "value": "F"}, {"label": "Association", "value": "G"}, {"label": "Trust", "value": "H"}, {"label": "Liquidator", "value": "I"}, {"label": "LLP", "value": "J"}, {"label": "Others", "value": "Z"}, {"label": "Not Categorised", "value": "X"}], "validations": {"required": true}}, {"key": "Batch.Report.RelatedPersons[].LegalPerson.RegistrationNumber", "type": "text", "label": "Registration Number", "validations": {"required": false, "maxLength": 20}}, {"key": "Batch.Report.RelatedPersons[].LegalPerson.DateOfIncorporation", "type": "date", "label": "Date Of Incorporation", "format": "YYYY-MM-DD", "maxDate": "new Date()", "validations": {"required": false}}, {"key": "Batch.Report.RelatedPersons[].LegalPerson.PlaceOfRegistration", "type": "text", "label": "Place Of Registration", "validations": {"required": false, "maxLength": 20}}, {"key": "Batch.Report.RelatedPersons[].LegalPerson.CountryCode", "type": "select", "label": "Country Code", "options": [{"label": "Afghanistan", "value": "AF"}, {"label": "Aland Islands", "value": "AX"}, {"label": "Albania", "value": "AL"}, {"label": "Algeria", "value": "DZ"}, {"label": "American Samoa", "value": "AS"}, {"label": "Andorra", "value": "AD"}, {"label": "Angola", "value": "AO"}, {"label": "Anguilla", "value": "AI"}, {"label": "Antarctica", "value": "AQ"}, {"label": "Antigua And Barbuda", "value": "AG"}, {"label": "Argentina", "value": "AR"}, {"label": "Armenia", "value": "AM"}, {"label": "Aruba", "value": "AW"}, {"label": "Australia", "value": "AU"}, {"label": "Austria", "value": "AT"}, {"label": "Azerbaijan", "value": "AZ"}, {"label": "Bahamas", "value": "BS"}, {"label": "Bahrain", "value": "BH"}, {"label": "Bangladesh", "value": "BD"}, {"label": "Barbados", "value": "BB"}, {"label": "Belarus", "value": "BY"}, {"label": "Belgium", "value": "BE"}, {"label": "Belize", "value": "BZ"}, {"label": "Benin", "value": "BJ"}, {"label": "Bermuda", "value": "BM"}, {"label": "Bhutan", "value": "BT"}, {"label": "Bolivia", "value": "BO"}, {"label": "Bosnia And Herzegovina", "value": "BA"}, {"label": "Bonaire, Sint Eustatius and Saba", "value": "BQ"}, {"label": "Botswana", "value": "BW"}, {"label": "Bouvet Island", "value": "BV"}, {"label": "Brazil", "value": "BR"}, {"label": "British Indian Ocean Territory", "value": "IO"}, {"label": "Brunei Darussalam", "value": "BN"}, {"label": "Bulgaria", "value": "BG"}, {"label": "Burkina Faso", "value": "BF"}, {"label": "Burundi", "value": "BI"}, {"label": "Cambodia", "value": "KH"}, {"label": "Cameroon", "value": "CM"}, {"label": "Canada", "value": "CA"}, {"label": "Cape Verde", "value": "CV"}, {"label": "Cayman Islands", "value": "KY"}, {"label": "Central African Republic", "value": "CF"}, {"label": "Chad", "value": "TD"}, {"label": "Chile", "value": "CL"}, {"label": "China", "value": "CN"}, {"label": "Christmas Island", "value": "CX"}, {"label": "Cocos (Keeling) Islands", "value": "CC"}, {"label": "Colombia", "value": "CO"}, {"label": "Comoros", "value": "KM"}, {"label": "Congo", "value": "CG"}, {"label": "Congo, The Democratic Republic Of The", "value": "CD"}, {"label": "Cook Islands", "value": "CK"}, {"label": "Costa Rica", "value": "CR"}, {"label": "Côte D''ivoire", "value": "CI"}, {"label": "Croatia", "value": "HR"}, {"label": "Cuba", "value": "CU"}, {"label": "Curacao", "value": "CW"}, {"label": "Cyprus", "value": "CY"}, {"label": "Czech Republic", "value": "CZ"}, {"label": "Denmark", "value": "DK"}, {"label": "Djibouti", "value": "DJ"}, {"label": "Dominica", "value": "DM"}, {"label": "Dominican Republic", "value": "DO"}, {"label": "Ecuador", "value": "EC"}, {"label": "Egypt", "value": "EG"}, {"label": "El Salvador", "value": "SV"}, {"label": "Equatorial Guinea", "value": "GQ"}, {"label": "Eritrea", "value": "ER"}, {"label": "Estonia", "value": "EE"}, {"label": "Ethiopia", "value": "ET"}, {"label": "Falkland Islands (Malvinas)", "value": "FK"}, {"label": "Faroe Islands", "value": "FO"}, {"label": "Fiji", "value": "FJ"}, {"label": "Finland", "value": "FI"}, {"label": "France", "value": "FR"}, {"label": "French Guiana", "value": "GF"}, {"label": "French Polynesia", "value": "PF"}, {"label": "French Southern Territories", "value": "TF"}, {"label": "Gabon", "value": "GA"}, {"label": "Gambia", "value": "GM"}, {"label": "Georgia", "value": "GE"}, {"label": "Germany", "value": "DE"}, {"label": "Ghana", "value": "GH"}, {"label": "Gibraltar", "value": "GI"}, {"label": "Greece", "value": "GR"}, {"label": "Greenland", "value": "GL"}, {"label": "Grenada", "value": "GD"}, {"label": "Guadeloupe", "value": "GP"}, {"label": "Guam", "value": "GU"}, {"label": "Guatemala", "value": "GT"}, {"label": "Guernsey", "value": "GG"}, {"label": "Guinea", "value": "GN"}, {"label": "Guinea-Bissau", "value": "GW"}, {"label": "Guyana", "value": "GY"}, {"label": "Haiti", "value": "HT"}, {"label": "Heard Island And McDonald Islands", "value": "HM"}, {"label": "Vatican City State", "value": "VA"}, {"label": "Honduras", "value": "HN"}, {"label": "Hong Kong", "value": "HK"}, {"label": "Hungary", "value": "HU"}, {"label": "Iceland", "value": "IS"}, {"label": "India", "value": "IN"}, {"label": "Indonesia", "value": "ID"}, {"label": "Iran, Islamic Republic Of", "value": "IR"}, {"label": "Iraq", "value": "IQ"}, {"label": "Ireland", "value": "IE"}, {"label": "Isle Of Man", "value": "IM"}, {"label": "Israel", "value": "IL"}, {"label": "Italy", "value": "IT"}, {"label": "Jamaica", "value": "JM"}, {"label": "Japan", "value": "JP"}, {"label": "Jersey", "value": "JE"}, {"label": "Jordan", "value": "JO"}, {"label": "Kazakhstan", "value": "KZ"}, {"label": "Kenya", "value": "KE"}, {"label": "Kiribati", "value": "KI"}, {"label": "Korea, Democratic People''s Republic Of", "value": "KP"}, {"label": "Korea, Republic Of", "value": "KR"}, {"label": "Kuwait", "value": "KW"}, {"label": "Kyrgyzstan", "value": "KG"}, {"label": "Lao People''s Democratic Republic", "value": "LA"}, {"label": "Latvia", "value": "LV"}, {"label": "Lebanon", "value": "LB"}, {"label": "Lesotho", "value": "LS"}, {"label": "Liberia", "value": "LR"}, {"label": "Libyan Arab Jamahiriya", "value": "LY"}, {"label": "Liechtenstein", "value": "LI"}, {"label": "Lithuania", "value": "LT"}, {"label": "Luxembourg", "value": "LU"}, {"label": "Macao", "value": "MO"}, {"label": "Macedonia, The Former Yugoslav Republic Of", "value": "MK"}, {"label": "Madagascar", "value": "MG"}, {"label": "Malawi", "value": "MW"}, {"label": "Malaysia", "value": "MY"}, {"label": "Maldives", "value": "MV"}, {"label": "Mali", "value": "ML"}, {"label": "Malta", "value": "MT"}, {"label": "Marshall Islands", "value": "MH"}, {"label": "Martinique", "value": "MQ"}, {"label": "Mauritania", "value": "MR"}, {"label": "Mauritius", "value": "MU"}, {"label": "Mayotte", "value": "YT"}, {"label": "Mexico", "value": "MX"}, {"label": "Micronesia, Federated States Of", "value": "FM"}, {"label": "Moldova, Republic Of", "value": "MD"}, {"label": "Monaco", "value": "MC"}, {"label": "Mongolia", "value": "MN"}, {"label": "Montenegro", "value": "ME"}, {"label": "Montserrat", "value": "MS"}, {"label": "Morocco", "value": "MA"}, {"label": "Mozambique", "value": "MZ"}, {"label": "Myanmar", "value": "MM"}, {"label": "Namibia", "value": "NA"}, {"label": "Nauru", "value": "NR"}, {"label": "Nepal", "value": "NP"}, {"label": "Netherlands", "value": "NL"}, {"label": "Netherlands Antilles", "value": "AN"}, {"label": "New Caledonia", "value": "NC"}, {"label": "New Zealand", "value": "NZ"}, {"label": "Nicaragua", "value": "NI"}, {"label": "Niger", "value": "NE"}, {"label": "Nigeria", "value": "NG"}, {"label": "Niue", "value": "NU"}, {"label": "Norfolk Island", "value": "NF"}, {"label": "Northern Mariana Islands", "value": "MP"}, {"label": "Norway", "value": "NO"}, {"label": "Oman", "value": "OM"}, {"label": "Pakistan", "value": "PK"}, {"label": "Palau", "value": "PW"}, {"label": "Palestinian Territory, Occupied", "value": "PS"}, {"label": "Panama", "value": "PA"}, {"label": "Papua New Guinea", "value": "PG"}, {"label": "Paraguay", "value": "PY"}, {"label": "Peru", "value": "PE"}, {"label": "Philippines", "value": "PH"}, {"label": "Pitcairn", "value": "PN"}, {"label": "Poland", "value": "PL"}, {"label": "Portugal", "value": "PT"}, {"label": "Puerto Rico", "value": "PR"}, {"label": "Qatar", "value": "QA"}, {"label": "Reunion Island", "value": "RE"}, {"label": "Romania", "value": "RO"}, {"label": "Russian Federation", "value": "RU"}, {"label": "Rwanda", "value": "RW"}, {"label": "Saint Barthelemy", "value": "BL"}, {"label": "Saint Helena, Ascension And Tristan da Cunha", "value": "SH"}, {"label": "Saint Kitts And Nevis", "value": "KN"}, {"label": "Saint Lucia", "value": "LC"}, {"label": "Saint Martin", "value": "MF"}, {"label": "Saint Pierre And Miquelon", "value": "PM"}, {"label": "Saint Vincent And The Grenadines", "value": "VC"}, {"label": "Samoa", "value": "WS"}, {"label": "San Marino", "value": "SM"}, {"label": "Sao Tome And Principe", "value": "ST"}, {"label": "Saudi Arabia", "value": "SA"}, {"label": "Senegal", "value": "SN"}, {"label": "Serbia", "value": "RS"}, {"label": "Seychelles", "value": "SC"}, {"label": "Sierra Leone", "value": "SL"}, {"label": "Singapore", "value": "SG"}, {"label": "Sint Marteen", "value": "SX"}, {"label": "Slovakia", "value": "SK"}, {"label": "Slovenia", "value": "SI"}, {"label": "Solomon Islands", "value": "SB"}, {"label": "Somalia", "value": "SO"}, {"label": "South Africa", "value": "ZA"}, {"label": "South Georgia And The South Sandwich Islands", "value": "GS"}, {"label": "South Sudan", "value": "SS"}, {"label": "Spain", "value": "ES"}, {"label": "Sri Lanka", "value": "LK"}, {"label": "Sudan", "value": "SD"}, {"label": "Suriname", "value": "SR"}, {"label": "Svalbard And Jan Mayen Islands", "value": "SJ"}, {"label": "Swaziland", "value": "SZ"}, {"label": "Sweden", "value": "SE"}, {"label": "Switzerland", "value": "CH"}, {"label": "Syrian Arab Republic", "value": "SY"}, {"label": "Taiwan, Province Of China", "value": "TW"}, {"label": "Tajikistan", "value": "TJ"}, {"label": "Tanzania, United Republic Of", "value": "TZ"}, {"label": "Thailand", "value": "TH"}, {"label": "Timor-Leste", "value": "TL"}, {"label": "Togo", "value": "TG"}, {"label": "Tokelau", "value": "TK"}, {"label": "Tonga", "value": "TO"}, {"label": "Trinidad And Tobago", "value": "TT"}, {"label": "Tunisia", "value": "TN"}, {"label": "Turkey", "value": "TR"}, {"label": "Turkmenistan", "value": "TM"}, {"label": "Turks And Caicos Islands", "value": "TC"}, {"label": "Tuvalu", "value": "TV"}, {"label": "Uganda", "value": "UG"}, {"label": "Ukraine", "value": "UA"}, {"label": "United Arab Emirates", "value": "AE"}, {"label": "United Kingdom", "value": "GB"}, {"label": "United States", "value": "US"}, {"label": "United States Minor Outlying Islands", "value": "UM"}, {"label": "Uruguay", "value": "UY"}, {"label": "Uzbekistan", "value": "UZ"}, {"label": "Vanuatu", "value": "VU"}, {"label": "Venezuela, Bolivarian Republic Of", "value": "VE"}, {"label": "Viet Nam", "value": "VN"}, {"label": "Virgin Islands, British", "value": "VG"}, {"label": "Virgin Islands, U.S.", "value": "VI"}, {"label": "Wallis And Futuna", "value": "WF"}, {"label": "Western Sahara", "value": "EH"}, {"label": "Yemen", "value": "YE"}, {"label": "Zambia", "value": "ZM"}, {"label": "Zimbabwe", "value": "ZW"}, {"label": "Not categorised", "value": "XX"}, {"label": "Others", "value": "ZZ"}], "validations": {"required": true}}, {"key": "Batch.Report.RelatedPersons[].LegalPerson.NatureOfBusiness", "type": "text", "label": "Nature Of Business", "validations": {"required": false, "maxLength": 50}}], "colClassName": "mt-4", "renderCondition": "values.Batch.Report.RelatedPersons[].Choice===\"legalperson\""}}, {"section": {"label": "Communication Address", "fields": [{"key": "Batch.Report.RelatedPersons[].CommunicationAddress.Address", "type": "text", "label": "Address", "validations": {"required": true, "maxLength": 225, "minLength": 8}}, {"key": "Batch.Report.RelatedPersons[].CommunicationAddress.City", "type": "text", "label": "City", "validations": {"required": false, "maxLength": 50}}, {"key": "Batch.Report.RelatedPersons[].CommunicationAddress.StateCode", "type": "select", "label": "State Code", "options": [{"label": "Andaman & Nicobar", "value": "AN"}, {"label": "Andhra Pradesh", "value": "AP"}, {"label": "Arunachal Pradesh", "value": "AR"}, {"label": "Assam", "value": "AS"}, {"label": "Bihar", "value": "BR"}, {"label": "Chandigarh", "value": "CH"}, {"label": "Chhattisgarh", "value": "CG"}, {"label": "Dadra and Nagar Haveli", "value": "DN"}, {"label": "Daman & Diu", "value": "DD"}, {"label": "Delhi", "value": "DL"}, {"label": "Goa", "value": "GA"}, {"label": "Gujarat", "value": "GJ"}, {"label": "Haryana", "value": "HR"}, {"label": "Himachal Pradesh", "value": "HP"}, {"label": "Jammu & Kashmir", "value": "JK"}, {"label": "Jharkhand", "value": "JH"}, {"label": "Karnataka", "value": "KA"}, {"label": "Kerala", "value": "KL"}, {"label": "Lakshadweep", "value": "LD"}, {"label": "Madhya Pradesh", "value": "MP"}, {"label": "Maharashtra", "value": "MH"}, {"label": "Manipur", "value": "MN"}, {"label": "Meghalaya", "value": "ML"}, {"label": "Mizoram", "value": "MZ"}, {"label": "Nagaland", "value": "NL"}, {"label": "Orissa", "value": "OR"}, {"label": "Pondicherry", "value": "PY"}, {"label": "Punjab", "value": "PB"}, {"label": "Rajasthan", "value": "RJ"}, {"label": "Sikkim", "value": "SK"}, {"label": "Tamil Nadu", "value": "TN"}, {"label": "Tripura", "value": "TR"}, {"label": "Uttar Pradesh", "value": "UP"}, {"label": "Uttarakhand", "value": "UA"}, {"label": "West Bengal", "value": "WB"}, {"label": "Others", "value": "ZZ"}, {"label": "Not Applicable", "value": "XX"}], "validations": {"required": true}}, {"key": "Batch.Report.RelatedPersons[].CommunicationAddress.PinCode", "type": "text", "label": "Pincode", "validations": {"required": false, "maxLength": 10}}, {"key": "Batch.Report.RelatedPersons[].CommunicationAddress.CountryCode", "type": "select", "label": "Country Code", "options": [{"label": "Afghanistan", "value": "AF"}, {"label": "Aland Islands", "value": "AX"}, {"label": "Albania", "value": "AL"}, {"label": "Algeria", "value": "DZ"}, {"label": "American Samoa", "value": "AS"}, {"label": "Andorra", "value": "AD"}, {"label": "Angola", "value": "AO"}, {"label": "Anguilla", "value": "AI"}, {"label": "Antarctica", "value": "AQ"}, {"label": "Antigua And Barbuda", "value": "AG"}, {"label": "Argentina", "value": "AR"}, {"label": "Armenia", "value": "AM"}, {"label": "Aruba", "value": "AW"}, {"label": "Australia", "value": "AU"}, {"label": "Austria", "value": "AT"}, {"label": "Azerbaijan", "value": "AZ"}, {"label": "Bahamas", "value": "BS"}, {"label": "Bahrain", "value": "BH"}, {"label": "Bangladesh", "value": "BD"}, {"label": "Barbados", "value": "BB"}, {"label": "Belarus", "value": "BY"}, {"label": "Belgium", "value": "BE"}, {"label": "Belize", "value": "BZ"}, {"label": "Benin", "value": "BJ"}, {"label": "Bermuda", "value": "BM"}, {"label": "Bhutan", "value": "BT"}, {"label": "Bolivia", "value": "BO"}, {"label": "Bosnia And Herzegovina", "value": "BA"}, {"label": "Bonaire, Sint Eustatius and Saba", "value": "BQ"}, {"label": "Botswana", "value": "BW"}, {"label": "Bouvet Island", "value": "BV"}, {"label": "Brazil", "value": "BR"}, {"label": "British Indian Ocean Territory", "value": "IO"}, {"label": "Brunei Darussalam", "value": "BN"}, {"label": "Bulgaria", "value": "BG"}, {"label": "Burkina Faso", "value": "BF"}, {"label": "Burundi", "value": "BI"}, {"label": "Cambodia", "value": "KH"}, {"label": "Cameroon", "value": "CM"}, {"label": "Canada", "value": "CA"}, {"label": "Cape Verde", "value": "CV"}, {"label": "Cayman Islands", "value": "KY"}, {"label": "Central African Republic", "value": "CF"}, {"label": "Chad", "value": "TD"}, {"label": "Chile", "value": "CL"}, {"label": "China", "value": "CN"}, {"label": "Christmas Island", "value": "CX"}, {"label": "Cocos (Keeling) Islands", "value": "CC"}, {"label": "Colombia", "value": "CO"}, {"label": "Comoros", "value": "KM"}, {"label": "Congo", "value": "CG"}, {"label": "Congo, The Democratic Republic Of The", "value": "CD"}, {"label": "Cook Islands", "value": "CK"}, {"label": "Costa Rica", "value": "CR"}, {"label": "Côte D''ivoire", "value": "CI"}, {"label": "Croatia", "value": "HR"}, {"label": "Cuba", "value": "CU"}, {"label": "Curacao", "value": "CW"}, {"label": "Cyprus", "value": "CY"}, {"label": "Czech Republic", "value": "CZ"}, {"label": "Denmark", "value": "DK"}, {"label": "Djibouti", "value": "DJ"}, {"label": "Dominica", "value": "DM"}, {"label": "Dominican Republic", "value": "DO"}, {"label": "Ecuador", "value": "EC"}, {"label": "Egypt", "value": "EG"}, {"label": "El Salvador", "value": "SV"}, {"label": "Equatorial Guinea", "value": "GQ"}, {"label": "Eritrea", "value": "ER"}, {"label": "Estonia", "value": "EE"}, {"label": "Ethiopia", "value": "ET"}, {"label": "Falkland Islands (Malvinas)", "value": "FK"}, {"label": "Faroe Islands", "value": "FO"}, {"label": "Fiji", "value": "FJ"}, {"label": "Finland", "value": "FI"}, {"label": "France", "value": "FR"}, {"label": "French Guiana", "value": "GF"}, {"label": "French Polynesia", "value": "PF"}, {"label": "French Southern Territories", "value": "TF"}, {"label": "Gabon", "value": "GA"}, {"label": "Gambia", "value": "GM"}, {"label": "Georgia", "value": "GE"}, {"label": "Germany", "value": "DE"}, {"label": "Ghana", "value": "GH"}, {"label": "Gibraltar", "value": "GI"}, {"label": "Greece", "value": "GR"}, {"label": "Greenland", "value": "GL"}, {"label": "Grenada", "value": "GD"}, {"label": "Guadeloupe", "value": "GP"}, {"label": "Guam", "value": "GU"}, {"label": "Guatemala", "value": "GT"}, {"label": "Guernsey", "value": "GG"}, {"label": "Guinea", "value": "GN"}, {"label": "Guinea-Bissau", "value": "GW"}, {"label": "Guyana", "value": "GY"}, {"label": "Haiti", "value": "HT"}, {"label": "Heard Island And McDonald Islands", "value": "HM"}, {"label": "Vatican City State", "value": "VA"}, {"label": "Honduras", "value": "HN"}, {"label": "Hong Kong", "value": "HK"}, {"label": "Hungary", "value": "HU"}, {"label": "Iceland", "value": "IS"}, {"label": "India", "value": "IN"}, {"label": "Indonesia", "value": "ID"}, {"label": "Iran, Islamic Republic Of", "value": "IR"}, {"label": "Iraq", "value": "IQ"}, {"label": "Ireland", "value": "IE"}, {"label": "Isle Of Man", "value": "IM"}, {"label": "Israel", "value": "IL"}, {"label": "Italy", "value": "IT"}, {"label": "Jamaica", "value": "JM"}, {"label": "Japan", "value": "JP"}, {"label": "Jersey", "value": "JE"}, {"label": "Jordan", "value": "JO"}, {"label": "Kazakhstan", "value": "KZ"}, {"label": "Kenya", "value": "KE"}, {"label": "Kiribati", "value": "KI"}, {"label": "Korea, Democratic People''s Republic Of", "value": "KP"}, {"label": "Korea, Republic Of", "value": "KR"}, {"label": "Kuwait", "value": "KW"}, {"label": "Kyrgyzstan", "value": "KG"}, {"label": "Lao People''s Democratic Republic", "value": "LA"}, {"label": "Latvia", "value": "LV"}, {"label": "Lebanon", "value": "LB"}, {"label": "Lesotho", "value": "LS"}, {"label": "Liberia", "value": "LR"}, {"label": "Libyan Arab Jamahiriya", "value": "LY"}, {"label": "Liechtenstein", "value": "LI"}, {"label": "Lithuania", "value": "LT"}, {"label": "Luxembourg", "value": "LU"}, {"label": "Macao", "value": "MO"}, {"label": "Macedonia, The Former Yugoslav Republic Of", "value": "MK"}, {"label": "Madagascar", "value": "MG"}, {"label": "Malawi", "value": "MW"}, {"label": "Malaysia", "value": "MY"}, {"label": "Maldives", "value": "MV"}, {"label": "Mali", "value": "ML"}, {"label": "Malta", "value": "MT"}, {"label": "Marshall Islands", "value": "MH"}, {"label": "Martinique", "value": "MQ"}, {"label": "Mauritania", "value": "MR"}, {"label": "Mauritius", "value": "MU"}, {"label": "Mayotte", "value": "YT"}, {"label": "Mexico", "value": "MX"}, {"label": "Micronesia, Federated States Of", "value": "FM"}, {"label": "Moldova, Republic Of", "value": "MD"}, {"label": "Monaco", "value": "MC"}, {"label": "Mongolia", "value": "MN"}, {"label": "Montenegro", "value": "ME"}, {"label": "Montserrat", "value": "MS"}, {"label": "Morocco", "value": "MA"}, {"label": "Mozambique", "value": "MZ"}, {"label": "Myanmar", "value": "MM"}, {"label": "Namibia", "value": "NA"}, {"label": "Nauru", "value": "NR"}, {"label": "Nepal", "value": "NP"}, {"label": "Netherlands", "value": "NL"}, {"label": "Netherlands Antilles", "value": "AN"}, {"label": "New Caledonia", "value": "NC"}, {"label": "New Zealand", "value": "NZ"}, {"label": "Nicaragua", "value": "NI"}, {"label": "Niger", "value": "NE"}, {"label": "Nigeria", "value": "NG"}, {"label": "Niue", "value": "NU"}, {"label": "Norfolk Island", "value": "NF"}, {"label": "Northern Mariana Islands", "value": "MP"}, {"label": "Norway", "value": "NO"}, {"label": "Oman", "value": "OM"}, {"label": "Pakistan", "value": "PK"}, {"label": "Palau", "value": "PW"}, {"label": "Palestinian Territory, Occupied", "value": "PS"}, {"label": "Panama", "value": "PA"}, {"label": "Papua New Guinea", "value": "PG"}, {"label": "Paraguay", "value": "PY"}, {"label": "Peru", "value": "PE"}, {"label": "Philippines", "value": "PH"}, {"label": "Pitcairn", "value": "PN"}, {"label": "Poland", "value": "PL"}, {"label": "Portugal", "value": "PT"}, {"label": "Puerto Rico", "value": "PR"}, {"label": "Qatar", "value": "QA"}, {"label": "Reunion Island", "value": "RE"}, {"label": "Romania", "value": "RO"}, {"label": "Russian Federation", "value": "RU"}, {"label": "Rwanda", "value": "RW"}, {"label": "Saint Barthelemy", "value": "BL"}, {"label": "Saint Helena, Ascension And Tristan da Cunha", "value": "SH"}, {"label": "Saint Kitts And Nevis", "value": "KN"}, {"label": "Saint Lucia", "value": "LC"}, {"label": "Saint Martin", "value": "MF"}, {"label": "Saint Pierre And Miquelon", "value": "PM"}, {"label": "Saint Vincent And The Grenadines", "value": "VC"}, {"label": "Samoa", "value": "WS"}, {"label": "San Marino", "value": "SM"}, {"label": "Sao Tome And Principe", "value": "ST"}, {"label": "Saudi Arabia", "value": "SA"}, {"label": "Senegal", "value": "SN"}, {"label": "Serbia", "value": "RS"}, {"label": "Seychelles", "value": "SC"}, {"label": "Sierra Leone", "value": "SL"}, {"label": "Singapore", "value": "SG"}, {"label": "Sint Marteen", "value": "SX"}, {"label": "Slovakia", "value": "SK"}, {"label": "Slovenia", "value": "SI"}, {"label": "Solomon Islands", "value": "SB"}, {"label": "Somalia", "value": "SO"}, {"label": "South Africa", "value": "ZA"}, {"label": "South Georgia And The South Sandwich Islands", "value": "GS"}, {"label": "South Sudan", "value": "SS"}, {"label": "Spain", "value": "ES"}, {"label": "Sri Lanka", "value": "LK"}, {"label": "Sudan", "value": "SD"}, {"label": "Suriname", "value": "SR"}, {"label": "Svalbard And Jan Mayen Islands", "value": "SJ"}, {"label": "Swaziland", "value": "SZ"}, {"label": "Sweden", "value": "SE"}, {"label": "Switzerland", "value": "CH"}, {"label": "Syrian Arab Republic", "value": "SY"}, {"label": "Taiwan, Province Of China", "value": "TW"}, {"label": "Tajikistan", "value": "TJ"}, {"label": "Tanzania, United Republic Of", "value": "TZ"}, {"label": "Thailand", "value": "TH"}, {"label": "Timor-Leste", "value": "TL"}, {"label": "Togo", "value": "TG"}, {"label": "Tokelau", "value": "TK"}, {"label": "Tonga", "value": "TO"}, {"label": "Trinidad And Tobago", "value": "TT"}, {"label": "Tunisia", "value": "TN"}, {"label": "Turkey", "value": "TR"}, {"label": "Turkmenistan", "value": "TM"}, {"label": "Turks And Caicos Islands", "value": "TC"}, {"label": "Tuvalu", "value": "TV"}, {"label": "Uganda", "value": "UG"}, {"label": "Ukraine", "value": "UA"}, {"label": "United Arab Emirates", "value": "AE"}, {"label": "United Kingdom", "value": "GB"}, {"label": "United States", "value": "US"}, {"label": "United States Minor Outlying Islands", "value": "UM"}, {"label": "Uruguay", "value": "UY"}, {"label": "Uzbekistan", "value": "UZ"}, {"label": "Vanuatu", "value": "VU"}, {"label": "Venezuela, Bolivarian Republic Of", "value": "VE"}, {"label": "Viet Nam", "value": "VN"}, {"label": "Virgin Islands, British", "value": "VG"}, {"label": "Virgin Islands, U.S.", "value": "VI"}, {"label": "Wallis And Futuna", "value": "WF"}, {"label": "Western Sahara", "value": "EH"}, {"label": "Yemen", "value": "YE"}, {"label": "Zambia", "value": "ZM"}, {"label": "Zimbabwe", "value": "ZW"}, {"label": "Not categorised", "value": "XX"}, {"label": "Others", "value": "ZZ"}], "validations": {"required": true}}], "colClassName": "mt-4"}}, {"section": {"label": "Phone", "fields": [{"key": "Batch.Report.RelatedPersons[].Phone.Telephone", "type": "text", "label": "Telephone", "validations": {"required": false, "maxLength": 30, "minLength": 6}}, {"key": "Batch.Report.RelatedPersons[].Phone.Mobile", "type": "text", "label": "Mobile", "validations": {"required": false, "maxLength": 30, "minLength": 6}}, {"key": "Batch.Report.RelatedPersons[].Phone.Fax", "type": "text", "label": "Fax", "validations": {"required": false, "maxLength": 30, "minLength": 6}}], "colClassName": "mt-4"}}, {"key": "Batch.Report.RelatedPersons[].Email", "type": "text", "label": "Email", "validations": {"regexp": "``", "required": false, "maxLength": 50, "minLength": 6}}, {"section": {"label": "Second Address", "fields": [{"key": "Batch.Report.RelatedPersons[].SecondAddress.Address", "type": "text", "label": "Address", "validations": {"required": false, "maxLength": 225, "minLength": 8}}, {"key": "Batch.Report.RelatedPersons[].SecondAddress.City", "type": "text", "label": "City", "validations": {"required": false, "maxLength": 50}}, {"key": "Batch.Report.RelatedPersons[].SecondAddress.StateCode", "type": "select", "label": "State Code", "options": [{"label": "Andaman & Nicobar", "value": "AN"}, {"label": "Andhra Pradesh", "value": "AP"}, {"label": "Arunachal Pradesh", "value": "AR"}, {"label": "Assam", "value": "AS"}, {"label": "Bihar", "value": "BR"}, {"label": "Chandigarh", "value": "CH"}, {"label": "Chhattisgarh", "value": "CG"}, {"label": "Dadra and Nagar Haveli", "value": "DN"}, {"label": "Daman & Diu", "value": "DD"}, {"label": "Delhi", "value": "DL"}, {"label": "Goa", "value": "GA"}, {"label": "Gujarat", "value": "GJ"}, {"label": "Haryana", "value": "HR"}, {"label": "Himachal Pradesh", "value": "HP"}, {"label": "Jammu & Kashmir", "value": "JK"}, {"label": "Jharkhand", "value": "JH"}, {"label": "Karnataka", "value": "KA"}, {"label": "Kerala", "value": "KL"}, {"label": "Lakshadweep", "value": "LD"}, {"label": "Madhya Pradesh", "value": "MP"}, {"label": "Maharashtra", "value": "MH"}, {"label": "Manipur", "value": "MN"}, {"label": "Meghalaya", "value": "ML"}, {"label": "Mizoram", "value": "MZ"}, {"label": "Nagaland", "value": "NL"}, {"label": "Orissa", "value": "OR"}, {"label": "Pondicherry", "value": "PY"}, {"label": "Punjab", "value": "PB"}, {"label": "Rajasthan", "value": "RJ"}, {"label": "Sikkim", "value": "SK"}, {"label": "Tamil Nadu", "value": "TN"}, {"label": "Tripura", "value": "TR"}, {"label": "Uttar Pradesh", "value": "UP"}, {"label": "Uttarakhand", "value": "UA"}, {"label": "West Bengal", "value": "WB"}, {"label": "Others", "value": "ZZ"}, {"label": "Not Applicable", "value": "XX"}], "validations": {"required": false}}, {"key": "Batch.Report.RelatedPersons[].SecondAddress.PinCode", "type": "text", "label": "Pincode", "validations": {"required": false, "maxLength": 10}}, {"key": "Batch.Report.RelatedPersons[].SecondAddress.CountryCode", "type": "select", "label": "Country Code", "options": [{"label": "Afghanistan", "value": "AF"}, {"label": "Aland Islands", "value": "AX"}, {"label": "Albania", "value": "AL"}, {"label": "Algeria", "value": "DZ"}, {"label": "American Samoa", "value": "AS"}, {"label": "Andorra", "value": "AD"}, {"label": "Angola", "value": "AO"}, {"label": "Anguilla", "value": "AI"}, {"label": "Antarctica", "value": "AQ"}, {"label": "Antigua And Barbuda", "value": "AG"}, {"label": "Argentina", "value": "AR"}, {"label": "Armenia", "value": "AM"}, {"label": "Aruba", "value": "AW"}, {"label": "Australia", "value": "AU"}, {"label": "Austria", "value": "AT"}, {"label": "Azerbaijan", "value": "AZ"}, {"label": "Bahamas", "value": "BS"}, {"label": "Bahrain", "value": "BH"}, {"label": "Bangladesh", "value": "BD"}, {"label": "Barbados", "value": "BB"}, {"label": "Belarus", "value": "BY"}, {"label": "Belgium", "value": "BE"}, {"label": "Belize", "value": "BZ"}, {"label": "Benin", "value": "BJ"}, {"label": "Bermuda", "value": "BM"}, {"label": "Bhutan", "value": "BT"}, {"label": "Bolivia", "value": "BO"}, {"label": "Bosnia And Herzegovina", "value": "BA"}, {"label": "Bonaire, Sint Eustatius and Saba", "value": "BQ"}, {"label": "Botswana", "value": "BW"}, {"label": "Bouvet Island", "value": "BV"}, {"label": "Brazil", "value": "BR"}, {"label": "British Indian Ocean Territory", "value": "IO"}, {"label": "Brunei Darussalam", "value": "BN"}, {"label": "Bulgaria", "value": "BG"}, {"label": "Burkina Faso", "value": "BF"}, {"label": "Burundi", "value": "BI"}, {"label": "Cambodia", "value": "KH"}, {"label": "Cameroon", "value": "CM"}, {"label": "Canada", "value": "CA"}, {"label": "Cape Verde", "value": "CV"}, {"label": "Cayman Islands", "value": "KY"}, {"label": "Central African Republic", "value": "CF"}, {"label": "Chad", "value": "TD"}, {"label": "Chile", "value": "CL"}, {"label": "China", "value": "CN"}, {"label": "Christmas Island", "value": "CX"}, {"label": "Cocos (Keeling) Islands", "value": "CC"}, {"label": "Colombia", "value": "CO"}, {"label": "Comoros", "value": "KM"}, {"label": "Congo", "value": "CG"}, {"label": "Congo, The Democratic Republic Of The", "value": "CD"}, {"label": "Cook Islands", "value": "CK"}, {"label": "Costa Rica", "value": "CR"}, {"label": "Côte D''ivoire", "value": "CI"}, {"label": "Croatia", "value": "HR"}, {"label": "Cuba", "value": "CU"}, {"label": "Curacao", "value": "CW"}, {"label": "Cyprus", "value": "CY"}, {"label": "Czech Republic", "value": "CZ"}, {"label": "Denmark", "value": "DK"}, {"label": "Djibouti", "value": "DJ"}, {"label": "Dominica", "value": "DM"}, {"label": "Dominican Republic", "value": "DO"}, {"label": "Ecuador", "value": "EC"}, {"label": "Egypt", "value": "EG"}, {"label": "El Salvador", "value": "SV"}, {"label": "Equatorial Guinea", "value": "GQ"}, {"label": "Eritrea", "value": "ER"}, {"label": "Estonia", "value": "EE"}, {"label": "Ethiopia", "value": "ET"}, {"label": "Falkland Islands (Malvinas)", "value": "FK"}, {"label": "Faroe Islands", "value": "FO"}, {"label": "Fiji", "value": "FJ"}, {"label": "Finland", "value": "FI"}, {"label": "France", "value": "FR"}, {"label": "French Guiana", "value": "GF"}, {"label": "French Polynesia", "value": "PF"}, {"label": "French Southern Territories", "value": "TF"}, {"label": "Gabon", "value": "GA"}, {"label": "Gambia", "value": "GM"}, {"label": "Georgia", "value": "GE"}, {"label": "Germany", "value": "DE"}, {"label": "Ghana", "value": "GH"}, {"label": "Gibraltar", "value": "GI"}, {"label": "Greece", "value": "GR"}, {"label": "Greenland", "value": "GL"}, {"label": "Grenada", "value": "GD"}, {"label": "Guadeloupe", "value": "GP"}, {"label": "Guam", "value": "GU"}, {"label": "Guatemala", "value": "GT"}, {"label": "Guernsey", "value": "GG"}, {"label": "Guinea", "value": "GN"}, {"label": "Guinea-Bissau", "value": "GW"}, {"label": "Guyana", "value": "GY"}, {"label": "Haiti", "value": "HT"}, {"label": "Heard Island And McDonald Islands", "value": "HM"}, {"label": "Vatican City State", "value": "VA"}, {"label": "Honduras", "value": "HN"}, {"label": "Hong Kong", "value": "HK"}, {"label": "Hungary", "value": "HU"}, {"label": "Iceland", "value": "IS"}, {"label": "India", "value": "IN"}, {"label": "Indonesia", "value": "ID"}, {"label": "Iran, Islamic Republic Of", "value": "IR"}, {"label": "Iraq", "value": "IQ"}, {"label": "Ireland", "value": "IE"}, {"label": "Isle Of Man", "value": "IM"}, {"label": "Israel", "value": "IL"}, {"label": "Italy", "value": "IT"}, {"label": "Jamaica", "value": "JM"}, {"label": "Japan", "value": "JP"}, {"label": "Jersey", "value": "JE"}, {"label": "Jordan", "value": "JO"}, {"label": "Kazakhstan", "value": "KZ"}, {"label": "Kenya", "value": "KE"}, {"label": "Kiribati", "value": "KI"}, {"label": "Korea, Democratic People''s Republic Of", "value": "KP"}, {"label": "Korea, Republic Of", "value": "KR"}, {"label": "Kuwait", "value": "KW"}, {"label": "Kyrgyzstan", "value": "KG"}, {"label": "Lao People''s Democratic Republic", "value": "LA"}, {"label": "Latvia", "value": "LV"}, {"label": "Lebanon", "value": "LB"}, {"label": "Lesotho", "value": "LS"}, {"label": "Liberia", "value": "LR"}, {"label": "Libyan Arab Jamahiriya", "value": "LY"}, {"label": "Liechtenstein", "value": "LI"}, {"label": "Lithuania", "value": "LT"}, {"label": "Luxembourg", "value": "LU"}, {"label": "Macao", "value": "MO"}, {"label": "Macedonia, The Former Yugoslav Republic Of", "value": "MK"}, {"label": "Madagascar", "value": "MG"}, {"label": "Malawi", "value": "MW"}, {"label": "Malaysia", "value": "MY"}, {"label": "Maldives", "value": "MV"}, {"label": "Mali", "value": "ML"}, {"label": "Malta", "value": "MT"}, {"label": "Marshall Islands", "value": "MH"}, {"label": "Martinique", "value": "MQ"}, {"label": "Mauritania", "value": "MR"}, {"label": "Mauritius", "value": "MU"}, {"label": "Mayotte", "value": "YT"}, {"label": "Mexico", "value": "MX"}, {"label": "Micronesia, Federated States Of", "value": "FM"}, {"label": "Moldova, Republic Of", "value": "MD"}, {"label": "Monaco", "value": "MC"}, {"label": "Mongolia", "value": "MN"}, {"label": "Montenegro", "value": "ME"}, {"label": "Montserrat", "value": "MS"}, {"label": "Morocco", "value": "MA"}, {"label": "Mozambique", "value": "MZ"}, {"label": "Myanmar", "value": "MM"}, {"label": "Namibia", "value": "NA"}, {"label": "Nauru", "value": "NR"}, {"label": "Nepal", "value": "NP"}, {"label": "Netherlands", "value": "NL"}, {"label": "Netherlands Antilles", "value": "AN"}, {"label": "New Caledonia", "value": "NC"}, {"label": "New Zealand", "value": "NZ"}, {"label": "Nicaragua", "value": "NI"}, {"label": "Niger", "value": "NE"}, {"label": "Nigeria", "value": "NG"}, {"label": "Niue", "value": "NU"}, {"label": "Norfolk Island", "value": "NF"}, {"label": "Northern Mariana Islands", "value": "MP"}, {"label": "Norway", "value": "NO"}, {"label": "Oman", "value": "OM"}, {"label": "Pakistan", "value": "PK"}, {"label": "Palau", "value": "PW"}, {"label": "Palestinian Territory, Occupied", "value": "PS"}, {"label": "Panama", "value": "PA"}, {"label": "Papua New Guinea", "value": "PG"}, {"label": "Paraguay", "value": "PY"}, {"label": "Peru", "value": "PE"}, {"label": "Philippines", "value": "PH"}, {"label": "Pitcairn", "value": "PN"}, {"label": "Poland", "value": "PL"}, {"label": "Portugal", "value": "PT"}, {"label": "Puerto Rico", "value": "PR"}, {"label": "Qatar", "value": "QA"}, {"label": "Reunion Island", "value": "RE"}, {"label": "Romania", "value": "RO"}, {"label": "Russian Federation", "value": "RU"}, {"label": "Rwanda", "value": "RW"}, {"label": "Saint Barthelemy", "value": "BL"}, {"label": "Saint Helena, Ascension And Tristan da Cunha", "value": "SH"}, {"label": "Saint Kitts And Nevis", "value": "KN"}, {"label": "Saint Lucia", "value": "LC"}, {"label": "Saint Martin", "value": "MF"}, {"label": "Saint Pierre And Miquelon", "value": "PM"}, {"label": "Saint Vincent And The Grenadines", "value": "VC"}, {"label": "Samoa", "value": "WS"}, {"label": "San Marino", "value": "SM"}, {"label": "Sao Tome And Principe", "value": "ST"}, {"label": "Saudi Arabia", "value": "SA"}, {"label": "Senegal", "value": "SN"}, {"label": "Serbia", "value": "RS"}, {"label": "Seychelles", "value": "SC"}, {"label": "Sierra Leone", "value": "SL"}, {"label": "Singapore", "value": "SG"}, {"label": "Sint Marteen", "value": "SX"}, {"label": "Slovakia", "value": "SK"}, {"label": "Slovenia", "value": "SI"}, {"label": "Solomon Islands", "value": "SB"}, {"label": "Somalia", "value": "SO"}, {"label": "South Africa", "value": "ZA"}, {"label": "South Georgia And The South Sandwich Islands", "value": "GS"}, {"label": "South Sudan", "value": "SS"}, {"label": "Spain", "value": "ES"}, {"label": "Sri Lanka", "value": "LK"}, {"label": "Sudan", "value": "SD"}, {"label": "Suriname", "value": "SR"}, {"label": "Svalbard And Jan Mayen Islands", "value": "SJ"}, {"label": "Swaziland", "value": "SZ"}, {"label": "Sweden", "value": "SE"}, {"label": "Switzerland", "value": "CH"}, {"label": "Syrian Arab Republic", "value": "SY"}, {"label": "Taiwan, Province Of China", "value": "TW"}, {"label": "Tajikistan", "value": "TJ"}, {"label": "Tanzania, United Republic Of", "value": "TZ"}, {"label": "Thailand", "value": "TH"}, {"label": "Timor-Leste", "value": "TL"}, {"label": "Togo", "value": "TG"}, {"label": "Tokelau", "value": "TK"}, {"label": "Tonga", "value": "TO"}, {"label": "Trinidad And Tobago", "value": "TT"}, {"label": "Tunisia", "value": "TN"}, {"label": "Turkey", "value": "TR"}, {"label": "Turkmenistan", "value": "TM"}, {"label": "Turks And Caicos Islands", "value": "TC"}, {"label": "Tuvalu", "value": "TV"}, {"label": "Uganda", "value": "UG"}, {"label": "Ukraine", "value": "UA"}, {"label": "United Arab Emirates", "value": "AE"}, {"label": "United Kingdom", "value": "GB"}, {"label": "United States", "value": "US"}, {"label": "United States Minor Outlying Islands", "value": "UM"}, {"label": "Uruguay", "value": "UY"}, {"label": "Uzbekistan", "value": "UZ"}, {"label": "Vanuatu", "value": "VU"}, {"label": "Venezuela, Bolivarian Republic Of", "value": "VE"}, {"label": "Viet Nam", "value": "VN"}, {"label": "Virgin Islands, British", "value": "VG"}, {"label": "Virgin Islands, U.S.", "value": "VI"}, {"label": "Wallis And Futuna", "value": "WF"}, {"label": "Western Sahara", "value": "EH"}, {"label": "Yemen", "value": "YE"}, {"label": "Zambia", "value": "ZM"}, {"label": "Zimbabwe", "value": "ZW"}, {"label": "Not categorised", "value": "XX"}, {"label": "Others", "value": "ZZ"}], "validations": {"required": false}}], "colClassName": "mt-4"}}], "isArray": true, "arrayKey": "Batch.Report.RelatedPersons", "required": true, "colClassName": "mt-4"}}], "required": true, "colClassName": "mt-4"}}]', 'STR Transaction', '{"POST": [{"UpdateProcessVariableCamunda": [{"ProcessVariableName": "str_report_id", "ProcessVariableType": "integer", "ProcessVariableValue": "this.FormValue.iValueID"}]}]}', 'Add Transaction Based STR');


SELECT pg_catalog.setval('ui.formmaster_ifromid_seq', 2, true);
