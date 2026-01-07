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
        int userId = address.getUser().getId();
        boolean isFirst = getUserAddresses(userId).isEmpty();
        addressDAO.insert(address);
        if (isFirst) {
            addressDAO.setDefaultByUser(userId, address.getId());
        }
    }

    public void setAddressDefault(int userId, int addressId) {
        addressDAO.setDefaultByUser(userId, addressId);
    }

    public void updateAddress(Address address, int addressId, int userId) {
        Address old = addressDAO.findById(addressId);
        if (old == null || old.getUser().getId() != userId) {
            throw new RuntimeException("Không có quyền sửa địa chỉ này");
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

    public Address getAddressById(int addressId) {
        return addressDAO.findById(addressId);
    }
}
