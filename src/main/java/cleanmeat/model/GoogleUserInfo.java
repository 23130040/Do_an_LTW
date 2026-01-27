package cleanmeat.model;

public class GoogleUserInfo {
    private String id;
    private String email;
    private boolean verified_email;
    private String name;
    private String picture;

    public String getEmail() { return email; }
    public String getName() { return name; }
    public String getPicture() { return picture; }
    public boolean isEmailVerified() { return verified_email; }
}