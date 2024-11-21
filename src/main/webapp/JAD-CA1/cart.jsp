<%@ include file="header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ page import="java.util.*, java.sql.*, com.cleaningService.util.DatabaseConnection" %>
<!DOCTYPE html>
<html>
<head>
    <title>Cart</title>
    <link rel="stylesheet" href="home.css">
    <link rel="stylesheet" href="cart.css">
    <script>
       
        function updateSummary() {
            const checkboxes = document.querySelectorAll('.cart-checkbox');
            const prices = document.querySelectorAll('.cart-price');
            const serviceCount = document.getElementById('serviceCount');
            const subtotalElement = document.getElementById('subtotal');

            let subtotal = 0;
            let selectedCount = 0;

            checkboxes.forEach((checkbox, index) => {
                if (checkbox.checked) {
                    subtotal += parseFloat(prices[index].innerText.replace('$', ''));
                    selectedCount++;
                }
            });

            serviceCount.innerText = selectedCount;
            subtotalElement.innerText = `$${subtotal.toFixed(2)}`;
        }

        function validateCheckout(event) {
            const checkboxes = document.querySelectorAll('.cart-checkbox');
            const isAnySelected = Array.from(checkboxes).some(checkbox => checkbox.checked);

            if (!isAnySelected) {
                event.preventDefault();
                alert('Please select at least one service to proceed to checkout.');
            }
        }
    </script>
</head>
<body>
    <div class="cart-container">
        <h1 class="cart-header">My Cart</h1>
        <p class="service-info">You have selected <span id="serviceCount">0</span> service(s) for checkout.</p>
        <form method="post">
            <%
              
                List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");

                if (cart == null || cart.isEmpty()) {
            %>
                <p class="empty-cart">Your cart is empty.</p>
            <%
                } else {
                    for (int i = 0; i < cart.size(); i++) {
                        Map<String, Object> item = cart.get(i);

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

                        String date = (String) item.getOrDefault("date", "Not specified");
                        String time = (String) item.getOrDefault("time", "Not specified");
                        String address = (String) item.getOrDefault("serviceAddress", "Not specified");
                        String specialRequest = (String) item.getOrDefault("specialRequest", "NA");
                        int duration = Integer.parseInt(item.getOrDefault("duration", "1").toString());
            %>
            <!-- Individual Cart Item -->
            <div class="cart-item">
                <div class="cart-item-left">
                    <input type="checkbox" name="selectedItems" value="<%= i %>" class="cart-checkbox" onchange="updateSummary()">
                    <div class="cart-item-image">
                        <img src="<%= image %>" alt="<%= subServiceName %>">
                    </div>
                </div>
                <div class="cart-item-details">
                    <h2><%= subServiceName %></h2>
                    <p class="cart-price">$<%= String.format("%.2f", price) %></p>
                    <p>Date: <%= date %></p>
                    <p>Time: <%= time %></p>
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
                <button type="submit" name="checkout" value="true" class="checkout-btn" onclick="validateCheckout(event)">Checkout</button>
            </div>
        </form>
        <%
if ("POST".equalsIgnoreCase(request.getMethod())) {
    // Retrieve the cart from the session

    if (cart == null) {
        cart = new ArrayList<>();
    }

    if (request.getParameter("checkout") != null) {
        // Handle checkout logic
        String[] selectedItems = request.getParameterValues("selectedItems");
        if (selectedItems != null) {
            List<Integer> indicesToRemove = new ArrayList<>();

            for (String index : selectedItems) {
                int itemIndex = Integer.parseInt(index);
                indicesToRemove.add(itemIndex);

                Map<String, Object> bookedItem = cart.get(itemIndex);

                // Safely retrieve values with default fallbacks
                Integer subServiceId = bookedItem.get("subServiceId") != null
                        ? Integer.parseInt(bookedItem.get("subServiceId").toString())
                        : -1;
                Integer serviceId = bookedItem.get("serviceId") != null
                        ? Integer.parseInt(bookedItem.get("serviceId").toString())
                        : -1;
                String specialRequest = bookedItem.get("specialRequest") != null
                        ? bookedItem.get("specialRequest").toString()
                        : "No special request";
                String date = bookedItem.get("date") != null
                        ? bookedItem.get("date").toString()
                        : "0000-00-00";
                String time = bookedItem.get("time") != null
                        ? bookedItem.get("time").toString()
                        : "00:00:00";

                // Avoid database insertion if keys are missing
                if (subServiceId != -1 && serviceId != -1) {
                    try (Connection conn = DatabaseConnection.connect();
                         PreparedStatement stmt = conn.prepareStatement(
                                 "INSERT INTO booking (user_id, sub_service_id, service_id, special_request, created_at) VALUES (?, ?, ?, ?, CURRENT_TIMESTAMP)")) {
                        stmt.setInt(1, userId);
                        stmt.setInt(2, subServiceId);
                        stmt.setInt(3, serviceId);
                        stmt.setString(4, specialRequest);
                        stmt.executeUpdate();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }

            // Remove checked items from the cart (in reverse order to prevent index shifting)
            indicesToRemove.sort(Collections.reverseOrder());
            for (int index : indicesToRemove) {
                cart.remove(index);
            }

            // Update session and redirect
            session.setAttribute("cart", cart);
            response.sendRedirect("serviceHistory.jsp");
        } else {
            out.println("<p style='color:red;'>Please select at least one service to checkout.</p>");
        }
    }

    if (request.getParameter("remove") != null) {
        // Handle Remove from Cart logic
        int removeIndex = Integer.parseInt(request.getParameter("remove"));
        if (removeIndex >= 0 && removeIndex < cart.size()) {
            cart.remove(removeIndex);
        }
        session.setAttribute("cart", cart);
        response.sendRedirect("cart.jsp");
    }
}
%>
        
    </div>
    <script>
        document.addEventListener('DOMContentLoaded', updateSummary);
    </script>
</body>
</html>
