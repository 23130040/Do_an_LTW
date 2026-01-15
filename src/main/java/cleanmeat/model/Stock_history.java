package cleanmeat.model;

import java.time.LocalDate;

public class Stock_history {
    private int id;
    private Item item;
    private String type;
    private double quantity;
    private LocalDate created_at;
    private User created_by;

    public Stock_history(int id, Item item, String type, double quantity, LocalDate created_at, User created_by) {
        this.id = id;
        this.item = item;
        this.type = type;
        this.quantity = quantity;
        this.created_at = created_at;
        this.created_by = created_by;
    }

    public Stock_history(Item item, String type, double quantity, User created_by) {
        this.item = item;
        this.type = type;
        this.quantity = quantity;
        this.created_by = created_by;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Item getItem() {
        return item;
    }

    public void setItem(Item item) {
        this.item = item;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public double getQuantity() {
        return quantity;
    }

    public void setQuantity(double quantity) {
        this.quantity = quantity;
    }

    public LocalDate getCreated_at() {
        return created_at;
    }

    public void setCreated_at(LocalDate created_at) {
        this.created_at = created_at;
    }

    public User getCreated_by() {
        return created_by;
    }

    public void setCreated_by(User created_by) {
        this.created_by = created_by;
    }
}
