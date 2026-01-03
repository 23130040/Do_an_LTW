package cleanmeat.model;

import java.time.LocalDate;

public class Item {
    private int id;
    private String name;
    private String short_description;
    private String long_description;
    private int category_id;
    private int origin_id;
    private int unit_id;
    private double price;
    private double discount;
    private int current_stock;
    private int min_stock;
    private LocalDate created_at;
    private LocalDate updated_at;
    private String imageUrl;

    public Item(int id, String name, String short_description, String long_description, int category_id, int origin_id, int unit_id, double price, double discount, int current_stock, int min_stock, LocalDate created_at, LocalDate updated_at) {
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
    public Item(String name, String short_description, String long_description, int category_id, int origin_id, int unit_id, double price, double discount, int current_stock, int min_stock) {
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

    public Item() {
    }

    public LocalDate getUpdated_at() {
        return updated_at;
    }

    public void setUpdated_at(LocalDate updated_at) {
        this.updated_at = updated_at;
    }

    public LocalDate getCreated_at() {
        return created_at;
    }

    public void setCreated_at(LocalDate created_at) {
        this.created_at = created_at;
    }

    public int getMin_stock() {
        return min_stock;
    }

    public void setMin_stock(int min_stock) {
        this.min_stock = min_stock;
    }

    public int getCurrent_stock() {
        return current_stock;
    }

    public void setCurrent_stock(int current_stock) {
        this.current_stock = current_stock;
    }

    public double getDiscount() {
        return discount;
    }

    public void setDiscount(double discount) {
        this.discount = discount;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getUnit_id() {
        return unit_id;
    }

    public void setUnit_id(int unit_id) {
        this.unit_id = unit_id;
    }

    public int getOrigin_id() {
        return origin_id;
    }

    public void setOrigin_id(int origin_id) {
        this.origin_id = origin_id;
    }

    public int getCategory_id() {
        return category_id;
    }

    public void setCategory_id(int category_id) {
        this.category_id = category_id;
    }

    public String getLong_description() {
        return long_description;
    }

    public void setLong_description(String long_description) {
        this.long_description = long_description;
    }

    public String getShort_description() {
        return short_description;
    }

    public void setShort_description(String short_description) {
        this.short_description = short_description;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
}
