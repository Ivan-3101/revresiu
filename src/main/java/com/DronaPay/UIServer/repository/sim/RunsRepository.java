package com.DronaPay.UIServer.repository.sim;

import com.DronaPay.UIServer.model.sim.Runs;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface RunsRepository extends JpaRepository<Runs, Long> {
    public List<Runs> findAllByItenantId(Integer itenantid);
}
