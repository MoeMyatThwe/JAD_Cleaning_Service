package com.cleaningService.dao;

import com.jadcleaning.model.SubService;
import com.jadcleaning.util.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class SubServiceDAO {

    public SubService getSubServiceById(int subServiceId) {
        SubService subService = null;
        String query = "SELECT * FROM sub_service WHERE sub_service_id = ?";

        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setInt(1, subServiceId);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                subService = new SubService();
                subService.setId(resultSet.getInt("sub_service_id"));
                subService.setName(resultSet.getString("sub_service_name"));
                subService.setDescription(resultSet.getString("description"));
                subService.setPrice(resultSet.getDouble("price"));
                subService.setImage(resultSet.getString("image"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return subService;
    }
}
