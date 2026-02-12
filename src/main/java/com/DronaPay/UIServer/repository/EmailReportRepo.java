package com.DronaPay.UIServer.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.DronaPay.UIServer.model.EmailReport;

import lombok.Data;

import java.util.*;


public interface EmailReportRepo extends JpaRepository<EmailReport, Integer> {
    List<EmailReport> findByBactiveTrueAndBdeleteFalse();
    List<EmailReport> findByBdeleteFalseAndItenantIdIsNotNull();
    EmailReport findByReportIdAndItenantId_Itenantid(Integer reportid, Integer tenantid);
    List<EmailReport> findByBdeleteFalseAndItenantId_ItenantidIn(List<Integer> tenantid);
}
