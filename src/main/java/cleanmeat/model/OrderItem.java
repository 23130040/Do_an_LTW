package cleanmeat.model;

import java.time.LocalDate;

public class OrderItem {
    private Item item;
    private double price;
    private int quantity;
    private LocalDate creates_at;

    public OrderItem(Item item, double price, int quantity, LocalDate creates_at) {
        this.item = item;
        this.price = price;
        this.quantity = quantity;
        this.creates_at = creates_at;
    }

    public OrderItem(Item item, double price, int quantity) {
        this.item = item;
        this.price = price;
        this.quantity = quantity;
    }

    public OrderItem() {
    }

    public LocalDate getCreates_at() {
        return creates_at;
    }

    public void setCreates_at(LocalDate creates_at) {
        this.creates_at = creates_at;
    }

    public Item getItem() {
        return item;
    }

    public double getPrice() {
        return price;
    }

    public double getQuantity() {
        return quantity;
    }

    public void setItem(Item item) {
        this.item = item;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}
