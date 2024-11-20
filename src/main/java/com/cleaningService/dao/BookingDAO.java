package com.cleaningService.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.cleaningService.util.DatabaseConnection;

public class BookingDAO {
    public boolean createBooking(int userId, int subServiceId, String date, String time, int duration, String serviceAddress, String specialRequest) {
        String sql = "INSERT INTO booking (user_id, sub_service_id, date, time, duration, service_address, special_request, created_at) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP)";

        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, userId);
            statement.setInt(2, subServiceId);
            statement.setString(3, date);
            statement.setString(4, time);
            statement.setInt(5, duration);
            statement.setString(6, serviceAddress);
            statement.setString(7, specialRequest);

            int rowsInserted = statement.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
