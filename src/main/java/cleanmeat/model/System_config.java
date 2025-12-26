package cleanmeat.model;

public class System_config {
    private int id;
    private String name;
    private String email;
    private String hotline;
    private String tax_code;
    private String facebook;
    private String instagram;
    private String address;
    private String logo_url;
    private User created_by;

    public System_config(int id, String name, String email, String hotline, String tax_code, String facebook, String instagram, String address, String logo_url, User created_by) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.hotline = hotline;
        this.tax_code = tax_code;
        this.facebook = facebook;
        this.instagram = instagram;
        this.address = address;
        this.logo_url = logo_url;
        this.created_by = created_by;
    }

    public System_config(int id, String name, String email, String hotline, String tax_code, String facebook, String instagram, String address, String logo_url) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.hotline = hotline;
        this.tax_code = tax_code;
        this.facebook = facebook;
        this.instagram = instagram;
        this.address = address;
        this.logo_url = logo_url;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getHotline() {
        return hotline;
    }

    public void setHotline(String hotline) {
        this.hotline = hotline;
    }

    public String getTax_code() {
        return tax_code;
    }

    public void setTax_code(String tax_code) {
        this.tax_code = tax_code;
    }

    public String getFacebook() {
        return facebook;
    }

    public void setFacebook(String facebook) {
        this.facebook = facebook;
    }

    public String getInstagram() {
        return instagram;
    }

    public void setInstagram(String instagram) {
        this.instagram = instagram;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getLogo_url() {
        return logo_url;
    }

    public void setLogo_url(String logo_url) {
        this.logo_url = logo_url;
    }

    public User getCreated_by() {
        return created_by;
    }

    public void setCreated_by(User created_by) {
        this.created_by = created_by;
    }
}
