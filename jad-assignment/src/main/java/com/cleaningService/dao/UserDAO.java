package com.cleaningService.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import org.mindrot.jbcrypt.BCrypt;

import java.sql.ResultSet;

import com.cleaningService.model.User;
import com.cleaningService.util.DBConnection; 



public class UserDAO {

    public boolean registerUser(User user) {
        boolean isUserRegistered = false;
        String sql = "INSERT INTO users (name, email, password, phone, address, role_id) VALUES (?, ?, ?, ?, ?, ?)";

        String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, user.getName());
            statement.setString(2, user.getEmail());
            statement.setString(3, hashedPassword);
            statement.setInt(4, user.getPhoneNum());
            statement.setString(5, user.getAddress());
            statement.setInt(6, 2);
            
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
    	
    	try(Connection connection = DBConnection.getConnection()) {
    		PreparedStatement statement = connection.prepareStatement(sql);
    		
    		statement.setString(1,  email);
    		ResultSet resultSet = statement.executeQuery();
    		
    		if(resultSet.next()) {
    			String storedPassword = resultSet.getString("password");
    			
    			if(BCrypt.checkpw(password, storedPassword)) {
    				return true;
    			}else {
    				return false;
    			}
    		}
    	}catch (SQLException e) {
            e.printStackTrace();
        }
        return isUserLogin;
    }
}