package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.repository.StatusCodeRepository;
import com.DronaPay.UIServer.model.StatusCode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

@Service
public class StatusCodeServiceImpl implements StatusCodeService {

	@Autowired
	private StatusCodeRepository statusCodeRepository;

	public void save(StatusCode sc) throws Exception {
		statusCodeRepository.save(sc);
	}

	@Cacheable(value="STATUSCODE", key="#i")
	public StatusCode findByIStatusId(int i) {

		return statusCodeRepository.getById(i);
//        return statusCodeRepository.findByiStatusID(i);
	}
}
