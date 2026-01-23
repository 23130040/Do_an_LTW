package cleanmeat.controller;

import cleanmeat.model.Stock_history;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import cleanmeat.model.User;
import cleanmeat.dao.UserDAO;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

@MultipartConfig
@WebServlet(name = "UserServlet", value = "/quan-ly-nguoi-dung")
public class UserServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        String searchKeyword = request.getParameter("search");
        String filterRole = request.getParameter("role");

        if ("edit".equals(action)) {
            int idToEdit = Integer.parseInt(request.getParameter("id"));
            User user = userDAO.findById(idToEdit);

            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            if (user != null) {
                out.write(userToJson(user));
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                out.write("{\"error\": \"User not found\"}");
            }
        } else if ("delete".equals(action)) {
            doDelete(request, response);
        }

            int page = 1;
            int pageSize = 5;

            String pageParam = request.getParameter("page");
            if (pageParam != null) {
                try {
                    page = Integer.parseInt(pageParam);
                    if (page < 1) page = 1;
                } catch (NumberFormatException ignored) {}
            }

            List<User> list = userDAO.searchAndFilter( searchKeyword, filterRole, page, pageSize);
            int totalRecords = userDAO.countFilteredUsers( searchKeyword, filterRole);
            int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

            int windowSize = 5;
            int half = windowSize / 2;

// Tính startPage sao cho currentPage nằm giữa
            int startPage = page - half;
            if (startPage < 1) {
                startPage = 1;
            }

// Chặn biên phải để luôn thấy trang cuối
            if (startPage + windowSize - 1 > totalPages) {
                startPage = Math.max(1, totalPages - windowSize + 1);
            }

            int endPage = Math.min(totalPages, startPage + windowSize - 1);

            request.setAttribute("users", list);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("startPage", startPage);
            request.setAttribute("endPage", endPage);

            request.setAttribute("searchKeyword", searchKeyword);
            request.setAttribute("filterRole", filterRole);

            request.getRequestDispatcher("/view/admin_quan_ly_user.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            insertUser(request, response);
        } else if ("update".equals(action)) {
            updateUser(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action or missing parameter.");
        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int idToDelete = Integer.parseInt(request.getParameter("id"));

            if (userDAO.delete(idToDelete)) {
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write("Xóa người dùng thành công.");
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("Lỗi: Không thể xóa người dùng.");
            }
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Lỗi: ID người dùng không hợp lệ.");
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Lỗi hệ thống khi xóa người dùng: " + e.getMessage());
        }
    }


    private void insertUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            HttpSession session = request.getSession(false);

            Boolean emailVerified = (session != null)
                    ? (Boolean) session.getAttribute("EMAIL_VERIFIED")
                    : null;

            String verifiedEmail = (session != null)
                    ? (String) session.getAttribute("VERIFIED_EMAIL")
                    : null;

            String email = request.getParameter("userEmail");

            if (emailVerified == null || !emailVerified || verifiedEmail == null
                    || !email.equalsIgnoreCase(verifiedEmail)) {

                response.setContentType("text/plain; charset=UTF-8");
                response.getWriter().write("EMAIL_NOT_VERIFIED");
                return;
            }

            User newUser = new User();
            newUser.setName(request.getParameter("userName"));
            newUser.setEmail(email);
            newUser.setPassword(request.getParameter("userPassword"));
            newUser.setPhone(request.getParameter("userPhone"));
            newUser.setRole(request.getParameter("userRole"));
            newUser.setStatus(true);
            newUser.setGender("");
            newUser.setBirthday(null);
            newUser.setAvatar("");

            if (userDAO.insert(newUser)) {
                session.removeAttribute("EMAIL_VERIFIED");
                session.removeAttribute("OTP_EMAIL");

                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write("SUCCESS");
                return;
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                        "Không thể thêm người dùng");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Lỗi khi thêm người dùng");
        }

    }

    private void updateUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu ID người dùng.");
                return;
            }
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("userName");
            String email = request.getParameter("userEmail");
            String phone = request.getParameter("userPhone");
            String role = request.getParameter("userRole");
            String newPassword = request.getParameter("userPassword");
            String statusParam = request.getParameter("userStatus");

            User existingUser = userDAO.findById(id);

            if (existingUser != null) {
                existingUser.setName(name);
                existingUser.setEmail(email);
                existingUser.setPhone(phone);
                existingUser.setRole(role);

                existingUser.setStatus("on".equalsIgnoreCase(statusParam));

                if (newPassword != null && !newPassword.isEmpty()) {
                    existingUser.setPassword(newPassword);
                }

                if (userDAO.update(existingUser, id)) {
                    response.getWriter().write("SUCCESS");
                } else {
                    response.getWriter().write("Lỗi: Không thể cập nhật người dùng.");
                }
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Lỗi: Người dùng không tồn tại.");
            }
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi cập nhật người dùng: " + e.getMessage());
        }
    }

    private String userToJson(User user) {
        if (user == null) return "{}";
        return String.format(
                "{\"id\": %d, \"name\": \"%s\", \"email\": \"%s\", \"phone\": \"%s\", \"role\": \"%s\", \"status\": %b}",
                user.getId(), user.getName(), user.getEmail(), user.getPhone(), user.getRole(), user.isStatus()
        );
    }
}