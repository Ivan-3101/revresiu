package com.DronaPay.UIServer.service.HelperServices;

import com.DronaPay.UIServer.model.WebUser;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.json.JSONArray;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.time.ZoneId;
import java.util.TimeZone;
import java.util.regex.Pattern;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;
import java.util.Date;
import java.util.List;

public class ExcelHelperService {

        public static String TYPE = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
        static String[] HEADERs = { "Case Id", "Case Type", "Stage", "Alert Summary", "Claimed By", "Claimed On",
                        "Created Date",
                        "Status" };
        static String SHEET = "Case Summary";

        public static byte[] analyzerReportToExcel(String reportName, List<String> headers,
                        List<List<Object>> rowDataAll) {
                try (Workbook workbook = new XSSFWorkbook(); ByteArrayOutputStream out = new ByteArrayOutputStream();) {
                        Sheet sheet = workbook.createSheet(reportName);
                        sheet.createFreezePane(0, 1);

                        // style for data cell
                        CellStyle cellStyle = workbook.createCellStyle();
                        cellStyle.setVerticalAlignment(VerticalAlignment.CENTER);
                        cellStyle.setAlignment(HorizontalAlignment.CENTER);
                        cellStyle.setBorderBottom(BorderStyle.THIN);
                        cellStyle.setBorderLeft(BorderStyle.THIN);
                        cellStyle.setBorderRight(BorderStyle.THIN);
                        cellStyle.setBorderTop(BorderStyle.THIN);
                        cellStyle.setBottomBorderColor(IndexedColors.BLACK.getIndex());
                        cellStyle.setTopBorderColor(IndexedColors.BLACK.getIndex());
                        cellStyle.setLeftBorderColor(IndexedColors.BLACK.getIndex());
                        cellStyle.setRightBorderColor(IndexedColors.BLACK.getIndex());
                        cellStyle.setWrapText(true);

                        Font font = workbook.createFont();
                        font.setFontHeightInPoints((short) 10);
                        font.setFontName("Arial");
                        font.setColor(IndexedColors.BLACK.getIndex());
                        font.setBold(true);
                        font.setItalic(false);

                        // style for header cell
                        CellStyle cellStyleHeader = workbook.createCellStyle();
                        cellStyleHeader.setVerticalAlignment(VerticalAlignment.CENTER);
                        cellStyleHeader.setAlignment(HorizontalAlignment.CENTER);
                        cellStyleHeader.setBorderBottom(BorderStyle.THIN);
                        cellStyleHeader.setBorderLeft(BorderStyle.THIN);
                        cellStyleHeader.setBorderRight(BorderStyle.THIN);
                        cellStyleHeader.setBorderTop(BorderStyle.THIN);
                        cellStyleHeader.setBottomBorderColor(IndexedColors.BLACK.getIndex());
                        cellStyleHeader.setTopBorderColor(IndexedColors.BLACK.getIndex());
                        cellStyleHeader.setLeftBorderColor(IndexedColors.BLACK.getIndex());
                        cellStyleHeader.setRightBorderColor(IndexedColors.BLACK.getIndex());
                        cellStyleHeader.setWrapText(true);
                        cellStyleHeader.setFont(font);
                        cellStyleHeader.setFillBackgroundColor(IndexedColors.LIGHT_BLUE.getIndex());
                        cellStyleHeader.setFillForegroundColor(IndexedColors.LIGHT_YELLOW.getIndex());
                        cellStyleHeader.setFillPattern(FillPatternType.SOLID_FOREGROUND);

                        // add header row
                        Row headerRow = sheet.createRow(0);
                        for (int col = 0; col < headers.size(); col++) {
                                Cell cell = headerRow.createCell(col);
                                cell.setCellValue(headers.get(col));
                                cell.setCellStyle(cellStyleHeader);
                        }

                        // add report data
                        int rowIdx = 1;
                        for (List<Object> rowData : rowDataAll) {
                                Row row = sheet.createRow(rowIdx++);
                                row.setHeight((short) -1);
                                for(int col = 0; col < rowData.size(); col++) {
                                        Cell cell = row.createCell(col);
                                        cell.setCellStyle(cellStyle);
                                        Object data = rowData.get(col);
                                        if(data == null) {
                                                cell.setBlank();
                                        } else if(data instanceof String) {
                                                cell.setCellValue((String) data);
                                        } else if(data instanceof Integer) {
                                                cell.setCellValue((Integer) data);
                                        } else if(data instanceof Long) {
                                                cell.setCellValue((Long) data);
                                        } else if(data instanceof Double) {
                                                cell.setCellValue((Double)data);
                                        } else if(data instanceof Float) {
                                                cell.setCellValue((Float) data);
                                        } else if(data instanceof Date) {
                                                SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy hh:mm a");
                                                cell.setCellValue(dateFormat.format(data));
                                        } else {
                                                cell.setCellValue(data.toString());
                                        }
                                        
                                }
                        }
                        
                        //auto size columns
                        for(int col = 0; col < headers.size(); col++) {
                                sheet.autoSizeColumn(col);
                        }
                        
                        workbook.write(out);
                        return out.toByteArray();

                } catch (IOException e) {
                        throw new RuntimeException("fail to import data to Excel file: " + e.getMessage());
                }
        }

