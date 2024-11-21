<%@ include file="header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ page import="java.sql.*, com.cleaningService.dao.BookingDAO" %>
<!DOCTYPE html>
<html>
<head>
    <title>Booking Details</title>
    <link rel="stylesheet" href="home.css">
    <link rel="stylesheet" href="services.css">
    <link rel="stylesheet" href="bookingDetails.css"> <!-- External CSS -->
</head>
<body>
    <div class="booking-container">
        <%
        // Fetch sub_service_id from the request
        String subServiceId = request.getParameter("sub_service_id");
        if (subServiceId == null) {
            out.println("<p style='color:red;'>Error: Sub-service ID is missing!</p>");
            return;
        }

        String subServiceName = "";
        String description = "";
        String price = "";
        String image = "";

        String query = "SELECT sub_service_name, description, price, image FROM sub_service WHERE sub_service_id = ?";
        try (Connection conn = com.cleaningService.util.DatabaseConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, Integer.parseInt(subServiceId));
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    subServiceName = rs.getString("sub_service_name");
                    description = rs.getString("description");
                    price = String.format("$%.2f", rs.getDouble("price"));
                    image = rs.getString("image");
                } else {
                    out.println("<p style='color:red;'>Sub-service not found!</p>");
                    return;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("<p style='color:red;'>An error occurred while fetching service details.</p>");
            return;
        }
        %>

        <!-- Display Selected Service Details -->
        <div class="service-summary">
            <h1>Booking for: <%= subServiceName %></h1>
            <p>Description: <%= description %></p>
            <p>Price: <%= price %></p>
            <img src="<%= image %>" alt="<%= subServiceName %>" class="service-image">
        </div>

        <!-- Booking Form -->
        <form method="post">
            <input type="hidden" name="sub_service_id" value="<%= subServiceId %>">

            <label for="date">Select Date:</label>
            <input type="date" name="date" required>

            <label for="time">Select Time:</label>
            <input type="time" name="time" required>

            <label for="duration">Duration (in hours):</label>
            <input type="number" name="duration" min="1" required>

            <label for="serviceAddress">Service Address:</label>
            <input type="text" name="serviceAddress" placeholder="Enter your address" required>

            <label for="specialRequest">Special Requests (optional):</label>
            <textarea name="specialRequest" rows="4"></textarea>

            <div class="buttons-container">
                <a href="serviceDetails.jsp" class="btn back-btn">Back to Services</a>
                <button type="submit" class="btn">Confirm Booking</button>
            </div>
        </form>

        <!-- Handle Form Submission -->
<%
if ("POST".equalsIgnoreCase(request.getMethod())) {
    if (userId == null) {
        out.println("<p style='color:red;'>You need to log in to book a service.</p>");
        return;
    }

    String serviceId = request.getParameter("service_id");
    String subServiceIdParam = request.getParameter("sub_service_id");
    String date = request.getParameter("date");
    String time = request.getParameter("time");
    String duration = request.getParameter("duration");
    String serviceAddress = request.getParameter("serviceAddress");
    String specialRequest = request.getParameter("special_request");

    // Null checks and default values
    int parsedServiceId = serviceId != null && !serviceId.isEmpty() ? Integer.parseInt(serviceId) : 0;
    int parsedSubServiceId = subServiceIdParam != null && !subServiceIdParam.isEmpty() ? Integer.parseInt(subServiceIdParam) : 0;
    int parsedDuration = duration != null && !duration.isEmpty() ? Integer.parseInt(duration) : 1; // Default duration: 1

    BookingDAO bookingDAO = new BookingDAO();
    boolean isSuccess = bookingDAO.createBooking(
        userId,
        parsedServiceId,
        parsedSubServiceId,
        date,
        time,
        parsedDuration,
        serviceAddress,
        specialRequest
    );

    if (isSuccess) {
        out.println("<p style='color:green;'>Booking successfully created!</p>");
    } else {
        out.println("<p style='color:red;'>Failed to create booking. Please try again later.</p>");
    }
}
%>

       
    </div>
</body>
</html>
