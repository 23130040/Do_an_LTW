package cleanmeat.model;

import java.time.LocalDate;

public class Item {
    private int id;
    private String name;
    private String short_description;
    private String long_description;
    private Category category_id;
    private Origin origin_id;
    private Unit unit_id;
    private double price;
    private double discount;
    private double current_stock; // Dùng BigDecimal cho số lượng (kg/lít)
    private double min_stock;     // Dùng BigDecimal
    private LocalDate created_at;
    private LocalDate updated_at;

    public Item(int id, String name, String short_description, String long_description, Category category_id, Origin origin_id, Unit unit_id, double price, double discount, double current_stock, double min_stock, LocalDate created_at, LocalDate updated_at) {
        this.id = id;
        this.name = name;
        this.short_description = short_description;
        this.long_description = long_description;
        this.category_id = category_id;
        this.origin_id = origin_id;
        this.unit_id = unit_id;
        this.price = price;
        this.discount = discount;
        this.current_stock = current_stock;
        this.min_stock = min_stock;
        this.created_at = created_at;
        this.updated_at = updated_at;
    }
    public Item(String name, String short_description, String long_description, Category category_id, Origin origin_id, Unit unit_id, double price, double discount, double current_stock, double min_stock) {
        this.name = name;
        this.short_description = short_description;
        this.long_description = long_description;
        this.category_id = category_id;
        this.origin_id = origin_id;
        this.unit_id = unit_id;
        this.price = price;
        this.discount = discount;
        this.current_stock = current_stock;
        this.min_stock = min_stock;
    }
}
