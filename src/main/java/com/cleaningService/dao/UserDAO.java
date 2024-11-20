package com.cleaningService.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;

import com.jadcleaning.util.DatabaseConnection;
import com.jadcleaning.model.User;
import org.mindrot.jbcrypt.BCrypt;

public class UserDAO {

	// Method to register a user
	public boolean registerUser(User user) {
	    boolean isUserRegistered = false;
	    String sql = "INSERT INTO users (name, email, password) VALUES (?, ?, ?)";

	    String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
	    try (Connection connection = DatabaseConnection.connect();
	         PreparedStatement statement = connection.prepareStatement(sql)) {

	        statement.setString(1, user.getName());
	        statement.setString(2, user.getEmail());
	        statement.setString(3, hashedPassword);

	        int rowsInserted = statement.executeUpdate();
	        if (rowsInserted > 0) {
	            isUserRegistered = true;
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return isUserRegistered;
	}


    // Method to fetch user details by email
    public User getUserByEmail(String email) {
        String sql = "SELECT id, name, email, password, role FROM users WHERE email = ?";
        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, email);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                User user = new User();
                user.setId(resultSet.getInt("id"));
                user.setName(resultSet.getString("name"));
                user.setEmail(resultSet.getString("email"));
                user.setPassword(resultSet.getString("password")); // Hashed password
                user.setRole(resultSet.getString("role")); // Role
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Method to verify password
    public boolean verifyPassword(String enteredPassword, String storedPassword) {
        return BCrypt.checkpw(enteredPassword, storedPassword);
    }
}
