<%@ include file="header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ page import="java.util.ArrayList, java.util.Map" %>
<%@ page import="com.cleaningService.dao.BookingDAO" %>
<!DOCTYPE html>
<html>
<head>
    <title>Confirm Booking</title>
</head>
<body>
    <div class="confirm-container">
        <h1>Confirm Booking</h1>
        <%
        ArrayList<Map<String, String>> cart = (ArrayList<Map<String, String>>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            out.println("<p>No items in your cart. <a href='services.jsp'>Browse services</a></p>");
        } else {
            BookingDAO bookingDAO = new BookingDAO();
            boolean allSuccessful = true;

            for (Map<String, String> booking : cart) {
                boolean isSuccess = bookingDAO.createBooking(
                    userId,
                    0, // Replace with actual service ID if available
                    Integer.parseInt(booking.get("subServiceId")),
                    booking.get("date"),
                    booking.get("time"),
                    Integer.parseInt(booking.get("duration")),
                    booking.get("serviceAddress"),
                    booking.get("specialRequest")
                );

                if (!isSuccess) {
                    allSuccessful = false;
                    break;
                }
            }

            if (allSuccessful) {
                session.removeAttribute("cart"); // Clear the cart
                out.println("<p style='color:green;'>All bookings confirmed!</p>");
            } else {
                out.println("<p style='color:red;'>Failed to confirm bookings. Please try again.</p>");
            }
        }
        %>
    </div>
</body>
</html>
