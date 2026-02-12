package com.DronaPay.UIServer.Constants.Enum;

import lombok.Getter;

@Getter
public enum DronaGodMenu {
    ADMIN("Admin"),
    USER_MANAGEMENT("User Management"),
    ADD_USER("Add User"),
    USER_PROFILE("User Profile"),
    EDIT_USER("Edit User"),
    APPROVE_EDIT_USER("Approve Edit User"),
    APPROVE_ADD_USER("Approve Add User"),
    ADMIN_REPORTS("Admin Reports");

    private final String displayName;

    DronaGodMenu(String displayName) {
        this.displayName = displayName;
    }

}
