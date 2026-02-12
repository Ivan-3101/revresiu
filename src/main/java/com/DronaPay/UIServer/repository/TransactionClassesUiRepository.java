package com.DronaPay.UIServer.repository;

import com.DronaPay.UIServer.model.TransactionClassesUI;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TransactionClassesUiRepository extends JpaRepository<TransactionClassesUI,Integer>{

    public TransactionClassesUI findByIclassIDAndItenantId(Integer classid, Integer tenantid);
    
    public List<TransactionClassesUI> findBybActiveTrue();

    public List<TransactionClassesUI> findAllBybActiveTrueAndItenantIdIn(List<Integer> tenantids);


    // @Query("SELECT u FROM TransactionClassesUI u WHERE  u.vcClassName = :vcclassname")
    // public TransactionClassesUI findByVcClassName(@Param("vcclassname") String vcClassName);

    public TransactionClassesUI findByiRecordStatusAndVcClassNameAndItenantId(Integer zero, String vcClassName, Integer tenantid);

    //@Query("SELECT u FROM TransactionClassesUI u WHERE  u.iRecordStatus = 0")
    
    public List<TransactionClassesUI> findByiRecordStatus(Integer zero);

    public List<TransactionClassesUI> findAllByiRecordStatusAndItenantIdInAndIclassIDIn(Integer zero,
    List<Integer> itenantids, List<Integer> classes);

    public List<TransactionClassesUI> findAllByiRecordStatusAndItenantIdIn(Integer zero, 
    List<Integer> itenantids);

    public List<TransactionClassesUI> findAllByiRecordStatusAndItenantId(Integer zero,
                                                                           Integer itenantids);


    // @Query("SELECT u FROM TransactionClassesUI u WHERE  u.iDecisionID.iDecisionID = :decisionid")
    // public List<TransactionClassesUI> findByIDecisionId(@Param("decisionid") Integer decisionid);

    public List<TransactionClassesUI> findByiDecisionID(Integer decisionid);

    // @Query(value="select  * from ui.transactionclasses where vcdecisionparams\\:\\:varchar like %:decisionid%",nativeQuery=true)
    // public List<TransactionClassesUI> findByIDecisionIdInParams(@Param("decisionid") String decisionId);
}
