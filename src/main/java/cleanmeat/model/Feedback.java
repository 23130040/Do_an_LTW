package cleanmeat.model;

import java.time.LocalDateTime;

public class Feedback {
    private int id;
    private int response_id;
    private User user;
    private int item_id;
    private String item_name;
    private int rating;
    private String comment;
    private LocalDateTime created_at;
    private LocalDateTime updated_at;
    private boolean isReplied;


    public Feedback(int id, int response_id, User user, int item_id, int rating, String comment,LocalDateTime created_at, LocalDateTime updated_at) {
        this.id = id;
        this.response_id = response_id;
        this.user = user;
        this.item_id = item_id;
        this.rating = rating;
        this.comment = comment;
        this.created_at = created_at;
        this.updated_at = updated_at;
    }

    public int getId() { return id; }
    public int getItem_id() { return item_id; }
    public User getUser() { return user; }
    public String getComment() { return comment; }
    public int getRating() { return rating; }
    public LocalDateTime getCreated_at() { return created_at; }
    public int getResponse_id() { return response_id; }
    public boolean isReplied() {
        return isReplied;
    }
    public void setReplied(boolean replied) {
        isReplied = replied;
    }
    public String getItem_name() { return item_name; }
    public void setItem_name(String item_name) { this.item_name = item_name; }

}

