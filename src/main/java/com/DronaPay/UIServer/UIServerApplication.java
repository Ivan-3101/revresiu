package com.DronaPay.UIServer;


import com.DronaPay.UIServer.configuration.FileStorageProperties;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.annotation.Bean;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.EnableScheduling;
//import springfox.documentation.builders.RequestHandlerSelectors;
//import springfox.documentation.service.ApiInfo;
//import springfox.documentation.spi.DocumentationType;
//import springfox.documentation.spring.web.plugins.Docket;

import java.util.Collections;
//import org.springframework.context.annotation.Bean;
//import org.springframework.core.env.Environment;
//import org.springframework.security.crypto.password.PasswordEncoder;
//
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;

//import com.algoengines.UIServer.response.MenuStructureResponse;
//
//import springfox.documentation.builders.RequestHandlerSelectors;
//import springfox.documentation.service.ApiInfo;
//import springfox.documentation.spi.DocumentationType;
//import springfox.documentation.spring.web.plugins.Docket;
//import springfox.documentation.swagger2.annotations.EnableSwagger2;

@SpringBootApplication
//@EnableSwagger2
@EnableConfigurationProperties({FileStorageProperties.class})
@EnableCaching
@EnableScheduling
@EnableAsync
public class UIServerApplication {

//	private static final Logger LOGGER = LoggerFactory.getLogger(UIServerApplication.class);
//
//	private final PasswordEncoder passwordEncoder;
//
//	private final WebUserService webUserService;
//
//	private final RoleDescService roleDescService;
//
//	private final MenuStructureDescService menuStructureDescService;
//
//	private final RoleMenuAccessMapService roleMenuAccessMapService;
//
//	private final UserRoleMenuAccessService userRoleMenuAccessService;
//
//	private final StatusCodeService statusCodeService;
//
//	private final WebUserAuditService webUserAuditService;
//
//	private final Environment env;
//
//	private final GroupDescService groupDescService;
//
//	private final ScoreRequestService scoreRequestService;
//
//	private final TransactionClassesService transactionClassesService;
//
//	private final RulesService rulesService;
//
//	private final DecisionService decisionService;
//
//	private final ProductService productService;
//
//	private final ParameterService parameterService;
//
//	private final ValidationFieldsListService validationFieldsListService;
//
//	public UIServerApplication(RoleDescService roleDescService, PasswordEncoder passwordEncoder, WebUserService webUserService, MenuStructureDescService menuStructureDescService, DecisionService decisionService, RoleMenuAccessMapService roleMenuAccessMapService, UserRoleMenuAccessService userRoleMenuAccessService, StatusCodeService statusCodeService, WebUserAuditService webUserAuditService, TransactionClassesService transactionClassesService, ValidationFieldsListService validationFieldsListService, ParameterService parameterService, Environment env, GroupDescService groupDescService, ScoreRequestService scoreRequestService, ProductService productService, RulesService rulesService) {
//		this.roleDescService = roleDescService;
//		this.passwordEncoder = passwordEncoder;
//		this.webUserService = webUserService;
//		this.menuStructureDescService = menuStructureDescService;
//		this.decisionService = decisionService;
//		this.roleMenuAccessMapService = roleMenuAccessMapService;
//		this.userRoleMenuAccessService = userRoleMenuAccessService;
//		this.statusCodeService = statusCodeService;
//		this.webUserAuditService = webUserAuditService;
//		this.transactionClassesService = transactionClassesService;
//		this.validationFieldsListService = validationFieldsListService;
//		this.parameterService = parameterService;
//		this.env = env;
//		this.groupDescService = groupDescService;
//		this.scoreRequestService = scoreRequestService;
//		this.productService = productService;
//		this.rulesService = rulesService;
//	}

