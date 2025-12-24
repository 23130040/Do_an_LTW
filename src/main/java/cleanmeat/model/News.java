package cleanmeat.model;

import java.time.LocalDate;

public class News {
    private int id;
    private String title;
    private String author;
    private String picture_url;
    private String content;
    private String status;
    private LocalDate created_at;
    private LocalDate updated_at;
    private User created_by;

    public News(int id, String title, String author, String content, String status, LocalDate created_at, LocalDate updated_at, User created_by) {
        this.id = id;
        this.title = title;
        this.author = author;
        this.content = content;
        this.status = status;
        this.created_at = created_at;
        this.updated_at = updated_at;
        this.created_by = created_by;
    }

    public News(String title, String author, String content, String status, User created_by) {
        this.title = title;
        this.author = author;
        this.content = content;
        this.status = status;
        this.created_by = created_by;
    }
}
