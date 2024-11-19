<%@ page import="java.sql.*, java.util.*" %>
<%@ include file="header.jsp" %>
<link rel="stylesheet" href="services.css">
<link rel="stylesheet" href="home.css">


<%
    String sql = "SELECT s.service_id, s.service_name, s.description, s.price, s.image, c.category_name " +
                 "FROM service s " +
                 "JOIN service_category c ON s.category_id = c.category_id";

    List<Map<String, String>> services = new ArrayList<>();

    try (Connection conn = com.jadcleaning.util.DatabaseConnection.connect();
         PreparedStatement stmt = conn.prepareStatement(sql);
         ResultSet rs = stmt.executeQuery()) {

        while (rs.next()) {
            Map<String, String> service = new HashMap<>();
            service.put("id", rs.getString("service_id"));
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

<section class="services">
    <h1>Our Specialized Services</h1>
    <div class="services-container">
        <% for (Map<String, String> service : services) { %>
            <div class="service-card">
                <img src="<%= service.get("image") %>" alt="<%= service.get("name") %>">
                <h2><%= service.get("name") %></h2>
                <p><%= service.get("description") %></p>
                <p>Price: $<%= service.get("price") %></p>
                <a href="serviceDetails.jsp?service_id=<%= service.get("id") %>" class="more-info">More Info</a>
            </div>
        <% } %>
    </div>
</section>

<%@ include file="footer.html" %>
