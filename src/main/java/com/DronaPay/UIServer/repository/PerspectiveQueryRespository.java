package com.DronaPay.UIServer.repository;
import com.DronaPay.UIServer.model.PerspectiveQuery;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


@Repository
public interface PerspectiveQueryRespository extends JpaRepository<PerspectiveQuery, Integer> {

    public PerspectiveQuery findByVcTableName(String vcTableName);
}
