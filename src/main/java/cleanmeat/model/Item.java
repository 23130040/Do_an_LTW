package cleanmeat.model;

import java.time.LocalDateTime;
import java.util.List;

public class Item {
    private int id;
    private String sku;
    private String name;
    private String short_description;
    private String long_description;
    private int category_id;
    private int origin_id;
    private Unit unit;
    private double price;
    private double discount;
    private int current_stock;
    private int min_stock;
    private LocalDateTime created_at;
    private LocalDateTime updated_at;
    private String imageUrl;
    private List<String> images;
    private String categoryName;
    private String originName;
    private String unitName;

    public Item(int id, String sku, String name, String short_description, String long_description, int category_id, int origin_id, Unit unit, double price, double discount, int current_stock, int min_stock, LocalDateTime created_at, LocalDateTime updated_at) {
        this.id = id;
        this.sku = sku;
        this.name = name;
        this.short_description = short_description;
        this.long_description = long_description;
        this.category_id = category_id;
        this.origin_id = origin_id;
        this.unit = unit;
        this.price = price;
        this.discount = discount;
        this.current_stock = current_stock;
        this.min_stock = min_stock;
        this.created_at = created_at;
        this.updated_at = updated_at;
    }

    public Item(String sku, String name, String short_description, String long_description, int category_id, int origin_id, Unit unit, double price, double discount, int current_stock, int min_stock) {
        this.name = name;
        this.sku = sku;
        this.short_description = short_description;
        this.long_description = long_description;
        this.category_id = category_id;
        this.origin_id = origin_id;
        this.unit = unit;
        this.price = price;
        this.discount = discount;
        this.current_stock = current_stock;
        this.min_stock = min_stock;
    }

    public Item() {
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getOriginName() {
        return originName;
    }

    public void setOriginName(String originName) {
        this.originName = originName;
    }

    public String getUnitName() {
        return unitName;
    }

    public void setUnitName(String unitName) {
        this.unitName = unitName;
    }

    public LocalDateTime getUpdated_at() {
        return updated_at;
    }

    public void setUpdated_at(LocalDateTime updated_at) {
        this.updated_at = updated_at;
    }

    public LocalDateTime getCreated_at() {
        return created_at;
    }

    public void setCreated_at(LocalDateTime created_at) {
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

    public Unit getUnit() {
        return unit;
    }

    public void setUnit(Unit unit) {
        this.unit = unit;
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
        return this.id;
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

    public String getSku() {
        return sku;
    }

    public void setSku(String sku) {
        this.sku = sku;
    }

    public double getFinalPrice() {
        return price * (100 - discount) / 100;
    }

    public List<String> getImages() {
        return images;
    }

    public void setImages(List<String> images) {
        this.images = images;
    }
}
