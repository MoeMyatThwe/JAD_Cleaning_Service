package com.cleaningService.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.cleaningService.util.DatabaseConnection;

public class FeedbackDAO {
    public boolean addFeedback(int userId, int bookingId, int subServiceId, String comments, int rating) {
        String sql = "INSERT INTO feedback (user_id, booking_id, sub_service_id, comments, rating) VALUES (?, ?, ?, ?, ?)";

        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, userId);
            statement.setInt(2, bookingId);
            statement.setInt(3, subServiceId);
            statement.setString(4, comments);
            statement.setInt(5, rating);

            int rowsInserted = statement.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
