package cleanmeat.model;

import java.time.LocalDate;

public class Unit {
    private int id;
    private String name;
    private int amount;
    private LocalDate created_at;
    private LocalDate updated_at;

    public Unit(int id, String name, int amount, LocalDate created_at, LocalDate updated_at) {
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

    public double getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
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
