package com.jadcleaning.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    private static final String URL = "jdbc:postgresql://ep-noisy-mouse-a16m2zvq.ap-southeast-1.aws.neon.tech/jad_cleaning_service";
    private static final String USER = "neondb_owner";
    private static final String PASSWORD = "p5rjJ1bYxKds";

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("PostgreSQL Driver not found!", e);
        }
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
