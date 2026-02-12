package com.DronaPay.UIServer.VOMapper;


import java.util.function.Function;


import com.DronaPay.UIServer.model.ListMaster;
import com.DronaPay.UIServer.ResponseVO.ListMasterVo;
import org.springframework.stereotype.Component;

@Component
public class ListMasterDTOMapper implements Function<ListMaster, ListMasterVo> {

    @Override
    public ListMasterVo apply(ListMaster listMaster) {
        return ListMasterVo.builder()
                .label(listMaster.getVcName())
                .value(listMaster.getId().getIListMasterID())
                .expiry(listMaster.getIForDays())
                .iConfigJson(listMaster.getIConfigJson())
                .build();
    }
}
