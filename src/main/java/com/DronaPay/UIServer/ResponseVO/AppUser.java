package com.DronaPay.UIServer.ResponseVO;

import lombok.Builder;
import lombok.Data;

import java.util.List;

//import java.util.ArrayList;
//import java.util.List;

//import lombok.Builder;
//import lombok.Data;


@Builder
@Data
public class AppUser {

    private String fullName;
    private String designation;
    private String email;
    private String mobile;
    private String username;
    //new
    private String profileimg;
    private String password;
    private String contact;
    private String address;
    private String firstname;
    private String lastname;
    //new
//	private List<RoleDesc> userPermissions;
//	private List<GroupDesc> userGroup;

    private List<DropdownWithObject> userPermissions;
    private List<DropdownWithObject> userGroup;

    private boolean edit;
    private boolean delete;
    private boolean approve;
    private boolean publish;
    private int id;
    private boolean audit;
    private String action;
    private String remark;
	private Boolean lock;
    private Boolean entryExist;
    private String vcorgid;

//	public static AppUser parse(WebUser wu, MenuPermissions mp, WebUser user)
//	{
//		AppUser au = new AppUser();
//		au.setId(wu.getIUserID());
//		au.setAudit(false);
//		au.setFullName(wu.getVcFirstName()+" "+wu.getVcLastName());
//		au.setDesignation(wu.getVcDesignation());
//		au.setEmail(wu.getVcEmailID());
//		au.setMobile(wu.getVcMobile());
//		au.setUsername(wu.getUsername());
//		au.setEdit(mp.isEdit());
//		au.setDelete(mp.isDelete());
//		au.setApprove(mp.isApprove());
//		au.setPublish(mp.isPublish());
//		return au;
//	}
//	
//	public static List<AppUser> parseList(List<WebUser> wus, MenuPermissions mp, WebUser user)
//	{
//		List<AppUser> res = new ArrayList<>();
//		for(WebUser wu : wus)
//		{
//			AppUser au = new AppUser();
//			au.setId(wu.getIUserID());
//			au.setAudit(false);
//			au.setFullName(wu.getVcFirstName()+" "+wu.getVcLastName());
//			au.setDesignation(wu.getVcDesignation());
//			au.setEmail(wu.getVcEmailID());
//			au.setMobile(wu.getVcMobile());
//			au.setUsername(wu.getUsername());
//			au.setEdit(mp.isEdit());
//			au.setDelete(mp.isDelete());
//			au.setApprove(false);
//			au.setPublish(mp.isPublish());
//			res.add(au);
//		}
//		return res;
//	}
//	
//	public static AppUser parse(WebUserAudit wua, MenuPermissions mp, WebUser user)
//	{
//		AppUser au = new AppUser();
//		au.setId(wua.getIUserAuditID());
//		au.setAudit(true);
//		au.setFullName(wua.getVcFirstName()+" "+wua.getVcLastName());
//		au.setDesignation(wua.getVcDesignation());
//		au.setEmail(wua.getVcEmailID());
//		au.setMobile(wua.getVcMobile());
//		au.setUsername(wua.getVcUserName());
//		au.setAction(wua.getVcAction());
//		au.setRemark(wua.getVcRemark());
//		if(wua.getIEntryUserID() == user)
//		{
//			au.setEdit(true);
//		}
//		else
//		{
//			au.setEdit(false);
//		}
//		
//		if(wua.getIEntryUserID() == user || mp.isDelete())
//		{
//			au.setDelete(true);
//		}
//		else
//		{
//			au.setDelete(false);
//		}
//		
//		if(wua.getIEntryUserID() != user && mp.isApprove())
//		{
//			au.setApprove(true);	
//		}
//		else
//		{
//			au.setApprove(false);
//		}
//		au.setPublish(false);
//		return au;
//	}
//
//	public static List<AppUser> parseAuditList(List<WebUserAudit> wus, MenuPermissions mp, WebUser user)
//	{
//		List<AppUser> res = new ArrayList<>();
//		for(WebUserAudit wu : wus)
//		{
//			AppUser au = new AppUser();
//			au.setId(wu.getIUserAuditID());
//			au.setAudit(true);
//			au.setFullName(wu.getVcFirstName()+" "+wu.getVcLastName());
//			au.setDesignation(wu.getVcDesignation());
//			au.setEmail(wu.getVcEmailID());
//			au.setMobile(wu.getVcMobile());
//			au.setUsername(wu.getVcUserName());
//			au.setAction(wu.getVcAction());
//			au.setRemark(wu.getVcRemark());
//			if(wu.getIEntryUserID() == user)
//			{
//				au.setEdit(true);
//			}
//			else
//			{
//				au.setEdit(false);
//			}
//			
//			if(wu.getIEntryUserID() == user)
//			{
//				au.setDelete(true);
//			}
//			else
//			{
//				au.setDelete(false);
//			}
//			
//			if(wu.getIEntryUserID() != user && mp.isApprove())
//			{
//				au.setApprove(true);	
//			}
//			else
//			{
//				au.setApprove(false);
//			}
//			au.setPublish(false);
//			
//				
//			res.add(au);
//		}
//		return res;
//	}

}

