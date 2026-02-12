package com.DronaPay.UIServer.repository;

import com.DronaPay.UIServer.model.ClientUser;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ClientUserRepository extends JpaRepository<ClientUser, String> {
}
