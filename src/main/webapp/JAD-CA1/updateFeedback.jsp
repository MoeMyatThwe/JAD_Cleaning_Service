<%@ include file="header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ page import="java.sql.*, com.cleaningService.util.DatabaseConnection" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Feedback</title>
    <link rel="stylesheet" href="home.css"> <!-- Reuse core styles -->
    <link rel="stylesheet" href="feedback.css"> <!-- Consistent feedback styling -->
</head>
<body>
    <div class="feedback-page">
        <div class="feedback-container">
            <h1>Update Feedback</h1>
            <%
            // Ensure the user is logged in
          
            if (userId == null) {
                out.println("<p style='color:red;'>Please log in to update feedback.</p>");
                return;
            }

            // Retrieve feedbackId and fetch feedback details
            String feedbackId = request.getParameter("feedbackId");
            String comments = "";
            int rating = 0;

            try (Connection conn = DatabaseConnection.connect();
                 PreparedStatement stmt = conn.prepareStatement(
                         "SELECT comments, rating FROM feedback WHERE feedback_id = ? AND user_id = ?")) {
                stmt.setInt(1, Integer.parseInt(feedbackId));
                stmt.setInt(2, userId);

                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        comments = rs.getString("comments");
                        rating = rs.getInt("rating");
                    } else {
                        out.println("<p style='color:red;'>Feedback not found or unauthorized access.</p>");
                        return;
                    }
                }
            } catch (SQLException e) {
                out.println("<p style='color:red;'>Error fetching feedback: " + e.getMessage() + "</p>");
                return;
            }
            %>

            <!-- Feedback Update Form -->
            <form method="post" action="processUpdateFeedback.jsp">
                <input type="hidden" name="feedbackId" value="<%= feedbackId %>">

                <!-- Star Rating -->
                <label for="rating">Rate the Service:</label>
                <div class="star-rating">
                    <% for (int i = 5; i >= 1; i--) { %>
                        <input type="radio" id="star<%= i %>" name="rating" value="<%= i %>" <%= (i == rating ? "checked" : "") %>>
                        <label for="star<%= i %>">★</label>
                    <% } %>
                </div>

                <!-- Feedback Textarea -->
                <label for="comments">Your Feedback:</label>
                <textarea id="comments" name="comments" rows="4" required><%= comments %></textarea>

                <!-- Submit Button -->
                <button type="submit" class="submit-btn">Update Feedback</button>
            </form>
        </div>
    </div>
</body>
</html>