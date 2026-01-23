package cleanmeat.model;

import java.time.LocalDateTime;

public class Address {
    private int id;
    private User user;
    private String address;
    private boolean isDefault;
    private LocalDateTime created_at;
    private LocalDateTime updated_at;

    public Address(User user, String address, boolean isDefault) {
        this.user = user;
        this.address = address;
        this.isDefault = isDefault;
    }

    public Address(int id, User user, String address, boolean isDefault, LocalDateTime created_at, LocalDateTime updated_at) {
        this.id = id;
        this.user = user;
        this.address = address;
        this.isDefault = isDefault;
        this.created_at = created_at;
        this.updated_at = updated_at;
    }

    public Address() {

    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public boolean isDefaultAddress() {
        return isDefault;
    }

    public void setDefaultAddress(boolean aDefault) {
        isDefault = aDefault;
    }

    public LocalDateTime getCreated_at() {
        return created_at;
    }

    public void setCreated_at(LocalDateTime created_at) {
        this.created_at = created_at;
    }

    public LocalDateTime getUpdated_at() {
        return updated_at;
    }

    public void setUpdated_at(LocalDateTime updated_at) {
        this.updated_at = updated_at;
    }
}
