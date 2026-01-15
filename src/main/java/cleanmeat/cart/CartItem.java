package cleanmeat.cart;

import cleanmeat.model.Item;

public class CartItem {
    private int id;
    private Item item;
    private int quantity;
    private int price;

    public CartItem() {
    }

    public CartItem(int id, Item item, int quantity, int price) {
        this.id = id;
        this.item = item;
        this.quantity = quantity;
        this.price = price;
    }

    public void quantityUp() {
        this.quantity++;
    }

    public void quantityDown() {
        this.quantity--;
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

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        if (quantity < 1) quantity = 1;
        this.quantity = quantity;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }
}
