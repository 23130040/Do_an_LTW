package cleanmeat.model;

import java.time.LocalDate;

public class Feedback {
    private int id;
    private int response_id;
    private User user;
    private Item item;
    private int rating;
    private String comment;
    private LocalDate created_at;
    private LocalDate updated_at;

    public Feedback(int id, int response_id, User user, Item item, int rating, String comment, LocalDate created_at, LocalDate updated_at) {
        this.id = id;
        this.response_id = response_id;
        this.user = user;
        this.item = item;
        this.rating = rating;
        this.comment = comment;
        this.created_at = created_at;
        this.updated_at = updated_at;
    }
    public Feedback(int id, int response_id, User user, Item item, int rating, String comment) {
        this.id = id;
        this.response_id = response_id;
        this.user = user;
        this.item = item;
        this.rating = rating;
        this.comment = comment;
    }
}
