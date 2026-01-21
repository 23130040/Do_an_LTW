package cleanmeat.model;

import java.time.LocalDateTime;

public class ItemImage {
    private int id;
    private int itemId;
    private String url;
    private boolean is_primary;
    private LocalDateTime created_at;

    public ItemImage(int id, int itemId, String url, boolean is_primary, LocalDateTime created_at) {
        this.id = id;
        this.itemId = itemId;
        this.url = url;
        this.is_primary = is_primary;
        this.created_at = created_at;
    }
    public ItemImage(int itemId, String url, boolean is_primary) {
        this.itemId = itemId;
        this.url = url;
        this.is_primary = is_primary;
    }

    public ItemImage() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getItemId() {
        return itemId;
    }

    public void setItemId(int itemId) {
        this.itemId = itemId;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public boolean isIs_primary() {
        return is_primary;
    }

    public void setIs_primary(boolean is_primary) {
        this.is_primary = is_primary;
    }

    public LocalDateTime getCreated_at() {
        return created_at;
    }

    public void setCreated_at(LocalDateTime created_at) {
        this.created_at = created_at;
    }
}
