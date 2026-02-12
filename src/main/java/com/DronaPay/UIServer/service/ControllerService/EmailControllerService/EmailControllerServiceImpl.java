package com.DronaPay.UIServer.service.ControllerService.EmailControllerService;

import com.DronaPay.UIServer.Constants.ResponseMessages;
import com.DronaPay.UIServer.model.EmailAuditTrail;
import com.DronaPay.UIServer.model.EmailModel;
import com.DronaPay.UIServer.model.Tenant;
import com.DronaPay.UIServer.requests.EmailAttachment;
import com.DronaPay.UIServer.requests.EmailRequest;
import com.DronaPay.UIServer.response.ApiResponse;
import com.DronaPay.UIServer.service.RepositoryService.ActivityLogService;
import com.DronaPay.UIServer.service.RepositoryService.EmailAuditTrailService;
import com.DronaPay.UIServer.service.RepositoryService.EmailRepoService;
import com.DronaPay.UIServer.service.RepositoryService.TenantRepositoryService;
import com.DronaPay.UIServer.util.HtmlTemplateEngine;
import com.DronaPay.UIServer.util.LoggerEncoderUtil;
import com.DronaPay.UIServer.util.TextTemplateEngine;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import lombok.extern.slf4j.Slf4j;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.thymeleaf.context.Context;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.ZonedDateTime;
import java.util.*;

@Service
@Slf4j
public class EmailControllerServiceImpl implements EmailControllerService {

    @Autowired
    private ActivityLogService activityLogService;

    @Autowired
    private LoggerEncoderUtil loggerEncoderUtil;

    @Autowired
    private EmailRepoService emailRepoService;

    @Autowired
    private TenantRepositoryService tenantRepositoryService;

    // @Value("${email.provider}")
    // private String emailProvider;

    // @Value("${spring.mail.properties.mail.sender}")
    // private String mailSenderName;

    // @Value("${spring.mail.username}")
    // private String mailSenderUserName;

    @Autowired
    private TextTemplateEngine textTemplateEngine;

    @Autowired
    private HtmlTemplateEngine htmlTemplateEngine;

    // @Autowired
    // private JavaMailSender javaMailSender;

    @Autowired
    private EmailAuditTrailService emailAuditTrailService;

    private Boolean sendEmailSmtp(List<String> toList, List<String> ccList, List<String> bccList, String body,
                                  String subject, Map<String, String> providerProperties, List<EmailAttachment> attachments, Boolean overridingProps)
            throws Exception {
        JavaMailSenderImpl javaMailSender = new JavaMailSenderImpl();
        // try {
        MimeMessage mimeMessage = javaMailSender.createMimeMessage();
        MimeMessageHelper mimeMessageHelper = new MimeMessageHelper(mimeMessage, true);

        // log.info("Sending email from request body smtp email properties");
        javaMailSender.setHost(providerProperties.get("mail.smtp.host"));
        javaMailSender.setPort(Integer.parseInt(providerProperties.get("mail.smtp.port")));
        javaMailSender.setUsername(providerProperties.get("mail.username"));
        if (overridingProps) {
            javaMailSender.setPassword(providerProperties.get("mail.password"));
        } else {
            javaMailSender.setPassword(tenantRepositoryService.decryptCipherText(providerProperties.get("mail.password")));
        }

        Properties props = System.getProperties();
        for (String provProp : providerProperties.keySet()) {
            if (provProp.equals("mail.smtp.host") || provProp.equals("mail.smtp.port")
                    || provProp.equals("mail.username") || provProp.equals("mail.sender")
                    || provProp.equals("mail.password")) {
                continue;
            }
            System.out.println("adding property in java mail properties " + provProp);
            props.put(provProp, providerProperties.get(provProp));
        }
        // props.put("mail.smtp.auth", providerProperties.get("mail.smtp.auth"));
        // props.put("mail.smtp.connectiontimeout",
        // providerProperties.get("mail.smtp.connectiontimeout"));
        // props.put("mail.smtp.timeout", providerProperties.get("mail.smtp.timeout"));
        // props.put("mail.smtp.writetimeout",
        // providerProperties.get("mail.smtp.writetimeout"));
        // props.put("mail.smtp.starttls.enable",
        // providerProperties.get("mail.smtp.starttls.enable"));
        // props.put("mail.debug","true");
        javaMailSender.setJavaMailProperties(props);
        mimeMessageHelper.setFrom(new InternetAddress(providerProperties.get("mail.username"),
                providerProperties.get("mail.sender")));

        if (toList != null) {
            mimeMessageHelper.setTo(toList.toArray(new String[0]));
        }

        if (ccList != null) {
            mimeMessageHelper.setCc(ccList.toArray(new String[0]));
        }

        if (bccList != null) {
            mimeMessageHelper.setBcc(bccList.toArray(new String[0]));
        }
        mimeMessageHelper.setSubject(subject);
        mimeMessageHelper.setText(body, true);
        if (attachments != null) {
            for (EmailAttachment attach : attachments) {
                byte[] decodedData = Base64.getDecoder().decode(attach.getFilecontent());
                mimeMessageHelper.addAttachment(attach.getFilename(), new ByteArrayResource(decodedData));
            }
        }
        javaMailSender.send(mimeMessage);
        log.info("mail sent via smtp");
        // } catch (Exception e) {
        // log.error("Error sending mail " + e.toString());
        // return false;
        // }

        return true;

    }

