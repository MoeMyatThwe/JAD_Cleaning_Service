package com.cleaningService.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.cleaningService.util.DatabaseConnection;
public class FeedbackDAO {
	public boolean addFeedback(int userId, int serviceId, String comments) {
	    String sql = "INSERT INTO feedback (user_id, service_id, comments) VALUES (?, ?, ?)";

	    try (Connection connection = DatabaseConnection.connect();
	         PreparedStatement statement = connection.prepareStatement(sql)) {

	        statement.setInt(1, userId); // Use userId instead of customerId
	        statement.setInt(2, serviceId);
	        statement.setString(3, comments);

	        int rowsInserted = statement.executeUpdate();
	        return rowsInserted > 0;
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return false;
	}

}
