package cleanmeat.services;

import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import java.util.Properties;
import jakarta.mail.Authenticator;


public class EmailService {

    private static final String FROM_EMAIL = "nmhau2410@gmail.com";
    private static final String APP_PASSWORD = "urzt aoyy weyc tnvk";

    public static void sendOTP(String toEmail, String otp) {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props,
                new Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(FROM_EMAIL, APP_PASSWORD);
                    }
                });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL));
            message.setRecipients(
                    Message.RecipientType.TO,
                    InternetAddress.parse(toEmail)
            );
            message.setSubject("Your OTP Code");

            message.setContent(
                    "<h3>Mã OTP của bạn</h3>"
                            + "<b>" + otp + "</b><br>"
                            + "OTP có hiệu lực trong 5 phút.",
                    "text/html; charset=UTF-8"
            );

            Transport.send(message);

        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }

}

