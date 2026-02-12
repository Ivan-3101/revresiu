package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.repository.ParameterRepository;
import com.DronaPay.UIServer.model.Parameter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class ParameterServiceImpl implements ParameterService {

	@Autowired
	private ParameterRepository parameterRepository;

	public void save(Parameter parameter) throws Exception {
		parameterRepository.save(parameter);
	}

	public List<String> getAllParameterType(int iProductID) {
		//return parameterRepository.getAllParameterType(iProductID);
		List<Parameter> parameters = parameterRepository.findByiProductID_iProductID(iProductID);
		return parameters.stream().map(x->x.getVcParameterName()).distinct().collect(Collectors.toList());
	}

	public List<Parameter> findAllByIProductIDAndvAndVcParameterType(int iProductID, String vcParameterType) {
		//return parameterRepository.findAllByIProductIDAndvAndVcParameterType(iProductID, vcParameterType);
		return parameterRepository.findByiProductID_iProductIDAndVcParameterType(iProductID, vcParameterType);
	}

	@Override
	public List<String> getAllParameterTypeForCustomTransaction() {
	   //return parameterRepository.getAllParameterTypeForCustomTransactionClass();
	   List<Parameter> parameterList = parameterRepository.findAll();
	   return parameterList.stream().map(x->x.getVcParameterName()).distinct().collect(Collectors.toList());
	}

	@Override
	public List<Parameter> findAllByIProductIDAndvAndVcParameterTypeForCustomTransactionClasses(
			String vcParameterType) {
		//return parameterRepository.findAllByIProductIDAndvAndVcParameterTypeForCustomTransaction(vcParameterType);
		return parameterRepository.findByVcParameterType(vcParameterType);
	}



}
