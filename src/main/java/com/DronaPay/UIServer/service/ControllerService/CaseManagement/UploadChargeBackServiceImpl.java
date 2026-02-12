package com.DronaPay.UIServer.service.ControllerService.CaseManagement;

import com.DronaPay.UIServer.Cache.LoggedUser;
import com.DronaPay.UIServer.Constants.MenuNames;
import com.DronaPay.UIServer.Constants.ResponseMessages;
import com.DronaPay.UIServer.model.ChargeBackTransactions;
import com.DronaPay.UIServer.model.UploadChargeBack;
import com.DronaPay.UIServer.model.WebUser;
import com.DronaPay.UIServer.repository.ChargeBackTransactionsRepository;
import com.DronaPay.UIServer.repository.UploadChargeBackRepository;
import com.DronaPay.UIServer.requests.UploadChargeBackRequest;
import com.DronaPay.UIServer.response.ApiResponse;
import com.DronaPay.UIServer.response.MenuPermissions;
import com.DronaPay.UIServer.service.ControllerService.ListManagement.ListManagementServiceImpl;
import com.DronaPay.UIServer.service.RepositoryService.ActivityLogService;
import com.DronaPay.UIServer.service.RepositoryService.WebUserService;
import com.DronaPay.UIServer.util.CamundaBasicAuthUtil;
import com.DronaPay.UIServer.util.FilePathChecker;
import com.DronaPay.UIServer.util.LoggerEncoderUtil;
import com.DronaPay.UIServer.util.RestTemplateUtil;
import com.google.common.collect.Iterators;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.ws.rs.core.HttpHeaders;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.client.ClientResponse;
import org.springframework.web.reactive.function.client.WebClient;
import org.springframework.http.*;

import java.io.File;
import java.io.FileWriter;
import java.io.PrintWriter;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.ZonedDateTime;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
public class UploadChargeBackServiceImpl implements UploadChargeBackService {

    private static final Logger LOGGER = LoggerFactory.getLogger(UploadChargeBackServiceImpl.class);
    final String menu_name = MenuNames.UploadChargeback;
    @Value("${chargeback.ui.upload.recordcount}")
    private Integer maxRow;

    @Autowired
    private ActivityLogService activityLogService;
    @Autowired
    private WebUserService webUserService;
    @Autowired
    private UploadChargeBackRepository uploadChargeBackRepository;
    @Autowired
    private ChargeBackTransactionsRepository chargebackTransactionRepository;
    @Autowired
    private LoggerEncoderUtil loggerEncoderUtil;
    @Autowired
    private FilePathChecker filePathChecker;

    @Value("${springapi.server.url}")
    private String spring_api_url;

    @Value("${file.upload-dir}")
    private String file_upload_directory;

    @Value("${springapi.server.key.name}")
    private String spring_server_key_name;


    @Value("${uploadchargeback.file.formats}")
    private String upload_chargeback_file_formats;


    @Value("${template.download.path}")
    private String template_download_path;


    @Autowired
    private CamundaBasicAuthUtil camundaBasicAuthUtil;


    public ResponseEntity<?> getAllUploadChargeBacks(Authentication pr) throws Exception {
        LOGGER.debug("entered in class " + ListManagementServiceImpl.class + " in method getAllUploadChargeBacks");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {

            List<UploadChargeBack> row = new ArrayList<UploadChargeBack>();
            try {

                row = uploadChargeBackRepository.findAll();
                row.sort((c1, c2) -> c1.getUploadChargeBackId() - c2.getUploadChargeBackId());
                Collections.reverse(row);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to access upload charge back files list",
                        "Error : " + e.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
            activityLogService.addActivity(loggedInUser, "upload chargeback file list accessed successfully");
            LOGGER.debug("Exiting getAllUploadChargeBacks Method in " + ListManagementServiceImpl.class
                    + " class with response  : upload chargeback file list");
            return ResponseEntity.ok(row);
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to access upload chargeback file list");
            LOGGER.debug("Exiting getAllUploadChargeBacks Method in " + ListManagementServiceImpl.class
                    + " class with response  : unauthorized to access list of lists");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to access list of lists"),
                    HttpStatus.FORBIDDEN);
        }
    }

