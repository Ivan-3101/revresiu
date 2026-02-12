package com.DronaPay.UIServer.service.HelperServices;

import com.DronaPay.UIServer.model.CheckerModel;
import com.DronaPay.UIServer.model.MakerModel;
import com.DronaPay.UIServer.model.WebUser;
import com.DronaPay.UIServer.service.Audit;
import com.DronaPay.UIServer.service.RepositoryService.StatusCodeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.time.ZonedDateTime;

@Component
public class CheckerMakerHelperService<U extends Audit<T>, T extends MakerModel, Q extends Audit<R>, R extends CheckerModel> {

    @Autowired
    private StatusCodeService statusCodeService;

    public Boolean save(U u, T t, Q q, R r, WebUser loggedInUser, Boolean approveAction, Boolean rejectEntry) {
        // t.setBclosed(false);

        // r.setDtEntryStamp(new Date());
        // r.setIApproverUserID(loggedInUser);
        // r.setIEntryUserID(loggedInUser);
        // r.setIStatus(statusCodeService.findByIStatusId(1));
        // q.saveAudit(r);
        // u.saveAudit(t);

        if (!approveAction && !rejectEntry) {
            // System.out.println("called 2");
            t.setBclosed(false);
            t.setDtEntryStamp(ZonedDateTime.now());
            t.setIEntryUserID(loggedInUser.getIuserID());
            t.setIorgId(loggedInUser.getIorgId());
            T saveT = u.saveAudit(t);
            if (saveT != null) {
                return true;
            } else {
                return false;
            }

        } else if (approveAction && !rejectEntry) {

            // t.setDtEntryStamp(new Date());
            // t.setIEntryUserID(loggedInUser);
            t.setBclosed(true);
            t.setIApproverUserID(loggedInUser.getIuserID());
            t.setIorgId(loggedInUser.getIorgId());
            t.setDtApproverStamp(ZonedDateTime.now());
            if (t.getVcAction().equals("A")) {
                t.setIstatus(statusCodeService.findByIStatusId(2));
            } else if (t.getVcAction().equals("M")) {
                t.setIstatus(statusCodeService.findByIStatusId(3));
            } else if (t.getVcAction().equals("X")) {
                t.setIstatus(statusCodeService.findByIStatusId(4));
            }
            r.setDtApproverStamp(ZonedDateTime.now());
            r.setIApproverUserID(loggedInUser.getIuserID());
            r.setIorgId(loggedInUser.getIorgId());
            r.setDtEntryStamp(t.getDtEntryStamp());
            r.setIEntryUserID(t.getIEntryUserID());
            r.setIorgId(t.getIorgId());
            r.setIstatus(t.getIstatus().getIStatusIDForMaster());
            T savedT = u.saveAudit(t);
            R saveR = q.saveAudit(r);
            if (savedT != null && saveR != null) {
                return true;
            } else {
                return false;
            }

        } else if (!approveAction && rejectEntry) {

            t.setBclosed(true);
            t.setIApproverUserID(loggedInUser.getIuserID());
            t.setIorgId(loggedInUser.getIorgId());
            t.setDtApproverStamp(ZonedDateTime.now());
            t.setIstatus(statusCodeService.findByIStatusId(5));
            T savedT = u.saveAudit(t);
            if (savedT != null) {
                return true;
            } else {
                return false;
            }

        } else {

            return false;
        }
    }

    public T saveWithObj(U u, T t, WebUser loggedInUser) {
        t.setBclosed(false);
        t.setDtEntryStamp(ZonedDateTime.now());
        t.setIEntryUserID(loggedInUser.getIuserID());
        t.setIorgId(loggedInUser.getIorgId());
        T saveT = u.saveAudit(t);
        return saveT;
    }
}
