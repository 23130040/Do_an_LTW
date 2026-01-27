package cleanmeat.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import cleanmeat.model.User;
import cleanmeat.dao.UserDAO;
import cleanmeat.security.HashUtil;


import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.util.List;

@MultipartConfig
@WebServlet(name = "UserServlet", value = "/quan-ly-nguoi-dung")
public class UserServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        User currentUser = (User) session.getAttribute("user");

        String action = request.getParameter("action");

        String searchKeyword = request.getParameter("search");
        String filterRole = request.getParameter("role");
        String filterStatusRaw = request.getParameter("status");
        Boolean filterStatus = null;

        if ("1".equals(filterStatusRaw)) {
            filterStatus = true;
        } else if ("0".equals(filterStatusRaw)) {
            filterStatus = false;
        }

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
        }else {


            int page = 1;
            int pageSize = 5;

            String pageParam = request.getParameter("page");
            if (pageParam != null) {
                try {
                    page = Integer.parseInt(pageParam);
                    if (page < 1) page = 1;
                } catch (NumberFormatException ignored) {
                }
            }

            List<User> list = userDAO.searchAndFilter( searchKeyword, filterRole, filterStatus, page, pageSize);
            int totalRecords = userDAO.countFilteredUsers( searchKeyword, filterRole);
            int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

            int windowSize = 5;
            int half = windowSize / 2;

            int startPage = page - half;
            if (startPage < 1) {
                startPage = 1;
            }

            if (startPage + windowSize - 1 > totalPages) {
                startPage = Math.max(1, totalPages - windowSize + 1);
            }

            int endPage = Math.min(totalPages, startPage + windowSize - 1);

            request.setAttribute("currentUser", currentUser);
            request.setAttribute("users", list);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("startPage", startPage);
            request.setAttribute("endPage", endPage);

            request.setAttribute("searchKeyword", searchKeyword);
            request.setAttribute("filterRole", filterRole);

            request.getRequestDispatcher("/view/admin_quan_ly_user.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            insertUser(request, response);
        } else if ("update".equals(action)) {
            updateUser(request, response);
        }
        else if ("updateStatus".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                boolean status = Boolean.parseBoolean(request.getParameter("status"));

                boolean success = userDAO.updateStatus(id, status);

                response.setContentType("text/plain");
                response.setCharacterEncoding("UTF-8");
                if (success) {
                    response.getWriter().write("SUCCESS");
                } else {
                    response.getWriter().write("ERROR");
                }
            } catch (Exception e) {
                response.getWriter().write("ERROR_EXCEPTION");
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action or missing parameter.");
        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/plain; charset=UTF-8");
        try {
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("ID không được để trống");
                return;
            }

            int idToDelete = Integer.parseInt(idStr);

            if (userDAO.delete(idToDelete)) {
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write("SUCCESS");
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("Không tìm thấy người dùng hoặc lỗi CSDL");
            }
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Định dạng ID không hợp lệ");
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Lỗi hệ thống: " + e.getMessage());
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

            String rawPassword = request.getParameter("userPassword");
            if (rawPassword == null || rawPassword.isEmpty()) {
                response.getWriter().write("PASSWORD_REQUIRED");
                return;
            }
            String birthdayStr = request.getParameter("birthday");

            LocalDate birthday = null;
            if (birthdayStr != null && !birthdayStr.isEmpty()) {
                birthday = LocalDate.parse(birthdayStr);
            }
            String gender = request.getParameter("gender");

            String hashedPassword = HashUtil.md5(rawPassword);
            User newUser = new User();
            newUser.setName(request.getParameter("userName"));
            newUser.setEmail(email);
            newUser.setPassword(hashedPassword);
            newUser.setPhone(request.getParameter("userPhone"));
            String phone = request.getParameter("userPhone");

            if (phone == null || phone.isBlank()) {
                response.getWriter().write("PHONE_REQUIRED");
                return;
            }

            if (!phone.matches("^0\\d{9}$")) {
                response.getWriter().write("PHONE_INVALID");
                return;
            }

            if (userDAO.isPhoneExists(phone)) {
                response.getWriter().write("PHONE_EXISTS");
                return;
            }
            newUser.setRole(request.getParameter("userRole"));
            newUser.setStatus(true);
            newUser.setEmail_verified(true);
            newUser.setGender(gender);
            newUser.setBirthday(birthday);
            newUser.setAvatar("");

            if (userDAO.insert(newUser)) {
                session.removeAttribute("EMAIL_VERIFIED");
                session.removeAttribute("OTP_EMAIL");

                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write("SUCCESS");
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

            if (!phone.matches("^0\\d{9}$")) {
                response.getWriter().write("PHONE_INVALID");
                return;
            }

            User oldUser = userDAO.findById(id);

            if (!phone.equals(oldUser.getPhone())
                    && userDAO.isPhoneExists(phone)) {
                response.getWriter().write("PHONE_EXISTS");
                return;
            }

            String role = request.getParameter("userRole");
            String newPassword = request.getParameter("userPassword");
            String statusParam = request.getParameter("userStatus");

            User existingUser = userDAO.findById(id);

            if (existingUser != null) {
                existingUser.setName(name);
                existingUser.setEmail(email);
                existingUser.setPhone(phone);
                existingUser.setRole(role);


                if (newPassword != null && !newPassword.isEmpty()) {
                    String hashedPassword = HashUtil.md5(newPassword);
                    existingUser.setPassword(hashedPassword);
                }

                if (userDAO.update(existingUser, id)) {
                    String currentPage = request.getParameter("currentPage");
                    if (currentPage == null || currentPage.isEmpty()) {
                        currentPage = "1";
                    }
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