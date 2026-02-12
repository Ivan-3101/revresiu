package com.DronaPay.UIServer.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.DronaPay.UIServer.model.Products;

@Repository
public interface ProductRepository extends JpaRepository<Products, Integer> {

    
}
