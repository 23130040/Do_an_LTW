package vn.edu.hcmuaf.fit.do_an_ltw.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.do_an_ltw.model.User;
import vn.edu.hcmuaf.fit.do_an_ltw.dao.UserDAO;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "UserServlet", value = "/quanlyuser")
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
        } else {
            final int RECORDS_PER_PAGE = 9;
            int currentPage = 1;
            String pageParam = request.getParameter("page");

            if (pageParam != null) {
                try {
                    currentPage = Integer.parseInt(pageParam);
                } catch (NumberFormatException e) {
                    currentPage = 1;
                }
            }
            if (currentPage < 1) currentPage = 1;

            List<User> fullFilteredList;

            if ((searchKeyword != null && !searchKeyword.isEmpty()) || (filterRole != null && !filterRole.isEmpty())) {
                fullFilteredList = userDAO.searchAndFilter(searchKeyword, filterRole);
            } else {
                fullFilteredList = userDAO.findAll();
            }

            int noOfRecords = fullFilteredList.size();
            int noOfPages = (int) Math.ceil((double) noOfRecords / RECORDS_PER_PAGE);

            if (noOfPages == 0) noOfPages = 1;

            int offset = (currentPage - 1) * RECORDS_PER_PAGE;

            if (offset >= noOfRecords && noOfRecords > 0) {
                currentPage = noOfPages;
                offset = (currentPage - 1) * RECORDS_PER_PAGE;
            }

            List<User> list = new ArrayList<>();

            if (noOfRecords > 0) {
                int start = Math.min(offset, noOfRecords);

                int end = Math.min(start + RECORDS_PER_PAGE, noOfRecords);

                if (start < end) {
                    try {
                        list = fullFilteredList.subList(start, end);
                    } catch (IndexOutOfBoundsException e) {
                        System.err.println("Lỗi Index khi phân trang: " + e.getMessage());
                        list = new ArrayList<>();
                    }
                } else {
                    list = new ArrayList<>();
                }
            }

            request.setAttribute("users", list);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("noOfPages", noOfPages);
            request.setAttribute("noOfRecords", noOfRecords);

            request.setAttribute("searchKeyword", searchKeyword);
            request.setAttribute("filterRole", filterRole);

            request.getRequestDispatcher("admin_quan_ly_user.jsp").forward(request, response);
        }
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

            if (userDAO.delete(null, idToDelete)) {
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

            String name = request.getParameter("userName");
            String email = request.getParameter("userEmail");
            String password = request.getParameter("userPassword");
            String phone = request.getParameter("userPhone");
            String role = request.getParameter("userRole");

            User newUser = new User();
            newUser.setName(name);
            newUser.setEmail(email);
            newUser.setPassword(password);
            newUser.setPhone(phone);
            newUser.setRole(role);
            newUser.setGender("");
            newUser.setBirthday(null);
            newUser.setAvatar("");

            newUser.setStatus(true);

            if (userDAO.insert(newUser)) {
                response.sendRedirect(request.getContextPath() + "/quanlyuser");
            } else {
                response.getWriter().write("Lỗi: Không thể thêm người dùng vào database.");
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi thêm người dùng: " + e.getMessage());
        }
    }

    private void updateUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
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
                    response.sendRedirect(request.getContextPath() + "/quanlyuser");
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