    public ResponseEntity<?> uploadChargeBack(MultipartFile file, Authentication pr) throws Exception {

        String upload_DIR = file_upload_directory;

        LOGGER.debug("entered in class " + ListManagementServiceImpl.class + " in method uploadChargeBack");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {

            if (file.getOriginalFilename().startsWith(".")) {
                activityLogService.addActivity(loggedInUser, "failed to upload document");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Invalid file ,file name cannot start with '.'"),
                        HttpStatus.UNSUPPORTED_MEDIA_TYPE);
            }

            // file extension check
            if (upload_chargeback_file_formats.contains(file.getContentType())) {

                // file size check
                if (file.getSize() == 0 || file.getSize() > 5242880) {
                    activityLogService.addActivity(loggedInUser,
                            "failed to upload chargeback file because File size is zero ");
                    LOGGER.debug("Exiting uploadChargeBack Method in " + ListManagementServiceImpl.class
                            + " class with response  : File size is zero");
                    return new ResponseEntity<ApiResponse>(new ApiResponse(false, "File size is zero"),
                            HttpStatus.BAD_REQUEST);
                }

                List<List<Object>> rows = new ArrayList<>();
                List<String> keys = new ArrayList<>();
                List<Map<Object, Object>> data = new ArrayList<>();
                List<UploadChargeBackRequest> objData = new ArrayList<>();

                try {

                    if (file.getOriginalFilename().endsWith(".XLSX") || file.getOriginalFilename().endsWith(".xlsx")) {

                        XSSFWorkbook wb = new XSSFWorkbook(file.getInputStream());
                        XSSFSheet sheet = wb.getSheetAt(0);
                        Iterator<Row> itr = sheet.iterator();

                        Integer size = Iterators.size(itr);

                        if (maxRow < size) {
                            LOGGER.info(loggerEncoderUtil
                                    .encode("failed to upload chargeback number of rows exceeded " + maxRow));
                            activityLogService.addActivity(loggedInUser,
                                    "failed to upload chargeback number of rows exceeded " + maxRow);
                            return new ResponseEntity<ApiResponse>(
                                    new ApiResponse(false,
                                            "failed to upload chargeback number of rows exceeded " + maxRow),
                                    HttpStatus.BAD_REQUEST);
                        }

                        int rowNumber = 0;
                        while (itr.hasNext()) {
                            Row row = itr.next();
                            if (rowNumber == 0) {

                                Iterator<Cell> cellIterator = row.cellIterator();
                                while (cellIterator.hasNext()) {
                                    Cell cell = cellIterator.next();
                                    switch (cell.getCellType()) {
                                        case NUMERIC:

                                            break;
                                        case STRING:
                                            // Check Column name is empty
                                            if (cell.getStringCellValue() == null || cell.getStringCellValue() == "") {
                                                activityLogService.addActivity(loggedInUser,
                                                        " failed to upload chargeback file because Column name is empty");
                                                LOGGER.debug("Exiting uploadChargeBack Method in "
                                                        + ListManagementServiceImpl.class
                                                        + " class with response  : Column name is empty");

                                                return new ResponseEntity<ApiResponse>(
                                                        new ApiResponse(false, "Column name is empty"),
                                                        HttpStatus.BAD_REQUEST);
                                            }
                                            keys.add(cell.getStringCellValue());

                                            break;
                                        case BLANK:
                                            activityLogService.addActivity(loggedInUser,
                                                    "failed to upload chargeback file because  Column name is empty");
                                            LOGGER.debug("Exiting uploadChargeBack Method in "
                                                    + ListManagementServiceImpl.class
                                                    + " class with response  : Column name is empty");
                                            return new ResponseEntity<ApiResponse>(
                                                    new ApiResponse(false, "Column name is empty"),
                                                    HttpStatus.BAD_REQUEST);
                                        default:

                                    }
                                }

                                rowNumber++;
                            } else {
                                Iterator<Cell> cellIterator = row.cellIterator();
                                List<Object> rowslist = new ArrayList<>();
                                while (cellIterator.hasNext()) {
                                    Cell cell = cellIterator.next();
                                    switch (cell.getCellType()) {
                                        case NUMERIC:
                                            rowslist.add(cell.toString());

                                            break;
                                        case STRING:
                                            rowslist.add(cell.getStringCellValue());

                                            break;
                                        case FORMULA:
                                            rowslist.add(cell.getDateCellValue());

                                            break;
                                        case BLANK:
                                            rowslist.add("");
                                        default:

                                    }
                                }

                                rows.add(rowslist);
                            }
                        }
                    } else {
                        HSSFWorkbook wb = new HSSFWorkbook(file.getInputStream());
                        HSSFSheet sheet = wb.getSheetAt(0);
                        Iterator<Row> itr = sheet.iterator();
                        int rowNumber = 0;
                        while (itr.hasNext()) {
                            Row row = itr.next();
                            if (rowNumber == 0) {

                                Iterator<Cell> cellIterator = row.cellIterator();
                                while (cellIterator.hasNext()) {
                                    Cell cell = cellIterator.next();
                                    switch (cell.getCellType()) {
                                        case NUMERIC:

                                            break;
                                        case STRING:
                                            // Check Column name is empty
                                            if (cell.getStringCellValue() == null || cell.getStringCellValue() == "") {
                                                activityLogService.addActivity(loggedInUser,
                                                        "failed to upload chargeback file because  Column name is empty");
                                                LOGGER.debug("Exiting uploadChargeBack Method in "
                                                        + ListManagementServiceImpl.class
                                                        + " class with response  : Column name is empty");

                                                return new ResponseEntity<ApiResponse>(
                                                        new ApiResponse(false,
                                                                "failed to upload chargeback file because Column name is empty"),
                                                        HttpStatus.BAD_REQUEST);
                                            }
                                            keys.add(cell.getStringCellValue());

                                            break;
                                        case BLANK:
                                            activityLogService.addActivity(loggedInUser,
                                                    "failed to upload chargeback file because Column name is empty");
                                            LOGGER.debug("Exiting uploadChargeBack Method in "
                                                    + ListManagementServiceImpl.class
                                                    + " class with response  : Column name is empty");

                                            return new ResponseEntity<ApiResponse>(
                                                    new ApiResponse(false, "Column name is empty"),
                                                    HttpStatus.BAD_REQUEST);
                                        default:

                                    }
                                }

                                rowNumber++;
                            } else {
                                Iterator<Cell> cellIterator = row.cellIterator();
                                List<Object> rowslist = new ArrayList<>();
                                while (cellIterator.hasNext()) {
                                    Cell cell = cellIterator.next();
                                    switch (cell.getCellType()) {
                                        case NUMERIC:
                                            rowslist.add(cell.toString());

                                            break;
                                        case STRING:
                                            rowslist.add(cell.getStringCellValue());

                                            break;
                                        case FORMULA:
                                            rowslist.add(cell.getDateCellValue());

                                            break;
                                        case BLANK:
                                            rowslist.add("");
                                        default:

                                    }
                                }

                                rows.add(rowslist);
                            }
                        }
                    }

                } catch (Exception e) {
                    LOGGER.error("Error " + e);
                }

                // Check missing column
                for (int i = 0; i < keys.size(); i++) {
                    int row = i + 1;
                    if (keys.get(i) == "" || keys.get(i) == null) {
                        activityLogService.addActivity(loggedInUser, "failed to upload chargeback file because Column "
                                + row + " is not present in the file");
                        LOGGER.debug(loggerEncoderUtil
                                .encode("Exiting uploadChargeBack Method in " + ListManagementServiceImpl.class
                                        + " class with response : Column " + row + " is not presen in the file"));
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false, " Column " + row + " is not presen in the file"),
                                HttpStatus.BAD_REQUEST);
                    }
                }

