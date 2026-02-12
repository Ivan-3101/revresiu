package com.DronaPay.UIServer.repository.sim;

import com.DronaPay.UIServer.model.sim.Simulations;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;


@Repository
public interface SimulationsRepository extends JpaRepository<Simulations, String> {

    public List<Simulations> findAllByItenantId(Integer itenantId);

    public Optional<Simulations> findBySimidAndItenantId(String simid, Integer itenantid);
}
