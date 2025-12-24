package cleanmeat.model;

import java.time.LocalDate;

public class Stock_history {
    private int id;
    private Item item;
    private String type;
    private double quantity;
    private LocalDate created_at;
    private User created_by;

    private Stock_history(int id, Item item, String type, double quantity, LocalDate created_at, User created_by) {
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
}