    public static void main(String[] args) {
        SpringApplication.run(UIServerApplication.class, args);
    }

//    @Bean
//    public Docket swaggerConfiguration() {
//        return new Docket(DocumentationType.SWAGGER_2)
//                .select()
//                .apis(RequestHandlerSelectors.basePackage("com.DronaPay.UIServer.controller"))
//                .build()
//                .apiInfo(apiDetails());
//    }
//
//    private ApiInfo apiDetails() {
//        return new ApiInfo(
//                "UIServer",
//                "Apis for DronaUI",
//                "1.0",
//                "AlgoEngines",
//                new springfox.documentation.service.Contact("Aniket Gayakwad", "https://github.com/aniketif", "aniketif@gmail.com"),
//                "Api License",
//                "https://github.com/aniketif",
//                Collections.emptyList());
//    }

//<----------------------- this below code is to add new default user into database ---------->


//	@PostConstruct
//	protected void init() {
//
//
//		ValidationFieldsList vpa = new ValidationFieldsList();
//		vpa.setVcFieldDisplayName("VPA");
//		vpa.setVcTransTableNFieldName("VPA");
//		vpa.setVcUPIFieldName("VPA");
//		vpa.setVcMessageFieldName("VPA");
//		vpa.setDtEntryDateTime(new Date());
//
//		ValidationFieldsList mobileNumber = new ValidationFieldsList();
//		mobileNumber.setVcFieldDisplayName("Mobile Number");
//		mobileNumber.setVcTransTableNFieldName("MobNo");
//		mobileNumber.setVcUPIFieldName("MobNo");
//		mobileNumber.setVcMessageFieldName("MobNo");
//		mobileNumber.setDtEntryDateTime(new Date());
//
//		ValidationFieldsList ipAddress = new ValidationFieldsList();
//		ipAddress.setVcFieldDisplayName("IP Address");
//		ipAddress.setVcTransTableNFieldName("IP");
//		ipAddress.setVcUPIFieldName("IP");
//		ipAddress.setVcMessageFieldName("IP");
//		ipAddress.setDtEntryDateTime(new Date());
//
//		validationFieldsListService.save(vpa);
//		validationFieldsListService.save(mobileNumber);
//		validationFieldsListService.save(ipAddress);
//
//		Product upiProduct = new Product();
//		upiProduct.setVcProductName("UPI");
//		upiProduct.setVcProductDetail("United Payment Interface by NPCI");
//		upiProduct.setBActive(true);
//		upiProduct.setIRecordStatus(1);
//
//
//		Product impsProduct = new Product();
//		impsProduct.setVcProductName("IMPS");
//		impsProduct.setVcProductDetail("IMPS");
//		impsProduct.setBActive(true);
//		impsProduct.setIRecordStatus(1);
//
//		Product rtgsProduct = new Product();
//		rtgsProduct.setVcProductName("RTGS");
//		rtgsProduct.setVcProductDetail("RTGS");
//		rtgsProduct.setBActive(true);
//		rtgsProduct.setIRecordStatus(1);
//
//		Product neftProduct = new Product();
//		neftProduct.setVcProductName("NEFT");
//		neftProduct.setVcProductDetail("NEFT");
//		neftProduct.setBActive(true);
//		neftProduct.setIRecordStatus(1);
//
//
//		Product ccProduct = new Product();
//		ccProduct.setVcProductName("CC");
//		ccProduct.setVcProductDetail("Credit Card");
//		ccProduct.setBActive(false);
//		ccProduct.setIRecordStatus(1);
//
//		Product dcProduct = new Product();
//		dcProduct.setVcProductName("DC");
//		dcProduct.setVcProductDetail("Debit Card");
//		dcProduct.setBActive(false);
//		dcProduct.setIRecordStatus(1);
//		try {
//			productService.save(upiProduct);
//			productService.save(impsProduct);
//			productService.save(rtgsProduct);
//			productService.save(neftProduct);
//			productService.save(ccProduct);
//			productService.save(dcProduct);
//
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//
//
//		Decision upiAuthentication = new Decision();
//		upiAuthentication.setIProductID(upiProduct);
//		upiAuthentication.setVcDecisionName("UPI Authorization");
//		upiAuthentication.setVcDecisionDetail("UPI Authorization");
//		upiAuthentication.setBActive(true);
//
//		Decision neftTransAuth = new Decision();
//		neftTransAuth.setIProductID(neftProduct);
//		neftTransAuth.setVcDecisionName("NEFT Trans Auth");
//		neftTransAuth.setVcDecisionDetail("NEFT Trans Auth");
//		neftTransAuth.setBActive(true);
//
//		Decision ccTransAuth = new Decision();
//		ccTransAuth.setIProductID(neftProduct);
//		ccTransAuth.setVcDecisionName("CC Trans Auth");
//		ccTransAuth.setVcDecisionDetail("CC Trans Auth");
//		ccTransAuth.setBActive(true);
//
//
//		try {
//			decisionService.save(upiAuthentication);
//			decisionService.save(neftTransAuth);
//			decisionService.save(ccTransAuth);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//
////		Rules rule = new Rules();
////		rule.setIRuleID(1);
////		rule.setIDecisionID(decision1);
////		rule.setIProductID(upiProduct);
////		rule.setVcRuleName("LimitCheck");
////		rule.setVcRuleDetail("LimitCheck");
////		rule.setBActive(true);
////		rule.setDtEntryDatetime(new Date());
////		rule.setVcRuleParams("{\"dLimitValue\":100000}");
////		rule.setVcRuleOrder("{\"FailedRule\": -1,\"SuccessRule\": 2}");
////		rule.setBCustom(true);
////		rule.setVcRuleDescription("asdf");
////
////		Rules rule1 = new Rules();
////		rule1.setIRuleID(2);
////		rule1.setIDecisionID(decision1);
////		rule1.setIProductID(upiProduct);
////		rule1.setVcRuleName("Whitelist");
////		rule1.setVcRuleDetail("Whitelist");
////		rule1.setBActive(true);
////		rule1.setDtEntryDatetime(new Date());
////		rule1.setVcRuleParams("{}");
////		rule1.setVcRuleOrder("{\"FailedRule\": 3,\"SuccessRule\": -1,\"StartRule\":1}");
////		rule1.setBCustom(true);
////		rule1.setVcRuleDescription("asdf");
////		try {
////			rulesService.save(rule);
////			rulesService.save(rule1);
////		} catch (Exception e) {
////			e.printStackTrace();
////		}
//
//
//
////		Parameter reqid = new Parameter();
////		reqid.setIProductID(upiProduct);
////		reqid.setVcParameterType("Transaction");
////		reqid.setVcParameterName("reqid");
////		reqid.setVcDataType("String");
////		reqid.setVcDescription("Score Request ID (Unique) e.g. Wrfruf039wdn2wd");
////
////		Parameter txnts = new Parameter();
////		txnts.setIProductID(upiProduct);
////		txnts.setVcParameterType("Transaction");
////		txnts.setVcParameterName("txn.ts");
////		txnts.setVcDataType("date time");
////		txnts.setVcDescription("Transaction Timestamp (ISO-8601 with fractions and timezone) e.g. 2021-05-26T19:46:24.000+05:30");
////
////		Parameter recentprofile = new Parameter();
////		recentprofile.setIProductID(upiProduct);
////		recentprofile.setVcParameterType("Recent Profile");
////		recentprofile.setVcParameterName("payee_d01_trans_count");
////		recentprofile.setVcDataType("String");
////		recentprofile.setVcDescription("Total Number / Count of transactions done by Payee today");
////
////		Parameter recentprofile1 = new Parameter();
////		recentprofile1.setIProductID(upiProduct);
////		recentprofile1.setVcParameterType("Recent Profile");
////		recentprofile1.setVcParameterName("payee_d01_trans_value");
////		recentprofile1.setVcDataType("Date time");
////		recentprofile1.setVcDescription("First transaction by the payment address");
////
////		Parameter historicprofile = new Parameter();
////		historicprofile.setIProductID(upiProduct);
////		historicprofile.setVcParameterType("Historic Profile");
////		historicprofile.setVcParameterName("dtFirstTransaction");
////		historicprofile.setVcDataType("date time");
////		historicprofile.setVcDescription("First transaction by the payment address");
////
////		Parameter historicprofile1 = new Parameter();
////		historicprofile1.setIProductID(upiProduct);
////		historicprofile1.setVcParameterType("Historic Profile");
////		historicprofile1.setVcParameterName("dtLastTransaction");
////		historicprofile1.setVcDataType("date time");
////		historicprofile1.setVcDescription("Last transaction by the payment address");
////
////		try {
////			parameterService.save(reqid);
////			parameterService.save(txnts);
////			parameterService.save(historicprofile);
////			parameterService.save(historicprofile1);
////			parameterService.save(recentprofile);
////			parameterService.save(recentprofile1);
////		} catch (Exception e) {
////			e.printStackTrace();
////		}
//
//
//		TransactionClasses upi = new TransactionClasses();
//		upi.setBActive(true);
//		upi.setBPayeeMandatory(false);
//		upi.setBPayerMandatory(true);
//		upi.setDtEntryDateTime(new Date());
//		upi.setVcClassName("UPI|API");
//		upi.setIChannelID(1);
//		upi.setIDecisionID(upiAuthentication);
//		upi.setIProductID(upiProduct);
//		upi.setIRecordStatus(0);
//
//		TransactionClasses card = new TransactionClasses();
//		card.setBActive(true);
//		card.setBPayeeMandatory(false);
//		card.setBPayerMandatory(true);
//		card.setDtEntryDateTime(new Date());
//		card.setVcClassName("CARD|POS");
//		card.setIChannelID(1);
//		card.setIDecisionID(ccTransAuth);
//		card.setIProductID(ccProduct);
//		card.setIRecordStatus(0);
//
////		TransactionClasses card = new TransactionClasses();
////		card.setBActive(true);
////		card.setBPayeeMandatory(false);
////		card.setBPayerMandatory(true);
////		card.setDtEntryDateTime(new Date());
////		card.setVcClassName("CARD|API");
////		card.setIChannelID(1);
////		card.setIDecisionID(ccTransAuth);
////		card.setIProductID(ccProduct);
////		card.setIRecordStatus(0);
//
//		TransactionClasses neft = new TransactionClasses();
//		neft.setBActive(true);
//		neft.setBPayeeMandatory(true);
//		neft.setBPayerMandatory(false);
//		neft.setDtEntryDateTime(new Date());
//		neft.setVcClassName("NEFT|ONLINE");
//		neft.setIChannelID(1);
//		neft.setIDecisionID(neftTransAuth);
//		neft.setIProductID(neftProduct);
//		neft.setIRecordStatus(0);
//
//		try {
//			transactionClassesService.save(upi);
//			transactionClassesService.save(card);
//			transactionClassesService.save(neft);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//
//		ScoreRequests upi1 = new ScoreRequests();
//		upi1.setVcRequestID("R-1634207692258");
//		upi1.setDtEntryDateTime(new Date());
//		//upi1.setVcRequestData("{\"reqid\":\"3\",\"txn\":{\"ts\":\"2021-10-05T07:57:13.500+05:30\",\"id\":\"t3\",\"org_txn_id\":\"t3\",\"note\":\"fridge\",\"type\":\"PAY\",\"class\":\"CARD|POS\",\"attribs\":{\"key_name\":\"transaction attribute value\"}},\"payer\":{\"addr\":\"5208-0034-0501-2397\",\"type\":\"PERSON\",\"amount\":50000,\"currency\":\"INR\",\"attribs\":{\"identity\":{\"type\":\"ACCOUNT\",\"verified_name\":\"kalicharan\"},\"device\":{\"id\":\"123456789\",\"geocode\":\"12.9667,77.5667\",\"ip\":\"123.123.123.123\",\"type\":\"POS\",\"os\":\"android 4\"}}},\"payee\":{\"addr\":\"SBIN0007524|0589043746074\",\"amount\":50000,\"currency\":\"INR\",\"attribs\":{\"identity\":{\"type\":\"ACCOUNT\",\"verified_name\":\"croma retail\"}}}}");
//		//upi1.setVcRequestData("{\"reqid\":\"1\",\"txn\":{\"ts\":\"2021-10-05T07:43:13.500+05:30\",\"id\":\"t1\",\"org_txn_id\":\"t1\",\"note\":\"onlinepurchase\",\"type\":\"PAY\",\"class\":\"UPI|API\",\"attribs\":{\"key_name\":\"transactionattributevalue\"}},\"payer\":{\"addr\":\"kalicharan@ok\",\"type\":\"PERSON\",\"amount\":50000,\"currency\":\"INR\",\"attribs\":{\"identity\":{\"type\":\"AADHAAR\",\"verified_name\":\"kalicharan\"},\"device\":{\"id\":\"123456789\",\"mobile\":\"91.99999.99999\",\"geocode\":\"12.9667,77.5667\",\"location\":\"SarjapurRoad,Bangalore,KA,IN\",\"ip\":\"123.123.123.123\",\"type\":\"mobile\",\"os\":\"Android4.4\",\"app\":\"CC1.0\",\"capability\":\"11001\"}}},\"payee\":{\"addr\":\"amazon@upi\",\"type\":\"ENTITY\",\"mcc\":\"1500\",\"amount\":50000,\"currency\":\"INR\",\"attribs\":{\"identity\":{\"type\":\"ACCOUNT\",\"verified_name\":\"AmazonIndia\"}}}}");
//		upi1.setVcRequestData("{ \"reqid\":\"R-1634642234543\", \"txn\":{ \"ts\":\"2021-10-19T11:17:14.543+05:30\", \"id\":\"T-1634642234543\", \"org_txn_id\":\"t1\", \"note\":\"online purchase\", \"type\":\"PAY\", \"class\":\"UPI|API\", \"attribs\":{ \"key_name\":\"transaction attribute value\"} }, \"payer\": { \"addr\":\"kalicharan_1@ok\", \"type\":\"PERSON\", \"amount\":50000, \"currency\":\"INR\", \"attribs\":{ \"identity\":{ \"type\": \"AADHAAR\", \"verified_name\":\"kalicharan\" }, \"device\":{ \"id\":\"123456789\", \"mobile\":\"91.99999.99999\", \"geocode\":\"12.9667,77.5667\", \"location\":\"Bangalore,Bangalore,Karnataka\", \"ip\":\"123.123.123.123\", \"type\":\"mobile\", \"os\":\"Android 4.4\", \"app\":\"CC 1.0\", \"capability\":\"11001\" } } }, \"payee\":{ \"addr\":\"amazon@upi\", \"type\":\"ENTITY\", \"mcc\":\"1500\", \"amount\":50000, \"currency\":\"INR\", \"attribs\":{ \"identity\":{ \"type\":\"ACCOUNT\", \"verified_name\":\"Amazon India\" } } } }");
//		//upi1.setVcRequestData("data");
//
//		ScoreRequests card1 = new ScoreRequests();
//		card1.setVcRequestID("R-1634228706651");
//		card1.setDtEntryDateTime(new Date());
//		card1.setVcRequestData("{ \"reqid\": \"29\", \"ts\": \"2021-10-18T10:04:42.000+05:30\", \"txn\": { \"ts\": \"2021-10-18T10:04:41.500+05:30\", \"id\": \"t29\", \"org_txn_id\": \"\", \"note\": \"fridge\", \"type\": \"PAY\", \"class\": \"CARD|POS\", \"attribs\": { \"key_name\": \"transaction attribute value\" } }, \"payer\": { \"addr\": \"5208-0034-0501-2397\", \"type\": \"PERSON\", \"amount\": 66500, \"currency\": \"USD\", \"attribs\": { \"identity\": { \"type\": \"ACCOUNT\", \"verified_name\": \"kalicharan\" }, \"device\": { \"id\": \"123456789\", \"geocode\": \"12.9667,77.5667\", \"ip\": \"123.123.123.123\", \"type\": \"POS\", \"os\": \"android 4\" }, \"account_details\": { \"card_type\": \"VISA|MASTERCARD|AMEX\", \"card_name\": \"Kalicharan K\", \"card_expiry\": \"2022-09-23\", \"billing_name\": \"Kalicharan K\", \"billing_address\": \"House No 7\", \"billing_city\": \"Mumbai\", \"billing_state\": \"Maharashtra\", \"billing_pincode\": \"400004\", \"billing_country\": \"India\" } } }, \"payee\": { \"addr\": \"SBIN0007524|0589043746074\", \"type\": \"ENTITY\", \"mcc\": 5732, \"amount\": 5000000, \"currency\": \"INR\", \"attribs\": { \"identity\": { \"type\": \"ACCOUNT\", \"verified_name\": \"croma retail\" }, \"account_details\": { \"name\": \"Croma Retail\", \"account\": \"0589043746074\", \"ifsc\": \"SBIN0007524\", \"phone\": \"91-22-000000\", \"email\": \"info@cromaretail.com\" } } } }");
//		//card1.setVcRequestData("{ \"reqid\": \"3\", \"txn\": { \"ts\": \"2021-10-05T07:57:13.500+05:30\", \"id\": \"t3\", \"org_txn_id\": \"t3\", \"note\": \"fridge\", \"type\": \"PAY\", \"class\": \"CARD|POS\", \"attribs\": { \"key_name\": \"transaction attribute value\" } }, \"payer\": { \"addr\": \"5208-0034-0501-2397\", \"type\": \"PERSON\", \"amount\": 50000, \"currency\": \"INR\", \"attribs\": { \"identity\": { \"type\": \"ACCOUNT\", \"verified_name\": \"kalicharan\" }, \"device\": { \"id\": \"123456789\", \"geocode\": \"12.9667,77.5667\", \"ip\": \"123.123.123.123\", \"type\": \"POS\", \"os\": \"android 4\" } } }, \"payee\": { \"addr\": \"SBIN0007524|0589043746074\", \"amount\": 50000, \"currency\": \"INR\", \"attribs\": { \"identity\": { \"type\": \"ACCOUNT\", \"verified_name\": \"croma retail\" } } } }");
//		//card1.setVcRequestData("data");
//
//		ScoreRequests neft1 = new ScoreRequests();
//		neft1.setVcRequestID("R-1634228976605");
//
//		neft1.setDtEntryDateTime(new Date());
//		neft1.setVcRequestData("{ \"reqid\": \"28\", \"ts\": \"2021-10-18T10:04:41.000+05:30\", \"txn\": { \"ts\": \"2021-10-18T10:04:40.500+05:30\", \"id\": \"t28\", \"org_txn_id\": \"\", \"note\": \"rent\", \"type\": \"PAY\", \"class\": \"NEFT|ONLINE\", \"attribs\": { \"key_name\": \"transaction attribute value\" } }, \"payer\": { \"addr\": \"HDFC0000001|0520003400042\", \"type\": \"PERSON\", \"amount\": 50000, \"currency\": \"INR\", \"attribs\": { \"identity\": { \"type\": \"AADHAAR\", \"verified_name\": \"kalicharan\" }, \"device\": { \"id\": \"123456789\", \"geocode\": \"12.9667,77.5667\", \"ip\": \"123.123.123.123\", \"type\": \"web\", \"os\": \"windows 10\", \"app\": \"chrome\" } } }, \"payee\": { \"addr\": \"ICIC0000543|0520003743074\", \"type\": \"PERSON\", \"mcc\": 0, \"amount\": 50000, \"currency\": \"INR\", \"attribs\": { \"identity\": { \"type\": \"ACCOUNT\", \"verified_name\": \"lalaram\" }, \"account_details\": { \"name\": \"lalaram\", \"account\": \"0520003743074\", \"ifsc\": \"ICIC0000543\", \"phone\": \"9999999999\", \"email\": \"lram@mail.com\" } } } }");
//		//neft1.setVcRequestData("{\"reqid\":\"3\",\"txn\":{\"ts\":\"2021-10-05T07:57:13.500+05:30\",\"id\":\"t3\",\"org_txn_id\":\"t3\",\"note\":\"fridge\",\"type\":\"PAY\",\"class\":\"CARD|POS\",\"attribs\":{\"key_name\":\"transaction attribute value\"}},\"payer\":{\"addr\":\"5208-0034-0501-2397\",\"type\":\"PERSON\",\"amount\":50000,\"currency\":\"INR\",\"attribs\":{\"identity\":{\"type\":\"ACCOUNT\",\"verified_name\":\"kalicharan\"},\"device\":{\"id\":\"123456789\",\"geocode\":\"12.9667,77.5667\",\"ip\":\"123.123.123.123\",\"type\":\"POS\",\"os\":\"android 4\"}}},\"payee\":{\"addr\":\"SBIN0007524|0589043746074\",\"amount\":50000,\"currency\":\"INR\",\"attribs\":{\"identity\":{\"type\":\"ACCOUNT\",\"verified_name\":\"croma retail\"}}}}");
//		//neft1.setVcRequestData("{ \"reqid\": \"2\", \"txn\": { \"ts\": \"2021-10-05T07:53:13.500+05:30\", \"id\": \"t2\", \"org_txn_id\": \"t2\", \"note\": \"rent\", \"type\": \"PAY\", \"class\": \"NEFT|ONLINE\", \"attribs\": { \"key_name\": \"transaction attribute value\" } }, \"payer\": { \"addr\": \"HDFC0000001|0520003400042\", \"type\": \"PERSON\", \"amount\": 50000, \"currency\": \"INR\", \"attribs\": { \"identity\": { \"type\": \"AADHAAR\", \"verified_name\": \"kalicharan\" }, \"device\": { \"id\": \"123456789\", \"geocode\": \"12.9667,77.5667\", \"ip\": \"123.123.123.123\", \"type\": \"web\", \"os\": \"windows 10\", \"app\": \"chrome\" } } }, \"payee\": { \"addr\": \"ICIC0000543|0520003743074\", \"amount\": 50000, \"currency\": \"INR\", \"attribs\": { \"identity\": { \"type\": \"ACCOUNT\", \"verified_name\": \"lalaram\" } } } }");
//		//neft1.setVcRequestData("data");
//
//		try {
//			scoreRequestService.save(upi1);
//			scoreRequestService.save(neft1);
//			scoreRequestService.save(card1);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//
//
//		LOGGER.error("@@@ Mysql properties @@@");
//		LOGGER.error(env.getProperty("spring.datasource.url"));
//		LOGGER.error(env.getProperty("spring.datasource.username"));
//		LOGGER.error(env.getProperty("spring.datasource.password"));
//
//		StatusCode approved = new StatusCode();
//		approved.setVcStatusName("Approved");
//		approved.setBUpdateMaster(false);
//
//		StatusCode inserted = new StatusCode();
//		inserted.setVcStatusName("Inserted");
//		inserted.setBUpdateMaster(true);
//		inserted.setIStatusIDForMaster(approved);
//
//		StatusCode edited = new StatusCode();
//		edited.setVcStatusName("Edited");
//		edited.setBUpdateMaster(true);
//		edited.setIStatusIDForMaster(approved);
//
//		StatusCode deleted = new StatusCode();
//		deleted.setVcStatusName("Deleted");
//		deleted.setBUpdateMaster(true);
//		deleted.setIStatusIDForMaster(deleted);
//
//		StatusCode rejected = new StatusCode();
//		rejected.setVcStatusName("Approved");
//		rejected.setBUpdateMaster(false);
//
//		try {
//			statusCodeService.save(approved);
//			statusCodeService.save(inserted);
//			statusCodeService.save(edited);
//			statusCodeService.save(deleted);
//			statusCodeService.save(rejected);
//		} catch (Exception e2) {
//			// TODO Auto-generated catch block
//			e2.printStackTrace();
//		}
//
//
//
//		GroupDesc alertViewer = new GroupDesc();
//		alertViewer.setVcGroupID("Alert Viewer");
//		alertViewer.setVcGroupName("Alert Viewer");
//		alertViewer.setVcGroupType("Alert Viewer");
//		alertViewer.setIStatus(approved);
//
//		GroupDesc alertAgent = new GroupDesc();
//		alertAgent.setVcGroupID("Alert Agent");
//		alertAgent.setVcGroupName("Alert Agent");
//		alertAgent.setVcGroupType("Alert Agent");
//		alertAgent.setIStatus(approved);
//
//		try {
//			groupDescService.save(alertAgent);
//			groupDescService.save(alertViewer);
//		} catch (Exception e1) {
//			// TODO Auto-generated catch block
//			e1.printStackTrace();
//		}
//
//
//		RoleDesc god = createRoleDesc("God");
//		RoleDesc ga = createRoleDesc("Group Admin");
//		RoleDesc apm = createRoleDesc("Alert Process Mgmt");
//		RoleDesc cm = createRoleDesc("Customer Mgmt");
//
//		try {
//			roleDescService.save(god);
//			roleDescService.save(ga);
//			roleDescService.save(apm);
//			roleDescService.save(cm);
//		} catch (Exception e1) {
//			// TODO Auto-generated catch block
//			e1.printStackTrace();
//		}
//
//
//		List<RoleDesc> satishPermissions=new ArrayList<>();
//		List<GroupDesc> satishGroup=new ArrayList<>();
//		satishGroup.add(alertAgent);
//		satishGroup.add(alertViewer);
//
//		try {
//			satishPermissions.add(roleDescService.findByvcRoleName("God"));
//		} catch (Exception e1) {
//			e1.printStackTrace();
//		}
//
//
//
//		WebUser satish=new WebUser();
//		satish.setIUserID(1);
//		satish.setVcUserName("satish");
//		satish.setVcPassword(passwordEncoder.encode("1234"));
//		satish.setVcFirstName("satish");
//		satish.setVcLastName("kashyap");
//		satish.setVcEmailID("satish@dronapay.com");
//		satish.setVcMobile("7219024345");
//		satish.setVcDesignation("CEO");
//		satish.setIStatus(approved);
//		satish.setUserGroup(satishGroup);
//		satish.setUserPermissions(satishPermissions);
//
//
//
//		List<RoleDesc> pallaviPermissions=new ArrayList<>();
//		try {
//			pallaviPermissions.add(cm);
//		} catch (Exception e1) {
//			// TODO Auto-generated catch block
//			e1.printStackTrace();
//		}
//
//
//		WebUserAudit pallavi = new WebUserAudit();
//		try {
//			pallavi.setTempiUserID(webUserAuditService.getIUserIdForAudit());
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		pallavi.setVcFirstName("pallavi");
//		pallavi.setVcLastName("Narvekar");
//		pallavi.setVcEmailID("pallavi@algoengines.com");
//		pallavi.setVcMobile("7219024345");
//		pallavi.setVcDesignation("CTO");
//		pallavi.setVcUserName("pallavi");
//		pallavi.setIEntryUserID(satish);
//		pallavi.setVcAction("A");
//		pallavi.setVcPassword(passwordEncoder.encode("1234"));
//		pallavi.setUserGroup(satishGroup);
//		pallavi.setUserPermissions(pallaviPermissions);
//
//
//		List<RoleDesc> zalaPermissions=new ArrayList<>();
//		try {
//			zalaPermissions.add(cm);
//		} catch (Exception e1) {
//			e1.printStackTrace();
//		}
//
//
//		WebUser zala=new WebUser();
//		zala.setIUserID(2);
//		zala.setVcFirstName("s m");
//		zala.setVcLastName("zala");
//		zala.setVcEmailID("zala@dronapay.com");
//		zala.setVcMobile("7219024345");
//		zala.setVcDesignation("CEO");
//		zala.setIStatus(approved);
//		zala.setVcUserName("zala");
//		zala.setIEntryUserID(satish);
//		zala.setVcPassword(passwordEncoder.encode("1234"));
//		zala.setUserGroup(satishGroup);
//		zala.setUserPermissions(zalaPermissions);
//
//
//
//
//		try {
//			webUserService.save(satish);
//			webUserService.save(zala);
//			webUserAuditService.save(pallavi);
//
//
//		} catch (Exception e1) {
//			// TODO Auto-generated catch block
//			e1.printStackTrace();
//		}
//
//		WebUserAudit aniket =new WebUserAudit();
//		try {
//			aniket.setTempiUserID(webUserAuditService.getIUserIdForAudit());
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		aniket.setVcFirstName("aniket");
//		aniket.setVcLastName("gaikwad");
//		aniket.setVcEmailID("aniket@algoengines.com");
//		aniket.setVcMobile("7219024345");
//		aniket.setVcDesignation("Dev");
//		aniket.setVcUserName("aniket");
//		aniket.setIEntryUserID(zala);
//		aniket.setVcAction("A");
//		aniket.setVcPassword(passwordEncoder.encode("1234"));
//		aniket.setUserGroup(satishGroup);
//		aniket.setUserPermissions(pallaviPermissions);
//		try {
//
//			webUserAuditService.save(aniket);
//
//		} catch (Exception e1) {
//			// TODO Auto-generated catch block
//			e1.printStackTrace();
//		}
//
////		MenuStructureDesc Dashboard = new MenuStructureDesc();
////		Dashboard.setVcMenuName("Dashboard");
////		Dashboard.setBCollapse(true);
////		Dashboard.setVcAction("tim-icons icon-chart-pie-36");
////		Dashboard.setVcState("dashboardCollapse");
////		Dashboard.setVcAction("dashboard");
////		Dashboard.setVcController("dashboard");
////		Dashboard.setISortOrder(0);
////		Dashboard.setIStatus(approved);
////		menuStructureDescService.save(Dashboard);
////		roleMenuAccessMapService.save(createRoleMenuAccessMap(Dashboard,god));
////
////
////		MenuStructureDesc Analytics = new MenuStructureDesc();
////		Analytics.setVcMenuName("Analytics");
////		Analytics.setBCollapse(true);
////		Analytics.setVcIcon("tim-icons icon-chart-bar-32");
////		Analytics.setVcState("analyticsCollapse");
////		Analytics.setVcAction("Analytics");
////		Analytics.setVcController("Analytics");
////		Analytics.setISortOrder(1);
////		Analytics.setIStatus(approved);
////		menuStructureDescService.save(Analytics);
////		roleMenuAccessMapService.save(createRoleMenuAccessMap(Analytics,god));
////
////		MenuStructureDesc Case = new MenuStructureDesc();
////		Case.setVcMenuName("Case");
////		Case.setBCollapse(true);
////		Case.setVcIcon("tim-icons icon-bag-16");
////		Case.setVcAction("Case");
////		Case.setISortOrder(2);
////		Case.setVcController("Case");
////		Case.setIStatus(approved);
////		Case.setVcState("caseCollapse");
////
////		menuStructureDescService.save(Case);
////		roleMenuAccessMapService.save(createRoleMenuAccessMap(Case,god));
////
//		MenuStructureDesc Testing = new MenuStructureDesc();
//		Testing.setVcMenuName("Testing");
//		Testing.setBCollapse(true);
//		Testing.setVcIcon("tim-icons icon-bulb-63");
//		Testing.setVcState("testingCollapse");
//		Testing.setVcAction("Testing");
//		Testing.setISortOrder(3);
//		Testing.setVcController("Testing");
//		Testing.setIStatus(approved);
//		menuStructureDescService.save(Testing);
//		roleMenuAccessMapService.save(createRoleMenuAccessMap(Testing,god));
//		roleMenuAccessMapService.save(createRoleMenuAccessMap(Testing, apm));
//
//		MenuStructureDesc Admin = new MenuStructureDesc();
//		Admin.setVcMenuName("Admin");
//		Admin.setBCollapse(true);
//		Admin.setVcIcon("tim-icons icon-badge");
//		Admin.setVcState("adminCollapse");
//		Admin.setVcAction("Admin");
//		Admin.setISortOrder(4);
//		Admin.setVcController("Admin");
//		Admin.setIStatus(approved);
//		menuStructureDescService.save(Admin);
//		roleMenuAccessMapService.save(createRoleMenuAccessMap(Admin,god));
//		roleMenuAccessMapService.save(createRoleMenuAccessMap(Admin,cm));
////
////		MenuStructureDesc Masters = new MenuStructureDesc();
////		Masters.setVcMenuName("Masters");
////		Masters.setBCollapse(false);
////		Masters.setVcIcon("tim-icons icon-atom");
////		Masters.setVcState("mastersCollapse");
////		Masters.setVcAction("Masters");
////		Masters.setISortOrder(5);
////		Masters.setVcController("Masters");
////		Masters.setIStatus(approved);
////		menuStructureDescService.save(Masters);
////		roleMenuAccessMapService.save(createRoleMenuAccessMap(Masters,god));
////
////		MenuStructureDesc LiveRiskScoring = new MenuStructureDesc();
////		LiveRiskScoring.setVcMenuName("Live Risk Scoring");
////		LiveRiskScoring.setIParentMenu(Dashboard);
////		LiveRiskScoring.setBCollapse(true);
////		//LiveRiskScoring.setVcIcon("tim-icons icon-laptop");
////		LiveRiskScoring.setVcMini("LRS");
////		LiveRiskScoring.setVcState("liveRiskScoringCollapse");
////		LiveRiskScoring.setVcAction("LiveRiskScoring");
////		LiveRiskScoring.setISortOrder(0);
////		LiveRiskScoring.setVcController("LiveRiskScoring");
////		LiveRiskScoring.setIStatus(approved);
////		menuStructureDescService.save(LiveRiskScoring);
////		roleMenuAccessMapService.save(createRoleMenuAccessMap(LiveRiskScoring, god));
////
////		MenuStructureDesc TopTransactions  = new MenuStructureDesc();
////		TopTransactions.setVcMenuName("TopTransactions ");
////		TopTransactions.setIParentMenu(LiveRiskScoring);
////		TopTransactions.setVcMini("TT");
////		TopTransactions.setVcAction("TopTransactions");
////		TopTransactions.setISortOrder(0);
////		TopTransactions.setVcController("TopTransactions");
////		TopTransactions.setIStatus(approved);
////		menuStructureDescService.save(TopTransactions);
////		roleMenuAccessMapService.save(createRoleMenuAccessMap(TopTransactions, god));
////
////		MenuStructureDesc LastAlerts   = new MenuStructureDesc();
////		LastAlerts.setVcMenuName("LastAlerts");
////		LastAlerts.setIParentMenu(LiveRiskScoring);
////		LastAlerts.setVcMini("LA");
////		LastAlerts.setVcAction("LastAlerts");
////		LastAlerts.setISortOrder(1);
////		LastAlerts.setVcController("LastAlerts");
////		LastAlerts.setIStatus(approved);
////		menuStructureDescService.save(LastAlerts);
////		roleMenuAccessMapService.save(createRoleMenuAccessMap(LastAlerts, god));
////
////		MenuStructureDesc Transaction = new MenuStructureDesc();
////		Transaction.setVcMenuName("Transaction");
////		Transaction.setIParentMenu(Analytics);
////		Transaction.setVcAction("Transaction");
////		Transaction.setISortOrder(0);
////		Transaction.setIStatus(approved);
////		Transaction.setVcController("Transaction");
////		menuStructureDescService.save(Transaction);
////		roleMenuAccessMapService.save(createRoleMenuAccessMap(Transaction,god));
////
////		MenuStructureDesc AllTasks = new MenuStructureDesc();
////		AllTasks.setVcMenuName("All Tasks");
////		AllTasks.setIParentMenu(Case);
////		AllTasks.setVcAction("AllTasks");
////		AllTasks.setISortOrder(0);
////		AllTasks.setVcController("AllTasks");
////		AllTasks.setIStatus(approved);
////		menuStructureDescService.save(AllTasks);
////		roleMenuAccessMapService.save(createRoleMenuAccessMap(AllTasks, god));
////
//		MenuStructureDesc PayRequest = new MenuStructureDesc();
//		PayRequest.setVcMenuName("Pay Request");
//		PayRequest.setIParentMenu(Testing);
//		PayRequest.setVcIcon("tim-icons icon-coins");
//		PayRequest.setVcMini("PR");
//		PayRequest.setVcLayout("/user");
//		PayRequest.setVcPath("/payment-request");
//		PayRequest.setVcAction("PayRequest");
//		PayRequest.setVcController("PayRequest");
//		PayRequest.setISortOrder(0);
//		PayRequest.setIStatus(approved);
//		menuStructureDescService.save(PayRequest);
//		roleMenuAccessMapService.save(createRoleMenuAccessMap(PayRequest,apm));
//		roleMenuAccessMapService.save(createRoleMenuAccessMap(PayRequest,god));
//
//		MenuStructureDesc AppUsers = new MenuStructureDesc();
//		AppUsers.setVcMenuName("App Users");
//		AppUsers.setIParentMenu(Admin);
//		AppUsers.setVcIcon("tim-icons icon-coins");
//		AppUsers.setVcMini("AU");
//		AppUsers.setVcLayout("/user");
//		AppUsers.setVcPath("/app-users");
//		AppUsers.setVcAction("AppUsers");
//		AppUsers.setISortOrder(0);
//		AppUsers.setVcController("AppUsers");
//		AppUsers.setIStatus(approved);
//		menuStructureDescService.save(AppUsers);
//		roleMenuAccessMapService.save(createRoleMenuAccessMap(AppUsers,god));
//
//		RoleMenuAccessMap rmamAppUsers = createRoleMenuAccessMap(AppUsers,cm);
//		rmamAppUsers.setBAdd(true);
//		rmamAppUsers.setBDelete(false);
//		rmamAppUsers.setBApprove(false);
//		rmamAppUsers.setBEdit(false);
//		roleMenuAccessMapService.save(rmamAppUsers);
//
//		MenuStructureDesc RuleManagement = new MenuStructureDesc();
//		RuleManagement.setVcMenuName("Rule Management");
//		RuleManagement.setIParentMenu(Testing);
//		RuleManagement.setVcIcon("tim-icons icon-align-center");
//		RuleManagement.setVcMini("RM");
//		RuleManagement.setVcLayout("/user");
//		RuleManagement.setVcPath("/rule-management");
//		RuleManagement.setVcAction("RuleManagement");
//		RuleManagement.setISortOrder(0);
//		RuleManagement.setVcController("AppUsers");
//		RuleManagement.setIStatus(approved);
//		menuStructureDescService.save(RuleManagement);
//		roleMenuAccessMapService.save(createRoleMenuAccessMap(RuleManagement,god));
//
//		RoleMenuAccessMap rmamRuleManagement = createRoleMenuAccessMap(RuleManagement,cm);
//		rmamRuleManagement.setBAdd(true);
//		rmamRuleManagement.setBDelete(false);
//		rmamRuleManagement.setBApprove(false);
//		rmamRuleManagement.setBEdit(false);
//		roleMenuAccessMapService.save(rmamRuleManagement);
//
//		MenuStructureDesc ListManagement = new MenuStructureDesc();
//		ListManagement.setVcMenuName("List Management");
//		ListManagement.setIParentMenu(Testing);
//		ListManagement.setVcIcon("tim-icons icon-bullet-list-67");
//		ListManagement.setVcMini("LM");
//		ListManagement.setVcLayout("/user");
//		ListManagement.setVcPath("/list-management");
//		ListManagement.setVcAction("ListManagementController");
//		ListManagement.setISortOrder(0);
//		ListManagement.setVcController("ListManagementController");
//		ListManagement.setIStatus(approved);
//		menuStructureDescService.save(ListManagement);
//		roleMenuAccessMapService.save(createRoleMenuAccessMap(ListManagement,god));
//
//		RoleMenuAccessMap rmamListManagement = createRoleMenuAccessMap(RuleManagement,cm);
//		rmamListManagement.setBAdd(true);
//		rmamListManagement.setBDelete(false);
//		rmamListManagement.setBApprove(false);
//		rmamListManagement.setBEdit(false);
//		roleMenuAccessMapService.save(rmamListManagement);
//
//
//		List<MenuStructureDesc> lMenu = menuStructureDescService.findAll();
//		List<MenuStructureResponse> rMenu = new ArrayList<MenuStructureResponse>();
//
//
//
//		for(MenuStructureDesc m : lMenu)
//		{
//			if(m.getIParentMenu() == null)
//			{
//
//				try {
//					rMenu.add(createMenu(m, lMenu));
//				}catch (Exception e) {
//					System.out.println("this is main "+e.toString());
//				}
//
//			}
//		}
//	}


//	private RoleDesc createRoleDesc(String roleName) {
//		RoleDesc roleDesc = new RoleDesc();
//		roleDesc.setVcRoleName(roleName);
//		roleDesc.setIStatus(statusCodeService.findByIStatusId(1));
//		roleDesc.setDtEntryStamp(new Date());
//
//		return roleDesc;
//	}
//
//	private MenuStructureResponse createMenu(MenuStructureDesc menu, List<MenuStructureDesc> lMenu)
//	{
//		MenuStructureResponse res = MenuStructureResponse.builder()
//				.name(menu.getVcMenuName())
//				.collapse(menu.isBCollapse())
//				.rtlName(menu.getVcRtlName())
//				.icon(menu.getVcIcon())
//				.state(menu.getVcState())
//				.build();
////		res.setName(menu.getVcMenuName());
////		res.setCollapse(menu.isBCollapse());
////		res.setRtlName(menu.getVcRtlName());
////		res.setIcon(menu.getVcIcon());
////		res.setState(menu.getVcState());
//		if(menu.isBCollapse()==true)
//		{
//
//
//			try {
//			res.setViews(createSubMenu(lMenu, menu.getIMenuID()));
//
//			}catch (Exception e) {
//				System.out.println("create menu exception "+e.toString());
//			}
//		}
//		return res;
//	}


//	private List<MenuStructureResponse> createSubMenu(List<MenuStructureDesc> lMenu, int ParentMenu)
//	{
//		List<MenuStructureResponse> subMenu = new ArrayList<>();
//		for(MenuStructureDesc m : lMenu)
//		{
//
//
//			if(m.getIParentMenu()!=null)
//			{
//				if(m.getIParentMenu().getIMenuID()== ParentMenu)
//				{
//					subMenu.add(createMenu(m, lMenu));
//				}
//			}
//		}
//		return subMenu;
//	}


//	private RoleMenuAccessMap createRoleMenuAccessMap(MenuStructureDesc menu, RoleDesc role)
//	{
//		RoleMenuAccessMap RMAM = new RoleMenuAccessMap();
//		RMAM.setIRoleID(role);
//		RMAM.setIMenuID(menu);
//		RMAM.setBview(true);
//		RMAM.setBAdd(true);
//		RMAM.setBEdit(true);
//		RMAM.setBDelete(true);
//		RMAM.setBApprove(true);
//		RMAM.setBPublish(true);
//		RMAM.setIStatus(true);
//		return RMAM;
//
//	}

}
