package com.DronaPay.UIServer.model;

import jakarta.persistence.*;
import lombok.Data;


@Entity
@Table(name = "ticketidgenerator", schema = "ui")
@Data
public class TicketIDGenerator {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    @Column(name = "ticketid", nullable = false)
    private Long ticketID;

}
