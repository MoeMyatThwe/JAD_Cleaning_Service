package com.cleaningService.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.jadcleaning.util.DatabaseConnection;

public class BookingDAO {
	public boolean createBooking(int userId, int subServiceId, String specialRequest) {
	    String sql = "INSERT INTO booking (user_id, sub_service_id, special_request) VALUES (?, ?, ?)";

	    try (Connection connection = DatabaseConnection.connect();
	         PreparedStatement statement = connection.prepareStatement(sql)) {

	        statement.setInt(1, userId); // Use userId instead of customerId
	        statement.setInt(2, subServiceId);
	        statement.setString(3, specialRequest);

	        int rowsInserted = statement.executeUpdate();
	        return rowsInserted > 0;
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return false;
	}

}
