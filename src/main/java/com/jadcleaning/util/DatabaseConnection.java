package com.jadcleaning.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    private static final String URL = "jdbc:postgresql://ep-noisy-mouse-a16m2zvq.ap-southeast-1.aws.neon.tech/jad_cleaning_service?sslmode=require";
    private static final String USER = "neondb_owner";
    private static final String PASSWORD = "p5rjJ1bYxKds";

    public static Connection connect() {
        Connection connection = null;
        try {
            // Load PostgreSQL JDBC Driver
            Class.forName("org.postgresql.Driver");
            // Establish the connection
            connection = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("Connected to the database successfully!");
        } catch (ClassNotFoundException e) {
            System.out.println("PostgreSQL Driver not found. Add the JAR file to the project.");
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("Connection failed!");
            e.printStackTrace();
        }
        return connection;
    }

    public static void main(String[] args) {
        // Test the connection
        connect();
    }
}
