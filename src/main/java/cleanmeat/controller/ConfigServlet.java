package cleanmeat.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import cleanmeat.dao.ConfigDAO;
import cleanmeat.model.System_config;

import java.io.IOException;

@WebServlet(name = "ConfigServlet", value = "/cau-hinh-he-thong", loadOnStartup = 1)
public class ConfigServlet extends HttpServlet {
    private ConfigDAO configDAO = new ConfigDAO();

    @Override
    public void init() throws ServletException {
        System_config config = configDAO.getSystemConfig();
        getServletContext().setAttribute("globalConfig", config);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ConfigDAO configDAO = new ConfigDAO();
        System_config config = configDAO.getSystemConfig();

        request.setAttribute("config", config);
        request.getRequestDispatcher("/view/admin_cau_hinh_he_thong.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String idRaw = request.getParameter("id");
        String name = request.getParameter("webName");
        String email = request.getParameter("email");
        String hotline = request.getParameter("hotline");
        String tax_code = request.getParameter("taxCode");
        String facebook = request.getParameter("facebook");
        String instagram = request.getParameter("instagram");
        String address = request.getParameter("address");
        String logo_url = request.getParameter("logoUrl");

        System_config config = new System_config(
                0,
                name,
                email,
                hotline,
                tax_code,
                facebook,
                instagram,
                address,
                logo_url
        );

        ConfigDAO configDAO = new ConfigDAO();
        boolean success;

        if (configDAO.hasConfig()) {
            int id = (idRaw != null && !idRaw.isEmpty()) ? Integer.parseInt(idRaw) : 1;
            success = configDAO.update(config, id);
        } else {
            try {
                success = configDAO.insert(config);
            } catch (Exception e) {
                e.printStackTrace();
                success = false;
            }
        }

        if (success) {
            System_config newConfig = configDAO.getSystemConfig();

            getServletContext().setAttribute("globalConfig", newConfig);

            response.sendRedirect("cau-hinh-he-thong?status=success");
        } else {
            response.sendRedirect("cau-hinh-he-thong?status=error");
        }

    }
}