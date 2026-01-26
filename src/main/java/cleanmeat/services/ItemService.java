package cleanmeat.services;

import cleanmeat.dao.ItemDAO;
import cleanmeat.model.Item;

public class ItemService {
    ItemDAO itemDAO = new ItemDAO();

    public Item getItemById(int id) {
        Item item = itemDAO.findById(id);
        if (item == null)
            throw new RuntimeException("Không tìm thấy sản phẩm");
        return item;
    }
}
