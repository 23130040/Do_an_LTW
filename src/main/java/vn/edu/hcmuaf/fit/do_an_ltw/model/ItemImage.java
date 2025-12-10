package vn.edu.hcmuaf.fit.do_an_ltw.model;

import java.time.LocalDateTime;

public class ItemImage {
    private int id;
    private Item item;
    private String url;
    private boolean is_primary;
    private LocalDateTime created_at;

    public ItemImage(int id, Item item, String url, boolean is_primary, LocalDateTime created_at) {
        this.id = id;
        this.item = item;
        this.url = url;
        this.is_primary = is_primary;
        this.created_at = created_at;
    }
    public ItemImage(Item item, String url, boolean is_primary) {
        this.item = item;
        this.url = url;
        this.is_primary = is_primary;
    }
}
