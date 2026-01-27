package cleanmeat.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@WebServlet(name = "GoogleLoginServlet", value = "/login-google")
public class GoogleLoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        String googleAuthUrl =
                "https://accounts.google.com/o/oauth2/v2/auth"
                        + "?client_id=584195356550-29lvjiudmg5i41sl38ubhgqtmakv3c8t.apps.googleusercontent.com"
                        + "&redirect_uri=" + URLEncoder.encode(
                        req.getScheme() + "://" + req.getServerName() + ":" +
                                req.getServerPort() + req.getContextPath() + "/login-google-callback",
                        StandardCharsets.UTF_8)
                        + "&response_type=code"
                        + "&scope=email%20profile";


        resp.sendRedirect(googleAuthUrl);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}