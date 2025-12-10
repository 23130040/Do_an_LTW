package vn.edu.hcmuaf.fit.do_an_ltw.model;

import java.time.LocalDate;

public class Address {
    private int id;
    private User user;
    private String address;
    private boolean is_Default;
    private LocalDate created_at;
    private LocalDate updated_at;

    public Address(User user, String address, boolean is_Default){
        this.user = user;
        this.address = address;
        this.is_Default = is_Default;
    }
    public Address(int id, User user, String address, boolean is_Default, LocalDate created_at, LocalDate updated_at){
        this.id = id;
        this.user = user;
        this.address = address;
        this.is_Default = is_Default;
        this.created_at = created_at;
        this.updated_at = updated_at;
    }
}
