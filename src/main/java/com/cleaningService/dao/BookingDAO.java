package com.cleaningService.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Time;

import com.cleaningService.util.DatabaseConnection;

public class BookingDAO {
    public boolean createBooking(int userId, int serviceId, int subServiceId, String date, String time, int duration, String serviceAddress, String specialRequest) {
        String sql = "INSERT INTO booking (user_id, service_id, sub_service_id, date, time, duration, service_address, special_request) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(sql)) {

         
            Date sqlDate = Date.valueOf(date); 
            Time sqlTime = Time.valueOf(time + ":00"); 

            statement.setInt(1, userId);
            statement.setInt(2, serviceId);
            statement.setInt(3, subServiceId);
            statement.setDate(4, sqlDate);
            statement.setTime(5, sqlTime);
            statement.setInt(6, duration);
            statement.setString(7, serviceAddress);
            statement.setString(8, specialRequest);

            int rowsInserted = statement.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