    private Boolean sendEmailKarix(List<String> toList, List<String> ccList, List<String> bccList, String body,
                                   String subject, Map<String, String> providerProperties, List<EmailAttachment> attachments, Boolean overridingProps)
            throws Exception {

        JSONObject message = new JSONObject();
        message.put("html", body);
        message.put("text", "Example text content");
        message.put("subject", subject);
        message.put("fromEmail", providerProperties.get("karix.from.email"));
        message.put("fromName", providerProperties.get("karix.from.name"));
        message.put("replyTo", providerProperties.get("karix.reply.email"));

        JSONArray recipients = new JSONArray(toList);
        message.put("recipients", recipients);

        if (ccList != null) {
            JSONArray ccRecipients = new JSONArray(ccList);
            message.put("ccRecipients", ccRecipients);
        }

        if (bccList != null) {
            JSONArray bccrecipients = new JSONArray(bccList);
            message.put("bccRecipients", bccrecipients);
        }

        if (attachments != null && !attachments.isEmpty()) {
            JSONArray attachmentsJson = new JSONArray();
            for (EmailAttachment attach : attachments) {
                JSONObject attachJson = new JSONObject();
                attachJson.put("name", attach.getFilename());
                attachJson.put("attachmentData", attach.getFilecontent());
                attachmentsJson.put(attachJson);
            }
            message.put("attachments", attachmentsJson);
        }

        JSONObject karixBody = new JSONObject();
        karixBody.put("version", "1.0");
        karixBody.put("userName", providerProperties.get("karix.username"));
        if (overridingProps) {
            karixBody.put("password", providerProperties.get("karix.password"));
        } else {
            karixBody.put("password", tenantRepositoryService.decryptCipherText(providerProperties.get("karix.password")));
        }
        karixBody.put("includeFooter", "yes");
        karixBody.put("message", message);

        log.info("karix body " + loggerEncoderUtil.encode(karixBody.toString()));

        String url = providerProperties.get("karix.email.url");
        HttpRequest karixMailReq = HttpRequest.newBuilder()
                .uri(URI.create(url + "/sendEmail"))
                .header("Content-Type", "application/json")
                .POST(HttpRequest.BodyPublishers.ofString(karixBody.toString()))
                .build();

        HttpClient client = HttpClient.newHttpClient();
        // try {
        HttpResponse<String> resClient = client.send(karixMailReq, HttpResponse.BodyHandlers.ofString());
        log.info("Karix EMAIL Status " + resClient.statusCode());
        log.info("Karix EMAIL Response " + resClient.body());
        // } catch (Exception e) {
        // log.error("Error : " + e + "\nParam : " + karixMailReq);
        // return false;
        // }

        return true;
    }

