package vn.edu.hcmuaf.fit.do_an_ltw.dao;

import vn.edu.hcmuaf.fit.do_an_ltw.model.User;

import java.util.List;
import java.util.Map;

public class test {
    public static void main(String[] args) {
        System.out.println("--- BẮT ĐẦU KIỂM TRA USERDAO ---");

        UserDAO userDAO = new UserDAO();
        System.out.println("Đã khởi tạo UserDAO và tải dữ liệu từ DB.");

        Map<Integer, User> loadedUsersMap = UserDAO.users;
        int userCount = loadedUsersMap.size();

        System.out.println("\nTổng số người dùng đã tải (từ HashMap): " + userCount);

        if (userCount > 0) {
            System.out.println("\n--- Chi tiết Người dùng đầu tiên (Key=1) ---");
            User firstUser = loadedUsersMap.get(1);

            if (firstUser != null) {
                System.out.println("ID: " + firstUser.getId());
                System.out.println("Tên: " + firstUser.getName());
                System.out.println("Email: " + firstUser.getEmail());
                System.out.println("Ngày sinh: " + firstUser.getBirthday());
                System.out.println("Trạng thái (Status): " + firstUser.isStatus());
            } else {
                System.out.println("Không tìm thấy người dùng với ID=1 trong HashMap.");
            }

            List<User> allUsersList = userDAO.findAll();
            if (!allUsersList.isEmpty()) {
                System.out.println("\n--- Kiểm tra phương thức findAll() ---");
                System.out.println("Số lượng từ findAll(): " + allUsersList.size());
            }

        } else {
            System.out.println("\n*** CẢNH BÁO: HashMap users rỗng. Hãy kiểm tra lại kết nối DB và dữ liệu trong bảng user. ***");
        }

        ConnectionPool.getInstance().closePool();
        System.out.println("\nĐã đóng Connection Pool.");
        System.out.println("--- KẾT THÚC KIỂM TRA ---");
    }
}