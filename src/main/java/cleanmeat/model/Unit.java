package cleanmeat.model;

import java.time.LocalDateTime;

public class Unit {
    private int id;
    private String name;
    private int amount;
    private LocalDateTime created_at;
    private LocalDateTime updated_at;

    public Unit(int id, String name, int amount, LocalDateTime created_at, LocalDateTime updated_at) {
        this.id = id;
        this.name = name;
        this.amount = amount;
        this.created_at = created_at;
        this.updated_at = updated_at;
    }

    public Unit(String name, int amount) {
        this.name = name;
        this.amount = amount;
    }

    public Unit() {
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

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public LocalDateTime getCreated_at() {
        return created_at;
    }

    public void setCreated_at(LocalDateTime created_at) {
        this.created_at = created_at;
    }

    public LocalDateTime getUpdated_at() {
        return updated_at;
    }

    public void setUpdated_at(LocalDateTime updated_at) {
        this.updated_at = updated_at;
    }
}
