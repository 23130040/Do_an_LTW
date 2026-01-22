package cleanmeat.filter;

import cleanmeat.model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter(urlPatterns = {})
//"/quanlysanpham", "/quanlyuser", "/quanlydanhmuc", "/quanlytintuc", "/quanlydanhgia", "/cauhinhhethong",
//        "/quanlykho"
public class AdminFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession();

        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user != null && "admin".equalsIgnoreCase(user.getRole())) {
            chain.doFilter(request, response);
        } else {
            String requestURI = httpRequest.getRequestURI();
            String queryString = httpRequest.getQueryString();
            String targetURL = requestURI + (queryString != null ? "?" + queryString : "");

            session.setAttribute("redirect_url", targetURL);

            httpResponse.sendRedirect(httpRequest.getContextPath() + "/dang-nhap");
        }
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void destroy() {}
}