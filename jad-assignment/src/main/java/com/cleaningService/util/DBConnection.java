package com.cleaningService.util;
import java.sql.*;

public class DBConnection {
	private static final String URL = "jdbc:postgresql://ep-noisy-mouse-a16m2zvq.ap-southeast-1.aws.neon.tech/jad_cleaning_service?user=neondb_owner&password=p5rjJ1bYxKds&sslmode=require";
    private static final String USER = "neondb_owner";
    private static final String PASSWORD = "p5rjJ1bYxKds";

    public static Connection getConnection() throws SQLException {
        try {
            // Load PostgreSQL JDBC driver
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("PostgreSQL JDBC Driver not found!", e);
        }
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
    
    public static void testConnection() {
    	try {
    	    Connection connection = getConnection();
    	    System.out.println("Connection successful: " + connection);
    	} catch (SQLException e) {
    	    System.err.println("Error Code: " + e.getErrorCode());
    	    System.err.println("SQL State: " + e.getSQLState());
    	    e.printStackTrace();
    	}

    }
    
    public static void main(String[] args) {
    	testConnection();
    }

}
