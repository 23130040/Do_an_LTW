package cleanmeat.services;

public class OtpData {
    private String otp;
    private long expireAt;

    public OtpData(String otp, long expireAt) {
        this.otp = otp;
        this.expireAt = expireAt;
    }

    public String getOtp() {
        return otp;
    }

    public long getExpireAt() {
        return expireAt;
    }

    public boolean isExpired() {
        return System.currentTimeMillis() > expireAt;
    }
}