    @Override
    public ResponseEntity<?> sendEmail(EmailRequest emailRequest) throws Exception {

        log.debug("Entered sendEmail method of class " + EmailControllerServiceImpl.class);
        EmailModel template = null;
        try {
            template = emailRepoService.findById(emailRequest.getTemplateid(), emailRequest.getItenantId());
        } catch (Exception e) {
            // activityLogService.addActivity(loggedInUser, "failed to fetch email template", e.toString());
            log.error("Exiting sendEmail  Method in " + EmailControllerService.class
                    + " class with response  : failed to fetch email template" + e);
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "failed to fetch email template"),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }

        if (template == null) {
            log.warn("Email template not found for ID: {}", emailRequest.getTemplateid());
            return new ResponseEntity<>(new ApiResponse(false, "Email template not found"), HttpStatus.NOT_FOUND);
        }

        String generatedBody = template.getBody();

        if (emailRequest.getBodyParams() != null) {
            final Context ctx = new Context();
            ctx.setVariables(emailRequest.getBodyParams());

            generatedBody = htmlTemplateEngine.process(generatedBody, ctx);
        }
        // System.out.println("Body generated " + generatedBody);

        String generatedSubject = template.getSubject();

        if (emailRequest.getSubjectParams() != null) {

            final Context ctx = new Context();
            ctx.setVariables(emailRequest.getSubjectParams());
            generatedSubject = textTemplateEngine.process(generatedSubject, ctx);
        }

        // System.out.println("subject " + generatedSubject);
        String emailProvider = null;
        Map<String, String> provProps = null;
        Boolean overridingProps = false;
        Tenant tenant = tenantRepositoryService.findByItenantId(emailRequest.getItenantId());

        if (tenant == null) {
            log.error("Tenant not found");
            return new ResponseEntity<>(new ApiResponse(false, "Invalid tenant"), HttpStatus.BAD_REQUEST);
        }

        if (tenant.getAttribs() == null) {
            log.info("Attribs not found for tenant. Email service provider details awaited from client");
            return new ResponseEntity<>(new ApiResponse(false, "Email service provider details awaited from client"), HttpStatus.OK);
        }

        if (emailRequest.getEmailProvider() != null && !emailRequest.getEmailProvider().isEmpty()
                && !emailRequest.getEmailProvider().isBlank()
                && !emailRequest.getEmailProvider().equalsIgnoreCase("none")) {
            log.info("Overiding with email provider properties");

            JsonNode additionalSettings = tenant.getAttribs().get("additionalEmailSettings");
            if (additionalSettings == null || !additionalSettings.isArray()) {
                log.error("No additional email settings configured");
                return new ResponseEntity<>(new ApiResponse(false, "Provider not allowed"), HttpStatus.BAD_REQUEST);
            }

            boolean configFound = false;
            Map<String, String> requestProps = emailRequest.getProviderProperties();

            for (JsonNode setting : additionalSettings) {
                JsonNode configProvider = setting.get("email.provider");
                if (configProvider != null && configProvider.asText().equalsIgnoreCase(emailRequest.getEmailProvider())) {

                    // Dynamic property validation
                    ObjectMapper mapper = new ObjectMapper();
                    Map<String, String> configProps = mapper.convertValue(setting, new TypeReference<Map<String,String>>(){});

                    if (validateAllProperties(configProps, requestProps)) {
                        configFound = true;
                        break;
                    }
                }
            }

            if (!configFound) {
                log.error("Provider config validation failed");
                return new ResponseEntity<>(new ApiResponse(false, "Provider config validation failed"), HttpStatus.BAD_REQUEST);
            }
            emailProvider = emailRequest.getEmailProvider();
            provProps = emailRequest.getProviderProperties();
            overridingProps = true;
        } else {
            // using uiserver properties
            log.info("Using properties configured in UIserver for tenant " + loggerEncoderUtil.encode(emailRequest.getItenantId().toString()));
//            Tenant tenant = tenantRepositoryService.findByItenantId(emailRequest.getItenantId());

            JsonNode outboundEmail = tenant.getAttribs().get("outboundEmailSettings");
            if (outboundEmail == null || outboundEmail.get("email.provider") == null) {
                log.info("Email service provider details awaited from client");
                return new ResponseEntity<>(new ApiResponse(false, "Email service provider details awaited from client"), HttpStatus.OK);
            }

            emailProvider = outboundEmail.get("email.provider").asText();
            ObjectMapper mapper = new ObjectMapper();
            provProps = mapper.convertValue(outboundEmail.get("email.provider.properties"),
                    new TypeReference<Map<String, String>>() {
                    });
        }

