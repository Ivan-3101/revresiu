package com.DronaPay.UIServer.response;

import com.DronaPay.UIServer.ResponseVO.HistoricProfileVO;
import lombok.Data;

import java.util.List;

@Data
public class HistoricProfileView {
    private Boolean view;
    private Boolean add;
    private Boolean delete;
    private Boolean edit;
    private Boolean approve;
    private Boolean publish;
    private List<HistoricProfileVO> historicProfileVO;
}
