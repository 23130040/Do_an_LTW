package cleanmeat.filter;

import cleanmeat.model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter(urlPatterns = {"/quan-ly-san-pham", "/quan-ly-nguoi-dung", "/quan-ly-danh-muc", "/quan-ly-tin-tuc", "/quan-ly-danh-gia",
        "/cau-hinh-he-thong", "/quan-ly-kho", "/quan-ly-don-hang", "/thong-ke", "/admin-thong-tin-tai-khoan",
                "/admin-doi-mat-khau"})
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
        }
        else if (user != null) {
            // Đã login nhưng KHÔNG PHẢI ADMIN

            // Lưu flag để hiển thị modal
            session.setAttribute("ROLE_ERROR", true);

            // Quay về trang trước đó (an toàn)
            String referer = httpRequest.getHeader("Referer");

            if (referer != null && !referer.contains("/quan-ly")) {
                httpResponse.sendRedirect(referer);
            } else {
                // fallback an toàn
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/trang-chu");
            }
            return;
        }

        else {
            // CHƯA LOGIN
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/dang-nhap");
        }

    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void destroy() {}
}