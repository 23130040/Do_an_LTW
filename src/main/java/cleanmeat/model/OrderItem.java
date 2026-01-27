package cleanmeat.model;

import java.time.LocalDateTime;

public class OrderItem {
    private Item item;
    private double price;
    private int quantity;
    private LocalDateTime creates_at;

    public OrderItem(Item item, double price, int quantity, LocalDateTime creates_at) {
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

    public LocalDateTime getCreates_at() {
        return creates_at;
    }

    public void setCreates_at(LocalDateTime creates_at) {
        this.creates_at = creates_at;
    }

    public Item getItem() {
        return item;
    }

    public double getPrice() {
        return price;
    }

    public int getQuantity() {
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

    public double getSubTotal() {
        return price * quantity;
    }

}
