package com.cleaningService.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.cleaningService.model.Booking;
import com.cleaningService.util.DBConnection;

public class BookingDAO {
    
    /////////////////////////////////////////////////////////////////////////////
    // ADMIN side
    /////////////////////////////////////////////////////////////////////////////

    public int retrieveBookingNum() {
    	int count = 0;
	    String sql = "SELECT COUNT(booking_id) AS bookingCount FROM booking";

	    try (Connection connection = DBConnection.getConnection();
	         PreparedStatement stmt = connection.prepareStatement(sql);
	         ResultSet resultSet = stmt.executeQuery()) {

	        if (resultSet.next()) {
	            count = resultSet.getInt("bookingCount");
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return count;
    }
    
    public List<Booking> retrieveAllBookings() {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT b.booking_id, u.name AS customer_name, s.service_name AS service_name, b.date, sc.category_name AS category_name "
                   + "FROM booking b "
                   + "JOIN users u ON b.user_id = u.id "
                   + "JOIN service s ON b.service_id = s.service_id "
                   + "JOIN service_category sc ON b.category_id = sc.category_id";  
        
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement pstmt = connection.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
             
            while (rs.next()) {  
                Booking booking = new Booking();
                booking.setId(rs.getInt("booking_id"));
                booking.setCustomerName(rs.getString("customer_name"));
                booking.setServiceName(rs.getString("service_name"));
                booking.setDate(rs.getString("date"));
                booking.setCategoryName(rs.getString("category_name"));
                
                bookings.add(booking);
                

            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
       
        return bookings;  
    }


    
    
}
