package com.cleaningService.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.cleaningService.model.Booking;
import com.cleaningService.model.Feedback;
import com.cleaningService.util.DBConnection;

public class FeedbackDAO {
    
    //For admin
    public int retrieveFeedbackNum() {
    	int count = 0;
	    String sql = "SELECT COUNT(feedback_id) AS feedbackCount FROM feedback";

	    try (Connection connection = DBConnection.getConnection();
	         PreparedStatement stmt = connection.prepareStatement(sql);
	         ResultSet resultSet = stmt.executeQuery()) {

	        if (resultSet.next()) {
	            count = resultSet.getInt("feedbackCount");
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return count;
    }
    
    public List<Feedback> retrieveAllFeedbacks(){
    	List<Feedback> feedbackList = new ArrayList<>();
    	 String sql = "SELECT fb.feedback_id, fb.comment, fb.rating, u.name AS customer_name, s.service_name AS service_name"
                 + "FROM feedback fb "
                 + "JOIN user u ON fb.user_id = u.id "
                 + "JOIN service s ON fb.service_id = s.service_id ";
        
    	 try (Connection connection = DBConnection.getConnection();
                 PreparedStatement pstmt = connection.prepareStatement(sql);
                 ResultSet rs = pstmt.executeQuery()) {
                 
                while (rs.next()) {  
                    Feedback feedback = new Feedback();
                    
                    feedback.setId(rs.getInt("id"));
                    feedback.setUsername("customer_name");
                    feedback.setServiceName(rs.getString("service_name"));
                    feedback.setRating(rs.getInt("rating"));
                    feedback.setComments(rs.getString("comment"));
                    
                    feedbackList.add(feedback);
                }
                
            } catch (SQLException e) {
                e.printStackTrace();
            }
        
        
		return feedbackList;  
    }

}
