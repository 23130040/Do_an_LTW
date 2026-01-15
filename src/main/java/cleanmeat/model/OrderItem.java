package cleanmeat.model;

import java.time.LocalDate;

public class OrderItem {
    private Item item;
    private double price;
    private double quantity;
    private LocalDate creates_at;

    public OrderItem(Item item, double price, double quantity, LocalDate creates_at) {
        this.item = item;
        this.price = price;
        this.quantity = quantity;
        this.creates_at = creates_at;
    }

    public OrderItem(Item item, double price, double quantity) {
        this.item = item;
        this.price = price;
        this.quantity = quantity;
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

    public void setQuantity(double quantity) {
        this.quantity = quantity;
    }
}
