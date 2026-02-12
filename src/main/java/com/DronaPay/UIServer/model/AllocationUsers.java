package com.DronaPay.UIServer.model;

import com.DronaPay.UIServer.CompositeKey.AllocationUsersKey;
import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "allocationusers", schema = "camunda")
@IdClass(AllocationUsersKey.class)
@Data
public class AllocationUsers {
   
    @Id
    @Column(name = "role1userid")
    private Integer role1UserID;

    @Id
    @Column(name = "role2userid")
    private Integer role2UserID;

    @Id
    @Column(name = "role1groupid")
    private Integer role1GroupID;

    @Id
    @Column(name = "role2groupid")
    private Integer role2GroupID;

    @Id
    @Column(name = "workflowid")
    private Integer workflowID;

    @Id
    @Column(name = "itenantid")
    private Integer itenantId;

    @Id
    @Column(name = "iorgid")
    private Integer iorgId;
}
