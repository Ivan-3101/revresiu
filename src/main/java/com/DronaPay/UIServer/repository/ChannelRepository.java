package com.DronaPay.UIServer.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.DronaPay.UIServer.model.Channels;

public interface ChannelRepository extends JpaRepository<Channels,Integer> {
    
}
