package cleanmeat.cart;

import java.util.HashMap;
import java.util.Map;

public class Cart {
    private Map<Integer, CartItem> map;

    public Cart(int countItem) {
        map = new HashMap<Integer, CartItem>();
    }
}
