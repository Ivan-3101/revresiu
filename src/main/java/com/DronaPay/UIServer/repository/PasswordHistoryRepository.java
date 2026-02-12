package com.DronaPay.UIServer.repository;

import com.DronaPay.UIServer.model.PasswordHistory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PasswordHistoryRepository extends JpaRepository<PasswordHistory, Integer> {

    List<PasswordHistory> findBybDeleteAndIorgIdAndIuserIdOrderByDtEntryStampAsc(Boolean bdelete, Integer iorgId, Integer iuserId );

}
