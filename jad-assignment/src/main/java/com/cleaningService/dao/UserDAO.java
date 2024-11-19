package com.cleaningService.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;

import com.cleaningService.model.User;
import com.cleaningService.util.DBConnection;
import org.mindrot.jbcrypt.*;
public class UserDAO {

    public boolean registerUser(User user) {
        boolean isUserRegistered = false;
        String sql = "INSERT INTO users (name, email, password) VALUES (?, ?, ?)";

        String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
        try (Connection connection = DBConnection.getConnection();
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
    
    public boolean verifyUser(String email, String password) {
        boolean isUserLogin = false;
        String sql = "SELECT password FROM users WHERE email=?";

        try (Connection connection = DBConnection.getConnection()) {
            System.out.println("Connected to the database.");
            PreparedStatement statement = connection.prepareStatement(sql);

            statement.setString(1, email);
            System.out.println("Executing query: " + statement);

            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                String storedPassword = resultSet.getString("password");
                System.out.println("Stored password hash: " + storedPassword);

                if (BCrypt.checkpw(password, storedPassword)) {
                    System.out.println("Password match!");
                    return true;
                } else {
                    System.out.println("Password does not match.");
                    return false;
                }
            } else {
                System.out.println("User not found for email: " + email);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isUserLogin;
    }

}
