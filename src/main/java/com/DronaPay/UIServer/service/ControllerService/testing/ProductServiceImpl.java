package com.DronaPay.UIServer.service.ControllerService.testing;

import com.DronaPay.UIServer.repository.ProductRepository;
import com.DronaPay.UIServer.model.Products;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ProductServiceImpl implements ProductService {

	@Autowired
	private ProductRepository productRepository;

	public void save(Products product) throws Exception {
		productRepository.save(product);
	}

	public Products findByiProductID(int iProductID) throws Exception {
		return productRepository.findById(iProductID).orElse(null);
	}

	@Override
	public List<Products> findALL() throws Exception {
		return productRepository.findAll();
	}
}
