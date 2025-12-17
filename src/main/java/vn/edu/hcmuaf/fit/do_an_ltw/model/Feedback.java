package vn.edu.hcmuaf.fit.do_an_ltw.model;

import java.time.LocalDateTime;

public class Feedback {
    private int id;
    private int response_id;
    private User user;
    private int item_id_raw;
    private int rating;
    private String comment;
    private LocalDateTime created_at;
    private LocalDateTime updated_at;


    public Feedback(int id, int response_id, User user, int item_id, int rating, String comment,LocalDateTime created_at, LocalDateTime updated_at) {
        this.id = id;
        this.response_id = response_id;
        this.user = user;
        this.item_id_raw = item_id;
        this.rating = rating;
        this.comment = comment;
        this.created_at = created_at;
        this.updated_at = updated_at;
    }

    public int getId() { return id; }
    public int getItem_id_raw() { return item_id_raw; }
    public User getUser() { return user; }
    public String getComment() { return comment; }
    public int getRating() { return rating; }
    public LocalDateTime getCreated_at() { return created_at; }
    public int getResponse_id() { return response_id; }

}

