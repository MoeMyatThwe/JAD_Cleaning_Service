<%@ include file="header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ page import="java.sql.*, java.util.*, com.cleaningService.util.DatabaseConnection" %>
<!DOCTYPE html>
<html>
<head>
    <title>Service History</title>
    <link rel="stylesheet" href="home.css">
    <link rel="stylesheet" href="history.css">
</head>
<body>
    <div class="history-container">
        <h1>My Service History</h1>
        <%
        // Ensure user is logged in
        if (userId == null) {
            out.println("<p style='color:red;'>Please log in to view your service history.</p>");
            return;
        }

        // Fetch service history for logged-in user
        try (Connection conn = DatabaseConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(
                     "SELECT b.booking_id, s.service_name, ss.sub_service_name, b.created_at, b.special_request, b.sub_service_id " +
                     "FROM booking b " +
                     "INNER JOIN sub_service ss ON b.sub_service_id = ss.sub_service_id " +
                     "INNER JOIN service s ON ss.service_id = s.service_id " +
                     "WHERE b.user_id = ? ORDER BY b.created_at DESC")) {
            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (!rs.isBeforeFirst()) {
                    out.println("<p class='empty-history'>No service history found.</p>");
                } else {
                    while (rs.next()) {
                        int bookingId = rs.getInt("booking_id");
                        String serviceName = rs.getString("service_name");
                        String subServiceName = rs.getString("sub_service_name");
                        String bookingDate = rs.getString("created_at");
                        String specialRequest = rs.getString("special_request");
                        int subServiceId = rs.getInt("sub_service_id");

        %>
        <div class="history-item">
            <h2><%= serviceName %> - <%= subServiceName %></h2>
            <p>Booking Date: <%= bookingDate %></p>
            <p>Special Request: <%= (specialRequest != null ? specialRequest : "None") %></p>
            <form method="get" action="feedback.jsp">
               
                <input type="hidden" name="bookingId" value="<%= bookingId %>">
                <input type="hidden" name="subServiceId" value="<%= subServiceId %>">
                <button type="submit" class="give-feedback-btn">Give Feedback</button>
            </form>
        </div>
        <%
                    }
                }
            }
        } catch (SQLException e) {
            out.println("<p style='color:red;'>Error retrieving service history: " + e.getMessage() + "</p>");
        }
        %>
    </div>
</body>
</html>
