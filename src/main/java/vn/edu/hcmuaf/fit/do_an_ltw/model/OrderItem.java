package vn.edu.hcmuaf.fit.do_an_ltw.model;

import java.time.LocalDate;

public class OrderItem {
    private Order order;
    private Item item;
    private double price;
    private double quantity;
    private LocalDate creates_at;

    public OrderItem(Order order, Item item, double price, double quantity, LocalDate creates_at) {
        this.order = order;
        this.item = item;
        this.price = price;
        this.quantity = quantity;
        this.creates_at = creates_at;
    }

    public OrderItem(Order order, Item item, double price, double quantity) {
        this.order = order;
        this.item = item;
        this.price = price;
        this.quantity = quantity;
    }
}