                // Check all columns are present
                if (keys.size() != 14) {
                    activityLogService.addActivity(loggedInUser,
                            "failed to upload chargeback file because All Columns are not present");
                    LOGGER.debug("Exiting uploadChargeBack Method in " + ListManagementServiceImpl.class
                            + " class with response : All Columns are not present");
                    return new ResponseEntity<ApiResponse>(new ApiResponse(false, "All Columns are not present"),
                            HttpStatus.BAD_REQUEST);
                }

                int dataLength = 0;
                for (int i = 0; i < rows.size(); i++) {
                    dataLength = dataLength + rows.get(i).size();
                }
                if (dataLength == 0) {

                    activityLogService.addActivity(loggedInUser,
                            "failed to upload chargeback file because Data is not present");
                    LOGGER.debug("Exiting uploadChargeBack Method in " + ListManagementServiceImpl.class
                            + " class with response : All Columns are not present");
                    return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Data is not present"),
                            HttpStatus.BAD_REQUEST);
                }

                int empty = 0;

                for (int i = 0; i < rows.size(); i++) {
                    for (int j = 0; j < rows.get(i).size(); j++) {
                        empty = empty + rows.get(i).get(j).toString().length();
                    }
                }

                if (empty == 0) {
                    activityLogService.addActivity(loggedInUser,
                            "failed to upload chargeback file because No records in file");
                    LOGGER.debug("Exiting uploadChargeBack Method in " + ListManagementServiceImpl.class
                            + " class with response : No records in file");
                    return new ResponseEntity<ApiResponse>(new ApiResponse(false, "No records in file"),
                            HttpStatus.BAD_REQUEST);
                }

                for (int i = 0; i < rows.size(); i++) {
                    Map<Object, Object> headers = new HashMap<>();
                    for (int j = 0; j < keys.size(); j++) {
                        headers.put(keys.get(j), rows.get(i).get(j));
                    }
                    data.add(headers);
                }

                DateFormat dateFormat = new SimpleDateFormat("dd-MMM-yy");
                DateFormat dateFormat2 = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm'Z'");

                for (int i = 0; i < rows.size(); i++) {

                    UploadChargeBackRequest obj = new UploadChargeBackRequest();
                    obj.setDate(rows.get(i).get(0).toString());
                    obj.setDueDate(rows.get(i).get(1).toString());
                    obj.setAdjType(rows.get(i).get(2).toString());
                    obj.setReasonCode(rows.get(i).get(3).toString());
                    obj.setDescription(rows.get(i).get(4).toString());
                    obj.setAggregatorCode(rows.get(i).get(5).toString());
                    obj.setMerchantId(rows.get(i).get(6).toString());
                    obj.setREFID(rows.get(i).get(7).toString());
                    obj.setTransactionDate(rows.get(i).get(8).toString());
                    obj.setPayerName(rows.get(i).get(9).toString());
                    obj.setAmount(rows.get(i).get(10).toString());
                    obj.setDebitNbin(rows.get(i).get(11).toString());
                    obj.setTransactionId(rows.get(i).get(12).toString());
                    obj.setNvlTsdkOrderId(rows.get(i).get(13).toString());
                    obj.setPassed("Pass");
                    obj.setErrorMsg(new ArrayList<>());
                    objData.add(obj);

                }

                // System.out.println(objData);
                String fieldName = file.getOriginalFilename();
                // System.out.println(fieldName.split(".XLSX")[0]);

                File logError = new File(upload_DIR + "\\" + fieldName.split(".XLSX")[0] + "ErrorLog.txt")
                        .getCanonicalFile();
                FileWriter fw = new FileWriter(logError);
                PrintWriter pw = new PrintWriter(fw);
                pw.println("Chargeback File Upload Processing Error Log:");
                pw.println("");
                pw.println("Process Start time : <" + new Date() + ">");
                pw.println(
                        "********************************************* File Summary *********************************************");
                pw.println("FIle Name : <" + file.getOriginalFilename() + ">");
                pw.println("File Size : <" + file.getSize() + "Bytes>");
                pw.println("");

                if (objData.isEmpty() || objData == null) {
                    activityLogService.addActivity(loggedInUser, " failed to upload chargeback No data found in file");
                    LOGGER.debug("Exiting uploadChargeBack Method in " + ListManagementServiceImpl.class
                            + " class with response  : No data found in file");
                    return new ResponseEntity<ApiResponse>(new ApiResponse(false, "No data found in file"),
                            HttpStatus.BAD_REQUEST);
                }

                for (int i = 0; i < objData.size(); i++) {
                    ChargeBackTransactions transactions = new ChargeBackTransactions();
                    transactions.setChargebackid(objData.get(i).getREFID());
                    transactions.setTransactionid(objData.get(i).getTransactionId());
                    transactions.setAdjType(objData.get(i).getAdjType());
                    try {

                        chargebackTransactionRepository.save(transactions);
                    } catch (Exception e) {
                        objData.get(i).setPassed("Fail");
                        if (!objData.get(i).getREFID().isEmpty() && !objData.get(i).getREFID().isBlank()) {
                            objData.get(i).getErrorMsg()
                                    .add("Task for chargeback id " + objData.get(i).getREFID() + " is already created");
                        }

                    }
                }

                HttpClient client = HttpClient.newHttpClient();

                for (int i = 0; i < objData.size(); i++) {

                    HttpRequest request = HttpRequest.newBuilder()
                            .uri(URI.create(spring_api_url + "/txnRequest/"
                                    + objData.get(i).getTransactionId()))
                            .header(spring_server_key_name, "")
                            .header("Content-Type", "application/json")
                            .GET()
                            .build();
                    HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
                    // System.out.println(response.body());

                    if (response.statusCode() != 200) {
                        objData.get(i).setPassed("Fail");
                        objData.get(i).getErrorMsg()
                                .add("< " + objData.get(i).getTransactionId() + " > is not a valid transaction");
                    }

                }

                for (int i = 0; i < objData.size(); i++) {
                    int row = i + 1;
                    String regexName = "^[a-zA-Z ]*$";
                    Pattern pattern = Pattern.compile(regexName);

                    // payer Name
                    if (objData.get(i).getPayerName() == null || objData.get(i).getPayerName() == "") {

                        objData.get(i).setPassed("Fail");
                        objData.get(i).getErrorMsg().add("< Payer Name > is empty in row " + row);

                    }

                    if (objData.get(i).getAggregatorCode() == null || objData.get(i).getAggregatorCode() == "") {
                        objData.get(i).setPassed("Fail");
                        objData.get(i).getErrorMsg().add("< Aggregator > code is empty in row " + row);
                    }

                    // "[0-9]{1,13}(\\.[0-9]*)?"
                    String regexAmount = "[0-9]*\\.?[0-9]*";
                    Pattern patternAmount = Pattern.compile(regexAmount);

                    // Amount
                    if (objData.get(i).getAmount() == null || objData.get(i).getAmount() == "") {
                        objData.get(i).setPassed("Fail");

                        objData.get(i).getErrorMsg().add("< Amount > is empty in row " + row);

                    }
                    Matcher matcherAmount = patternAmount.matcher(objData.get(i).getAmount());
                    if (!matcherAmount.matches()) {
                        objData.get(i).setPassed("Fail");
                        if (objData.get(i).getAmount() != null && !objData.get(i).getAmount().equals("")) {

                            objData.get(i).getErrorMsg().add("< Amount > is not valid in row " + row);
                        }

                    }

                    String regexOnlyID = "^[a-zA-Z0-9]*$";
                    Pattern patternId = Pattern.compile(regexOnlyID);

                    if (objData.get(i).getAdjType() == null || objData.get(i).getAdjType() == "") {
                        objData.get(i).setPassed("Fail");
                        objData.get(i).getErrorMsg().add("< AdjType > is empty in row " + row);
                    }

                    if (objData.get(i).getReasonCode() == null || objData.get(i).getReasonCode() == "") {
                        objData.get(i).setPassed("Fail");
                        objData.get(i).getErrorMsg().add(" < Reason code > is empty in row " + row);
                    }

                    // Merchant ID
                    if (objData.get(i).getMerchantId() == null || objData.get(i).getMerchantId() == "") {
                        objData.get(i).setPassed("Fail");

                        objData.get(i).getErrorMsg().add("< Merchant ID > is empty in row " + row);

                    }

                    // Transaction ID
                    if (objData.get(i).getTransactionId() == null || objData.get(i).getTransactionId() == "") {
                        objData.get(i).setPassed("Fail");

                        objData.get(i).getErrorMsg().add("< Transaction ID > is empty in row " + row);

                    }

                    // Debit Nbin
                    if (objData.get(i).getDebitNbin() == null || objData.get(i).getDebitNbin() == "") {
                        objData.get(i).setPassed("Fail");

                        objData.get(i).getErrorMsg().add("< Debit ID > is empty in row " + row);

                    }

                    // NvlTSDKOrderID
                    if (objData.get(i).getNvlTsdkOrderId() == null || objData.get(i).getNvlTsdkOrderId() == "") {
                        objData.get(i).setPassed("Fail");

                        objData.get(i).getErrorMsg().add("< Transaction ID > is empty in row " + row);

                    }

                    if (objData.get(i).getREFID() == null || objData.get(i).getREFID() == "") {
                        objData.get(i).setPassed("Fail");
                        objData.get(i).getErrorMsg().add(" < Ref ID > is empty in row " + row);

                    }

                    Matcher refID = patternId.matcher(objData.get(i).getMerchantId());

                    if (!refID.matches()) {
                        objData.get(i).setPassed("Fail");
                        if (objData.get(i).getREFID() != null && !objData.get(i).getREFID().equals("")) {

                            objData.get(i).getErrorMsg().add(" < Ref ID > is not valid in row " + row);
                        }
                    }

                    Matcher matcherMerchnatID = patternId.matcher(objData.get(i).getMerchantId());
                    if (!matcherMerchnatID.matches()) {
                        objData.get(i).setPassed("Fail");
                        if (objData.get(i).getMerchantId() != null && !objData.get(i).getMerchantId().equals("")) {

                            objData.get(i).getErrorMsg().add(" < Merchant ID > is not valid in row " + row);
                        }

                    }

                    Matcher matcherDebitID = patternId.matcher(objData.get(i).getDebitNbin());
                    if (!matcherDebitID.matches()) {
                        objData.get(i).setPassed("Fail");
                        if (objData.get(i).getDebitNbin() != null && !objData.get(i).getDebitNbin().equals("")) {

                            objData.get(i).getErrorMsg().add("< Debit ID > is not valid in row " + row);
                        }

                    }

                    Matcher matcherNVl = patternId.matcher(objData.get(i).getNvlTsdkOrderId());
                    if (!matcherNVl.matches()) {
                        objData.get(i).setPassed("Fail");
                        if (objData.get(i).getNvlTsdkOrderId() != null
                                && !objData.get(i).getNvlTsdkOrderId().equals("")) {

                            objData.get(i).getErrorMsg().add(" < Order ID > is not valid in row " + row);
                        }

                    }

                    if (objData.get(i).getDate() == null || objData.get(i).getDate() == "") {
                        objData.get(i).setPassed("Fail");

                        objData.get(i).getErrorMsg().add(" < Date > is empty in row " + row);

                    }

                    if (objData.get(i).getDueDate() == null || objData.get(i).getDueDate() == "") {
                        objData.get(i).setPassed("Fail");

                        objData.get(i).getErrorMsg().add(" < Due Date > is empty in row " + row);

                    }

                    if (objData.get(i).getTransactionDate() == null || objData.get(i).getTransactionDate() == "") {
                        objData.get(i).setPassed("Fail");

                        objData.get(i).getErrorMsg().add("< Transaction Date > is empty in row " + row);

                    }

                    if (objData.get(i).getDate().matches("\\d{2}-\\d{3}-\\d{4}")) {
                        objData.get(i).setPassed("Fail");

                        objData.get(i).getErrorMsg().add("< Date > is not valid in row " + row);

                    }

                    if (objData.get(i).getDueDate().matches("\\d{2}-\\d{3}-\\d{4}")) {
                        objData.get(i).setPassed("Fail");

                        objData.get(i).getErrorMsg().add("< Due Date > is not valid in row " + row);

                    }

                    if (objData.get(i).getTransactionDate().matches("\\d{2}-\\d{3}-\\d{4}")) {
                        objData.get(i).setPassed("Fail");
                        // pw.print("Transaction Date is invalid in row " + row + " ");
                        objData.get(i).getErrorMsg().add(" < Transaction Date > is not valid in row " + row);

                    }

                }

                // pw.close();

                UploadChargeBack upFile = new UploadChargeBack();
                upFile.setFieldName(fieldName);
                upFile.setUploadTimeStamp(ZonedDateTime.now());
                upFile.setTotalRecords(rows.size());
                upFile.setUploadFile(upload_DIR + File.separator + file.getOriginalFilename());
                upFile.setErrorLog(upload_DIR + "\\" + fieldName.split(".XLSX")[0] + "ErrorLog.txt");

                boolean f = false;
                int passed = 0;
                int failed = 0;

                for (int i = 0; i < objData.size(); i++) {
                    ResponseEntity<String> clientResponse = null;
                    String strDate = "";
                    String dDate = "";
                    String tDate = "";
                    if (objData.get(i).getPassed() == "Pass") {
                        Date startDate = dateFormat.parse(objData.get(i).getDate());
                        Date dueDate = dateFormat.parse(objData.get(i).getDueDate());
                        Date transDate = dateFormat.parse(objData.get(i).getTransactionDate());
                        strDate = dateFormat2.format(startDate);
                        dDate = dateFormat2.format(dueDate);
                        tDate = dateFormat2.format(transDate);
                    }

                    String body = "{\n" +
                            "\"variables\":{\n" +
                            "\"TransactionId\":{\n" +
                            "\"value\":\"" + objData.get(i).getTransactionId() + "\",\n"
                            +
                            "\"type\":\"string\"\n" +
                            "},\n" +
                            "\"CBType\":{\"value\":\"" + objData.get(i).getAdjType() + "\",\"type\":\"string\"},\n" +
                            "\"refId\":{\"value\":\"" + objData.get(i).getREFID() + "\",\"type\":\"string\"},\n" +
                            "\"CBCode\":{\"value\":\"" + objData.get(i).getReasonCode() + "\",\"type\":\"string\"},\n" +
                            "\"CBReason\":{\"value\":\"" + objData.get(i).getDescription()
                            + "\",\"type\":\"string\"}},\n" +
                            "\"businessKey\":\"" + new Date().toInstant() + "\"}";

                    if (objData.get(i).getPassed() == "Pass") {
                        passed++;

                        try {

//                            clientResponse = WebClient.create(spring_api_url)
//                                    .post()
//                                    .uri("/engine-rest/process-definition/key/ChargeBack/start")
//                                    .header("Authorization", camundaBasicAuthUtil.getBasicAuth(loggedInUser))
//                                    .contentType(MediaType.APPLICATION_JSON)
//                                    .accept(MediaType.APPLICATION_JSON)
//                                    .body(BodyInserters.fromValue(body))
//                                    .exchange()
//                                    .block();
                            RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
                            org.springframework.http.HttpHeaders headers = new org.springframework.http.HttpHeaders();
                            headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(loggedInUser));
                            headers.setContentType(MediaType.APPLICATION_JSON);
                            headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));

                            HttpEntity<String> entity = new HttpEntity<>(body, headers);

                            clientResponse = restTemplate.exchange(
                                    spring_api_url + "/engine-rest/process-definition/key/ChargeBack/start",
                                    HttpMethod.POST,
                                    entity,
                                    String.class
                            );
