package com.DronaPay.UIServer.service.RepositoryService;

import java.util.List;

import com.DronaPay.UIServer.model.Parameter;

public interface ParameterService {

	public void save(Parameter parameter) throws Exception;

	public List<String> getAllParameterType(int iProductID);

	public List<Parameter> findAllByIProductIDAndvAndVcParameterType(int iProductID, String vcParameterType);

	public List<String> getAllParameterTypeForCustomTransaction();

	public List<Parameter> findAllByIProductIDAndvAndVcParameterTypeForCustomTransactionClasses(String vcParameterType);

}
