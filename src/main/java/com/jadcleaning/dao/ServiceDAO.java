package com.jadcleaning.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.jadcleaning.models.Service;
import com.jadcleaning.util.DatabaseConnection;

public class ServiceDAO {
    public List<Service> getAllServices() throws Exception {
        List<Service> services = new ArrayList<>();
        String query = "SELECT * FROM service";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Service service = new Service();
                service.setId(rs.getInt("service_id"));
                service.setName(rs.getString("service_name"));
                service.setDescription(rs.getString("description"));
                service.setPrice(rs.getDouble("price"));
                services.add(service);
            }
        }
        return services;
    }
}
