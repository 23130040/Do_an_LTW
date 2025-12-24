package cleanmeat.model;

import java.time.LocalDate;

public class Unit {
    private int id;
    private String name;
    private double amount;
    private LocalDate created_at;
    private LocalDate updated_at;

    public Unit(int id, String name, double amount, LocalDate created_at, LocalDate updated_at) {
        this.id = id;
        this.name = name;
        this.amount = amount;
        this.created_at = created_at;
        this.updated_at = updated_at;
    }

    public Unit(String name, double amount) {
        this.name = name;
        this.amount = amount;
    }

}
