package com.DronaPay.UIServer.service.ControllerService.testing;

import java.util.List;

import com.DronaPay.UIServer.model.Products;

public interface ProductService {

	public void save(Products product) throws Exception;

	public Products findByiProductID(int iProductID) throws Exception;

	public List<Products> findALL() throws Exception;
}
