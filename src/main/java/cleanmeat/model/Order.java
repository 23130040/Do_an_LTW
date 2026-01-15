package cleanmeat.model;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class Order {
    private int id;
    private User user;
    private Address address;
    private double total_price;
    private String status;
    private LocalDate created_at;
    private LocalDate updated_at;
    private List<OrderItem> listItem;

    public Order(int id, User user, Address address, double total_price, String status, LocalDate created_at, LocalDate updated_at) {
        this.id = id;
        this.user = user;
        this.address = address;
        this.total_price = total_price;
        this.status = status;
        this.created_at = created_at;
        this.updated_at = updated_at;
        this.listItem = new ArrayList<>();
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

    public Address getAddress() {
        return address;
    }

    public void setAddress(Address address) {
        this.address = address;
    }

    public double getTotal_price() {
        return total_price;
    }

    public void setTotal_price(double total_price) {
        this.total_price = total_price;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public List<OrderItem> getListItem() {
        return listItem;
    }

    public void setListItem(List<OrderItem> listItem) {
        this.listItem = listItem;
    }
}
