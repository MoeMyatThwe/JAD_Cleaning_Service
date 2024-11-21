<%@ include file="header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ page import="java.util.*, java.sql.*, com.cleaningService.util.DatabaseConnection" %>
<!DOCTYPE html>
<html>
<head>
    <title>Cart</title>
    <link rel="stylesheet" href="cart.css">
    <link rel="stylesheet" href="home.css">
</head>
<body>
    <div class="cart-container">
        <h1 class="cart-header">Order Summary</h1>
        <form method="post" action="checkout.jsp">
            <%
                // Retrieve the cart from the session
                List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");
                double total = 0.0;

                if (cart == null || cart.isEmpty()) {
            %>
                <p class="empty-cart">Your cart is empty.</p>
            <%
                } else {
                    for (int i = 0; i < cart.size(); i++) {
                        Map<String, Object> item = cart.get(i);

                        // Retrieve sub_service_id and fetch dynamic details from the database
                        int subServiceId = Integer.parseInt(item.get("subServiceId").toString());
                        String subServiceName = "";
                        String image = "";
                        double price = 0.0;

                        try (Connection conn = DatabaseConnection.connect();
                             PreparedStatement stmt = conn.prepareStatement("SELECT sub_service_name, image, price FROM sub_service WHERE sub_service_id = ?")) {
                            stmt.setInt(1, subServiceId);
                            try (ResultSet rs = stmt.executeQuery()) {
                                if (rs.next()) {
                                    subServiceName = rs.getString("sub_service_name");
                                    image = rs.getString("image");
                                    price = rs.getDouble("price");
                                }
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }

                        // Other details from the session
                        String address = (String) item.getOrDefault("address", "Not specified");
                        String specialRequest = (String) item.getOrDefault("specialRequest", "NA");
                        int duration = Integer.parseInt(item.getOrDefault("duration", "1").toString());

                        total += price;
            %>
            <!-- Individual Cart Item -->
            <div class="cart-item">
                <div class="cart-item-left">
                    <input type="checkbox" name="selectedItems" value="<%= i %>" class="cart-checkbox">
                    <div class="cart-item-image">
                        <img src="<%= image %>" alt="<%= subServiceName %>">
                    </div>
                </div>
                <div class="cart-item-details">
                    <h2><%= subServiceName %></h2>
                    <p>Price: $<%= String.format("%.2f", price) %></p>
                    <p>Duration: <%= duration %> hours</p>
                    <p>Address: <%= address %></p>
                    <p>Special Request: <%= specialRequest %></p>
                </div>
                <div class="cart-item-right">
                    <button type="submit" name="remove" value="<%= i %>" class="remove-btn">Remove from Cart</button>
                </div>
            </div>
            <%
                    }
                }
            %>
            <!-- Cart Summary -->
            <div class="cart-summary">
                <p class="total-price">Subtotal: $<%= String.format("%.2f", total) %></p>
                <button type="submit" class="checkout-btn">Proceed to Checkout</button>
            </div>
        </form>
    </div>
</body>
</html>
