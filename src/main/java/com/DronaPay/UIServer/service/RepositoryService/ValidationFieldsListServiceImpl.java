package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.repository.ValidationFieldsListRepository;
import com.DronaPay.UIServer.model.ValidationFieldsList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ValidationFieldsListServiceImpl implements ValidationFieldsListService {

	@Autowired
	private ValidationFieldsListRepository validationFieldsListRepository;

	public void save(ValidationFieldsList validationFieldsList) {
		validationFieldsListRepository.save(validationFieldsList);
	}

	public List<ValidationFieldsList> findAll() {
		return validationFieldsListRepository.findAll();
	}

	@Override
	public List<ValidationFieldsList> findAllByItenantid(Integer itenantid) {
		return validationFieldsListRepository.findAllByitenantId(itenantid);
	}
}