        public static ByteArrayInputStream caseSummaryToExcel(JSONArray response, WebUser loggedInUser) {
                try (Workbook workbook = new XSSFWorkbook(); ByteArrayOutputStream out = new ByteArrayOutputStream();) {
                        Sheet sheet = workbook.createSheet(SHEET);
                        sheet.createFreezePane(0, 1);
                        sheet.setColumnWidth(0, 25 * 256);
                        sheet.setColumnWidth(1, 25 * 256);
                        sheet.setColumnWidth(2, 25 * 256);
                        sheet.setColumnWidth(3, 50 * 256);
                        sheet.setColumnWidth(4, 25 * 256);
                        sheet.setColumnWidth(5, 25 * 256);
                        sheet.setColumnWidth(6, 25 * 256);
                        sheet.setColumnWidth(7, 25 * 256);
                        CellStyle cellStyle = workbook.createCellStyle();
                        cellStyle.setVerticalAlignment(VerticalAlignment.CENTER);
                        cellStyle.setAlignment(HorizontalAlignment.CENTER);
                        cellStyle.setBorderBottom(BorderStyle.THIN);
                        cellStyle.setBorderLeft(BorderStyle.THIN);
                        cellStyle.setBorderRight(BorderStyle.THIN);
                        cellStyle.setBorderTop(BorderStyle.THIN);
                        cellStyle.setBottomBorderColor(IndexedColors.BLACK.getIndex());
                        cellStyle.setTopBorderColor(IndexedColors.BLACK.getIndex());
                        cellStyle.setLeftBorderColor(IndexedColors.BLACK.getIndex());
                        cellStyle.setRightBorderColor(IndexedColors.BLACK.getIndex());
                        cellStyle.setWrapText(true);

                        Font font = workbook.createFont();
                        font.setFontHeightInPoints((short) 10);
                        font.setFontName("Arial");
                        font.setColor(IndexedColors.BLACK.getIndex());
                        font.setBold(true);
                        font.setItalic(false);

                        CellStyle cellStyleHeader = workbook.createCellStyle();
                        cellStyleHeader.setVerticalAlignment(VerticalAlignment.CENTER);
                        cellStyleHeader.setAlignment(HorizontalAlignment.CENTER);
                        cellStyleHeader.setBorderBottom(BorderStyle.THIN);
                        cellStyleHeader.setBorderLeft(BorderStyle.THIN);
                        cellStyleHeader.setBorderRight(BorderStyle.THIN);
                        cellStyleHeader.setBorderTop(BorderStyle.THIN);
                        cellStyleHeader.setBottomBorderColor(IndexedColors.BLACK.getIndex());
                        cellStyleHeader.setTopBorderColor(IndexedColors.BLACK.getIndex());
                        cellStyleHeader.setLeftBorderColor(IndexedColors.BLACK.getIndex());
                        cellStyleHeader.setRightBorderColor(IndexedColors.BLACK.getIndex());
                        cellStyleHeader.setWrapText(true);
                        cellStyleHeader.setFont(font);
                        cellStyleHeader.setFillBackgroundColor(IndexedColors.LIGHT_BLUE.getIndex());
                        cellStyleHeader.setFillForegroundColor(IndexedColors.LIGHT_YELLOW.getIndex());
                        cellStyleHeader.setFillPattern(FillPatternType.SOLID_FOREGROUND);

                        // Header
                        Row headerRow = sheet.createRow(0);
                        for (int col = 0; col < HEADERs.length; col++) {
                                Cell cell = headerRow.createCell(col);
                                cell.setCellValue(HEADERs[col]);
                                cell.setCellStyle(cellStyleHeader);
                                // cell.getCellStyle().setFont(font);
                                // cell.getCellStyle().setFillBackgroundColor(IndexedColors.LIGHT_BLUE.getIndex());
                        }
                        int rowIdx = 1;
                        String formD = null;
                        for (int i = 0; i < response.length(); i++) {
                                // System.out.println( response.getJSONObject(i).optQuery("/assignee"));
                                ZoneId timeZone = loggedInUser.getTimeZone() != null
                                                ? ZoneId.of(loggedInUser.getTimeZone())
                                                : ZoneId.systemDefault();
                                // LocalDateTime
                                // created=LocalDateTime.parse(response.getJSONObject(i).optQuery("/created").toString(),DateTimeFormatter.ISO_DATE_TIME);
                                // DateTimeFormatter sdf =
                                // DateTimeFormatter.ofPattern("YYYY-MM-dd'T'HH:mm:ss.SSSZZ");
                                // sdf.parse(response.getJSONObject(i).optQuery("/created").toString())
                                // DateTimeFormatter ampmformat=DateTimeFormatter.ofPattern("dd-M-yyyy hh:mm:ss
                                // a");
                                // String formattedDate=created.atZone(timeZone).format(ampmformat);
                                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZZ");
                                sdf.setTimeZone(loggedInUser.getTimeZone() != null
                                                ? TimeZone.getTimeZone(loggedInUser.getTimeZone())
                                                : TimeZone.getDefault());
                                // System.out.println(response.getJSONObject(i).optQuery("/created").toString());
                                SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MMM-yyyy hh:mm a");
                                dateFormat.setTimeZone(
                                                loggedInUser.getTimeZone() != null
                                                                ? TimeZone.getTimeZone(loggedInUser.getTimeZone())
                                                                : TimeZone.getDefault());
                                String formattedCreatedDate = null;
                                String recentClaimTime = "NA";
                                try {

                                        // System.out.println(sdf.parse(response.getJSONObject(i).optQuery("/created").toString()));
                                        formattedCreatedDate = dateFormat
                                                        .format(sdf.parse(response.getJSONObject(i).optQuery("/created")
                                                                        .toString()));
                                        if (response.getJSONObject(i).optQuery("/recentClaimTime") != null) {
                                                recentClaimTime = dateFormat
                                                                .format(sdf.parse(response.getJSONObject(i)
                                                                                .optQuery("/recentClaimTime")
                                                                                .toString()));
                                        }
                                        // System.out.println(formattedCreatedDate);
                                        // Instant
                                        // inst=Instant.parse(response.getJSONObject(i).optQuery("/created").toString());
                                        // System.out.println(inst.atZone(timeZone));

                                } catch (Exception e) {
                                        // TODO: handle exception
                                }
                                Row row = sheet.createRow(rowIdx++);
                                row.setHeight((short) -1);
                                // row.setRowStyle(cellStyle);
                                row.createCell(0)
                                                .setCellValue(response.getJSONObject(i)
                                                                .optQuery("/TicketID").toString());
                                row.getCell(0).setCellStyle(cellStyle);
                                row.createCell(1).setCellValue(
                                                response.getJSONObject(i).optQuery("/WorkflowName")
                                                                .toString());
                                row.getCell(1).setCellStyle(cellStyle);
                                row.createCell(2).setCellValue(
                                                response.getJSONObject(i).optQuery("/name")
                                                                .toString());
                                row.getCell(2).setCellStyle(cellStyle);

                                row.createCell(3)
                                                .setCellValue(response.getJSONObject(i)
                                                                .optQuery("/Alert")
                                                                + " \n "
                                                                + response.getJSONObject(i)
                                                                                .optQuery("/payer")

                                                                + " -> "
                                                                + Double.parseDouble(
                                                                                response.getJSONObject(i).optQuery(
                                                                                                "/TransactionAmount") == null
                                                                                                                ? "0"
                                                                                                                : response.getJSONObject(
                                                                                                                                i)
                                                                                                                                .optQuery(
                                                                                                                                                "/TransactionAmount")
                                                                                                                                .toString())
                                                                                / 100
                                                                + " -> "
                                                                + response.getJSONObject(i)
                                                                                .optQuery("/payee"));

                                row.getCell(3).setCellStyle(cellStyle);
                                row.createCell(4).setCellValue(
                                                response.getJSONObject(i).optQuery("/recentClaimee") == null ? "NA"
                                                                : response.getJSONObject(i).optQuery("/recentClaimee")
                                                                                .toString());
                                row.getCell(4).setCellStyle(cellStyle);
                                row.createCell(5).setCellValue(recentClaimTime);
                                row.getCell(5).setCellStyle(cellStyle);
                                row.createCell(6).setCellValue(formattedCreatedDate);
                                row.getCell(6).setCellStyle(cellStyle);
                                row.createCell(7).setCellValue(
                                                response.getJSONObject(i).get("assignee").equals(null) ? "Unclaimed"
                                                                : "Claimed");
                                row.getCell(7).setCellStyle(cellStyle);
                                formD = formattedCreatedDate;
                        }

                        // for (Object obj : tutorials) {
                        // ObjectMapper mapper= new ObjectMapper();
                        // JsonNode node=mapper.re ;
                        // System.out.println(node);
                        // Row row = sheet.createRow(rowIdx++);
                        // row.createCell(0).setCellValue(node.get("formVariable").get("TicketID").get("value").asText());
                        // row.createCell(1).setCellValue(node.get("formVariable").get("WorkflowName").get("value").asText());
                        // row.createCell(2).setCellValue(node.get("formVariable").get("Alert").get("value").asText()+"\r\n"+node.get("formVariable").get("payer").get("value").asText()+"
                        // ->
                        // "+node.get("formVariable").get("TransactionAmount").get("value").asDouble()/100+"
                        // -> " +node.get("formVariable").get("payee").get("value").asText());
                        // row.createCell(3).setCellValue(node.get("recentClaimee")!=null?node.get("recentClaimee").asText():"NA");
                        // row.createCell(4).setCellValue(node.get("recentClaimTime")!=null?node.get("recentClaimTime").asText():"NA");
                        // row.createCell(5).setCellValue(node.get("created").asText());
                        // row.createCell(6).setCellValue(node.get("assignee")==null?"Unclaimed":"Claimed");
                        // }
                        workbook.write(out);
                        ByteArrayOutputStream zipOut = new ByteArrayOutputStream();
                        ZipOutputStream zos = new ZipOutputStream(zipOut);


                    if (formD != null) {
                        zos.putNextEntry(new ZipEntry("CaseSummary-" + formD.split(Pattern.quote(" "))[0] + ".xlsx"));
                    }
                    else
                    {
                        zos.putNextEntry(new ZipEntry("CaseSummary.xlsx"));
                    }
                    out.writeTo(zos);
                        zos.closeEntry();
                        zos.close();

                        return new ByteArrayInputStream(zipOut.toByteArray());
                } catch (IOException e) {
                        throw new RuntimeException("fail to import data to Excel file: " + e.getMessage());
                }
        }
}
