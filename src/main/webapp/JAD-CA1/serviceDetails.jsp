<%@ page import="java.sql.*, java.util.*" %>
<%@ include file="header.jsp" %>
<link rel="stylesheet" href="services.css">
<link rel="stylesheet" href="home.css">


<%
    String serviceId = request.getParameter("service_id");

    String sql = "SELECT ss.sub_service_name, ss.description, ss.price, ss.image " +
                 "FROM sub_service ss " +
                 "WHERE ss.service_id = ?";

    List<Map<String, String>> subServices = new ArrayList<>();

    try (Connection conn = com.jadcleaning.util.DatabaseConnection.connect();
         PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setInt(1, Integer.parseInt(serviceId));
        try (ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Map<String, String> subService = new HashMap<>();
                subService.put("name", rs.getString("sub_service_name"));
                subService.put("description", rs.getString("description"));
                subService.put("price", String.format("%.2f", rs.getDouble("price")));
                subService.put("image", rs.getString("image"));
                subServices.add(subService);
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>

<section class="service-details">
    <h1>Service Details</h1>
    <div class="sub-services-container">
        <% for (Map<String, String> subService : subServices) { %>
            <div class="sub-service-card">
                <img src="<%= subService.get("image") %>" alt="<%= subService.get("name") %>">
                <h2><%= subService.get("name") %></h2>
                <p><%= subService.get("description") %></p>
                <p>Price: $<%= subService.get("price") %></p>
                <button class="book-now">Book Now</button>
            </div>
        <% } %>
    </div>
    <a href="services.jsp" class="back-button">Back to Services</a>
</section>

<%@ include file="footer.html" %>