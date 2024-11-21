<%@ include file="header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ page import="java.util.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Cart</title>
    <link rel="stylesheet" href="home.css">
    <link rel="stylesheet" href="services.css">
    <link rel="stylesheet" href="cart.css"> <!-- Include external CSS -->
</head>
<body>
    <div class="cart-container">
        <h1>Order Summary</h1>
        <%
            // Retrieve the cart from the session
            List<Map<String, String>> cart = (List<Map<String, String>>) session.getAttribute("cart");
            if (cart == null || cart.isEmpty()) {
        %>
            <p class="empty-cart">Your cart is empty.</p>
            <a href="services.jsp" class="btn">Browse Services</a>
        <%
            } else {
                double totalPrice = 0.0;
                for (int i = 0; i < cart.size(); i++) {
                    Map<String, String> item = cart.get(i);

                    // Extract details from the cart
                    String subServiceId = item.get("subServiceId");
                    String subServiceName = "Unknown Service";
                    String image = "default-image.jpg"; // Default image
                    String priceStr = "0.00";

                    // Query the database to get additional details
                    String query = "SELECT sub_service_name, image, price FROM sub_service WHERE sub_service_id = ?";
                    try (Connection conn = com.cleaningService.util.DatabaseConnection.connect();
                         PreparedStatement stmt = conn.prepareStatement(query)) {
                        stmt.setInt(1, Integer.parseInt(subServiceId));
                        try (ResultSet rs = stmt.executeQuery()) {
                            if (rs.next()) {
                                subServiceName = rs.getString("sub_service_name");
                                image = rs.getString("image");
                                priceStr = String.format("%.2f", rs.getDouble("price"));
                            }
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }

                    // Parse the price safely
                    double price = 0.0;
                    try {
                        price = Double.parseDouble(priceStr);
                    } catch (NumberFormatException e) {
                        price = 0.0;
                    }

                    totalPrice += price; // Update total price
        %>
            <div class="cart-item">
                <img src="<%= image %>" alt="<%= subServiceName %>" class="cart-item-image">
                <div class="cart-item-details">
                    <h2><%= subServiceName %></h2>
                    <p>Price: $<%= price %></p>
                    <p>Duration: <%= item.get("duration") %> hours</p>
                    <p>Address: <%= item.get("serviceAddress") %></p>
                    <p>Special Request: <%= item.get("specialRequest") %></p>
                    <form method="post">
                        <input type="hidden" name="removeIndex" value="<%= i %>">
                        <button type="submit" class="remove-btn">Remove from Cart</button>
                    </form>
                </div>
            </div>
        <%
                }
        %>
            <div class="cart-summary">
                <h3>Subtotal: $<%= String.format("%.2f", totalPrice) %></h3>
                <form action="confirmBooking.jsp" method="post">
                    <button type="submit" class="btn proceed-btn">Proceed to Checkout</button>
                </form>
            </div>
        <%
            }
        %>
    </div>
</body>
</html>
