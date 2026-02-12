package com.DronaPay.UIServer.requests;

import lombok.Data;
import lombok.Getter;

import java.util.List;

@Getter
public class SectionRequestBody {
    private List<String> sectionNameList;
    private String parameters;
    private String timeZone;
}
