package cleanmeat.model;

import java.time.LocalDate;

public class Address {
    private int id;
    private User user;
    private String address;
    private boolean isDefault;
    private LocalDate created_at;
    private LocalDate updated_at;

    public Address(User user, String address, boolean isDefault) {
        this.user = user;
        this.address = address;
        this.isDefault = isDefault;
    }

    public Address(int id, User user, String address, boolean isDefault, LocalDate created_at, LocalDate updated_at) {
        this.id = id;
        this.user = user;
        this.address = address;
        this.isDefault = isDefault;
        this.created_at = created_at;
        this.updated_at = updated_at;
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

    public LocalDate getCreated_at() {
        return created_at;
    }

    public void setCreated_at(LocalDate created_at) {
        this.created_at = created_at;
    }

    public LocalDate getUpdated_at() {
        return updated_at;
    }

    public void setUpdated_at(LocalDate updated_at) {
        this.updated_at = updated_at;
    }
}
