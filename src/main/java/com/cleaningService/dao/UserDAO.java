/* 
 * JAD-CA1
 * Class-DIT/FT/2A/23
 * Student Name: Moe Myat Thwe
 * Admin No.: P2340362
 */
package com.cleaningService.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;

import com.cleaningService.model.User;
import com.cleaningService.util.DatabaseConnection;

import org.mindrot.jbcrypt.BCrypt;

public class UserDAO {

	// Method to register a user and return the userId
	public int registerUser(User user) {
	    int userId = -1; // Default value indicating failure
	    String sql = "INSERT INTO users (name, email, password, role) VALUES (?, ?, ?, ?) RETURNING id";
	    String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());

	    try (Connection connection = DatabaseConnection.connect();
	         PreparedStatement statement = connection.prepareStatement(sql)) {

	        statement.setString(1, user.getName());
	        statement.setString(2, user.getEmail());
	        statement.setString(3, hashedPassword);
	        statement.setString(4, "customer"); // Default role as 'customer'

	        ResultSet rs = statement.executeQuery();
	        if (rs.next()) {
	            userId = rs.getInt("id"); // Fetch the generated user ID
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return userId;
	}

    // Method to fetch user details by email
    public User getUserByEmail(String email) {
        String sql = "SELECT id, name, email, password, role FROM users WHERE email = ?";
        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, email);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                // Populate user object with fetched details
                User user = new User();
                user.setId(resultSet.getInt("id"));
                user.setName(resultSet.getString("name"));
                user.setEmail(resultSet.getString("email"));
                user.setPassword(resultSet.getString("password")); // Hashed password
                user.setRole(resultSet.getString("role")); // Role name or ID
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Method to verify the entered password with the stored hashed password
//    public boolean verifyPassword(String enteredPassword, String storedPassword) {
//        return BCrypt.checkpw(enteredPassword, storedPassword);
//    }
    
    public boolean verifyPassword(String enteredPassword, String storedPassword) {
        System.out.println("Entered Password: " + enteredPassword);
        System.out.println("Stored Password: " + storedPassword);
        boolean match = BCrypt.checkpw(enteredPassword, storedPassword);
        System.out.println("Password Match: " + match);
        return match;
    }

}
