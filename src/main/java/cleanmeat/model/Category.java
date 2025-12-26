package cleanmeat.model;

import java.sql.Timestamp;
import java.time.LocalDate;

public class Category {
    private int id;
    private String name;
    private String description;
    private LocalDate created_at;
    private LocalDate updated_at;

    public Category(int id, String name, String description, LocalDate created_at, LocalDate updated_at) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.created_at = created_at;
        this.updated_at = updated_at;
    }

    public Category(String name, String description) {
        this.name = name;
        this.description = description;
    }

    public Category() {
    }

    public Category(int id, String name, String description, Timestamp createdAt, Timestamp updatedAt) {
        this.id = id;
        this.name = name;
        this.description = description;
        // Chuyển đổi Timestamp sang LocalDate (theo Model hiện tại của bạn)
        this.created_at = createdAt != null ? createdAt.toLocalDateTime().toLocalDate() : null;
        this.updated_at = updatedAt != null ? updatedAt.toLocalDateTime().toLocalDate() : null;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public LocalDate getCreated_at() {
        return created_at;
    }

    public void setCreated_at(LocalDate created_at) {
        this.created_at = created_at;
    }

    public LocalDate getUpdated_at() {
        return updated_at;
    }

    public void setUpdated_at(LocalDate updated_at) {
        this.updated_at = updated_at;
    }
}
