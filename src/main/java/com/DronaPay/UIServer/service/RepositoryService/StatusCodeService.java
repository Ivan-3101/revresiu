package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.StatusCode;

public interface StatusCodeService {

	public void save(StatusCode sc) throws Exception;

	public StatusCode findByIStatusId(int i);

}