        Boolean status = false;
        if (emailProvider.equalsIgnoreCase("karix")) {
            status = sendEmailKarix(emailRequest.getToEmail(), emailRequest.getCcEmail(), emailRequest.getBccEmail(),
                    generatedBody, generatedSubject, provProps, emailRequest.getAttachments(), overridingProps);
        } else if (emailProvider.equalsIgnoreCase("smtp")) {
            status = sendEmailSmtp(emailRequest.getToEmail(), emailRequest.getCcEmail(), emailRequest.getBccEmail(),
                    generatedBody, generatedSubject, provProps, emailRequest.getAttachments(), overridingProps);
        }
        if (status) {
            log.debug("Exiting sendEmail method from class " + EmailControllerServiceImpl.class
                    + " with response success");

            EmailAuditTrail emailAuditTrail = new EmailAuditTrail();
            String[] splittedSubject = generatedSubject.split("\\s+");

            String correlationKey = "";
            try {
                correlationKey = splittedSubject[0].split("\\:")[1];
            } catch (ArrayIndexOutOfBoundsException e) {
                log.info("Correlation key not found in subject " + generatedSubject);
            }

            emailAuditTrail.setCorrelationId(correlationKey);
            emailAuditTrail.setEmailTemplateId(template.getId());
            emailAuditTrail.setProcessingStatus(1);
            String finalBody = (emailRequest.getSensitiveVariables() == null)
                    ? generatedBody
                    : maskSensitiveVariables(template.getBody(), emailRequest.getBodyParams(),
                    emailRequest.getSensitiveVariables());
            emailAuditTrail.setSendBody(finalBody);
            emailAuditTrail.setSentSubject(generatedSubject);
            emailAuditTrail.setSentTimeStamp(ZonedDateTime.now());
            emailAuditTrail.setItenantId(emailRequest.getItenantId());

            try {
                emailAuditTrailService.save(emailAuditTrail);
            } catch (Exception e) {
                log.error(e.toString());
            }
            return new ResponseEntity<>(new ApiResponse(true, "Email sent successfully"),
                    HttpStatus.OK);
        } else {
            log.error("Exiting sendEmail method from class " + EmailControllerServiceImpl.class
                    + " with response internal error");
            return new ResponseEntity<>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }

    }

    private String maskSensitiveVariables(String template, Map<String, Object> bodyParams, List<String> sensitiveVariables) {
        if (bodyParams == null || template == null) {
            return template;
        }

        Set<String> sensitiveSet = (sensitiveVariables != null) ? new HashSet<>(sensitiveVariables) : Collections.emptySet();
        StringBuilder result = new StringBuilder(template);

        for (Map.Entry<String, Object> entry : bodyParams.entrySet()) {
            String key = entry.getKey();
            String placeholder = "${" + key + "}";

            if (!sensitiveSet.contains(key)) {
                String value = entry.getValue().toString();
                int index;
                while ((index = result.indexOf(placeholder)) != -1) {
                    result.replace(index, index + placeholder.length(), value);
                }
            }
        }
        return result.toString();
    }

    private boolean validateAllProperties(Map<String, String> configProps, Map<String, String> requestProps) {
        // Check all configured properties exist in request
        for (Map.Entry<String, String> entry : configProps.entrySet()) {
            if(Objects.equals(entry.getKey(), "email.provider")) continue;
            String reqValue = requestProps.get(entry.getKey());
            if (reqValue == null || !reqValue.equals(entry.getValue())) {
                log.warn("Property mismatch - Key: {}",
                        entry.getKey());
                return false;
            }
        }
        return true;
    }

}
