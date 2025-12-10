package vn.edu.hcmuaf.fit.do_an_ltw.model;

import java.time.LocalDate;

public class Notification {
    private int id;
    private User user;
    private String content;
    private String email;
    private String url;
    private LocalDate created_at;

    public Notification(int id, User user, String content, String email, String url, LocalDate created_at) {
        this.id = id;
        this.user = user;
        this.content = content;
        this.email = email;
        this.url = url;
        this.created_at = created_at;
    }

    public Notification(User user, String content, String email, String url) {
        this.user = user;
        this.content = content;
        this.email = email;
        this.url = url;
    }
}
