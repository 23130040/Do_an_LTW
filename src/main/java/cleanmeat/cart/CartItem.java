package cleanmeat.cart;

import cleanmeat.model.Item;

public class CartItem {
    private int id;
    private Item item;
    private int quantity;

    public CartItem(int id, Item item, int quantity) {
        this.id = id;
        this.item = item;
        this.quantity = quantity;
    }

    public void quantityUp() {
        this.quantity++;
    }

    public void quantityDown() {
        if (this.quantity > 1) {
            this.quantity--;
        }
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

    public double getSubTotal() {
        return this.quantity * this.item.getPrice();
    }
}
