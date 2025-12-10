package vn.edu.hcmuaf.fit.do_an_ltw.model;

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

    public System_config(int id, String name, String emain, String hotline, String tax_code, String facebook, String instagram, String address, String logo_url, User created_by) {
        this.id = id;
        this.name = name;
        this.email = emain;
        this.hotline = hotline;
        this.tax_code = tax_code;
        this.facebook = facebook;
        this.instagram = instagram;
        this.address = address;
        this.logo_url = logo_url;
        this.created_by = created_by;
    }

}
