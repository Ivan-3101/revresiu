package com.DronaPay.UIServer.model.EmbeddedId;

import java.io.Serializable;

import com.DronaPay.UIServer.model.Tenant;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import jakarta.persistence.FetchType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.Data;

@Data
@Embeddable
public class ListMasterEmbeddedId implements Serializable {

    @Column(name = "ilistmasterid", nullable = false)
    private Integer iListMasterID;

    @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    @JoinColumn(name = "itenantid")
    private Tenant itenantId;
    
}
