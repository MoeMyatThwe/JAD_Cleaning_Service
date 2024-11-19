<%@ page import="java.sql.*, java.util.*, com.jadcleaning.util.DatabaseConnection" %>

<%
    // Fetch data from the database
    List<Map<String, String>> services = new ArrayList<>();
    String sql = "SELECT s.service_name, s.description, s.price, s.image, c.category_name " +
                 "FROM service s " +
                 "JOIN service_category c ON s.category_id = c.category_id";

    try (Connection conn = com.jadcleaning.util.DatabaseConnection.connect();
         PreparedStatement stmt = conn.prepareStatement(sql);
         ResultSet rs = stmt.executeQuery()) {

        while (rs.next()) {
            Map<String, String> service = new HashMap<>();
            service.put("name", rs.getString("service_name"));
            service.put("description", rs.getString("description"));
            service.put("price", String.format("%.2f", rs.getDouble("price")));
            service.put("image", rs.getString("image"));
            service.put("category", rs.getString("category_name"));
            services.add(service);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Services</title>
    <link rel="stylesheet" href="services.css"> 
</head>
<body>
    <h1>Our Specialized Services</h1>
    <div class="service-container">
    <% for (Map<String, String> service : services) { %>
        <div class="service-card">
            <img src="<%= service.get("image") %>" alt="<%= service.get("name") %>">
            <h3><%= service.get("name") %></h3>
            <p><%= service.get("description") %></p>
            <p class="price">$<%= service.get("price") %></p>
            <p class="category">Category: <%= service.get("category") %></p>
        </div>
    <% } %>
</div>
    
</body>
</html>
