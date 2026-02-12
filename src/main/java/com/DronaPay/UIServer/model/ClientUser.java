package com.DronaPay.UIServer.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;

@Entity
@Table(name = "clientuser", schema = "ui")
@Getter
@Setter
public class ClientUser implements UserDetails {

    @Id
    @Column(name = "clientid")
    private String clientID;

    @Column(name = "vcclientsecret")
    private String vcClientSecret;

    @Column(name = "vcclientname")
    private String vcClientName;

    @Column(name = "bdelete")
    private Boolean bdelete;

    @Column(name = "bactive")
    private Boolean bactive;

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return null;
    }

    @Override
    public String getPassword() {
        return vcClientSecret;
    }

    @Override
    public String getUsername() {
        return clientID;
    }

    @Override
    public boolean isAccountNonExpired() {
        return false;
    }

    @Override
    public boolean isAccountNonLocked() {
        return false;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return false;
    }

    @Override
    public boolean isEnabled() {
        return bactive;
    }
}
