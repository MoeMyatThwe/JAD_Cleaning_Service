<%@ include file="header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ page import="java.sql.*, com.cleaningService.util.DatabaseConnection" %>
<!DOCTYPE html>
<html>
<head>
    <title>Give Feedback</title>
    <link rel="stylesheet" href="home.css">
    <link rel="stylesheet" href="feedback.css">
</head>
<body>
    <div class="feedback-container">
        <h1>Give Feedback</h1>
        <%
        // Ensure user is logged in
        if (userId == null) {
            out.println("<p style='color:red;'>Please log in to give feedback.</p>");
            return;
        }

        // Get bookingId and subServiceId from the request
        String bookingId = request.getParameter("bookingId");
        String subServiceId = request.getParameter("subServiceId");

        if (bookingId == null || subServiceId == null) {
            out.println("<p style='color:red;'>Invalid request. Missing parameters.</p>");
            return;
        }

        String serviceName = "";
        String subServiceName = "";

        // Fetch service details for context
        try (Connection conn = DatabaseConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(
                     "SELECT s.service_name, ss.sub_service_name " +
                     "FROM sub_service ss " +
                     "INNER JOIN service s ON ss.service_id = s.service_id " +
                     "WHERE ss.sub_service_id = ?")) {
            stmt.setInt(1, Integer.parseInt(subServiceId));

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    serviceName = rs.getString("service_name");
                    subServiceName = rs.getString("sub_service_name");
                }
            }
        } catch (SQLException e) {
            out.println("<p style='color:red;'>Error fetching service details: " + e.getMessage() + "</p>");
            return;
        }
        %>

        <!-- Feedback Form -->
        <form method="post">
            <p>Service: <%= serviceName %> - <%= subServiceName %></p>
            <label for="feedback">Your Feedback:</label><br>
            <textarea id="feedback" name="feedback" rows="4" cols="50" required></textarea><br>
            <button type="submit" class="submit-btn">Submit Feedback</button>
        </form>
        <%
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String feedback = request.getParameter("feedback");

            try (Connection conn = DatabaseConnection.connect();
                 PreparedStatement stmt = conn.prepareStatement(
                         "INSERT INTO feedback (user_id, service_id, comments) VALUES (?, ?, ?)")) {
                stmt.setInt(1, userId);
                stmt.setInt(2, Integer.parseInt(subServiceId));
                stmt.setString(3, feedback);
                stmt.executeUpdate();

                out.println("<p style='color:green;'>Thank you for your feedback!</p>");
            } catch (SQLException e) {
                out.println("<p style='color:red;'>Error saving feedback: " + e.getMessage() + "</p>");
            }
        }
        %>
    </div>
</body>
</html>
