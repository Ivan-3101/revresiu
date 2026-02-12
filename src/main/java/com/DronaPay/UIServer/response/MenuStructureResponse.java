package com.DronaPay.UIServer.response;

import java.util.List;

import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class MenuStructureResponse {
	private Boolean collapse;
	private String name;	
	private String rtlName;
	private String icon; 
	private String state; 
	private String mini;
	private String rtlMini;
	private String path;
	private String layout;
	private Boolean defaultload;
	private List<MenuStructureResponse> views;
}
