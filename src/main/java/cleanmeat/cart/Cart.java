package cleanmeat.cart;

import cleanmeat.model.Item;
import cleanmeat.model.User;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

public class Cart {
    private Map<Integer, CartItem> map;

    public Cart() {
        this.map = new HashMap<Integer, CartItem>();
    }

    public void addCartItem(CartItem cartItem) {
        if (!map.containsKey(cartItem.getId())) {
            map.put(cartItem.getId(), cartItem);
        } else {
            map.get(cartItem.getId()).quantityUp();
        }
    }

    public boolean removeCartItem(int id) {
        return map.remove(id) == null;
    }

    public double getTotal() {
        double total = 0;
        for (CartItem cartItem : map.values()) {
            total += cartItem.getSubTotal();
        }
        return total;
    }

    public Collection<CartItem> getList() {
        return map.values();
    }
}
