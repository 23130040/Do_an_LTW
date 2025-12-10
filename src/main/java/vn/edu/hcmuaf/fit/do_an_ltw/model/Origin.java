package vn.edu.hcmuaf.fit.do_an_ltw.model;

import java.time.LocalDate;

public class Origin {
    private int id;
    private String name;
    private String description;
    private LocalDate created_at;
    private LocalDate updated_at;

    public Origin(int id, String name, String description, LocalDate created_at, LocalDate updated_at) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.created_at = created_at;
        this.updated_at = updated_at;
    }

    public Origin(String name, String description) {
        this.name = name;
        this.description = description;
    }
}
