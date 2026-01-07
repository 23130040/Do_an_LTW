package cleanmeat.services;

import cleanmeat.dao.AddressDAO;
import cleanmeat.model.Address;

import java.sql.SQLException;
import java.util.List;

public class AddressService {
    private final AddressDAO addressDAO = new AddressDAO();

    public List<Address> getUserAddresses(int userId) {
        return addressDAO.findAllByUserId(userId);
    }

    public void addAddress(Address address) throws SQLException {
        if (address.isDefaultAddress()) {
            addressDAO.clearDefaultByUser(address.getUser().getId());
        }
        boolean success = addressDAO.insert(address);
        if (!success) {
            throw new RuntimeException("Failed to insert address");
        }
    }

    public void updateAddress(Address address, int addressId, int userId) {
        Address old = addressDAO.findById(address.getId());
        if (old == null || old.getUser().getId() != userId) {
            throw new RuntimeException("Không có quyền sửa địa chỉ này");
        }
        if (address.isDefaultAddress()) {
            addressDAO.clearDefaultByUser(userId);
        }
        addressDAO.update(address, addressId);
    }

    public void deleteAddress(int addressId, int userId) {
        Address address = addressDAO.findById(addressId);
        if (address == null || address.getUser().getId() != userId) {
            throw new RuntimeException("Không có quyền xóa địa chỉ này");
        }
        if (address.isDefaultAddress()) {
            throw new RuntimeException("Không thể xóa địa chỉ mặc định");
        }
        addressDAO.delete(addressId);
    }
}
