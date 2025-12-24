package cleanmeat.model;

import java.time.LocalDate;

public class Order {
    private int id;
    private User user;
    private Address address;
    private double total_price;
    private String status;
    private String transport_type;
    private String payment_type;
    private LocalDate created_at;
    private LocalDate updated_at;

    public Order(User user, Address address, double total_price, String status, String transport_type, String payment_type) {
        this.user = user;
        this.address = address;
        this.total_price = total_price;
        this.status = status;
        this.transport_type = transport_type;
        this.payment_type = payment_type;
    }

    public Order(int id, User user, Address address, double total_price, String status, String transport_type, String payment_type, LocalDate created_at, LocalDate updated_at) {
        this.id = id;
        this.user = user;
        this.address = address;
        this.total_price = total_price;
        this.status = status;
        this.transport_type = transport_type;
        this.payment_type = payment_type;
        this.created_at = created_at;
        this.updated_at = updated_at;
    }
}
