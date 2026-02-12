package com.DronaPay.UIServer.exception;

import com.DronaPay.UIServer.Constants.ResponseMessages;
import com.DronaPay.UIServer.response.ApiResponse;
import com.DronaPay.UIServer.service.RepositoryService.ActivityLogService;
import com.DronaPay.UIServer.util.LoggerEncoderUtil;
import jakarta.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.web.HttpMediaTypeNotSupportedException;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.method.annotation.MethodArgumentTypeMismatchException;
import org.springframework.web.reactive.function.client.WebClientRequestException;
import org.springframework.web.util.ContentCachingRequestWrapper;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;


//@Order(Ordered.HIGHEST_PRECEDENCE)
@ControllerAdvice
public class CustomExceptionHandler {

    private static final Logger LOGGER = LoggerFactory.getLogger(CustomExceptionHandler.class);

    @Autowired
    private LoggerEncoderUtil loggerEncoderUtil;

    @Autowired
    private ActivityLogService activityLogService;

    @ExceptionHandler(SQLException.class)
    public final ResponseEntity<?> handleSqlExceptions(Exception e) {
        LOGGER.error("Error : " + e);
        return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Something is wrong with Database"),
                HttpStatus.FAILED_DEPENDENCY);
    }

    @ExceptionHandler(Exception.class)
    public final ResponseEntity<?> handleExceptions(Exception e) {
        HttpServletRequest request =
                ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();

        String requestUrl = request.getRequestURL().toString();
        String requestMethod = request.getMethod();

        LOGGER.error("Request URL: \n {} Method: {} \n Error Message: {} \n StackTrace: {}", requestUrl, requestMethod, e.getMessage(), e.getStackTrace());

        return ResponseEntity
                .status(HttpStatus.INTERNAL_SERVER_ERROR)
                .contentType(MediaType.APPLICATION_JSON)
                .body(new ApiResponse(false, ResponseMessages.GenericErrorMessage));
    }


    @ExceptionHandler(IOException.class)
    public final ResponseEntity<?> IOExceptionExceptions(IOException e) {
        HttpServletRequest request =
                ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();

        String requestUrl = request.getRequestURL().toString();
        String requestMethod = request.getMethod();
        String message = e.getMessage();

        // Check for client disconnection errors (SSE, broken pipe, connection reset, etc.)
        if (message != null && (
                message.contains("Broken pipe") ||
                        message.contains("Connection reset") ||
                        message.contains("aborted by the software in your host machine") ||
                        message.contains("Connection reset by peer"))) {

            LOGGER.info("Client disconnected - Request URL: {} Method: {} Error: {}",
                    requestUrl, requestMethod, message);

            // Don't return a response for client disconnections
            return null;
        }

        // For actual server-side IO errors, log and return error response
        LOGGER.error("Request URL: \n {} Method: {} \n Error Message: {} \n StackTrace: {}",
                requestUrl, requestMethod, message, e.getStackTrace());

        return ResponseEntity
                .status(HttpStatus.INTERNAL_SERVER_ERROR)
                .contentType(MediaType.APPLICATION_JSON)
                .body(new ApiResponse(false, ResponseMessages.GenericErrorMessage));
    }

    @ExceptionHandler(WebClientRequestException.class)
    public final ResponseEntity<?> WebClientRequestExceptionHandler(Exception e) {
        LOGGER.error("Error : " + e);

        return ResponseEntity
                .status(HttpStatus.FAILED_DEPENDENCY)
                .contentType(MediaType.APPLICATION_JSON)
                .body(new ApiResponse(false, "config error - contact admin"));
    }

    @ExceptionHandler(HttpMessageNotReadableException.class)
    public final ResponseEntity<?> HttpMessageNotReadableException(Exception e) {
        HttpServletRequest request =
                ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();

        String requestUrl = request.getRequestURL().toString();
        String requestMethod = request.getMethod();

        LOGGER.error("Request URL: \n {} Method: {} \n Error Message: {} \n StackTrace: {}", requestUrl, requestMethod, e.getMessage(), e.getStackTrace());


        return ResponseEntity
                .status(HttpStatus.BAD_REQUEST)
                .contentType(MediaType.APPLICATION_JSON)
                .body(new ApiResponse(false, "Required request body is missing"));
    }


    @ExceptionHandler(FileNotFoundException.class)
    public final ResponseEntity<?> FileNotFoundException(Exception e) {
        if(e.getMessage().contains("static"))
        {
            LOGGER.info(e.getMessage());
        }
        else
        {
            LOGGER.error(e.getMessage(), e);
        }

        return ResponseEntity
                .status(HttpStatus.NOT_FOUND)
                .contentType(MediaType.APPLICATION_JSON)
                .body(new ApiResponse(false, "File not found"));

    }


    @ExceptionHandler(HttpRequestMethodNotSupportedException.class)
    public final ResponseEntity<?> WebClientRequestExceptionHandler12(HttpServletRequest req, Exception e) {
        LOGGER.error("Error : " + e +
                ", Requested url" + loggerEncoderUtil.encode(req.getRequestURI())+ ", IPAddress : " + loggerEncoderUtil.encode(req.getRemoteAddr()));
        return ResponseEntity
                .status(HttpStatus.METHOD_NOT_ALLOWED)
                .contentType(MediaType.APPLICATION_JSON)
                .body(new ApiResponse(false, "Request Method not Supported"));

    }



    @ExceptionHandler(HttpMediaTypeNotSupportedException.class)
    public final ResponseEntity<?> handleHttpMediaTypeNotSupported(HttpServletRequest req, HttpMediaTypeNotSupportedException ex) {

        String requestUrl = req.getRequestURL().toString();
        String requestMethod = req.getMethod();

        LOGGER.info("Request URL: \n {} Method: {} \n Error Message: {} \n StackTrace: {}", requestUrl, requestMethod, ex.getMessage(), ex.getStackTrace());

        return ResponseEntity
                .status(HttpStatus.METHOD_NOT_ALLOWED)
                .contentType(MediaType.APPLICATION_JSON)
                .body(new ApiResponse(false, "Request Method not Supported"));
    }

    @ExceptionHandler(NotFoundException.class)
    public final ResponseEntity<?> NotFoundExceptionHandler(NotFoundException e) {
        if (e.getWebUser() != null) {
            if (e.getType().equalsIgnoreCase("INFO")) {
                LOGGER.info("Error : " + loggerEncoderUtil.encode(e.getMessage()) + " , Username : " + loggerEncoderUtil.encode(e.getWebUser().getUsername())
                        + " , parameters : " + loggerEncoderUtil.encode(e.getParameters()));
            } else {
                LOGGER.error("Error : " + loggerEncoderUtil.encode(e.getMessage()) + " , Username : " + loggerEncoderUtil.encode(e.getWebUser().getUsername())
                        + " , parameters : " + loggerEncoderUtil.encode(e.getParameters()));
            }
            activityLogService.addActivity(e.getWebUser(), e.getMessage(), e.getParameters());

            return ResponseEntity
                    .status(HttpStatus.BAD_REQUEST)
                    .contentType(MediaType.APPLICATION_JSON)
                    .body(new ApiResponse(false, e.getMessage()));

        } else {
            if (e.getType().equalsIgnoreCase("INFO")) {
                LOGGER.info("Error : " + loggerEncoderUtil.encode(e.getMessage()) + " , Username : " + ""
                        + " , parameters : " + loggerEncoderUtil.encode(e.getParameters()));
            } else {
                LOGGER.error("Error : " + loggerEncoderUtil.encode(e.getMessage()) + " , Username : " + ""
                        + " , parameters : " + loggerEncoderUtil.encode(e.getParameters()));
            }

            return ResponseEntity
                    .status(HttpStatus.BAD_REQUEST)
                    .contentType(MediaType.APPLICATION_JSON)
                    .body(new ApiResponse(false, e.getMessage()));
        }
    }

    @ExceptionHandler(ForbiddenException.class)
    public final ResponseEntity<?> ForbiddenExceptionExceptionHandler(ForbiddenException e) {
        String username = (e.getWebUser() != null) ? e.getWebUser().getUsername() : "";


        switch (e.getType().toUpperCase()) {
            case "INFO" -> LOGGER.info("Error : {} , Username : {} , parameters : {}",
                    loggerEncoderUtil.encode(e.getMessage()),
                    loggerEncoderUtil.encode(username),
                    loggerEncoderUtil.encode(e.getParameters()));
            case "DEBUG" -> LOGGER.debug("Error : {} , Username : {} , parameters : {}",
                    loggerEncoderUtil.encode(e.getMessage()),
                    loggerEncoderUtil.encode(username),
                    loggerEncoderUtil.encode(e.getParameters()));
            default -> LOGGER.error("Error : {} , Username : {} , parameters : {}",
                    loggerEncoderUtil.encode(e.getMessage()),
                    loggerEncoderUtil.encode(username),
                    loggerEncoderUtil.encode(e.getParameters()));
        }

        if (e.getWebUser() != null) {
            activityLogService.addActivity(e.getWebUser(), e.getMessage(), e.getParameters());
        }

        return ResponseEntity
                .status(HttpStatus.FORBIDDEN)
                .contentType(MediaType.APPLICATION_JSON)
                .body(new ApiResponse(false, e.getMessage()));
    }


    @ExceptionHandler(BadRequestException.class)
    public final ResponseEntity<?> BadRequestExceptionHandler(BadRequestException e) {
        if (e.getWebUser() != null) {
            LOGGER.error("Error : " + loggerEncoderUtil.encode(e.getMessage()) + " , Username : " + loggerEncoderUtil.encode(e.getWebUser().getUsername())
                    + " , parameters : " + loggerEncoderUtil.encode(e.getParameters()));
            activityLogService.addActivity(e.getWebUser(), e.getMessage(), e.getParameters());


            return ResponseEntity
                    .status(HttpStatus.BAD_REQUEST)
                    .contentType(MediaType.APPLICATION_JSON)
                    .body(new ApiResponse(false, e.getMessage()));
        } else {
            LOGGER.error("Error : " + loggerEncoderUtil.encode(e.getMessage()) + " , Username : " + ""
                    + " , parameters : " + loggerEncoderUtil.encode(e.getParameters()));
            //     activityLogService.addActivity(e.getMessage(), e.getParameters());

            return ResponseEntity
                    .status(HttpStatus.BAD_REQUEST)
                    .contentType(MediaType.APPLICATION_JSON)
                    .body(new ApiResponse(false, e.getMessage()));
        }
    }


    @ExceptionHandler(TokenNotValid.class)
    public final ResponseEntity<?> TokenNotValidHandler(TokenNotValid e) {

        LOGGER.debug("Error : token not valid " + loggerEncoderUtil.encode(e.getMessage()) + " , parameters : " + loggerEncoderUtil.encode(e.getParameters()));
        // activityLogService.addActivity(e.getMessage(), e.getParameters());


        return ResponseEntity
                .status(HttpStatus.BAD_REQUEST)
                .contentType(MediaType.APPLICATION_JSON)
                .body(new ApiResponse(false, e.getMessage()));
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    protected ResponseEntity<?> handleMethodArgumentNotValid(MethodArgumentNotValidException ex) {
        List<String> errors = ex.getBindingResult().getFieldErrors().stream().map(x -> x.getDefaultMessage())
                .collect(Collectors.toList());
//        String message;
//        if (errors.size() > 0) {
//            message = "Mandatory fields cannot be empty";
//        } else {
//            message = errors.get(0);
//        }
        String message = errors.isEmpty() ? "Validation failed" : errors.get(0);

        return ResponseEntity
                .status(HttpStatus.BAD_REQUEST)
                .contentType(MediaType.APPLICATION_JSON)
                .body(new ApiResponse(false,message));
    }


    @ExceptionHandler(MethodArgumentTypeMismatchException.class)
    public ResponseEntity<?> handleTypeMismatch(MethodArgumentTypeMismatchException ex) {
        String message = String.format("Invalid value '%s' for parameter '%s'. Expected type is %s.",
                ex.getValue(), ex.getName(), ex.getRequiredType().getSimpleName());

        HttpServletRequest request =
                ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();

        String requestUrl = request.getRequestURL().toString();
        String requestMethod = request.getMethod();

        LOGGER.info("Request URL: \n {} Method: {} \n Error Message: {} \n StackTrace: {}", requestUrl, requestMethod, ex.getMessage(), ex.getStackTrace());

        return ResponseEntity
                .status(HttpStatus.BAD_REQUEST)
                .contentType(MediaType.APPLICATION_JSON)
                .body(new ApiResponse(false,message));
    }

//     @ExceptionHandler(MethodArgumentNotValidException.class)
//     protected ResponseEntity<Object> handleMethodArgumentNotValid(MethodArgumentNotValidException ex,
//                                                                   HttpHeaders headers, HttpStatus status, WebRequest request) {

//         Map<String, Object> body = new LinkedHashMap<>();
//         body.put("timestamp", new Date());
//         body.put("status", status.value());

//         // Get all errors
//         List<String> errors = ex.getBindingResult().getFieldErrors().stream().map(x -> x.getDefaultMessage())
//                 .collect(Collectors.toList());
//         body.put("errors", errors);
//         return new ResponseEntity<>(body, headers, status);
//     }
}
