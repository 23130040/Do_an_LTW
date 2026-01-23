package cleanmeat.model;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Date;

public class News {
    private int id;
    private String title;
    private String author;
    private String picture_url;
    private String content;
    private String status;
    private LocalDateTime created_at;
    private LocalDateTime updated_at;
    private User created_by;


    public News(int id, String title, String author, String content, String status, LocalDateTime created_at, LocalDateTime updated_at, User created_by) {
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

    public News() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getPicture_url() {
        return picture_url;
    }

    public void setPicture_url(String picture_url) {
        this.picture_url = picture_url;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
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

    public User getCreated_by() {
        return created_by;
    }

    public void setCreated_by(User created_by) {
        this.created_by = created_by;
    }

}