//                            System.out.println(clientResponse.bodyToMono(String.class).block());
                            System.out.println(clientResponse.getBody());
//                            clientResponse.releaseBody();
                            if (clientResponse.getStatusCode() != HttpStatus.OK) {
                                upFile.setStatus("Fail");
                                objData.get(i).getErrorMsg().add("Ticket Creation Failed for < "
                                        + objData.get(i).getTransactionId() + " >");
                                objData.get(i).setPassed("Fail");
                                passed--;
                                failed++;
                            }

                        } catch (Exception e) {
                            upFile.setStatus("Fail");
                            LOGGER.error("Error : " + e + "\nParam : " + body);
                            activityLogService.addActivity(loggedInUser, "failed to create ticket",
                                    "Error : " + e.toString());
                            objData.get(i).getErrorMsg().add("Ticket Creation Failed for < "
                                    + objData.get(i).getTransactionId() + " >");
                            objData.get(i).setPassed("Fail");
                            passed--;
                            failed++;

                        }
                    } else {
                        failed++;
                    }
                }
                pw.println("# Total Records : <" + objData.size() + ">");
                pw.println("# Records Passed : <" + passed + ">");
                pw.println("# Records Failed : <" + failed + ">");
                pw.println("");
                pw.println(
                        "*********************************************************************************************************");
                pw.println("");
                pw.println("");

                for (int i = 0; i < objData.size(); i++) {
                    int row = i + 1;
                    if (objData.get(i).getPassed() == "Fail") {
                        pw.print("< Record" + row + " >: < " + objData.get(i).getREFID() + " > :");
                        for (int j = 0; j < objData.get(i).getErrorMsg().size(); j++) {
                            pw.print(" < " + objData.get(i).getErrorMsg().get(j) + " > ");
                            if (j < objData.get(i).getErrorMsg().size() - 1) {
                                pw.print(",");
                            }
                        }
                        pw.println("");
                        pw.println("");

                    }
                }

                pw.println("");

                pw.println(
                        "*********************************************************************************************************");

                pw.println("Process End Time : <" + new Date() + ">");
                pw.close();

                filePathChecker.setPermissions(logError.toPath());
                try {
                    String pathString = upload_DIR + File.separator + new Date().getTime() + file.getOriginalFilename();
                    if (!filePathChecker.isValidPath(pathString)) {
                        LOGGER.error("Invalid file path " + upload_DIR + File.separator + new Date().getTime()
                                + file.getOriginalFilename());
                        activityLogService.addActivity(loggedInUser, "failed to create ticket, invalid file path "
                                + upload_DIR + File.separator + new Date().getTime() + file.getOriginalFilename());
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }
                    Path path = Paths.get(pathString).toAbsolutePath().normalize();
                    Files.copy(file.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);
                    filePathChecker.setPermissions(path);
                    f = true;

                } catch (Exception e) {

                    LOGGER.error(loggerEncoderUtil
                            .encode("Error : " + e + "\nParam : file name " + file.getOriginalFilename()));
                    activityLogService.addActivity(loggedInUser, "failed to create ticket",
                            "Error : " + e.toString() + ", Parameters : " + file.getOriginalFilename());
                    return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);

                }
                try {
                    if (f == true) {
                        upFile.setPassedRecords(passed);
                        upFile.setFailedRecords(failed);
                        if (objData.size() == passed) {
                            upFile.setStatus("Pass");
                        } else {
                            upFile.setStatus("Fail");
                        }
                        uploadChargeBackRepository.save(upFile);
                    }
                } catch (Exception e) {

                    LOGGER.error("Error : " + e + "\nParam : file  " + loggerEncoderUtil.encode(upFile.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to create ticket",
                            "Error : " + e.toString() + ", Parameters : " + upFile);
                    return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                activityLogService.addActivity(loggedInUser, "File Uploaded Successfully", file.getOriginalFilename());
                LOGGER.debug("Exiting uploadChargeBack Method in " + ListManagementServiceImpl.class
                        + " class with response  : File Uploaded Successfully");
                return new ResponseEntity<ApiResponse>(new ApiResponse(true, "File Uploaded Successfully"),
                        HttpStatus.OK);
            }
            activityLogService.addActivity(loggedInUser,
                    "failed to upload chargeback file becasue file is not  XLSX file or XLS file",
                    file.getOriginalFilename());
            LOGGER.info("Exiting uploadChargeBack Method in " + ListManagementServiceImpl.class
                    + " class with response  : Please upload XLSX file or XLS file");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Please upload XLSX file or XLS file"),
                    HttpStatus.BAD_REQUEST);
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to upload chargeback file");
            LOGGER.debug("Exiting uploadChargeBack Method in " + ListManagementServiceImpl.class
                    + " class with response  : unauthorized to upload chargeback file");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to upload chargeback file"),
                    HttpStatus.FORBIDDEN);
        }
    }

    public ResponseEntity<?> downloadTemplate(Authentication pr, HttpServletRequest request) throws Exception {

        LOGGER.debug("entered in class " + ListManagementServiceImpl.class + " in method downloadTemplate");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {

            String upload_DIR = template_download_path;

            Path path = Paths.get(upload_DIR + File.separator + "template.xlsx").toAbsolutePath().normalize();
            Resource resource = null;
            try {
                resource = new UrlResource(path.toUri());
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : uri path " + loggerEncoderUtil.encode(path.toUri().toString()));
                activityLogService.addActivity(loggedInUser, "failed to download chargeback template file",
                        "Error : " + e.toString() + ", Parameters : " + path.toUri());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            String contentType = null;
            try {
                contentType = request.getServletContext().getMimeType(resource.getFile().getAbsolutePath());
            } catch (Exception e) {
                System.out.println("Could not determine file type.");
            }

            // Fallback to the default content type if type could not be determined
            if (contentType == null) {
                contentType = "application/octet-stream";
            }

            activityLogService.addActivity(loggedInUser, "chargeback file downloaded",
                    "Parameters : " + resource.getFile().getAbsolutePath());
            LOGGER.debug("Exiting downloadTemplate Method in " + ListManagementServiceImpl.class
                    + " class with response  : chargeback template file");
            return ResponseEntity.ok().contentType(MediaType.parseMediaType(contentType))
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + resource.getFilename() + "\"")
                    .body(resource);
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to download chargeback template file");
            LOGGER.debug("Exiting downloadTemplate Method in " + ListManagementServiceImpl.class
                    + " class with response  : unauthorized to download chargeback template file");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to download chargeback template file"),
                    HttpStatus.FORBIDDEN);
        }

    }


    @Override
    public ResponseEntity<?> downloadErrorLog(int id, Authentication pr, HttpServletRequest request) throws Exception {

        LOGGER.debug("entered in class " + ListManagementServiceImpl.class + " in method downloadErrorLog");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {

            UploadChargeBack upCB = uploadChargeBackRepository.getById(id);

            Path path = Paths.get(upCB.getErrorLog()).toAbsolutePath().normalize();
            Resource resource = null;
            try {
                resource = new UrlResource(path.toUri());
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : uri path " + loggerEncoderUtil.encode(path.toUri().toString()));
                activityLogService.addActivity(loggedInUser, "failed to download chargeback error log",
                        "Error : " + e.toString() + ", Parameters : " + path.toUri());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);

            }

            String contentType = null;
            try {
                contentType = request.getServletContext().getMimeType(resource.getFile().getAbsolutePath());
            } catch (Exception ex) {
                LOGGER.info("Could not determine file type.");
            }

            // Fallback to the default content type if type could not be determined
            if (contentType == null) {
                contentType = "application/octet-stream";
            }
            activityLogService.addActivity(loggedInUser, "chargeback error log file downloaded",
                    "Parameters : " + resource.getFile().getAbsolutePath());
            LOGGER.debug("Exiting downloadTemplate Method in " + ListManagementServiceImpl.class
                    + " class with response  : chargeback error log file downloaded");

            return ResponseEntity.ok().contentType(MediaType.parseMediaType(contentType))
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + resource.getFilename() + "\"")
                    .body(resource);
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to download error log chargeback file");
            LOGGER.debug("Exiting downloadErrorLog Method in " + ListManagementServiceImpl.class
                    + " class with response  : unauthorized to download error log chargeback file");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to download error log chargeback file"),
                    HttpStatus.FORBIDDEN);
        }
    }
}
