package com.DronaPay.UIServer.repository;

import com.DronaPay.UIServer.model.Parameter;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
public interface ParameterRepository extends JpaRepository<Parameter, Integer> {

    // @Query("SELECT DISTINCT p.vcParameterType FROM Parameter p where p.iProductID.iProductID = :iproductid")
    // public List<String> getAllParameterType(@Param("iproductid") int iProductID);

    public List<Parameter> findByiProductID_iProductID(Integer iProductID);

    // @Query("SELECT p FROM Parameter p WHERE p.iProductID.iProductID = :iproductid AND p.vcParameterType = :vcparametertype")
    // public List<Parameter> findAllByIProductIDAndvAndVcParameterType(@Param("iproductid") int iProductID, @Param("vcparametertype")String vcParameterType);

    public List<Parameter> findByiProductID_iProductIDAndVcParameterType(int iproductid, String vcparamtype);

    // @Query("SELECT DISTINCT p.vcParameterType FROM Parameter p ")
    // public List<String> getAllParameterTypeForCustomTransactionClass();


    // @Query("SELECT p FROM Parameter p WHERE p.vcParameterType = :vcparametertype")
    // public List<Parameter> findAllByIProductIDAndvAndVcParameterTypeForCustomTransaction( @Param("vcparametertype")String vcParameterType);

    public List<Parameter> findByVcParameterType(String vcParameterType);
}
