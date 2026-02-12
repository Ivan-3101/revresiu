package com.DronaPay.UIServer.service.RepositoryService;

import java.util.List;

import com.DronaPay.UIServer.model.ValidationFieldsList;

public interface ValidationFieldsListService {

	public void save(ValidationFieldsList validationFieldsList);

	public List<ValidationFieldsList> findAll();

	public List<ValidationFieldsList> findAllByItenantid(Integer itenantid);
}
