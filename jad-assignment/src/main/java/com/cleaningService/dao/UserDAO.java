package com.cleaningService.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

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
}
